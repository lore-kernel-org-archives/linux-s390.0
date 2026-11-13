Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597166;
	b=CLJB2zB+Bz74elYJfK1aw9dGf84+X9mL44T9V+t25zV1DkWiQUx9y/ULxbjKzid8R1j3
	 1BYfOr9nQh59zz+nHjkRA9Ye6eYK1yb/ceLg0hBRsdUNG9reCPKwNz119iHTM6AVgBx6Q
	 OowykVd913lmsr/5h5WliaZDwWCYB300uCmQMzi86/2W1cMN9Rpn9lSkWJpZuiO/8YPx+
	 kb4ItTIriWdVaOM20y6+IZ2zmHoopYElMmBsDkWlv40i/1NWAMnDq2IB3qajygLJ0k/JR
	 3Ezhd590iwGTIVBeTv+2uIPEaNK5y/i6mRlTKt6cLSJ0l9iLHbcVWjNAyciXicYNnSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597166;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lpnM2hBW1D0k5wgh5lzVOzhc7no62X+neBhoHjY2U9Q=;
	b=qToQoFxrlk1JQqGoVYf7cRceYs27e30f7NM1359sn5Fu+FShyyi+x0R3TJ9pf1m+0upw
	 8z9KAOV44HuO7KJwhcWjhi/4GO5GTAM7kd/MhwAj98dPLelXUY+kt3g+T8ORpcGr2R0F4
	 UdH0DmZWPcOfq2xxJxpqAotnMDRDH+sA1omb//uL2KZvgBOAGt7pqF+zXEzpRsQo+hdvB
	 LgiKWryDRGZtthybp87SFHyE2MvjqtnPeE9JB7aVGOadJKoKTEcRWegQOGW83HHP1FKVP
	 usl1S1EIVvA1necOh8ngIHcpy6E8r0CP5DhDv9aQpbtPyfzxMfI76uZdd5penT0Dakg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XD8hznjB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B1606A33A
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XD8hznjB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A650C1F000C4;
	Fri, 13 Nov 2026 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597166;
	bh=lpnM2hBW1D0k5wgh5lzVOzhc7no62X+neBhoHjY2U9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XD8hznjBhvgfQFeGCf6JpoyANf0N6Dqyx2P5I4mviDTxKRON78vLaB9AHUkovE3iX
	 uQtvRuDlDkYGTN6f7777FmxuU76cRFj7zshGAdj8vWeMgcYfQB+yaxxPp1Wv7LkFZG
	 sjIdHSZ7Obic5r6Pnq/UD8fT4tiMPT35Ma4VdFi7lb+hZG/UEg8nb1j5hLbJVunJwe
	 aU5lSMytEWYe+OQ3rSp6HRkleCLj5p0OnFkXZgnpnDfLAybYujtEFpG9S7URll8/YE
	 vrJzzlOECGSj3ZBDVesbj1oVd0LTsYmO+BqlijyUvmEpZ57NAt4CVW/6ta476c822p
	 aMEWBnkLo7jrQ==
Message-ID: <sashiko-outbox-213525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] sched: restore preferred CPUs when hotplug removes
 the last one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113184257.621707-3-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:12:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Offlining the last preferred CPU leaves cpu_preferred_mask empty. Normal
> fair load balancing stops, potentially leaving CPUs idle while having
> queued tasks.
>=20
> Currently, steal governor is the only module that may modify the mask,
> so it takes care of it by resetting the mask to mirror the active cpumask.
>=20
> The design allows alternative preferred cpumask managers; relying on
> loadable modules to maintain consistency of the core data structure
> is not worthwhile in general.
>=20
> Restore all remaining active CPUs as preferred in sched_cpu_deactivate()
> path, without relying on the steal governor to recover.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113184257.6217=
07-2-ynorov@nvidia.com?part=3D2

