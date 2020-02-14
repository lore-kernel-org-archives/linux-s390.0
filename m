Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729070AbgBNKZd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 05:25:33 -0500
Subject: Re: [PATCH 04/35] s390/protvirt: add ultravisor initialization
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-5-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <44aa351c-2333-e1df-42ce-6cf3a6808802@redhat.com>
Date: Fri, 14 Feb 2020 11:25:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-5-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

[...]

>  #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                 =
         \
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index f2ab2528859f..5f178d557cc8 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -560,6 +560,8 @@ static void __init setup_memory_end(void)
>  			vmax =3D _REGION1_SIZE; /* 4-level kernel page table */
>  	}
> =20
> +	adjust_to_uv_max(&vmax);

I'd somewhat prefer

if (prot_virt_host)
	adjust_to_uv_max(&vmax);

> +
>  	/* module area is at the end of the kernel address space. */
>  	MODULES_END =3D vmax;
>  	MODULES_VADDR =3D MODULES_END - MODULES_LEN;
> @@ -1140,6 +1142,7 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	memblock_trim_memory(1UL << (MAX_ORDER - 1 + PAGE_SHIFT));
> =20
> +	setup_uv();

and

if (prot_virt_host)
	setup_uv();

Moving the checks out of the functions. Makes it clearer that this is
optional.

>  	setup_memory_end();
>  	setup_memory();
>  	dma_contiguous_reserve(memory_end);
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index fbf2a98de642..a06a628a88da 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -46,4 +46,57 @@ static int __init prot_virt_setup(char *val)
>  	return rc;
>  }
>  early_param("prot_virt", prot_virt_setup);
> +
> +static int __init uv_init(unsigned long stor_base, unsigned long stor_=
len)
> +{
> +	struct uv_cb_init uvcb =3D {
> +		.header.cmd =3D UVC_CMD_INIT_UV,
> +		.header.len =3D sizeof(uvcb),
> +		.stor_origin =3D stor_base,
> +		.stor_len =3D stor_len,
> +	};
> +	int cc;
> +
> +	cc =3D uv_call(0, (uint64_t)&uvcb);

Could do

int cc =3D uv_call(0, (uint64_t)&uvcb);

> +	if (cc || uvcb.header.rc !=3D UVC_RC_EXECUTED) {
> +		pr_err("Ultravisor init failed with cc: %d rc: 0x%hx\n", cc,
> +		       uvcb.header.rc);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +void __init setup_uv(void)
> +{
> +	unsigned long uv_stor_base;
> +
> +	if (!prot_virt_host)
> +		return;
> +
> +	uv_stor_base =3D (unsigned long)memblock_alloc_try_nid(
> +		uv_info.uv_base_stor_len, SZ_1M, SZ_2G,
> +		MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
> +	if (!uv_stor_base) {
> +		pr_info("Failed to reserve %lu bytes for ultravisor base storage\n",
> +			uv_info.uv_base_stor_len);

pr_err() ? pr_warn()?

> +		goto fail;
> +	}
> +
> +	if (uv_init(uv_stor_base, uv_info.uv_base_stor_len)) {
> +		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
> +		goto fail;
> +	}
> +
> +	pr_info("Reserving %luMB as ultravisor base storage\n",
> +		uv_info.uv_base_stor_len >> 20);
> +	return;
> +fail:

I'd add here:

pr_info("Disabling support for protected virtualization");

> +	prot_virt_host =3D 0;> +}
> +
> +void adjust_to_uv_max(unsigned long *vmax)
> +{
> +	if (prot_virt_host && *vmax > uv_info.max_sec_stor_addr)
> +		*vmax =3D uv_info.max_sec_stor_addr;

Once you move the prot virt check out of this function

	*vmax =3D max_t(unsigned long, *vmax, uv_info.max_sec_stor_addr);

> +}
>  #endif
>=20


--=20
Thanks,

David / dhildenb
