Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6E3A5433;
	Tue, 28 Jul 2026 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259241; cv=none; b=hujYPJn6GVR1ighV3Uien7cPYdE+BdIZx7NFo+SFKI4QwkLW9Rvvx0yax5T+OFOtlROCqF5fKIZSQchZ3XhiG31xp7oaS+It7DjXSnX9Rj0rXN1B19sySxM7dw6vAdyD5MaCtMDTuQLBxNmk2Vd1kLWAYtAycuhXTF7BQ/V86qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259241; c=relaxed/simple;
	bh=FA2pKaJ9gNV5cAHUFXf4Sk1FhqZHuhGh/VE/CMELh6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lhoKsNS4/+CfyA3kJRZd0KQNKlIiEEuGZXtGGCqUamVAKhPbc91OrGGRpWH5m6Au0ocOXXQU91Hz0ehqyQHOdL1zLbDX/n9rtd4cabjmJvy3CuVQ4fcfD0boAAadYpuUsWYlam4QPnK3ZHxExnv2tdWywBFZez5Zn0VaS36LHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUo1hDuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUo1hDuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248CC1F000E9;
	Tue, 28 Jul 2026 17:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259240;
	bh=7rRC6vTr6whUBQcu5Y5lrisf0123/gcns6FhU/1UnQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUo1hDucUYPBQqHxwnX3KQ1xbApplh7D20xG9oTn30Mn9ryad1yYjgd/ojanximtK
	 kzC58vy2Yb44UQhF9VOV+miwC50DvFn76THqJZs81S9xEI2a+LtejGfpOPy09XSHQT
	 TeZmKIbNdWqe7Rc7N8jz15kA8DEO67a10k+sNcMHSGaBWxNFvStibB+sdIhSPIj+kq
	 t8ca5NoTTatOaBJtUU3XfVjVJ91r5ItbcqnKWpaYfbmDCZvcnxgR8xko2Q25ziaiqn
	 +G4dnjd8eD8rGJLsILCs5MXDLUJqwlv5XK+4A+ddqCirKBIACkDaHk/xmkUleliFY+
	 3SDq+1F6dmeyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/13] KVM: s390: ucontrol: Add missing locking
 around gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260728170708.294400-6-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:20:39 +0000
Message-Id: <20260728172040.248CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The struct kvm_s390_mmu_cache (vcpu->arch.mc) is permanently leake=
d in the error cleanup paths of kvm_arch_vcpu_create().
--

--- Patch [5]: [PATCH v4 05/13] KVM: s390: ucontrol: Add missing locking ar=
ound gmap_remove_child() ---
commit 8377be474458b5d68906db9024e50f7b0c2263fe
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Add missing locking around gmap_remove_child()

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 5046de39d739e..fa6a0bacd9675 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3868,7 +3868,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> =20
>  out_ucontrol_uninit:
>  	if (kvm_is_ucontrol(vcpu->kvm)) {
> +		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
>  		gmap_remove_child(vcpu->arch.gmap);
> +		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
>  		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
>  	}
>  out_free_sie_block:
>  	free_page((unsigned long)(vcpu->arch.sie_block));
>  	return rc;

[Severity: High]
This is a pre-existing issue, but does this error path leak vcpu->arch.mc?

In kvm_arch_vcpu_create(), vcpu->arch.mc is dynamically allocated via
kvm_s390_new_mmu_cache(). If a subsequent step like gmap_new_child() or
kvm_s390_vcpu_setup() fails, the code jumps here to out_ucontrol_uninit
or out_free_sie_block.

Since these paths return an error without calling
kvm_s390_free_mmu_cache(vcpu->arch.mc), and the core KVM code in
kvm_vm_ioctl_create_vcpu() does not invoke kvm_arch_vcpu_destroy() when
creation fails, it appears this memory could be permanently leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D5
