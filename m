Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976476;
	b=NoMcyQQ/ciYzeRmoa4qivmVWhPa57UdWY/loM0J8KanGGO6dTLxDpmD6CLNJ/9sjMyfU
	 FTDc9u2249Pt1Nf69dlyPFDsojKXqAHhE1znTocfQFEVBJ2VwUJtXUlXVJDfqewqqruUa
	 G8wDSTMwEBiPQ1Ms6nm0T+FS9liDzolTXp3iy2vYdej0m6xZxFh3Vd2//2g39YdwgviNO
	 /qhZ+GMn++pkjYkaj6rBgZFVd6jHOQYra+3pGBn51agZp+X47mF9EGPhxc7DLlCIY7cR+
	 wvEYHyDsshTBhM4UiOnnBBHSpuTK3vIYdRhMg94UhMGqu2oX/bBhDtYa7Vdvm/7SYHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976476;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RYlxtB7hakqpzz9E4S5E+yivO4gIbKU8snsTmq8w1IE=;
	b=n5PKdwFI0wE5XhcoMU+y/kY2h+wxpwwesxycdW2MfIOv/HgDb88Xo25uMfJ0iwsHJEjM
	 AubA3rSYXGytd+FX/ErknvOx8agKz4sTpho7EfavAfO6qXCkaDZgmw437KeY5+4HVom9e
	 yop8GDD3rs3GwHNlikuAYnoG5tejms79alv4WQL9mfVGl43IDrjYSjsBFx4AbXf8oEj9c
	 KAG9YxUojvXPL71SIgCJO+/HKWneZfIcMPKemJYkkhzkmf+SdWXe/HiVfDtFBQqjdonNh
	 Nqf0wvWuTZn2paU10mxfhE6n8YdisZzJLeFksd7NKH00RQ50IT+eEjB5QnFDAmH7chg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7n2WRDO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DEE606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7n2WRDO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E436C1F0089F;
	Fri,  6 Nov 2026 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976476;
	bh=RYlxtB7hakqpzz9E4S5E+yivO4gIbKU8snsTmq8w1IE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7n2WRDO9G42kEMqyAD1cekA9qWqwa92BYKox/7Iu//oG00L9CKORh8DICcbDxPeN
	 uQ0/2EizVoR/N1Q9KFAwHiGle3XgNZ2GXmzGPic+CmcNVQ0IAFLBLbNBF3DsLjsy0/
	 ryNPFhD16OnYRtGV3IBICBS4SC0mu67113accFKZGpwIAxRlz14ISGGh1+PkkArgFQ
	 bnx7/5VWbbCuzqdB9fdSIpSsNPldkp1cm+oYRZYteSJlDK7irCNJfPVREZYxzMRsQA
	 vGkYaWempNx8UwJY1iUcUTN955hZnFrTRh/iVNhPmcgkpGj4c6iS7i/bBKyfcS3Rz+
	 TNXEodk+twyyA==
Message-ID: <sashiko-outbox-201607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/15] lib/lz4: remove LZ4_decompress_fast() and its
 variants
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-2-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144250eucas1p23dbd9566bcf265bb48728cedff315031@eucas1p2.samsung.com>
 <20261106-lz4-vendor-upstream-v2-2-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:47:55 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> LZ4_decompress_fast(), LZ4_decompress_fast_continue() and
> LZ4_decompress_fast_usingDict() have no users left. Upstream has
> deprecated all three since v1.9: they take only the decompressed size,
> so a corrupt or malicious stream has nothing to stop the decoder from
> reading past the end of its input.
>=20
> Remove them, their exports and their declarations in <linux/lz4.h>,
> along with the two helpers only they used. Doing it before lib/lz4 moves
> to upstream LZ4 keeps them out of the glue that move adds.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D2

