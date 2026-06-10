Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85FD3446CE;
	Wed, 10 Jun 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111188; cv=none; b=uZbDYS6Afg1WzB+qQnrX50KUnQyu9mwqsCBACNHYv0x2jBR8Gq2082kvOWI3WcIrmGkaB6WFbSLm+FzJ8rFL/BUApwXn0y+jI5t5RxX9UsnGQ2iwT6HZ1gX98ogr8ri7Z6K8eDS0FIb4yIDubis7/3+mUFCRzW+yWKBnkagb9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111188; c=relaxed/simple;
	bh=7cgMsRQUBojA6Mva2ZYVvWsCGdM3/e+cNfzD10dDeio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O0O574IL3OROmNQehoNIh9SYHeSKZp9CwbaT1kbLHHdpxcZRvofDSW+1QsL7h7CXWQK31S96TQm8vdiATfDOhC/XsoTwfPNrP6MnfcjqhHi7a7YtGFIdYdld/hxHp54m1Sd1jOVezSIDBZnZTWluRd7NWGxoS6pMUmYVn2WMqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGSs4LCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGSs4LCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFF01F00899;
	Wed, 10 Jun 2026 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111187;
	bh=Z8ruKHHrlEYrpu6Cn+yWVJnDZPbAYpa+QMkhGoRxhLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TGSs4LCLc9Tt+HNdxZVSF53FXJm0UzAvGMlASAfrx4rkXD4BGMpJmxYRLMx0TH3Qg
	 s7oB89jH3m4YmSmOZCmvomhXijjGG2HjVrzRg77QaDPH5/nrNjpaqtS9ykghiAinPL
	 slTNidno5EmOfXguS9dZIpl5iET/UtC6LnqhK5x3do5rkCLJt2N/aqjYQqnc8qe44T
	 wzzFIjhkwu43bFo3Tv+hebG+jA6k+ivLgH1WjPlaLFCFTHc+bS9uRNtU/q47+Yp1C6
	 a6SCQB/qCmKBnBs1+fCYOOQR/KEWGHDTkkGh+eifD5te8tCGPyDnsKfExIeJgeSOrK
	 SzlB3gv8RnVpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] KVM: s390: vsie: Add missing
 radix_tree_preload() in _gaccess_shadow_fault()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260610165247.238366-5-imbrenda@linux.ibm.com>
References: <20260610165247.238366-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:06:26 +0000
Message-Id: <20260610170627.2FFF01F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Ignoring the return value of radix_tree_preload() causes an unbala=
nced unlock and preempt count underflow if preloading fails.
--

commit c5536624d068cf6e0fec6f8851a47bfb6f4371b3
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Add missing radix_tree_preload() in _gaccess_shadow_fault()

This commit adds a missing radix_tree_preload() to _gaccess_shadow_fault()
to guarantee forward progress. It also splits the core of the function
into ___gaccess_shadow_fault() to simplify locking.

CC: stable@vger.kernel.org # 7.1

> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 20e28b183c1ac..c072b6872bf8b 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c

[ ... ]

> @@ -1582,35 +1582,46 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu=
_cache *mc, struct gmap *sg,

[ ... ]

>  static inline int _gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gm=
ap *sg, gpa_t saddr,
>  					unsigned long seq, struct pgtwalk *walk)
>  {
>  	int rc;
> =20
>  	if (kvm_s390_array_needs_retry_unsafe(vcpu->kvm, seq, walk->raw_entries=
))
>  		return -EAGAIN;
>  	rc =3D kvm_s390_mmu_cache_topup(vcpu->arch.mc);
>  	if (rc)
>  		return rc;
> +
> +	do {
> +		radix_tree_preload(GFP_KERNEL);
> +		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
> +			rc =3D ___gaccess_shadow_fault(vcpu, sg, saddr, seq, walk);
> +		radix_tree_preload_end();

[Severity: High]
Does this code handle radix_tree_preload() allocation failures correctly?

radix_tree_preload() can return -ENOMEM under memory pressure. When it fail=
s,
it returns without disabling preemption or acquiring the local lock.

Since the return value is ignored here, radix_tree_preload_end() is
unconditionally called at the end of the loop iteration. Could this result
in an unbalanced unlock and preempt count underflow if the preload fails?

> +	} while (rc =3D=3D -ENOMEM);
> +
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165247.2383=
66-1-imbrenda@linux.ibm.com?part=3D4
