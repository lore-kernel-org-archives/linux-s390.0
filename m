Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47F429CDC;
	Fri, 31 Jul 2026 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504933; cv=none; b=KNBa35XQPhNGdJLm2ykfV7RnP/vcbpSNwLQQwa26sKPoCFXaZrjrL0eeXOhqtHZTSvm8J8M2zl7DLeNtjjUEy27thZqLdpM6ZqiGcG2hzbNjOzUs2lO5lyuu+cN8VNWnfIEo7mhLIiPfb9K6VfvciG4LNGIdMPpKqYojuJbpxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504933; c=relaxed/simple;
	bh=IbuBqA/wAS2Gk6BcmIjMGkIbzEwy9SX84xXyEROJCDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ehhvv1bA/z1/5lLzs1SkHE7vMdcs6vY4EVKA2eamzGOSLzG2JECu8o6vQ2nJMF9LX7tQCS2jQGRCdWbec1AJlTcK5t3DBmtCaqxDuueZ9ydMVuylU1WIi82tYLZ8LBDcPeSinzwdYMvW1AURTNuuLCow6pOLmHuOylosO6sa7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWnpxtmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWnpxtmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B1C1F000E9;
	Fri, 31 Jul 2026 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504930;
	bh=wByzuSHP6dpFy5K8TsYWdAuDcO/Qu5z4cmThaJ4Gds8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bWnpxtmQun4kD9Begw7cu0TlfzWDXUPSB8HQzN+sEs2ck3wDHnLMnDok/rL6VEHkU
	 sQFeyEKZuzgUPj3s38lb64+SxST5cG7NTYPUWCK0FxQOs7cJAwtCagnf0/wIhIxzHw
	 f9eiux/VDtDIJFCqI0j9NxwcHd0h7KxJWwMXdBXKaSMzVx1a+mdJeW01ZPfIYTwnT+
	 9dB3iQM7hCbd/7uIIUSJOVm8mbnVVLz7ureMItkRfIDik+AWuUI0AFzCEZubAKJ4MA
	 lGDWSpt+KnNLJsLWr/5Tms1bbffXeVi87yyfJeNwIfhQbCcTgvwzMqaa4atfKkHHWe
	 hzF3rhraXiRRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/14] KVM: s390: ucontrol: Add missing locking
 around gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731130138.173983-10-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:35:29 +0000
Message-Id: <20260731133530.47B1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of the VCPU MMU cache (`vcpu->arch.mc`) on `kvm_arch_v=
cpu_create()` error paths.
--

--- Patch [9]: [PATCH v7 09/14] KVM: s390: ucontrol: Add missing locking ar=
ound gmap_remove_child() ---
commit f9a2b14fcbcb96b8df54e09c4777e2c6d45f939a
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
This is a pre-existing issue, but does this error path leak the VCPU MMU
cache?

Looking at kvm_arch_vcpu_create() in arch/s390/kvm/kvm-s390.c, if a failure
happens and the code jumps to out_ucontrol_uninit or out_free_sie_block,
it appears to return the error code without calling kvm_s390_free_mmu_cache=
()
on vcpu->arch.mc.

Since the core KVM function kvm_vm_ioctl_create_vcpu() skips calling
kvm_arch_vcpu_destroy() when kvm_arch_vcpu_create() returns an error,
does this permanently leak the dynamically allocated cache object and its
elements?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D9
