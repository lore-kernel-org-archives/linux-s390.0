Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE236EA98;
	Thu,  9 Jul 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610742; cv=none; b=suwEmscgxTR5C1fkxVkFeCK3XyY5xcomTA0PivkeyPpwp+/QGULA1g690AGfiUpFf2GEmSWTayeDAjeY46Nhl1KOlQKpYLLnlQZmQTp605M/NC8aZ0zxkxAGsGsK4ZVHOeaIseHHjRtXSfVqrGdCHrKlSK5YJsAOw3P1hIiiUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610742; c=relaxed/simple;
	bh=DdTFjLHjssV3wK6rKlS+tPTY/zuDw3H2I/ozXo0kJdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svNaZiCHVJkB40p9AYprykbADsvTIReM7oF+bKluHCjvBfbV8eo+n2Mak/gZdgg8JeelPV5EwNWW/xBiERBO2z5teqYmTeDEXY0xsUqOLRkZ8geZdJQucttsHM8bh7xvjCgYmkR+Miu7zPE4lYclRE47WmXa78DgmHwmH2srDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kryV9sqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kryV9sqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596461F00A3A;
	Thu,  9 Jul 2026 15:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610740;
	bh=JAFiL36r/G0cZxeKduUvAGyRirtPuay1HexwZhQigBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kryV9sqLlM1R8hfQjJbURkwW3GS2sW2XzRJ6SkjnPm10UAomIxnKVbzmvfVQNYRgb
	 Lni/Gy1RuHQ9SHgWXMQ1u4VxsAP/1e2ECD1ZmAghCq3FeilQ5PPLq4UJ69REP5IV3l
	 NdUCir88+q6XePW17NaG/R/nLS4dzIad72lkMtUUTIsnKjXoL4rAPI/BJnGx0tyAK2
	 RutxJAsrc8b+WS/0K9uiwyN3qvmyfph2qjEEzUIwoPPSt/3WrHMDIxQsl53BXgreJv
	 o3Hwm3ox6onW4lzLKA2ysfCTX87DNC058db8cw2y54OR1gX4itdwFHjmscHGdXHWoy
	 CrXCIUbDOD3yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/21] KVM: s390: vsie: Replace radix_tree with xarray
 addr_to_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-12-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-12-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:25:39 +0000
Message-Id: <20260709152540.596461F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional overwrite and logic error in `get_vsie_page` due to =
`xa_store()` misuse.
- [Medium] Missing `xa_destroy()` causes memory leak of XArray internal nod=
es during VM teardown.
- [Medium] Incorrect XArray initialization drops memcg accounting and adds =
free-slot tracking overhead.
--

--- Patch [12]: [PATCH 12/21] KVM: s390: vsie: Replace radix_tree with xarr=
ay addr_to_page ---
commit b9607cfaff7f6d624df41b31c8e80cc0a315a2e3
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Replace radix_tree with xarray addr_to_page

This commit replaces the radix_tree implementation in the s390 vsie with
an xarray for addr_to_page. Changing to the xarray API directly relaxes some
of the locking obligations and provides more symmetry with the next vsie
changes in the series.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 4090b4019f215..1734215ae73a9 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> @@ -1574,14 +1569,13 @@ static struct vsie_page *get_vsie_page(struct kvm=
 *kvm, unsigned long addr)
>  			kvm->arch.vsie.next %=3D nr_vcpus;
>  		}
>  		if (vsie_page->scb_gpa !=3D ULONG_MAX)
> -			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
> -					  vsie_page->scb_gpa >> 9);
> +			xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> 9);
>  		/* Mark it as invalid until it resides in the tree. */
>  		vsie_page->scb_gpa =3D ULONG_MAX;
>  	}
> =20
>  	/* Double use of the same address or allocation failure. */
> -	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_pag=
e)) {
> +	if (xa_store(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_page, GFP_KE=
RNEL)) {

[Severity: High]
Does this unintentionally change the error handling semantics by using
xa_store() instead of xa_insert()?

The original radix_tree_insert() correctly refused to overwrite existing
entries and returned an error (e.g., -EEXIST). However, xa_store()
unconditionally overwrites the entry and returns the previous pointer or an
error pointer on failure.

If an entry already exists, xa_store() returns the old vsie_page pointer,
which evaluates to true. The code incorrectly treats this as an error, call=
ing
put_vsie_page() on the newly inserted page while returning NULL. The new pa=
ge
remains in the xarray but its scb_gpa is left as ULONG_MAX, breaking lookups
for this address.

Also, should this be using GFP_KERNEL_ACCOUNT to maintain the accounting
properties of the original code?

>  		put_vsie_page(vsie_page);
>  		mutex_unlock(&kvm->arch.vsie.mutex);
>  		return NULL;
[ ... ]
> @@ -1660,7 +1654,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>  void kvm_s390_vsie_init(struct kvm *kvm)
>  {
>  	mutex_init(&kvm->arch.vsie.mutex);
> -	INIT_RADIX_TREE(&kvm->arch.vsie.addr_to_page, GFP_KERNEL_ACCOUNT);
> +	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ALLOC);

[Severity: Medium]
Should this use XA_FLAGS_ACCOUNT (or 0) instead of XA_FLAGS_ALLOC?

The original code initialized the radix tree with GFP_KERNEL_ACCOUNT, ensur=
ing
that memory allocated for internal nodes was accounted to the guest's memory
cgroup. Initializing with XA_FLAGS_ALLOC and storing with GFP_KERNEL drops =
this
accounting.

Additionally, XA_FLAGS_ALLOC enables internal free-slot tracking
(XA_FLAGS_TRACK_FREE) which is typically meant for ID allocators (like
xa_alloc()). Using this on an xarray indexed by sparse physical addresses a=
dds
unnecessary overhead.

>  }
> =20
>  /* Destroy the vsie data structures. To be called when a vm is destroyed=
. */
> @@ -1676,10 +1670,8 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
>  			if (vsie_page->gmap_cache.gmap)
>  				release_gmap_shadow(vsie_page);
>  		kvm->arch.vsie.pages[i] =3D NULL;
> -		/* free the radix tree entry */
>  		if (vsie_page->scb_gpa !=3D ULONG_MAX)
> -			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
> -					  vsie_page->scb_gpa >> 9);
> +			xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> 9);
>  		free_vsie_page(vsie_page);
>  	}
>  	kvm->arch.vsie.page_count =3D 0;

[Severity: Medium]
Will this leak the xarray internal nodes when tearing down a VM?

If any page was left with scb_gpa =3D=3D ULONG_MAX (e.g., due to the xa_sto=
re()
issue mentioned above), xa_erase() is skipped for that entry.

Because the VM destruction path never calls
xa_destroy(&kvm->arch.vsie.addr_to_page), the xarray internal nodes allocat=
ed
for any remaining entries will be permanently leaked. Should xa_destroy() be
called here to guarantee all internal memory is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D12
