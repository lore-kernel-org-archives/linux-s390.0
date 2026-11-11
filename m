Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427977;
	b=5mBGx+yReovZ0lpDtBSobomLRLpcstYJfE61pc+9A/vaitaOW957sFwRlglPor0Cb57t
	 bQzfrj7VkHX2rsClMJCObwnYaMv0r7ncRanSsq8v6fXbfcnPubVzemU02PIm9JOdPX+hi
	 wf/MrWBWjbY7qdJLUrRG8Qpx9ips82PW55PZxm7ty29AHPy+hp3AvK6B3wKBwAlUkKKo8
	 V+y45MubfemB4biGK265p+Vb6BOc/JWAh+WMRoyRkW1FbMA6R+cUr3V7786cY91UTpCj2
	 jyWcXDfEOi9wyix4zdSiIgnLsnzxezv8BKYBsVrkUoUfdJPuCzrbMBjWjUbjV+XecKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427977;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gKgOcrXe1sQbhSxAhHex2nNjRJudKf47XKkAJvayxKE=;
	b=ea3GdcGXJ7h9zcgLSjxRpNO50QoYUO8lobY3Knu/MkxXtNkZpqLTjHOubpmbGtsfZq3J
	 POmslV4bbaZlNaVy4oFdPk8coXoprYETQq/R6hCowkg9qaGmc0pDs+xwxnGHb1dOi1Sw1
	 M2RUWLmduu64D37n1Ed6NRe1JafEaCAJaSduArLUUL5ym8bAEU52kWXU8WOlUTZ3p9/xl
	 Rspm2jPIXu8sLCx1HymkXHh7tGY+Omdugy3ichbiQyca5sn0bqxQiLFqa03kSkIjKG4SP
	 ihVOboORg80drma56hJCFtQ/r5cY4SklBVTS8DcCgm1nAY/n0t1xex63NmAdfXOImuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggGbocdb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED786606A31C
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggGbocdb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D9C1F00A05;
	Wed, 11 Nov 2026 20:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427976;
	bh=gKgOcrXe1sQbhSxAhHex2nNjRJudKf47XKkAJvayxKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggGbocdbiCnfCfEdqySN+u16FXpe7xevVu/POqiwZR6S8Iair+b4i3Lhw3cajRQcT
	 EeGSyo1HCoViBlJ0o7+sMNO7RrY6LtjcLck5ZuYyMBfcc/8d6eneJngQpeZu7joVZs
	 YMJb2UHJSrUksjpmwGIvVDRE19Ba7osNg0nmxQ79OMS6yl5KZQ4C19uEnDogEcjv10
	 juTR8L+qdUslrtnrOUvoT7Hwqpf0sS6kB2eHppl1Wb8RVafOJB4KcEReO/RnBe2VkW
	 Ig2qZjk8HxeCf6pGy33GHZ7lyEl0dyoytEwIP4rsNPfEsGwqyrbeEtjsjPtp19FMqM
	 eIHsqDIYcEeEg==
Message-ID: <sashiko-outbox-209621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/14] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-2-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:12:55 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D1

