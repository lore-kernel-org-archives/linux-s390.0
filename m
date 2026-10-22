Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684717;
	b=XebbEZJaOf1XFhm5PAbYv2Zdika5PeckJp5CITEtfe8EL3h5ERvX8ms7Bzkdm0d4Qt6d
	 arpYdiXC/kx140j5dx5v2hpB80WTbIKdQDwfGQaVzOBybjfell9iIP43GgUVOYHvd0xnZ
	 IaBoM4b0u4nJ1nJ+pGETBYbR2cq1+mTmI3EdNhmF8zFtt7FMBTt6dYzOmyuursf4ZXZYJ
	 y9HyqO9RMVV9oxKfwV5I31JIQ5MtY6Pz7HN1g3TDXpLxU12dVqgNJfl9QJhpzPERpA8Pa
	 cfgUocSp89EuzG6Ot2PEe5hvnHmJ4MmPKSghStTpEBi+vG44tGmosj0qRI0ohhSNDsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684717;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IvzXjn40cpJiV8vI7Q2782OG7xSJJyPml/xwPMuhGdM=;
	b=JNAGw/sykvqkyawnN04z+EOC6fFiH1geYBjO354vq1GSxN7OrYmb2VEO7R/IoWEe7A5f
	 oO4i02wdFhSW3epA6zc0PjSWmWYM510ocdbwhrtj/WSjh0ylK2uEfPXVfXIGhqqpicutZ
	 4BOuxAbX1oCbqSJiBh5iGiPvrrvA0NnnRsTYYiJGbrf4L+TUzMqdxJfIthYkrbN+/pRHl
	 ix3SH1FlX/jfmZ+EPoz6egB2JgqXemykMZdyT2RSDNhMS5/ficfGSYtGfRLmNL7mD4SJG
	 fMlgD2PFNBFCSr0eqdUNT/1azfYOpMMTf5ayk06zP7FkEulKj21rO2JpeoLvtBCrqvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2Pq1dn0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78197606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2Pq1dn0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6201F01829;
	Thu, 22 Oct 2026 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792684717;
	bh=IvzXjn40cpJiV8vI7Q2782OG7xSJJyPml/xwPMuhGdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2Pq1dn0oX6jVWLfmLLACOJqp9ogY5EiuO2ejLoDgttx7QWUZ00qigTwVM1J4qdVv
	 YTrG68oxeo/fsA8jhaQL88qhf15/k9jkbxF8Pv8FWmGjlt23JWsLDNe1AuHMmv9pOL
	 FXzkEnKF1IrwYMVecrBjeO21a2Z8Okbe9MMmq1gmvtD2rBB4HU6HIhD0w6TINHgmS2
	 TDlQoaZ5gwG5Qf/AR8hwQ6EWeVLnBuBoWUICKcSt7HEj6cEdxfRhVRqMOGLP1n86LT
	 k3ZakJ0SR7e2jVJLe0DgTUrNzsv7TuirdpYEoHp8lFO7e5fBpzSPiO5DfP6MGUkZXA
	 gfiLu15XpiVSQ==
Message-ID: <sashiko-outbox-181746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/10] KVM: s390: Move some skey functions to headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-2-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:58:35 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move some storage key handling functions to headers, since they will be
> needed from outside, and they are small, so inlining is acceptable.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D1

