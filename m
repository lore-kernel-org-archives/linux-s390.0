Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778431;
	b=SrfeBuj6neaasDvw1yO2fFWD+oJ2xgzN9JpZtBXP/eyJd6xradTpWUIz97Q+5XNFogtv
	 +Doo5IaX8UQtBvMnrjCWfp02JU6lrYPpm8Rcx0FFNsQeTG8YHAMSYMUNGW9PPqI5xap1z
	 9jd9HOEIVlbG48YrulhT7JYLocV9+B+s2BR/V3pEfgilkMSq8cLSSwF/jtOuAGFc0vh7u
	 SbmqpOqUZeFCs8mje/wDOG+liNesDHX8WLYdzk9Qvpez2Wp67DjzYWEyTeOCkSXHml2Zv
	 FHLtuvyCSUqBy8ADEHZxMzvqj8ET5Yx+QQNMRZGYORViWQeefoKCy7NFjugeGn55kiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SvXPoDO3iCPC+IXO/tzDcIWtpgrQCBbuxt5ywsc3WKY=;
	b=o9qJbtL/+xMVsTd19IZYlulEOMjh2Kufa0l2agUUzPXktwDb+S0KC9ps8FzghvNEZY+7
	 iqfwIDOu3V8Q4k1WQKJkJwdTED8Yw7Wi7rHHuh0ww8iruLchKRkH5ErmSPFQJZO1+GZF1
	 IYMOp3fiGLGvxTkeP1vBZyhBhh+BYPbNpnrmKz63EDa2NLEhl9LiPcrDYWwlzgh5sRf+3
	 JcHy3vz/zhyhWOhpgaw/9cNFHlVddoa+AvL4ATAX4L1+x9uXzUSy/bLX/uy/vwNVqdwa/
	 f0RUOulEX9qudm9ndqvRBO+mgNFrfk/LatLWSkkBjQorIUrrx2JgzOeKgXi368fEyIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llWQnKvN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA2606A31D
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llWQnKvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4DF1F01825;
	Fri, 23 Oct 2026 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778430;
	bh=SvXPoDO3iCPC+IXO/tzDcIWtpgrQCBbuxt5ywsc3WKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llWQnKvNT9gO+xXeMHxjFYBEQ9T8ZYwihSwn2JVcYAFiBEb0Q4ZzzBQxTPyamMApI
	 8g6JrbGuXabYaKr6/zbfiErFWDzgtUedKInVLRWcIZA9/RTcM6blgydSlCN08dOJ9z
	 FeuTl+drOVjmIlPbysOAduz5wtyq6GnQzjAs04nHRHJnK5OGaXAhFt6jEkBAIuKNRl
	 9UbSV6nG3c8VwiPoGxIfJGlntTbVGAob6f7ElqtSOwiK7fNJq/ri6Y7tmfnQ9CFxpt
	 Mf9Zcq90mRgEZHpxxCvaahLqVSjTlpkbwXlLMd24K0SK26qtX8iBn7ChHCPbxfoq+g
	 go7dqYpc1DK2g==
Message-ID: <sashiko-outbox-183028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/15] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-9-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:00:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
> starts a process of restoring the device state of the vfio device on the
> target system. To prepare for restoring the device state, open a file
> stream to receive the guest's AP configuration saved when the device state
> on the source system transitioned from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the write operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D8

