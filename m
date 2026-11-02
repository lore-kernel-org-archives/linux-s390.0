Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643015;
	b=2bc8tSKBuYdynIRCHYTQevUicOw33ZrFooqRQJ8BLGtxmJ7brfym584Y9PC1XebHiEkc
	 kUHKkbD2NkC+3tjMgz+To4yVUV4pEArcB/ZqgAnWitbRWX1xvc5Bi1uBsikJJvsFNncWk
	 pUleoKH7PUW/KUMQQo1APtD8QhhakQXV12vhCwYgpxGRJt/adXxWnDoOjBEeHfF4mLv4C
	 23Azkm/nTABVwCxS8xm65iJzhKwcugE3km1rmN4SC4O61xwtQcOK5/WfVpGvTsC7Xul6n
	 cRcEax/UoQg3umal8UDc2ENx5dolHl7MvtUk+IR3Mm64W7wjze1oy0uQMSzGIUZzbpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643015;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hrrr5ND0+ppyM7VCCwwA8ws2CXCYpqjIM+hPLmTF504=;
	b=dhI+H44a96c3QxkUj8PCG17lmNwfmq7NP1/dhg6F+MgOtJtzKD+IWfQilZFvqETNONN9
	 r1i54Fogw7ITh1i3+qAQisKezLfmOsaYAq2GTwClfLDdHb3khaC5jOzxbuLzGNFsxbkrF
	 Y1SUqVWR0sJwcycvRWwEwBPq0coRdeJ12SJQUvS/p3svxN1sMawSJUpWyBTkZboKCnFP9
	 Q/T/2jDba1yZR7kapS5fOvv7OMWiqE0SjoNGGbNtOZnjdTY0BGns/7UMFIl6BfRuPWzed
	 lf/NKB6EmE//pmZDJ/CKGUY4Y8TRjc5MOS4GmWlHX0rWMGTaIpKftEaybb7eV5zQcuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwSnB0oR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382B606A324
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwSnB0oR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE641F00A16;
	Mon,  2 Nov 2026 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643015;
	bh=Hrrr5ND0+ppyM7VCCwwA8ws2CXCYpqjIM+hPLmTF504=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwSnB0oRawZFwseRJuRX6SRwyEYWBO5VNU83gHIrRKt6pWuVRPYZ/45O+Q5CVxDYr
	 sigLTq6eIdSQ3DAG8B9lze4VFoQNBd4hsl61lQGaCRXRCCJ1KcGlAy2SfCdyY+TpQp
	 ybpnj4PESWbXLOCuBUXSzmmwZWJaQSEPAEgG0jyxXX+1HIus5u9khcAYjYDDMGbm1n
	 qaiVf/pTkU7mbxvs3x2nIQSjpUjrXBrEdiIntuh16vIMIe9RdkKtSt5YLKdfOeQKyb
	 NxJaJO5to+ogyXLNzmZyFVN0HxVk0Ch9cGb2f8LvCjHIcVDJdV6QVsBvgBky36qghD
	 kuuKy7SPpboDA==
Message-ID: <sashiko-outbox-193912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/14] s390/vfio-ap: Add 'migration' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-14-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:10:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add the 'migration' feature to the features provided by the sysfs
> /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
> of vfio devices is supported. Since live guest migration is not supported
> for SE guests, the 'migration' feature will not be included when the
> feature attribute is displayed.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D13

