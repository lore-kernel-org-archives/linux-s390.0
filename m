Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC93D954C;
	Fri, 31 Jul 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504110; cv=none; b=aTHRMGBTRIZBwy82G7gUruAOT6bNzu2OQO8/a0CXDyIMsXWvxEIxEDXF32DQqsyobZZADx+IOJyXnXog5BKIYjH5kWHumnfnl8zxoqw17KA8u1t8M8BvpRwq7YkpSHRrVvLPdJrZNKTRhiNqFeBmZwCP8xL1cnZaMzU806O023Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504110; c=relaxed/simple;
	bh=oQrDbiIp17HmAvAxBKgPwp2JGywpR1NuZrS+A59C5Gg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jUb3WPC9pMd71HdyPzLyb8LVk9prBhHcptJMOfPilaVuzpWra8EPmNL9vxGijclT07XVNo1YmKt63rnYT8OFB6SXHetYcWZf/PdwhvvUbhr36mnU9k1cjJg6CQ9dybXCsyNcti+5KXcujqXuqzFaWRoL1QZ01Li3HUhfZ5ceBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzVRSRJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzVRSRJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C361B1F000E9;
	Fri, 31 Jul 2026 13:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504109;
	bh=XlAF5CwvMdQFzhsqk96FNUg7fgpwMDLqF+erUmCaBv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzVRSRJRbXbGGR+rj+TESD47yGyIBJrlB0Q7IIL4rnDF2D9H0wO/3hoF9P56+JuKm
	 cPmoWZxejTE1bn2g0ldsw56VNvdGhsqSvCoqj6srl38J32PQSq9zW0tKhPGvmJVwcV
	 zwc73czRIiyOji5P/Qu162G4T1FuSlHYzEbyA4+wqK4+hFNYBGB6uwiQEN1gXjVIVB
	 t7YjeSgV6hq1rnzDzpL1h9Ic8ip9NEPH8JN1CiV5IAnvCKoKJCV/YopkWc4NSnuQSJ
	 fZAsQIvAnmdSon2nxTgKK0I918unRfM8FbmvaHjxyWeqLxBk2V9srKV9fzF2fZ0Tov
	 GFjpLsZejG+jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/14] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731130138.173983-4-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:21:48 +0000
Message-Id: <20260731132148.C361B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `kvm_arch_vcpu_create` function leaks the MMU cache on error p=
aths.
- [High] Memory leak of protected VCPU storage base (`stor_base`) and SIDA =
pages when `uv_call` fails in `kvm_s390_pv_create_cpu()`.
--

--- Patch [3]: [PATCH v7 03/14] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()=
 ---
commit a13468185076d541edaaa78721cdc3f5e4915351
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>
KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()

This patch fixes an issue in kvm_s390_vcpu_unsetup_cmma() where a 0
cbrlo could cause free_page() to attempt to free physical page 0 when
running with V !=3D R. It adds a check to only free cbrlo if it is non-zero.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1b3290a5ad1ae..9be27db0a21e6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3678,7 +3678,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_v=
cpu *vcpu)
> =20
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>  {
> -	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
> +	if (vcpu->arch.sie_block->cbrlo)
> +		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
>  	vcpu->arch.sie_block->cbrlo =3D 0;
>  }
> =20

[Severity: High]
This isn't a regression introduced by this patch, but the kvm_arch_vcpu_cre=
ate
function appears to leak the MMU cache on error paths:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
...
	if (kvm_is_ucontrol(vcpu->kvm)) {
		rc =3D -ENOMEM;
		vcpu->arch.gmap =3D gmap_new_child(vcpu->kvm->arch.gmap, -1UL);
		if (!vcpu->arch.gmap)
			goto out_free_sie_block;
	}
...
out_free_sie_block:
	free_page((unsigned long)(vcpu->arch.sie_block));
	return rc;
}

Can this leak vcpu->arch.mc? If vcpu creation fails after it is allocated,
the error path jumps to out_free_sie_block, but it doesn't seem to free
vcpu->arch.mc. Since kvm->created_vcpus is decremented upon failure,
could an unprivileged user repeatedly call KVM_CREATE_VCPU to trigger
failures and exhaust kernel memory?

[Severity: High]
This is a pre-existing regression, but there is also a potential memory leak
of the protected vcpu storage base (stor_base) and SIDA pages when
uv_call() fails:

arch/s390/kvm/pv.c:kvm_s390_pv_create_cpu() {
...
	cc =3D uv_call(0, (u64)&uvcb);
...
	if (cc) {
		u16 dummy;

		kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
		return -EIO;
	}
...
}

arch/s390/kvm/pv.c:kvm_s390_pv_destroy_cpu() {
...
	if (!kvm_s390_pv_cpu_get_handle(vcpu))
		return 0;
...
}

Since the handle is only set after a successful uv_call(), does the early
return in kvm_s390_pv_destroy_cpu() silently skip freeing
vcpu->arch.pv.stor_base and the sidad page? Could this be reached by a
user repeatedly calling KVM_CREATE_VCPU on a protected VM to trigger
failures, leading to a host denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D3
