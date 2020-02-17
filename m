Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37749 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729045AbgBQKV7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 05:21:59 -0500
Subject: Re: [PATCH v2 05/42] s390/mm: provide memory management functions for
 protected KVM guests
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-6-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f5523486-ee76-e6c1-9563-658bca7f3b0d@redhat.com>
Date: Mon, 17 Feb 2020 11:21:44 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-6-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org

> diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.=
h
> index 85e944f04c70..4ebcf891ff3c 100644
> --- a/arch/s390/include/asm/page.h
> +++ b/arch/s390/include/asm/page.h
> @@ -153,6 +153,11 @@ static inline int devmem_is_allowed(unsigned long =
pfn)
>  #define HAVE_ARCH_FREE_PAGE
>  #define HAVE_ARCH_ALLOC_PAGE
> =20
> +#if IS_ENABLED(CONFIG_PGSTE)
> +int arch_make_page_accessible(struct page *page);
> +#define HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
> +#endif
> +

Feels like this should have been one of the (CONFIG_)ARCH_HAVE_XXX
thingies defined via kconfig instead.

E.g., like (CONFIG_)HAVE_ARCH_TRANSPARENT_HUGEPAGE

[...]

> +
> +/*
> + * Requests the Ultravisor to encrypt a guest page and make it
> + * accessible to the host for paging (export).
> + *
> + * @paddr: Absolute host address of page to be exported
> + */
> +int uv_convert_from_secure(unsigned long paddr)
> +{
> +	struct uv_cb_cfs uvcb =3D {
> +		.header.cmd =3D UVC_CMD_CONV_FROM_SEC_STOR,
> +		.header.len =3D sizeof(uvcb),
> +		.paddr =3D paddr
> +	};
> +
> +	if (uv_call(0, (u64)&uvcb))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +/*
> + * Calculate the expected ref_count for a page that would otherwise ha=
ve no
> + * further pins. This was cribbed from similar functions in other plac=
es in
> + * the kernel, but with some slight modifications. We know that a secu=
re
> + * page can not be a huge page for example.

s/ca not cannot/

> + */
> +static int expected_page_refs(struct page *page)
> +{
> +	int res;
> +
> +	res =3D page_mapcount(page);
> +	if (PageSwapCache(page)) {
> +		res++;
> +	} else if (page_mapping(page)) {
> +		res++;
> +		if (page_has_private(page))
> +			res++;
> +	}
> +	return res;
> +}
> +
> +static int make_secure_pte(pte_t *ptep, unsigned long addr,
> +			   struct page *exp_page, struct uv_cb_header *uvcb)
> +{
> +	pte_t entry =3D READ_ONCE(*ptep);
> +	struct page *page;
> +	int expected, rc =3D 0;
> +
> +	if (!pte_present(entry))
> +		return -ENXIO;
> +	if (pte_val(entry) & _PAGE_INVALID)
> +		return -ENXIO;
> +
> +	page =3D pte_page(entry);
> +	if (page !=3D exp_page)
> +		return -ENXIO;
> +	if (PageWriteback(page))
> +		return -EAGAIN;
> +	expected =3D expected_page_refs(page);
> +	if (!page_ref_freeze(page, expected))
> +		return -EBUSY;
> +	set_bit(PG_arch_1, &page->flags);
> +	rc =3D uv_call(0, (u64)uvcb);
> +	page_ref_unfreeze(page, expected);
> +	/* Return -ENXIO if the page was not mapped, -EINVAL otherwise */
> +	if (rc)
> +		rc =3D uvcb->rc =3D=3D 0x10a ? -ENXIO : -EINVAL;
> +	return rc;
> +}
> +
> +/*
> + * Requests the Ultravisor to make a page accessible to a guest.
> + * If it's brought in the first time, it will be cleared. If
> + * it has been exported before, it will be decrypted and integrity
> + * checked.
> + */
> +int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvc=
b)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long uaddr;
> +	struct page *page;
> +	int rc, local_drain =3D 0;

local_drain could have been a bool.

> +	spinlock_t *ptelock;
> +	pte_t *ptep;
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
> +	/*
> +	 * Secure pages cannot be huge and userspace should not combine both.
> +	 * In case userspace does it anyway this will result in an -EFAULT fo=
r
> +	 * the unpack. The guest is thus never reaching secure mode. If
> +	 * userspace is playing dirty tricky with mapping huge pages later
> +	 * on this will result in a segmenation fault.

s/segmenation/segmentation/

> +	 */
> +	if (is_vm_hugetlb_page(vma))
> +		goto out;
> +
> +	rc =3D -ENXIO;
> +	page =3D follow_page(vma, uaddr, FOLL_WRITE);
> +	if (IS_ERR_OR_NULL(page))
> +		goto out;
> +
> +	lock_page(page);
> +	ptep =3D get_locked_pte(gmap->mm, uaddr, &ptelock);
> +	rc =3D make_secure_pte(ptep, uaddr, page, uvcb);
> +	pte_unmap_unlock(ptep, ptelock);
> +	unlock_page(page);
> +out:
> +	up_read(&gmap->mm->mmap_sem);
> +
> +	if (rc =3D=3D -EAGAIN) {
> +		wait_on_page_writeback(page);
> +	} else if (rc =3D=3D -EBUSY) {
> +		/*
> +		 * If we have tried a local drain and the page refcount
> +		 * still does not match our expected safe value, try with a
> +		 * system wide drain. This is needed if the pagevecs holding
> +		 * the page are on a different CPU.
> +		 */
> +		if (local_drain) {
> +			lru_add_drain_all();

I do wonder if that is valid to be called with all the locks at this poin=
t.

> +			/* We give up here, and let the caller try again */
> +			return -EAGAIN;
> +		}
> +		/*
> +		 * We are here if the page refcount does not match the
> +		 * expected safe value. The main culprits are usually
> +		 * pagevecs. With lru_add_drain() we drain the pagevecs
> +		 * on the local CPU so that hopefully the refcount will
> +		 * reach the expected safe value.
> +		 */
> +		lru_add_drain();

dito ...

> +		local_drain =3D 1;
> +		/* And now we try again immediately after draining */
> +		goto again;
> +	} else if (rc =3D=3D -ENXIO) {
> +		if (gmap_fault(gmap, gaddr, FAULT_FLAG_WRITE))
> +			return -EFAULT;
> +		return -EAGAIN;
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(gmap_make_secure);
> +
> +int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr)
> +{
> +	struct uv_cb_cts uvcb =3D {
> +		.header.cmd =3D UVC_CMD_CONV_TO_SEC_STOR,
> +		.header.len =3D sizeof(uvcb),
> +		.guest_handle =3D gmap->guest_handle,
> +		.gaddr =3D gaddr,
> +	};
> +
> +	return gmap_make_secure(gmap, gaddr, &uvcb);
> +}
> +EXPORT_SYMBOL_GPL(gmap_convert_to_secure);
> +
> +/**
> + * To be called with the page locked or with an extra reference!

Can we have races here? (IOW, two callers concurrently for the same page)

> + */
> +int arch_make_page_accessible(struct page *page)
> +{
> +	int rc =3D 0;
> +
> +	/* Hugepage cannot be protected, so nothing to do */
> +	if (PageHuge(page))
> +		return 0;
> +
> +	/*
> +	 * PG_arch_1 is used in 3 places:
> +	 * 1. for kernel page tables during early boot
> +	 * 2. for storage keys of huge pages and KVM
> +	 * 3. As an indication that this page might be secure. This can
> +	 *    overindicate, e.g. we set the bit before calling
> +	 *    convert_to_secure.
> +	 * As secure pages are never huge, all 3 variants can co-exists.
> +	 */
> +	if (!test_bit(PG_arch_1, &page->flags))
> +		return 0;
> +
> +	rc =3D uv_pin_shared(page_to_phys(page));
> +	if (!rc) {
> +		clear_bit(PG_arch_1, &page->flags);
> +		return 0;
> +	}

Overall, looks sane to me. (I am mostly concerned about possible races,
e.g., when two gmaps would be created for a single VM and nasty stuff be
done with them). But yeah, I guess you guys thought about this ;)

--=20
Thanks,

David / dhildenb
