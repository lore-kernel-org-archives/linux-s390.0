Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310839;
	b=wbyyjcxaUv8hMWnWzXxNGWBOBdtdC3P9SL8tNapakcznun1liZS87BsMyqBb5rCzC9Rp
	 jFDA21GXHgPl17rKHqjbqmHSVA59xq0Ivln2yvGHT5byFLqPf13A6KYCGEEPSq8p+aenh
	 ua6ESoE/gRz9PTA/5BQxOnY1hQRQnghAsplAaCsnEe2GY2Jjf8kZnCIO1i2BULnLqkjSo
	 HVIBwXH7t7H3H/45hi33VYZoepVR2QQTwp/wYSKbWA4qr/iIJM/S2xeLup2RvcUVBzHKL
	 hoG7RJoGZAfD4X1C4tDXvM9j7f8cjXk3x77OUHH2pfS9CrC8r1B1undnPTx7l9wz7SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5A1wcjUBlBKPiX5K3dSWYt6IB/a1gV+cURAhW3XYmWU=;
	b=pcVB/yhnClAQKXW9HHJ51sV237ILhBh3OAdILoUTeuiQ3pHMghq1rk3ffceQbNYFcabc
	 mtbQz4QnXK6I7rFE/m665Huu3stzbd/cNxCUdW3IDsGIoLBhNd8XGYpqbLjhRnvl7uHUf
	 4El/juiK0XmSZ4O4fwo4WGG+myKpJThs2vu2agA87awqZIrUZuNJSx3Dlnx5cnN1EKK+Q
	 I4j13j7gweVqEYPF+arlloQdrdGrrvQh7+KlGa0mIhv0cE0f+bq0fDteDq2aIRk70oA+t
	 02dPWwfN/ZO2/RcscnfYpJD4fyc84+ljrmUje2P7g41caXwdzasiKRq/mf3zTI0wypg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TAMV4/G+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97F606A31C
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAMV4/G+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415E41F0089F;
	Tue, 10 Nov 2026 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310838;
	bh=5A1wcjUBlBKPiX5K3dSWYt6IB/a1gV+cURAhW3XYmWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAMV4/G+NGFaU/OtlLa7QKhiFiUVhFcOA0QDZWl6bQyDzoYvcVG6OXTCGRb6vjSsC
	 RcB6WMLUOXlpcV9H3S/ZbBlVnyqsmvfTE1FZoIcllpffcdus++MD+BmCRTN9KdRTxy
	 enB7hrL//xW/DHsZTQMVTfk80oe/Abv6zDEDN4ER8VNJRVwrZzDSGz/bg6hEI6m2Jt
	 pQH0vrUS26kte35ZkvFM+H+3+Iuyob1YKLJa7zhiDQJ/mfXoJZDg/5LIlC1QzunwFL
	 9jMn0dJsr4h7TThTNvoOvUg3Ly0Ctu/Ghzkq1TOSfJr5ITKVTWW7HakpHB+kzZo8ue
	 5hShL4ndHkVvA==
Message-ID: <sashiko-outbox-206947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] s390/sclp: Introduce macro sclp_gds_for_each()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110113047.238367-3-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
 <20261110113047.238367-3-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:40:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_find_gds_{sub}vector() does not deal well with malformed event buffe=
rs
> consisting of GDS {sub}vectors. This can result in an infinite loop or
> an out-of-bounds memory read. Therefore, abort with NULL if
> * the next GDS header would exceed the given end boundary
> * the length in a GDS header contains an invalid value.
>   A valid length value in a GDS header should be at least as large
>   as the size of the corresponding GDS header (2 or 4 bytes)
>   but also not lead to exceeding the given end boundary.
>=20
> Use the new macro in sclp_find_gds_{sub}vector() to iterate over entries
> of a GDS {sub}vector in a safe manner bailing out on the first invalid
> entry.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110113047.2383=
67-1-egorenar@linux.ibm.com?part=3D2

