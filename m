Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111817;
	b=0CR67s0G+YUFhXn68txo70w1x5THUFg2gJddrkkbe1FpYY24bUFrI8Q1pBMEps6mkf9G
	 tRBXmIBh9AumXGcFK3BsKCOXfKoVo8yzMfVab8I7HC/Z1qxmHgj//w0xUrWv7LHiKyD1j
	 VCuJIypsrm4Xj5M4dsmiihyAOBAZrhIM6m4D86k/B2ihNnS4gejV1MHWUeJ8oUndGyh3g
	 23LVClgv90sfM52AcJZmPOO1JadbSGEQVyErAx0XRzBNKXdX3s3CC8hCeQK6Xp33BuY3B
	 F447vac2oYvwIoPLsmxD9b3jZWQAMFwJvhDQV3wXsDcoJrLyprfdWjAd6pKvHK+V61Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4vm1fkra0aTfCKh6qyBOIQmsH9SXZaCxxqsY/UxH8Ag=;
	b=YH2b5l7ZJejQl1iY9efCoT1jdQSLIc3pxDWImJBi2JJWZ23U6lYhpj5lrdkncKKH76kZ
	 XCg+kgRB1yVQSEETpcSxvi4grxKEDO5ZwdThDhQ0qwuS4WgzzjXF1XTnbmbcagYAwJ8TX
	 SiDSltIS+yMoDfIcqdEXNShVVBg6bCuBsvtWcbyWcwewhzpvmEDk5wnQJYfq8+1Pa38M9
	 nh0hkz32FLcCFpGBoUA6Md9BsDLhz2VBRsPQBExYXlSPoWLJSKn+30245ViNy9Kvv/gr8
	 oDixPkcCy3gofQllYTu6/ejUCQl1rJOf7alSrupI+ruoRP02j4zRhQDejuQ+K2DsC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csYVBTPm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EB606A31B
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csYVBTPm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B991F01828;
	Tue, 27 Oct 2026 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111817;
	bh=4vm1fkra0aTfCKh6qyBOIQmsH9SXZaCxxqsY/UxH8Ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csYVBTPmdE07OvbCxvVRrfU2pE78Z8c5xtaQVtleD8Mtt+4dBZDTlb0dVlZRBtqVE
	 mibdUvIWspnwrarYeeS5w3MDObdM063736fXJuUHtQYIB8PkSA92EzVe0WXuqPYax1
	 yIkUKscvlXHpQ+0pvtB2FSm3gZfvsx1pJGlUQfC0lbL9n3ep1AkK1UM0Q5U1fIzLsG
	 F9xTU9qYHdS5Ptk+QY+ZtAFwRlj/MW+99Z6q/oWWcS7XODkiHAzVRSAZlc1HIgGqaR
	 O2k0EfOUmhn1OJxGfvjhz+1mhU+zSwE93shALzxZfXAD62uuBx5Xcz8zFiV1v9BqFy
	 VcBMXQWLIbbvQ==
Message-ID: <sashiko-outbox-186736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] s390/module: Serialize text patching with
 text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-6-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:36:56 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex in apply_relocate_add() in order to serialize text
> patching.
>=20
> This is part of larger series where at the end s390_kernel_write()
> requires that callers hold text_mutex for serialization.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D5

