Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422514;
	b=lj/0yiDL6KZN2Cc85oQDq5zoJXySDUT4u746v6uOgxI4MUIAKOOIDrOTgVxWNu4BuxS2
	 aSbTS1XW8NjcomEoYb6Gsh49jy1OTpSciJSxG20OD2BMMGkbgfvNWZDlDr3i4mk3ADk9n
	 YNhPreBL9GCGWEwVX0K2eiGbHdfGEPsVl2E5zWcKd1nf9Oa57LVls2ZSpTMtdBmiMT5AQ
	 P2F0PJN81KXZU8HvYOEE+oOMgMAX8iOqjITB1kr4t8u4C55CHzkzrnGflhxGep36Z7DJG
	 H30p7j6agI1xLFljIL0TSgA5mqc5YCSNmCe/gdti3xtG8WeKRSXfKcOSgbAe4wLCVig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422514;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kCs7vd8wc0s+qwnSGWObWyQIEgupWhXgBo+zFR7Cpps=;
	b=Cl+N5/6dMWBYGlZZyIentTDOb2o4wwRe40v1RaHFOuHBDC9nF0Emz/urn8CN/U8WDX0A
	 2iKiMJhJe8Xy+xBWzW0HTrVzKEmmVHqjO1aI2jhbHgLDa19wRSKdQDcNd3JA1R3qq0AVi
	 AZ7WFJPiDNqY4E4dTWrOLdRtmflOv0UMaGU+Lg/zMW+qNzKArlFWfP7F/AVzQTxH2gTOW
	 h8jZ5cS/BK/eciGq/Sl58qlAw6d1xApow+o4q9Pimtm9yxDXnYZbRSnyTgOXlzrSf2wi/
	 oo7R1rG62eTp8B3WKb/Lculg42LqEqvgnwV1rC8JTgcFSs48nkwE5xwI2IhtPe5xYRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSWB3jRb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE6608604B
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSWB3jRb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D190F1F000C5;
	Mon, 19 Oct 2026 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422514;
	bh=kCs7vd8wc0s+qwnSGWObWyQIEgupWhXgBo+zFR7Cpps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSWB3jRbaVaZFHVIVJuazEf63yVOyZvFlAlafUeq9azU1kMimnydt9qdDW1c0w3rm
	 RLPOLY7E02I/wftJxex541JycjNZOJc0QyGUwIVQyTv5wCH7ty4AoYKasIfXE+0W5p
	 EFivYR7mocivx9k8w/hepLOdzMvoJ7s1n2O5AEvP9y04TK5EI3bIDygG1XUkie0O6u
	 acEBytOmM5GdMAJLl2inzT9lYH3eTpMn92pYk+aFmqilbTbAtJ2pvpDqnRS4dGh/YX
	 W3T5wj/GshYSUng7GL4NmnRJoWL8vMpsVUizrd/DHGC5Q5YzuNLcwk6a60NDBFTMty
	 KDOOdYpSH8mXw==
Message-ID: <sashiko-outbox-177618@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] s390/mm: Fix handling of vmalloc area in
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261019135441.1420968-404-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-404-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:08:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Heiko Carstens <hca@linux.ibm.com>
>=20
> [ Upstream commit a2e5a9d853e015bc876399eb18435aa88101c60a ]
>=20
> Secure storage access exceptions in vmalloc area need to be handled
> separately since virt_to_phys() does not work on such addresses. Given
> that there cannot be a valid access let such exceptions fail
> immediately. The kernel will either fixup or crash.
>=20
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>> ---
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-404-sashal@kernel.org?part=3D1

