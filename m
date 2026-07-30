Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A03932C8;
	Thu, 30 Jul 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430531; cv=none; b=fCNYuTFhbNPPZNgPInpw153eNHqf1kkzKVGXl+lqNhsIeR0cYMfuUubPMXFTHAQRaNz70ZIo0xd6oMWD7NXEnZyvx/kSVBBfZaGbbJWK735Mxp89zBiE5x8r2Sdb1lRmS9Ls+K8Qb6BVVvpRgKu1W4J4sqyct2WEKOlVGV2GmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430531; c=relaxed/simple;
	bh=Yp2STJTKiXKmLlTUBQJQggde7m+/507H9FF0Ljiiwck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OOmQNJIelsn48pZbxawmFc5Bw5+Zvd6HjAanUhLkU38V0FUT8oZo4ZetftmnjScn6TKtVbhuC8cbVFPYWF5FNFhA97Z9hFFseEDE3ahYxUEP+iwxePBut2mRTGcTmh+qHJ8kTf3aXksF7CeT3W/oDVTBC1dweuCxkleHGEud2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYLDM57u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYLDM57u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276F11F000E9;
	Thu, 30 Jul 2026 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430530;
	bh=PzQ1APsjxsRrucXCM3nUy2jsXkzxHNYL9DbI3qGTSn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYLDM57umrYyMeb69GlMRI9yn9HaWx7XrzeeuGk/kdaf5nXcmGINbZ5YxsSXDZiN/
	 ePG7xtJ+4te6fT73MP6IkdFgCp9OWuf7s0zQbfuKvnQ9D803igwaFn/dUPV2JRLzKs
	 KaePRuZrrdIy6+EzKT4oGgBXuj8uHNXwj7vMYQkq90BPCK/zqU5So1fLQdjTU2goQ0
	 X5W2CZfhRnB5tANRsyu6keEsS3MeRfkyF1YSqXA+q4xIWmjh4Q3mPrXomRwfSo6iLN
	 PPAqtm0s7eo5PEfkLcngYjY5EJtqlA82AIin2v/r9cnln2MY99MYY9j8BqZWJ0CRNV
	 CeoSB+Fah7/PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/14] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260730162714.133327-3-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:55:29 +0000
Message-Id: <20260730165530.276F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unprivileged local memory corruption via `sca_dispose(NULL)` l=
eading to freeing physical pages 1, 2, and 3.
- [High] Memory leak of `vcpu->arch.mc` in the error path of `kvm_arch_vcpu=
_create()`.
- [High] Missing lock acquisition when removing a child gmap in the vCPU cr=
eation error path.
- [High] When `uv_call` fails during `kvm_s390_pv_create_cpu()`, newly allo=
cated `stor_base` and `sida_addr` pages are permanently leaked.
--

--- Patch [2]: [PATCH v6 02/14] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()=
 ---
commit b2abac5b0352ced2b250d10ad5dfc60b18cae87c
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()

In some cases kvm_s390_vcpu_unsetup_cmma() can be called with a 0
cbrlo; in such cases, if running with V !=3D R, free_page() will attempt
to free physical page 0.

Fix by freeing cbrlo only if it's non-zero.

Fixes: b31605c12f4e ("KVM: s390: make cmma usage conditionally")
Fixes: 29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle=
 handling")

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f86b4b0b356f4..9ec5833a09732 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3677,7 +3677,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_v=
cpu *vcpu)
> =20
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>  {
> -	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
> +	if (vcpu->arch.sie_block->cbrlo)
> +		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
>  	vcpu->arch.sie_block->cbrlo =3D 0;
>  }

While reviewing this code, a few other things were noticed nearby.

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
[ ... ]
out_ucontrol_uninit:
	if (kvm_is_ucontrol(vcpu->kvm)) {
		gmap_remove_child(vcpu->arch.gmap);

[Severity: High]
This is a pre-existing issue, but is it possible we are missing a lock here?

In kvm_arch_vcpu_create(), if a ucontrol VM's vCPU setup fails, it calls
gmap_remove_child(vcpu->arch.gmap).

The gmap_remove_child() function expects the parent gmap's children_lock to
be held and concurrently modifies the parent gmap's children list. However,
this error path appears to omit acquiring the children_lock.

Could this lead to a data race and list corruption?


		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
	}
out_free_sie_block:
	free_page((unsigned long)(vcpu->arch.sie_block));
	return rc;
}

[Severity: High]
This is a pre-existing issue, but what happens to the vcpu->arch.mc memory
when we take this error path?

When an error occurs in kvm_arch_vcpu_create() after vcpu->arch.mc
allocation, the code jumps to out_ucontrol_uninit and out_free_sie_block.

While it frees the sie_block and removes the gmap child, it seems to never
free the memory allocated by kvm_s390_new_mmu_cache(vcpu->arch.mc).

Can userspace repeatedly trigger vCPU creation failures to leak memory and
cause a local denial of service?


arch/s390/kvm/kvm-s390.c:kvm_arch_init_vm() {
[ ... ]
out_err:
	free_page((unsigned long)kvm->arch.sie_page2);
	debug_unregister(kvm->arch.dbf);
	sca_dispose(kvm);
[ ... ]
}

arch/s390/kvm/kvm-s390.c:sca_dispose() {
	free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
	kvm->arch.sca =3D NULL;
}

[Severity: Critical]
This is a pre-existing issue, but is there a risk of memory corruption here?

In kvm_arch_init_vm(), if VM creation fails early, the code jumps to out_err
before kvm->arch.sca is allocated.

Since the kvm structure is zero-allocated, kvm->arch.sca is NULL.

The sca_dispose() function calls
free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca)). The size of
struct esca_block is roughly 16KB.

The free_pages_exact(virt, size) function loops from addr =3D virt to
addr + PAGE_ALIGN(size), incrementing by PAGE_SIZE, and calls
free_page(addr).

For virt =3D=3D NULL, it iterates through addresses 0, 4096, 8192, and 1228=
8.

While free_page(0) is safely ignored, free_page(4096) translates to
__free_pages(virt_to_page(4096), 0) and incorrectly frees host physical pag=
es
1, 2, and 3 into the buddy allocator.

Can an unprivileged user trigger this trivially by calling
ioctl(KVM_CREATE_VM, 1)?


arch/s390/kvm/pv.c:kvm_s390_pv_create_cpu() {
[ ... ]
	cc =3D uv_call(0, (u64)&uvcb);
[ ... ]
	if (cc) {
		u16 dummy;

		kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
		return -EIO;
	}
[ ... ]
}

arch/s390/kvm/pv.c:kvm_s390_pv_destroy_cpu() {
	int cc;

	if (!kvm_s390_pv_cpu_get_handle(vcpu))
		return 0;
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but does this error handling permanently leak
the newly allocated stor_base and sida_addr pages?

The kvm_s390_pv_create_cpu() function allocates vcpu->arch.pv.stor_base
and sida_addr. If uv_call fails, it jumps to error handling which
calls kvm_s390_pv_destroy_cpu(vcpu).

However, kvm_s390_pv_destroy_cpu() begins with an early return:
if (!kvm_s390_pv_cpu_get_handle(vcpu)) return 0;

Because vcpu->arch.pv.handle is only set upon successful uv_call completion,
the handle is 0 here. Thus, the destruction routine does nothing and bypass=
es
the free_pages() blocks entirely.

Could a compromised or malicious userspace trigger failures in uv_call to
repeatedly leak host memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D2
