Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724089;
	b=vo6IN0aDVrOQ6FziVt0i9pRCII3I8DADfM0I22WRWk6ho3JqgKxV3P/ErTeP1yvJhh2J
	 ThxveFR5Fdsm6A3fvZofXZvWeCJS1P6YxqiN4tW1A8wTRMSTTAZpSYhvszrPtEpcuq8eo
	 gUSahjQhBTtYrwNjbs6h1u431c8e+CjZgTWdhv3byTBYDxca6ELtN9+nIEdIbxofMDBCc
	 2uZDV9FEoDW3z2QiL8zkQdBLiMvANiKDuobgE2XaSH3h2ipgNKdax9s7OR8+E+0SIAmj3
	 JuAxzp7FxPZLwf+FMT6I1Ltf2HL9Ugnu5RSUpd+d4KhamI1n+KbL/xzk46wlHzsnX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J3JnGTLFRZ/XYbwizS0rYNhmNGFaBfdxCeTT3w0So4w=;
	b=3iQxE8Cj7I6fbjzmYMmmrR88LF2aw8CqmyN7ggVN9rpgMvr1t8zyA57v+q1yD2Rv3JYu
	 K0h2w6VldKVbCvBHlOikU6zSkBiRaGeEp81e6+syLT/u4AU+mOi0Y/67epBsEFY/4YkcK
	 YxtkOAlcUDZqT/nNUUOv6p3zwhPe5RzvbQRiJHA7mShXualoHMbNlhQI290jMi7YA8XQY
	 pYBHHXSONjy5tgAKA9sj+hR8fLvO5Fz6TkQyN5SI9NUQCut77AhNtQmg2Ch0le6y/M2DS
	 Tu1TMrcAkwC9Kl4VTR9yg+qNr+2knqEchXDwcCAV8yY3p+0VJGFWCqKFvsrXfUW4OnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBWtZKVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC956083620
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBWtZKVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FD91F000C1;
	Tue,  3 Nov 2026 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724088;
	bh=J3JnGTLFRZ/XYbwizS0rYNhmNGFaBfdxCeTT3w0So4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iBWtZKVOoN4QzRPwaK9DNnmG1hx/+oGVSgIeyRioq9FCrqbHEg1hh2fTSlRCsQJNT
	 /R0F3YuubO4lUaVgYAcVGhuxnY99hJ3tQZYBzkVPRBc/EVUmvTMzzz7JUPSdOA24Ku
	 Uo+Bt2eD/Vv934VoUFFR9bZ8qqdD6b5+8NPXeohsfGb2g1K2bute2tSoDe42b/LMAR
	 EqLA1185OC1LUf82IaC8TE9xwGVeeV2vnXjiBS4N3UBPRifVNO3OR76ItGlUh6m+Xa
	 Mf9R+1IDjq2wW006gcH6+6ULjIMFDWavKegN2n510WFPmDJw/S00hLXZl1Xm20/f3g
	 ATi9O1T4mGb/g==
Message-ID: <sashiko-outbox-195738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: s390: arm64: Turn vcpu->arch.pause into a
 counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Grapentin" <gra@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-1-21c36fedd878@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <20261103-s390_arm64_kvm_fixups-v1-1-21c36fedd878@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:41:28 +0000
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-s390_arm64=
_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com?part=3D1

