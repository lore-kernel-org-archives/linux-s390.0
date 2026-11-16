Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828004;
	b=HXsJMI2Pm/pdj6/T2jjfnMJ9w6ZPEaFJWiZd+JCO1pNY5uhyhi54Gx1a3UbEMqR7YxWa
	 t0TYHx6LaH5mmHuzZHwhklQ61tFhV6vKD72/mCDzCWBb3rFmyAyQX1NQKWMod6gY69MZm
	 pOlSAAXLYiE7N7kd5wGyRHfveJhH1laEUV7ktRSBKl1rv33DC5xqE/wSj7WLiQgCiKmUP
	 5WFMgyB+Ms0IgUAVPnCruL6wMTNQHwVfqOkz39uiVyEBoGRc2rhRxeTQYhRmj1MBCEOBa
	 l+zhAdqCh+hIW0OJ5xJkr9+1RAvpPjdF/IKqz/vPaE3K6kfvIHvdHScLJt/MBQgFlVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828004;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3qfSGLVIk5gExQqn63xk9giu2v+mPEbp1W5CN7wO6Fw=;
	b=Vt/x/KCx++2uM4jwmXzPK2CCnGbG1g/EV7cDWELQJBhY0ACG8T+QJO7VK2DakvjZG3Kw
	 N3jZSt9DF3WQ1AHXrtCWQu1TTi583kY5kmnaJeG0LTp8R7k1A3/IV/3vfhsO2o+3mNTmc
	 jow0SCx1mMvYi9WH6tUe7TQXq8CQJ4Wjfl6PZfzAOI07FacKeAXVcNDdcR6TeL7c4if8f
	 nsM3NsvETgf49LurAYaX4Yx8Gmzr7oNctitVF8kS5mtJlYXk4GhCyu2VvayswMZGRn9Hr
	 cHD6Dm0NOKdwGtMfyWv2AF1NET8eWUutnisLoXC0KWnOSupoOnGrZ+RNPdRWIavaCCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ls1q+2C0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1F606A330;
	Mon, 16 Nov 2026 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ls1q+2C0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0531F000C4;
	Mon, 16 Nov 2026 11:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828003;
	bh=3qfSGLVIk5gExQqn63xk9giu2v+mPEbp1W5CN7wO6Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ls1q+2C0A6ZX/HtIGtTYzTyLCELF19/aSKReU4zTxkeXqkXERQnEs5f0/B+flKaOL
	 N3THy8TGRM5PbhYgMA9NWP18ct03yBKxq13GRdNFDkTCaTrj0mlqVGGhwp0TiiBH6v
	 RDakx2Rn0RTiVAxt2ljXnc/d+zpKJD3Jc9uuyd1ZQiOT0gihGHi5OYhzpRoaoC0IJK
	 YBvLNZHk7CaRWcsE83H9JU7uAY4flGMVKaUYGziwVUfHlR06VNbMbZk0Es2v0yE9Q3
	 u3oAwoDO+siAUM2yGYAbStFYyddbFBdaGKo4c2wcNIKTYr43l+wPyjq9orykazN6CL
	 YqcTFZprghlsA==
Message-ID: <sashiko-outbox-216890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:20:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D27

