Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851893;
	b=G81uJy1tO5bZI1pcc8eRdlPd2hQQXXKP6Kg/qqW4X36+160TVPCMMGILuBiYovlQJkR1
	 VYEgSH0DnVqSMHSmUNeSIMbZM6NZzADJ52hadupK+zelYbZEp549WO1NFIPaxxoot8q7P
	 cd+JtiSAjs5riZ76gVe2EuRGfLL3L3vKMZr0aqhSqzJipiU4xVb7nXKE9eh3KoBnVII/2
	 KZSHvVXH5y561sLk1U7DzgEFDqeO3+eZ86aPgpCYYHIX/di5QymtGKUPNWyJEsSNr1ehn
	 cUa6lLn/u/6+TshpAUqqKl44tl1wt8ZTcClOKux++A20mgD7wxzDcNTINEZ/TlUoHZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s+So4m+TUzNIoOESu5i4FpgEajSBnKuVH9Y5MNOz5yo=;
	b=RaU0r1Z64wzYS5M7E64olyCBSn7OkXRQ3RiS3xZjM9jfiB3f525fYO7mzfLpaH9XTDmJ
	 DINieNoi8UKzklOg6qSlQYb6uWaxZXXPe2BSgsVCBNQU4XbTMJ+9Lt/O7T7rhhTZbETdP
	 0OPh5D6Yxm1tQhywkZrox52WjV+D8NobAgFh1ZKDb9kJI1lXPXixwAQjvaYF49CemjY7a
	 5pJjCO2suBL2PVrgeT4FVkdArO0d6nCZ0Gpe1aNRlALJVySLtqWtYR9wikgKsFHEmH+DN
	 S7grIr4cNb3UeBAGg4/bAPSa6slvFgSgD3XmXBxBuqWmfROMTRwkFC5lWWfo/MNGdJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euHjhzUi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADB606A88B
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euHjhzUi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0B51F000C4;
	Mon, 16 Nov 2026 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851893;
	bh=s+So4m+TUzNIoOESu5i4FpgEajSBnKuVH9Y5MNOz5yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=euHjhzUiMMgXdPmTsM5RhH2Q9Di5HQU3wsWqv65gg2hBzLAPcDv14j/I2DE0mLok3
	 mU/nU3n1dAaS2xZb/QYTR9XVxB4geP8Di/Ipc2aj0Lbl6hbka8NUC/q2ZJO3Wi2Cyq
	 ILmj1uAHATZySH4oFjPqScUZ2lfAfcPSrWh5HhrZ4h2LG7Kx1JzdpuyFxy7QI6lTGu
	 jN3wECYyImOt9pzKP8eCCrpnZXOe1oaK4A0efSOxrQjIyvp0pm10GStfnLyGnZd7yn
	 QVXZuKNDekwPjEOIf1EHl5yrCewt7r2NsV4jhm7H6409cgHuQVHEr68NNUn3lRP99B
	 /pZkyRrtxRFmA==
Message-ID: <sashiko-outbox-217470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] s390/cert_store: Fix error handling of
 get_user_session_keyring()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-10-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:58:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> create_cs_keyring(), cleanup_cs_keys(), and find_cs_keyring() all pass
> the return value of get_user_session_keyring() to other functions without
> checking it. This can lead to dereferencing an error pointer.
>=20
> Check the return value before using it.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D9

