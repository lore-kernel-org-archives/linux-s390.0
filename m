Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180BB2F12AC;
	Fri, 31 Jul 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514843; cv=none; b=sBlEBNPWUY1dLx8knc9sgiIoLkps2l23Jq5ytQuTkN7S3sh3b5K1gAbqI8soFEmSTBqUg68F/4Hj8XqPxOMkwD49J3TiumhCeyXEUHsvupnNDXVYj6HblMBenxvSSFGelQTF5nwPU7axVfBGU8daJ4y+GRK3Ks79WFXikWpWgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514843; c=relaxed/simple;
	bh=nFVhHwKkJgbd9A4o4BwqBIhJ0qqZ4lCrIhEat7W8/x8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QAlwZei49gszxHDmDwLmcnvgTqd6SqUOU0RXNMXfb7dPZWS3C77xT8PEPl5exKzc+bny2pbwmGzbCop53jWMxFrDsCG14NlYxwtl7MsMSuUtFM7a/qU6v15iIWhHQzp2SAqh3JGKxVsDU+Vz5LXe919l8eGjuMmb0/VVdp6cpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWdSqKVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWdSqKVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA1C1F00AC4;
	Fri, 31 Jul 2026 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785514836;
	bh=0WWuGiL1LTw1W6f84+ovwwgW8xMflAkxqbFx6AGS+gg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWdSqKVuDvMC04PlPZldCOE/ej0tfiPP7Cw1naa789pWR3Gzv9JrXDTTUTlB9XxCc
	 ltLOSz5AvQ09IPQucjIvfoBmK0opH0ASINO0v9fpEkv1a4RNs9HrudQjyXTQLiUSx1
	 bXVQ8aZCI+q9F/TY/GNjEwNT+Ig6vg/7/Tx0L5Idx9zpvuifTWRbuuzNkpYPPAt0Oi
	 Y7jnq/EF1sB+4SsMoS7plJX5z/IhtLBGGStf3Fem65ZWIuQuujiwoyIEeTJrdKJDj2
	 l9yTy+u3fi16H52G8B06538UP1QCzCj3ezL1l3MbYnX3KJnRX6r2B77WWK8OfxrmbV
	 SUVukFBhVYipg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm: pull writability check to follow_pfnmap_start()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731160514.1101989-1-pbonzini@redhat.com>
References: <20260731160514.1101989-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:20:35 +0000
Message-Id: <20260731162036.1FA1C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM fails to return KVM_PFN_ERR_RO_FAULT on write faults to read-o=
nly PFNMAP VMAs, breaking MMIO emulation.
--

--- Patch [1]: [PATCH] mm: pull writability check to follow_pfnmap_start() =
---
commit 22ed2320251e3d4544366aecf373c7a819e369d9
Author: Paolo Bonzini <pbonzini@redhat.com>

mm: pull writability check to follow_pfnmap_start()

This commit pulls the writability check directly into follow_pfnmap_start()
via a new write_fault parameter. This allows the function to check
permissions and return an error directly if the mapping is not writable
when a write fault is requested.

Link: https://lore.kernel.org/kvm/CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=3DbEHm=
fnG54qyBAHFg@mail.gmail.com/

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

>  static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>  			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
>  {

[ ... ]

>  		bool unlocked =3D false;
>  		r =3D fixup_user_fault(current->mm, kfp->hva,
> -				     (write_fault ? FAULT_FLAG_WRITE : 0),
> +				     (args.write_fault ? FAULT_FLAG_WRITE : 0),
>  				     &unlocked);
>  		if (unlocked)
>  			return -EAGAIN;
>  		if (r)
>  			return r;

[Severity: High]
Will this early return bypass the new KVM_PFN_ERR_RO_FAULT fallback logic
added below?

When handling a write fault on a read-only PFNMAP memory region,
args.write_fault is true, causing the first follow_pfnmap_start() to return
-EFAULT. This correctly triggers a call to fixup_user_fault() with
FAULT_FLAG_WRITE.

However, since the underlying VMA lacks VM_WRITE, fixup_user_fault() will
also return -EFAULT. The early error check here will immediately propagate
that -EFAULT back to the caller.

> =20
>  		r =3D follow_pfnmap_start(&args);
> -		if (r)
> +		if (r) {
> +			if (r =3D=3D -EFAULT) {
> +				*p_pfn =3D KVM_PFN_ERR_RO_FAULT;
> +				return 0;
> +			}
>  			return r;

Could this cause the function to skip this new check entirely, preventing K=
VM
from properly returning KVM_PFN_ERR_RO_FAULT? If so, it seems like this
would crash the VM on guest writes to read-only PFNMAP memory regions
instead of emulating them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731160514.1101=
989-1-pbonzini@redhat.com?part=3D1
