Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984115;
	b=RDAWFZK1kezdQqdBGlP5NvSZtK3LPBXU90DPPx78czmPJunl8tghozEwNJst8E9XoAZX
	 Uhu60jKaNOwAdv6btt9NM8fNfpmX2goRtP/rAxO/44E04n11S5ZPAc2AN67C30C0Vr/Ay
	 5RUnQHuTuBl9pCVfQutL1gBqWoxXcNnVCgqyJJi2O6AydxONgn5hZMDWeReJh3QMLwejE
	 hfCunxL6oced1Qux4lScZwEud5B6L+rITebnNsbhndUEoVUKcGCdS3OUnT0+JJ69GyvT0
	 qmZPgOjkVg/FmfXO5EXYbhvED7dJ7ilLNX7rH5ZGBbzGQARPhRhWZq+sykCUq7e1a5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7FVeu1JmNCf2XP2Ymx8hDfiq11rBOaJkgDpL4CID5uI=;
	b=gplWIDNMJJAQG99VgoqecCU+If5zmkdtkv6Wp6WXgQJr0kMpL+i0yhoZqWfC0tuSANRv
	 LiAx1YKhLen5m6pyEUY0HEGSEnKmGnf557wyjcnIa1IQD8+znOv46ATp/PPwF/K/iGy+G
	 AaRLHrqhO7W2WwFFKalusFRydkxp+j9Zju63EcrrTHkRQ9r1d+jNl6Pw+CEUUAHPFIYDa
	 FrUX1ISSyvdBn+iwxQa0fcfR8OopHLHaxoPr8SIXLbOASnjLkgwAS4iqdn61ISyIjJfsM
	 dTtMzmbx8aPKfZt0rDwiU7y/KOVEFZopX4NPB4Ge7/H3LPjwstQCq6L7GPs/ZEjue3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BM/n/Ama";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47713606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BM/n/Ama
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7DD1F0089F;
	Fri,  6 Nov 2026 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984114;
	bh=7FVeu1JmNCf2XP2Ymx8hDfiq11rBOaJkgDpL4CID5uI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BM/n/Amaf5IRSaJptj5c3g46SQq3jtve3cEefKdgKrTFdN1sxN0Sb0hipEFv2o3vD
	 bTqhWIXW+X5J5aVdMUVRyDPcnl0aok2eAYRCKiDqlaNmTpZce7vm0WO4eXVDHhFdV6
	 zK3wdRrhnWn1mGL2mZcIvVsMuWyZIM8IzvrWyP+LcEQO490ZJIuP7YUfdzOY2dZeR6
	 +WP2qIY0nB0BvCzIZzrS5bVQAVGgFYHOSYMdJqwVCaJ+b6fVqczib4pDtdFGeK7ox4
	 ZVtfjdDJ6DNH4bCFjPD8BMByIfRuuRcDU3v2g3zeQfc0fNCbv3+CNduPRAjDiK3Oe0
	 3jHKWxMVQLLXw==
Message-ID: <sashiko-outbox-201873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 3/6] KVM: s390: arm64: Turn vcpu->arch.pause into a
 counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261106164958.431978-4-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
 <20261106164958.431978-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:55:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> The s390 arm64 vcpu struct mirrors arm64's kvm_vcpu_arch. When commit
> e64309198eda2 ("KVM: arm64: Turn vcpu->arch.pause into a counter")
> changed the type of kvm_vcpu_arch.pause from bool to atomic_t, the merge
> into this tree missed the s390 copy, leaving it out of sync.
>=20
> Nothing on the s390 side accesses vcpu->arch.pause yet, so this has
> no functional effect. Align the type to keep the mirror identical to
> its arm64 counterpart.
>=20
> Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Reviewed-by: Andreas Grapentin <gra@linux.ibm.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106164958.4319=
78-4-borntraeger@linux.ibm.com?part=3D1

