Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428488;
	b=NsU0igIT/c3G6hLtAhRzt0dPdQ5ljEtps0Iq8d6dk0lrz8+Z+8rzvCiRLv4Vc9zi+qx3
	 Z/7VkSE7l04a5grUs1phv3nrZwD5yQRmjlfTyXxOwVknluahBkJe+u8nMetHjeNzWJ52G
	 3o5wfoT6Ptfey5Q51CmeLKpQ1GOo8q8yT6RW3ErpmxvZlRxLL81lTFYlCWYekEB7rG8Lr
	 80D/4MzEcs0D3k8XujycM9bBTMB23SgNnfk9FnVF5njq6itShyu+dVNnDR1iIyXAS9ibV
	 XJ6rkTU3c5lumBLvRDEElPH7L7EU71fq8tZ1Oqtyf39bHiNsbylJuWVmCcb8q5QxEvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YADiru2+nUsjOHU2t23t8MVIKO5dWR+THpBLJqkL4Q0=;
	b=bZ9PUqa/FLR3JAdy7LVkI2ULVeVClSbxswxn+4VjqCplm5trOnyqSVSDW2/l/EiIyU6/
	 WuljNLu2VDoBp3yoQtoxtAujKBzVI40El3TniR6zn+OAVQUxJ6cc/hjvWKIDP7A4drNfE
	 4JRp8pWFa7x6umroYhBpbJi8rKwrEpeBYM9YisdQADlgEiIgPPYOB0OHLTlEhDlOwPSIq
	 RfJD8vzhIwxmN81tkUHm/b7I1CMhYnP6F1x7HsF2DuQJAqdH+rCYLPNogJlg5DYkvBfB5
	 7lZTGkCbiY1EoSfa3GBPQXA59JlI9iLXFH0zu+E0t3rYvHLC5VP8JNgbZ/FR2IK4v1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nS+ANwKN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61261606A321
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nS+ANwKN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A501F00A05;
	Wed, 11 Nov 2026 20:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428487;
	bh=YADiru2+nUsjOHU2t23t8MVIKO5dWR+THpBLJqkL4Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nS+ANwKNzmY+qqg7YQtJ+lbhSSzKP91TEly83OZz0JnXHjN+UT8nZGaar0nbIofdX
	 qIa/7/VVy9yDxzvVg1kFWnTkTiXe7I9USdwLKBvDlCFOHPCjK768y0jL0tk3OMNkLI
	 iofD/a7suhNGBuV5WdHVyN3gMg4kABzg/VdDiefoIwwRN3XLULKYlbBfeb+Dp5z4gx
	 W+zdLib+LIyae44CocXNvIEZIM2akc6FLtqnIq3gwEwmFnlx/8Z/MzJ/cn9fozKujo
	 ajzO4qBgU4Nlv+cIpGsiRfdT80lK5Dv2S+qu0OKG9uyjsNKMg1+3z/OjpS4X2r4gaK
	 Lo4Yi0JKPjiTA==
Message-ID: <sashiko-outbox-209639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 14/14] s390/vfio-ap: Add live guest migration
 chapter to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-15-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:21:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add a 'Live Guest Migration' chapter to the
> Documentation/arch/s390/vfio-ap.rst document to describe the details for
> initiating live guest migration for a guest to which AP adapters, domains
> and control domains have been passed through.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D14

