Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2F3A05F2;
	Wed, 29 Jul 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347451; cv=none; b=mBF+w6BepEnRmp3BzcMq9hyY6vEWOyHBwvM2/dAt2+e6ATeZ+bV4m5mo8iejb4lhMdxMuEYVjV8Yj7j9LKtnjsmQ7rDlmvtJx1YJsx0Lb9sm+5hPGNUtinb/qzmShcUzkKhztUnMZt++rIsyDT9TVAZpZHD9btkoaNivTD1w0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347451; c=relaxed/simple;
	bh=ef859Lgt/Gq70oZYk1Spr9Vkfj16lKxPR1XSZea+SgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m+QH5w54ldOTE8QL/uT9/DR1ZNFIeYM0dwM8DicqAn3RbCUWlEQWHS54+85mLrP+YetVVuc9iDWKN71O7K3N/4aBw5/8Yn98vYcmy+oLwaZ6F9SjFY5u88eFBDemsfkmbwiM0RnpfOrxqjO2mXAx4Ki3t6GxAFgvcFNeSZLw9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=off2nohn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="off2nohn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06E91F000E9;
	Wed, 29 Jul 2026 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785347447;
	bh=cO+p35hq8V2ZB40yql/iZFJocM0TmHpoboLg82yuncg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=off2nohnNYEIUNXRhPRNdICSu4+nQqGNzIBoPFQR/+p6861CuEVgoS3wylBedaWRT
	 vxCmhlGciWJHWYBXdvN/DOBASs+kvwvWkFIn1GNU/Vf3DfGKTtusiRTgaz8lFE/Wrg
	 GuQEds0qydhvYll3zAJCEMFtbH8+GVn04kTZtO/cvT8ghQMqy1pR2NBid35jcx46EV
	 XndqxCkVTssNc+3oane9yUBY726ZeWyoMFmlANOePnjk6qrIot7nwlxZVwa/TdrPmu
	 o2P2n4NsBEvk0E+FshG90VDgP3dU9wOACL6czwvz7HO+aroRMBXy0EFnnYcshygXdE
	 7H+lxI9A8ERzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/13] KVM: s390: ucontrol: Add missing locking
 around gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729152938.782383-9-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:50:46 +0000
Message-Id: <20260729175046.F06E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The struct kvm_s390_mmu_cache (vcpu->arch.mc) is permanently leake=
d on error paths in kvm_arch_vcpu_create().
--

--- Patch [8]: [PATCH v5 08/13] KVM: s390: ucontrol: Add missing locking ar=
ound gmap_remove_child() ---
commit 1255c78b1a63e5de1172d37ceb311f1fd31eb54f
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Add missing locking around gmap_remove_child()

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2ae431030621e..c04b7e84c4346 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3869,7 +3869,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> =20
>  out_ucontrol_uninit:
>  	if (kvm_is_ucontrol(vcpu->kvm)) {
> +		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
>  		gmap_remove_child(vcpu->arch.gmap);
> +		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
>  		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
>  	}
>  out_free_sie_block:

[Severity: High]
This isn't a bug introduced by this patch, but does this error path
permanently leak the struct kvm_s390_mmu_cache (vcpu->arch.mc)?

Looking at kvm_arch_vcpu_create() in arch/s390/kvm/kvm-s390.c, vcpu->arch.mc
is dynamically allocated earlier in the function via kvm_s390_new_mmu_cache=
().

If a subsequent setup step fails (such as gmap_new_child or
kvm_s390_vcpu_setup) and execution jumps to out_ucontrol_uninit or
out_free_sie_block, the function returns without calling
kvm_s390_free_mmu_cache(vcpu->arch.mc).

Since the KVM core bypasses kvm_arch_vcpu_destroy() when vCPU creation fail=
s,
could this lead to a permanent memory leak if a user repeatedly creates VMs
and artificially triggers failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D8
