Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778370;
	b=YQi6YNxQYj8k59PrqWBjRMTSQbAJA7rQHBraTyjk10rLd9k7wD4beW5wS6s9BGQc8BFj
	 YFuu87xQaghHIFeseu+mbpMSn7jdwp5lNqxWPi0e8JwvgEE/AqU3kzDcFfFiaLsbkcYDr
	 o1dLvVAwabkgWTOI3fbL8NdFXGT06WbbTCBXCKOtxIXB1YTBXQBNRkTDPOqTftwKdd/6P
	 UOfGo98u7Kx0jhn+zlzv1R+bOMJgVEd5QuWPYk+ifGQMwcg1GPS8r1b9EaMa5Gvz/LsqN
	 Z13hN5e2KgAqjl/KqBblJpcfTWo4D3RB5xBdwv8yUjK+omXe7GUJLt68MGVJm4TdHfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8qSIgLrW41AdEWzMe1WByuS3fb+phyC8nkHYcwdrkuI=;
	b=1NxgXoeFnIPRk7oEj1hK5dxrfr7iWYNQ1m0cC5BkFPH0x2KwzVmwfwsmmIBc84/vLDqJ
	 8eMfljBGuPVvJAzqmx94+5eleK8RWjpuEgsGg6nljiKIFkPncVBAdeWhVI/sESH3KAywq
	 M71/618nkadXDZYfEaBDk83UjvbfkSWjhyUiDYEhoc26bRYQOORYM9QMpgH/ldJzxCEys
	 FtjpTN2NBouODfNjEFD+rFgSEMx0r+X4cG8HkziAAHiztbE2FRyDQMg+Z+OhzHN86Vbqm
	 1mk6uhR91PqadusNUEYJnX5EeYHuaMvGk6UU1eqqKr3ZUKuPcXbl7n/1A17NBcOJv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXaCp2+7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E06606A334
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXaCp2+7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8441F031EC;
	Fri, 23 Oct 2026 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778369;
	bh=8qSIgLrW41AdEWzMe1WByuS3fb+phyC8nkHYcwdrkuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXaCp2+79J6Od56Bh8aH8wQtPFd6ZQ2JAXv+INFw9kDRLkQpgOJxGYinCnDpdy/Fg
	 6RZvDNHA+NhuNONF+63WbwILe2dYs6jDP9XeOVKu9SVMFMa7vbO5n24I4+sNYQ1epw
	 pd0iiXqll63GON5S0Pqbv/krVKZ5Z9t8hLN0dg6fwPoS2UpeL1QNPuLaXxXk/XaRuz
	 FCdPMPvSyNbsLf4JDLLBvYlzWcIov1YJJlBPFj5iTA58zTlAL5aXSKeBo/1kMgxRDF
	 W5ibzqCMleqHu2XHDFKt8mZRXtCLWS834naabH1xdF2Q1CPD0FLGh86JKHTSeQnVZf
	 IZSO6n1fTIhRA==
Message-ID: <sashiko-outbox-183027@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-5-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:59:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> According to the VFIO migration specifications, userspace must issue a
> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
> state transition to recover the device and return its migration state to
> RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RES=
ET
> is issued that releases any open migration file buffers and resets the
> migration state to RUNNING.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D4

