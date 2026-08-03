Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EB377559;
	Mon,  3 Aug 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761961; cv=none; b=lkk7M1Rd8has3Y/1khRftTOLGFpHVrHjPRVuiEZJXLxtrDSvuxzCMLb3+pRZMPjbnNXD86yDwu2AcyBkJ9DMOz7j3feiXNNdawVk9kuBvypdEeFcTsuK63UkMqk0klyWHMkMETurzhHtxBNzMe571cCPi4zX3M84En6kbLe/5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761961; c=relaxed/simple;
	bh=IhA5UO3ts9AlQ/tS/RTDJmqmQH5bXoyQXUr8AFJDvwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=itdcojTqmlXPkriBN4GfdjvBme4SHG+OtxasETUnNGg7GcV7JbPv6v0hfwmvQR5UxdveOenG9QfFP0/EO1uynlWb3iZnUXMGKnDVsAPV+5FlQqlySw6mcfAdt6CKhzxnSixPuKzrmxhORr4CBa6XiKz65tv+93xFTzNgAphTqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ5kG391; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ5kG391"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B614F1F000E9;
	Mon,  3 Aug 2026 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785761959;
	bh=wYbApGr5ZSY6/0CltcupQJEkP83+JaLvSMd68pVtbCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJ5kG391LSqJwnVvk64CaWgQ3l05yREsn0BnHWRpTwuWxXDTeSlMBDDRd4wH9sNpw
	 Zu6Dc2ScEvQ5bwuuqL2FNfQrk0XLUiokfPFdYhiIBQ8F4nfcBDhmQGSck3IjLCmKao
	 hr3d8PL1XWJkzm4hbUENolkI0+lTN8ow1VBp/oZYnmqEychP1gFOI7PyTPC1vYcNhF
	 XW6eTmeqVvDICWnw0O/v0Asp+Wvw92nKyxZTc4MhvMm86GppmQX+GthAYQ5FYYTirE
	 DTlN51UvxuZXPOSFzT/Fq23MHAuJVGs0Luyn3PvIocM9jSC6UkOIwzSmTexPRgNDIm
	 uu0xDRel8MU+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/13] KVM: s390: ucontrol: Add missing locking
 around gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803124040.126471-10-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 12:59:17 +0000
Message-Id: <20260803125918.B614F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The dynamically allocated MMU cache (`vcpu->arch.mc`) and its asso=
ciated cached pages are permanently leaked in the error paths of `kvm_arch_=
vcpu_create()`.
--

--- Patch [9]: [PATCH v8 09/13] KVM: s390: ucontrol: Add missing locking ar=
ound gmap_remove_child() ---
commit 468ac730893edf1b533b2a8b139847cb8a9ef03c
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
   =20
gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

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
This is a pre-existing issue, but does this error path leak the dynamically
allocated MMU cache (vcpu->arch.mc) and its internal cached pages?

Earlier in kvm_arch_vcpu_create(), the cache is allocated:

	vcpu->arch.mc =3D kvm_s390_new_mmu_cache();
	if (!vcpu->arch.mc)
		return -ENOMEM;

If the function encounters an error and jumps to out_free_sie_block, it cle=
ans
up the sie_page but returns without calling kvm_s390_free_mmu_cache().

The core KVM code in kvm_vm_ioctl_create_vcpu() skips calling
kvm_arch_vcpu_destroy() when the architecture-specific create function fail=
s,
which might permanently leak the mc memory. This could allow unprivileged
users to trigger a denial of service (OOM) through memory exhaustion by
creating PV vCPUs in a misconfigured environment or exhausting limits.

This leak remains unfixed at the end of the patch series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D9
