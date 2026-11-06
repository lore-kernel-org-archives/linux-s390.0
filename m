Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983124;
	b=Sqo8WJwd9nk5l5tYw0EReucldwyg5g0PsWNugbtbDeJHqpXbSYxqngP3MRFcUjTqg1Md
	 HSRYsgxyVIpi01YWzWjeVcJ51czz8BwqrdEWbsYNa6iqMdDeJIesvCFxQhJ0cYBGrO+ra
	 zuR2tLRbWZCNMfiKI1zJDDfmQH6yMTKAjU5blIFUcMA6WzlRjhzraf4AbHGryP1s8stMN
	 YUH0GJccvm3YhpL1AcyiPd5n/nCJOydcPH4MfF4uvNgXTeut3F8x+3JpQxEz08kmEn6i7
	 3EAcikg8633D7Ny0nbLplfCu4Cbmxg0/mfhGBGARXQLnFhC1s8dZqy1gdcfVhb01a2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983124;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+oDEpG5vfM0u+aGsOSix0J/ErgvyQuJ32hC0wwVTVhA=;
	b=xkC/ERStZANdfKYH8+zTSpfJ+aTMPY7MeYC2Qjxhq2dPWdrhcFGJKdIVxv4cA/MXZMiA
	 C62Y+CJaRi6g2PV9cFCFhI6NQZ3RRAQX47++QdF0S6rIeAK5/cZTusP3TdkqyS99HDA8R
	 6rudw+UI7Uz7+i4Wt0Hn/wnJn8hEHIZ5TXxd4Cy+HJkMcD0OPyyCgje93By2Zk3t9cEHw
	 WkebmaKzKhh8dccxc3BC63VXHMwDMRF++s/1ePcgZlB4qTlbKP3Y73k8AokAwpH/U+wGu
	 9EeKTl+z/AcrS++OEl+td1h71cCXyEDnICwvhNty6oOodHmvYojNEFrXtdyjIi6LQcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojpZIbK4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C0606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojpZIbK4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1D11F0089F;
	Fri,  6 Nov 2026 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983123;
	bh=+oDEpG5vfM0u+aGsOSix0J/ErgvyQuJ32hC0wwVTVhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ojpZIbK4Lyd41jvO1J2GH1G4h80ilcuMafBFFgG9MIn2awTX/pL/ifp4MGVyYxI20
	 4Z9ZAt3jmUIS9HyQdg0qUInR4cZUyLHlU4b7QV3qFkWSQfTvhI/WYLWKjaRs9GSVpk
	 kUE1uAbM/sRk2d7FMsOmNhlwpsXdD+nIeF081W/1MnMXXrDhPH13HqxL3hu/Gy4GM7
	 qOE2Y5povXDfq8vH/3rtRFsCIojuE+LLevvn8v7xq8PhejqPjAn+I0aZaKjU7AmHgC
	 xQiCgHoMF34ZstZ1S1gG3pctrUiiyA+UEeJByENFciYMEsCprY/5trOBE1eHEIe3pq
	 6g7BDnZfNGU7g==
Message-ID: <sashiko-outbox-201838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/23] arm64: Prepare headers for sysreg sharing with
 s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-4-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-4-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:38:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move the get-spectre-state functions to a convenient location. Guard
> GICv5 headers away from s390 for arm_arch_timer.h.
>=20
> No functional changes.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D4

