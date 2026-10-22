Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689243;
	b=gOqLllwfxnaCWcQm7gSCmZXVn7lMcuVVyglaDaOhkqea6efqwXqOfaN9b/mZSABuvmOJ
	 N6hhGFzhkfyAEky87Zy91KFA+esaUX6IggiTxTCWnZCj4LtRCdoPrnoKNurRT4fjzZXLK
	 aTXvAvGaRtIfjcJdRI9imYzHtACgRTe6e0wGkDb7afIADGej+oVXNnVzhZ7EqmWz3k2og
	 FFSFZASjz81VKOwG/bw8iIimHQ33vg5kPJHd0dEr9FQgZkl0Q8pWHYEpABzokAY5Ok4e8
	 l++a3nmri8LqOSg6CQiqA/eu5GOmX35OwYGisWNwrQ75GLSTHG6XKxeH6O2WK3adkXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BNp4QGN7169N3PrgrTJUsCJgPQgbB9nOxreN3sXTlW8=;
	b=jW5st0pRqP4PzkI172S6oOsNNgvKVn8lwZbB+gC3LEgCbr1AiD7APibEdrgprmNEwySt
	 bn5b6oqpiQUH7mRSVYdRNoz7HMXTPq5vFRyRt0iL/XM++haV824DpLTW9ubOmAONMFxdY
	 zphJxqDjoNXk9M69LPZfe5jQJ8BaMHO5cYwzi0xGKRs70tEeCXYr+horJKn2LW2bxIyhz
	 4EmKiQebmwhGhnXPnJswK5BiduUrVgt0wXGhDvY3xp9Sx0O0GXdx/ucADRUzFBRwvhgpP
	 XKZ5DX/L8redCYLQbfWawr3ktJ9zT1n3OI+kE0SIt8skNCzT74xt9xXgZrjBM85GO/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWNl+M1o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77191606A319
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWNl+M1o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCA21F01825;
	Thu, 22 Oct 2026 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689243;
	bh=BNp4QGN7169N3PrgrTJUsCJgPQgbB9nOxreN3sXTlW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWNl+M1o97sIHLapI0/wlhqGDE+4BhakvdU0dwbyYs1Kl1sw8EdA9EygJVVjIzDUJ
	 uCU492xSOMo2JZorBF+6FVxC4hoNvWHMMJW4YX1dL2PmXeevDEib5Hbx1bjJekq18S
	 GyFj/HJfwAbFz7k1N9TCPeyX9o30963LnNO+yd/4Pke9zUIJSwerosnSLJADE5SG9K
	 7gz7QWdYK+gCUBK84/4DywUHqrhauRQXn0zECvXWRfPQKi44Rywe3hZdui+BNtqSLu
	 Qtt8Xo9MR/b3G3dhtZifurfNtj12C3xdUC6ulzPNwQEZ02EkgSeqLdudR41nEsKF81
	 mxySOEK6zwTjA==
Message-ID: <sashiko-outbox-181849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/2] zfcp: Replace sg-list with sg_table in
 zfcp_fsf_ct_els structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "M Nikhil" <nikh1092@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022170828.4189701-2-nikh1092@linux.ibm.com>
References: <20261022170828.4189701-1-nikh1092@linux.ibm.com>
 <20261022170828.4189701-2-nikh1092@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:14:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The zfcp_fsf_ct_els data structure is updated to replace the sg_req and
> sg_resp members, which are of type struct scatterlist, with request and
> response sg_table instances.
>=20
> These sg_table structure reference the corresponding scatterlists
> (sg_req and sg_resp) maintained in struct zfcp_fc_req.
>=20
> These changes allows to track the original and mapped scatterlist nents
> once zfcp is converted to use DMA-API for mapping the sg lists.
>=20
> Signed-off-by: M Nikhil <nikh1092@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022170828.4189=
701-1-nikh1092@linux.ibm.com?part=3D1

