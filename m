Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851599;
	b=SrJ3VuLKapHZkOsCEFVdk/ml5VVFORYm4OnxueZIOWJmsKWrZCzJABckVSuoozoawXP/
	 +k90MKWcdjWLJyTAHdrXCm8bongrAWupkaXElAYyV8upU3+ztSjXpoL57tlsZRell3WQV
	 Fh+JDjWMxZwFzaRUYrd8faSQygKc+aqsjVBs5H8mPd70xr9I3P1Ura4uttifX9dJOdTzr
	 hTm3+1L7x+C1WdjdMaL07Y1A073iFGLo2b0WsUFZxedtnBr2VzP1heWzX55Lduwa3GtkB
	 RIpn0zQ8otX8yor9Pm36FEUnDZV17Jy5xDjF9TyTJ+auGvmwTzNazAdV+02hO3ONDsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SFAvawkdD611Ni0KbDS+Is7L1fHOHye2MYp+TI9GENE=;
	b=moXHYSBZ3gBthwGUK7aOecX2qZI52U9BwxvME++R2IwkAPmjW/pRTHlDTnlW1iU4VoDv
	 ErxBsqgjaLIajbuN4dE3E7Tg1UbZku76H8pBC/txSqDBi3cBn/YpFo4ehF3+Ydz0B9Xg8
	 Wa2eisvnBybFocQR76B0Q9LuAmtHUX7B/7CSmGHUYltEpstjoNacT/6cVoZLml14T8ZJi
	 Ja2o+8fCz8+X6Yu+NjZnAIDVqWQpX+i+v8p6oIASg5Y0rmnM5VOrGMLT1y26qrteXGqMB
	 Kbd98b8Stq/FGwJ+npc464TKD5mApGXvBe9yMGLJ/jN9/OGRidkhqaYscX4U9aKDe+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzE9WxnJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01881606A882
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzE9WxnJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F7C1F000C4;
	Mon, 16 Nov 2026 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851598;
	bh=SFAvawkdD611Ni0KbDS+Is7L1fHOHye2MYp+TI9GENE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzE9WxnJSrRbL5s/XgUoRV7RCGFRCsi+8OhBubCYVu1G5/u9xDYFFPzbHCb+/ky8g
	 b+7cjt1Xur9b88taKOW9+5mOhnhtTN0fJO7Y+JsZK7VRpWaxdArn2Bp46LDaNI9Vg9
	 bST2TE50bjhyCr7lv6XkcIsoR6aUIvH/vphwhX4HVPGBRkZY1t48+8TK3OuRpKBeZk
	 ieAtKPRzFa1RTG9KZBiey4FuJiY7tuTuT8R51PBG6hpkMZ/ajVOmRSWfsSgWESry+r
	 Cq0ZgEnih2gYK/jK0LgZxQFhmLPchYBDHwy3Lb2n39wTwr5EqNSWRkg00pMGTc9/b4
	 MXMENg5+xrc6Q==
Message-ID: <sashiko-outbox-217453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] s390/cert_store: Do not search the process
 keyrings for the cert_store keyring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-12-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-12-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:53:18 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> find_cs_keyring() first searches the user session keyring for the
> cert_store keyring, and falls back to request_key(), which searches the
> thread, process and session keyrings of the calling task. Any keyring
> named "cert_store" found this way is accepted.
>=20
> cleanup_cs_keys() then invalidates and unlinks all of its keys, and
> clears and invalidates the keyring itself, without checking permissions.
> If the refresh is triggered by a task which inherited a session keyring
> that contains a keyring named "cert_store" not created by this code, this
> keyring and its keys are destroyed.
>=20
> create_cs_keyring() always links the keyring into the user session
> keyring, so the first search is sufficient. Remove the request_key()
> fallback.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D11

