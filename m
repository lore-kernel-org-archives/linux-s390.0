Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685608;
	b=kq1gFI5AcnXnK6VvbIWqrfCXYo01ockDl89/MzyIRk0G3tBO4XdVXwrr4wv0GbQlG+LK
	 EEutrKrwEsKPmeUurzxttKy6jFnssHon/0Q5nlU5KNcYWvp4rTThiCs7uASQstIQj1AsS
	 1xoucROijz2LHCTsExBaXFfDjQIkB0ekhceu3c0ULm4VW4j/+enJtWUw0IvoW5W6xtCbK
	 NpR7AB+d363dZb/0AJsspXMuSH2TdFNPlq7z2IeHfbudXPLsv6xX4aYdu359XXxZGFrSw
	 PgW48Zq+bM9fov7yOMypAKmbDWpCZdLbaLnb2Ysy/zgAY0k8puhqyIPAjoZ9NkGgkOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qvrX22z9wIWWkzERvAIBOnpRRw+r4JUaaRsGljbNiDE=;
	b=wPi/z2NBAd+13dk6K/D3Uuxyds2IHGIeqNs/7LmwHsP3f8iEKUfU5ZQfTzd4qR+bwBo8
	 Zk8BX3CmX12L9XcYboLb0gaPumgZoPGCEuXdVzBIswC6l/J/gc47d7hVXlrPTvjjc99nw
	 v4wb5J98KILdZ9p7Pu1AHqt6fdp9PKikKyj+qTIMk5OHiPYxcVOwps9sGjlu5zXg/UM3g
	 zg0vf4uJ9p1vNcj/U18JCUoDO8S9u604LSOtv2ON8eBEwU8KfLV7xabovmRX4Wm0CmL12
	 NQfhAzZdrdFZYLQU09T2PuwZ+OVsJYknNVU0mnfwHeHpMLK9DpSbD+52JreGJ8sYV9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fE4zgilB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D868606A31E
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fE4zgilB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C1A1F01825;
	Thu, 22 Oct 2026 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685608;
	bh=qvrX22z9wIWWkzERvAIBOnpRRw+r4JUaaRsGljbNiDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fE4zgilB3P1yojnHfohifiC/7eglhxyyyGodjQFK5ZolDvtnE2tO2kPdHmE611uHs
	 EDQYWFLYvlhph+oYIziC0XRDPsDH0u/5JNte0isTZ5tBqhfTUylxikvdRc3n3IdaEH
	 zoHfBf+y/08MZysP+gld/H+GAiVRg+0+CTl0SPBKERoRLf2X0Pr971fC/IWhbBuBvT
	 zuzqvBiz7AY86zsZtm98ONlTtIR7BALnM9p5G6V0Qxxx8QkxyxaW3uQHlsw+OmhKTk
	 EwAyzVP9+vzkN5KzfK7ewnKR2V9bWkMQMvsxD/arJZ9E326Zbf7LKepsGmCJ1MrrPV
	 UragnbSe3CY3Q==
Message-ID: <sashiko-outbox-181792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/10] KVM: s390: Automatically enable storage keys
 for UCONTROL VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-5-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Automatically enable storage keys for UCONTROL VMs upon creation. There
> is no point in leaving it to the lazy initialization, as storage keys
> will almost surely be used very early in the boot process of a UCONTROL
> guest. Furthermore, if storage keys initialization fails, it will
> prevent the VM from starting, instead of failing at runtime.
>=20
> Opportunistically improve error handling if the fake memslot cannot be
> initialized properly.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D4

