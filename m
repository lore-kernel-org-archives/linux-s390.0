Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49746 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389045AbgBNSAH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 13:00:07 -0500
Subject: Re: [PATCH 05/35] s390/mm: provide memory management functions for
 protected KVM guests
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-6-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1fb4da22-bab4-abe3-847b-5a7d79d84774@redhat.com>
Date: Fri, 14 Feb 2020 18:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-6-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

> =20
>  /*
> @@ -1086,12 +1106,16 @@ static inline pte_t ptep_get_and_clear_full(str=
uct mm_struct *mm,
>  					    unsigned long addr,
>  					    pte_t *ptep, int full)
>  {
> +	pte_t res;

Empty line missing.

>  	if (full) {
> -		pte_t pte =3D *ptep;
> +		res =3D *ptep;
>  		*ptep =3D __pte(_PAGE_INVALID);
> -		return pte;
> +	} else {
> +		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
>  	}
> -	return ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> +	if (mm_is_protected(mm) && pte_present(res))
> +		uv_convert_from_secure(pte_val(res) & PAGE_MASK);
> +	return res;
>  }

[...]

> +int uv_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)=
;
> +int uv_convert_from_secure(unsigned long paddr);
> +
> +static inline int uv_convert_to_secure(struct gmap *gmap, unsigned lon=
g gaddr)
> +{
> +	struct uv_cb_cts uvcb =3D {
> +		.header.cmd =3D UVC_CMD_CONV_TO_SEC_STOR,
> +		.header.len =3D sizeof(uvcb),
> +		.guest_handle =3D gmap->guest_handle,
> +		.gaddr =3D gaddr,
> +	};
> +
> +	return uv_make_secure(gmap, gaddr, &uvcb);
> +}

I'd actually suggest to name everything that eats a gmap "gmap_",

e.g., "gmap_make_secure()"

[...]

> =20
>  #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                 =
         \
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index a06a628a88da..15ac598a3d8d 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -9,6 +9,8 @@
>  #include <linux/sizes.h>
>  #include <linux/bitmap.h>
>  #include <linux/memblock.h>
> +#include <linux/pagemap.h>
> +#include <linux/swap.h>
>  #include <asm/facility.h>
>  #include <asm/sections.h>
>  #include <asm/uv.h>
> @@ -99,4 +101,174 @@ void adjust_to_uv_max(unsigned long *vmax)
>  	if (prot_virt_host && *vmax > uv_info.max_sec_stor_addr)
>  		*vmax =3D uv_info.max_sec_stor_addr;
>  }
> +
> +static int __uv_pin_shared(unsigned long paddr)
> +{
> +	struct uv_cb_cfs uvcb =3D {
> +		.header.cmd	=3D UVC_CMD_PIN_PAGE_SHARED,
> +		.header.len	=3D sizeof(uvcb),
> +		.paddr		=3D paddr,

please drop all the superfluous spaces (just as in the other uv calls).

> +	};
> +
> +	if (uv_call(0, (u64)&uvcb))
> +		return -EINVAL;
> +	return 0;
> +}

[...]

> +static int make_secure_pte(pte_t *ptep, unsigned long addr, void *data=
)
> +{
> +	struct conv_params *params =3D data;
> +	pte_t entry =3D READ_ONCE(*ptep);
> +	struct page *page;
> +	int expected, rc =3D 0;
> +
> +	if (!pte_present(entry))
> +		return -ENXIO;
> +	if (pte_val(entry) & (_PAGE_INVALID | _PAGE_PROTECT))
> +		return -ENXIO;
> +
> +	page =3D pte_page(entry);
> +	if (page !=3D params->page)
> +		return -ENXIO;
> +
> +	if (PageWriteback(page))
> +		return -EAGAIN;
> +	expected =3D expected_page_refs(page);

I do wonder if we could factor out expected_page_refs() and reuse from
other sources ...

I do wonder about huge page backing of guests, and especially
hpage_nr_pages(page) used in mm/migrate.c:expected_page_refs(). But I
can spot some hugepage exclusion below ... This needs comments.

> +	if (!page_ref_freeze(page, expected))
> +		return -EBUSY;
> +	set_bit(PG_arch_1, &page->flags);

Can we please document somewhere how PG_arch_1 is used on s390x? (page)

"The generic code guarantees that this bit is cleared for a page when it
first is entered into the page cache" - should not be an issue, right?

> +	rc =3D uv_call(0, (u64)params->uvcb);
> +	page_ref_unfreeze(page, expected);
> +	if (rc)
> +		rc =3D (params->uvcb->rc =3D=3D 0x10a) ? -ENXIO : -EINVAL;
> +	return rc;
> +}
> +
> +/*
> + * Requests the Ultravisor to make a page accessible to a guest.
> + * If it's brought in the first time, it will be cleared. If
> + * it has been exported before, it will be decrypted and integrity
> + * checked.
> + *
> + * @gmap: Guest mapping
> + * @gaddr: Guest 2 absolute address to be imported

I'd just drop the the (incomplete) parameter documentation, everybody
reaching this point should now what a gmap and what a gaddr is ...

> + */
> +int uv_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
> +{
> +	struct conv_params params =3D { .uvcb =3D uvcb };
> +	struct vm_area_struct *vma;
> +	unsigned long uaddr;
> +	int rc, local_drain =3D 0;
> +
> +again:
> +	rc =3D -EFAULT;
> +	down_read(&gmap->mm->mmap_sem);
> +
> +	uaddr =3D __gmap_translate(gmap, gaddr);
> +	if (IS_ERR_VALUE(uaddr))
> +		goto out;
> +	vma =3D find_vma(gmap->mm, uaddr);
> +	if (!vma)
> +		goto out;
> +	if (is_vm_hugetlb_page(vma))
> +		goto out;

Hah there it is! How is it enforced on upper layers/excluded? Will
hpage=3Dtrue fail with prot virt? What if a guest is not a protected gues=
t
but wants to sue huge pages? This needs comments/patch description.

> +
> +	rc =3D -ENXIO;
> +	params.page =3D follow_page(vma, uaddr, FOLL_WRITE | FOLL_NOWAIT);
> +	if (IS_ERR_OR_NULL(params.page))
> +		goto out;
> +
> +	lock_page(params.page);
> +	rc =3D apply_to_page_range(gmap->mm, uaddr, PAGE_SIZE, make_secure_pt=
e, &params);

Ehm, isn't it just always a single page?

> +	unlock_page(params.page);
> +out:
> +	up_read(&gmap->mm->mmap_sem);
> +
> +	if (rc =3D=3D -EBUSY) {
> +		if (local_drain) {
> +			lru_add_drain_all();
> +			return -EAGAIN;
> +		}
> +		lru_add_drain();

comments please why that is performed.

> +		local_drain =3D 1;
> +		goto again;

Could we end up in an endless loop?

> +	} else if (rc =3D=3D -ENXIO) {
> +		if (gmap_fault(gmap, gaddr, FAULT_FLAG_WRITE))
> +			return -EFAULT;
> +		return -EAGAIN;
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(uv_make_secure);
> +
> +/**
> + * To be called with the page locked or with an extra reference!
> + */
> +int arch_make_page_accessible(struct page *page)
> +{
> +	int rc =3D 0;
> +
> +	if (PageHuge(page))
> +		return 0;

Ah, another instance. Comment please why

> +
> +	if (!test_bit(PG_arch_1, &page->flags))
> +		return 0;

"Can you describe the meaning of this bit with three words"? Or a couple
more? :D

"once upon a time, the page was secure and still might be" ?
"the page is secure and therefore inaccessible" ?

> +
> +	rc =3D __uv_pin_shared(page_to_phys(page));
> +	if (!rc) {
> +		clear_bit(PG_arch_1, &page->flags);
> +		return 0;
> +	}
> +
> +	rc =3D uv_convert_from_secure(page_to_phys(page));
> +	if (!rc) {
> +		clear_bit(PG_arch_1, &page->flags);
> +		return 0;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(arch_make_page_accessible);
> +
>  #endif
>=20

More code comments would be highly appreciated!

--=20
Thanks,

David / dhildenb
