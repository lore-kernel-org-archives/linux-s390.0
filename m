Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17D371D1D;
	Mon,  3 Aug 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777553; cv=none; b=WLC4Yzgv+Z3y4sCl/8TeUZdOFN8R2tW4diGKTMZLfDAKIYzgl4AYRFukYHmmirbbHOT51NtSgCMWm9Cg934up58Fk5v/xK2jbzymWNd58BdYOYlz7HJngCDQQKn1kvsfxwCXNf8eTvRWWRTIaazAUAWIXduhytOoI3nz68iRD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777553; c=relaxed/simple;
	bh=DdoKkB1OQAtTSoYqx4cw2e53a4HMsD/juRnyW5bU+Mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AjBJz1Xe82UZrolwgO+7iLBJ1vYNfRZJs5YKmE5qn0X0BoOYKKIyCfyO1bl83LKUEdTA+B9Vt81DPm0K+XCzc4zVz3m2lLmKvu91o6Gty1g85QBW/yBo5KkrLS061pa2lKFa7ej9ne9PhYf8SLuviGqyGx/F5ZekdO9i9z3yH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNq7AJ5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNq7AJ5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39A41F00A3A;
	Mon,  3 Aug 2026 17:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777552;
	bh=OS65eQmi8bBmH9boGJCbiz6974n/rD2WpRZvNRqGpx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNq7AJ5+07DZF2Yh5IakDMnxAMzZCEB216WKKgnyd2jgEdNf2M2rMd/KzRsKpYn6S
	 ezhgn7DWv0Pww8X/FaAoD+vFOUxLjGAKU2rVi+jf6CWTPB1JBrfXkWMumVv1JCJAWW
	 qSWQAQx23fPkmHoYgcKwbrzYFyOdzkOSv2oGGT0bYKk+Rx9n3Rvf2XPnGBkHv8Nz7W
	 W8znVtBogMM7UGhcJCnLpfFgUzZlZAtIh+9euB8+wG5N/SxoFSA5Fzh9Z5+SmKUKxs
	 dyt9cVr4OQqh9zkil31JqmKEUUiRpoI7yPyL9VtfFMQ0nOK+IE2OW7oH3XZF0Ch5+J
	 BJVv7ODu3qGrA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 19/23] KVM: s390: ucontrol: Add missing locking
 around gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803160924.236807-20-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-20-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:19:10 +0000
Message-Id: <20260803171911.D39A41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of `vcpu->arch.mc` on error paths in `kvm_arch_vcp=
u_create`.
--

--- Patch [19]: [GIT PULL v1 19/23] KVM: s390: ucontrol: Add missing lockin=
g around gmap_remove_child() ---
commit 61cd1afcaa7879de84aab0c942311aadeeda9499
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Add missing locking around gmap_remove_child()

This commit adds missing locking around gmap_remove_child() in the error
handling path of kvm_arch_vcpu_create() for UCONTROL guests.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ba811f0673d10..2741ca323edea 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3875,7 +3875,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
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
This isn't a bug introduced by this patch, but does this error path leak
the mmu cache allocated for the vCPU?

In kvm_arch_vcpu_create() within arch/s390/kvm/kvm-s390.c, if an
unprivileged process repeatedly calls KVM_CREATE_VCPU near its memory
cgroup limit, allocations in kvm_s390_vcpu_setup() can fail. This causes
execution to jump to the out_ucontrol_uninit and out_free_sie_block error
paths.

While these error paths free vcpu->arch.sie_block and handle the child
gmap, it appears they miss calling kvm_s390_free_mmu_cache() to free
vcpu->arch.mc.

Could this result in a permanent memory leak of vcpu->arch.mc and its
topped-up pages when vCPU creation fails?

>  	free_page((unsigned long)(vcpu->arch.sie_block));
>  	return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D19
