Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662406;
	b=Tp9Qb3iA3Cmi6MNFmJ88lPHVJpShrtq1V/Cbp85OMp6N5D5vqufmkPYQJWjnrUe5Iwk6
	 FGXMYHl9PF8VshpI606rgY2HnHaXKU7Zw9d4pMWnJYDaVja6gPP3aa87P2X/mY1G+3+Wt
	 sfex/Vq6oxGhk536waM4dRl6N5OaF8pIeQ8V3wZ40MGW9yrQnIK5e5q3WY1UfsGIU5J4Y
	 nY93nadnRdAQzv7kEwPHNGlrfqNQBtXtLFFC+oSQG+GvTiurjNAHF1HHuqNsNcxosfOer
	 BGnimEETiIHSnsrqsEboH7goDG8K0cGPgQ9ykM4fXokns0loG1+LxZK+JWpGnEcCG/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662406;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PpQ8b62TqzaHbAtGWJzrfL3OPwRj91o3WJTbmFKDHH4=;
	b=X5GZEgFXn78lid9NFazQnjMowEd7VK8f1kmaDp1TR/roFeJ8j/pDer3d9VHc7vVVs/r+
	 7siHqOBEPUT91fSe4Cf0dguM20Mk1Vzad33S0UqE0rW96OJRCYOVJdQzX+Zry0KZRl6rL
	 hZf2hetG+78UdvoVi8p5UbCdAABfXkyG48n5umaMnXc3u8v0U/mYki1q4Al4/zkMQYOHz
	 U0uVQFzpiEaA+di6ec9ZjLo4xtA3gybcql3QaOWODnldWyfDLl17DbEzFbs/e/onZONbs
	 EJjMHpVlaIjTuQ0KodKwACLGu/ReU2uXZNJ9FTbY2b3hy4BCmemeRmO2PIHHgXdNhuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivxyiWJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B2606A323;
	Sat, 14 Nov 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivxyiWJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070991F000C4;
	Sat, 14 Nov 2026 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662406;
	bh=PpQ8b62TqzaHbAtGWJzrfL3OPwRj91o3WJTbmFKDHH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivxyiWJPLIphsxu2x0AbOEXAXhJqp9yKhuKOqlzP/to1KAIhpbz1uIWMw7cPVfsod
	 A0j1Of92a2gdfX4LuIjzdwhv/4AzN5U97nAM5wEjfcw49EDEJ3V7hI2A+diQjmiXFN
	 oK2BSKX1jY4h5NxfhXjUKaLvL0RQn+Or1mn7+Xub+QAwSl1FkOQdc/JhABEEcC+z+w
	 RYlC5vZoU22Iag+VNBleLiPKZ4Ft4bwsPV177qUh1xrC0L9+d2+0emcNdCQmH6aF8l
	 hiyKnjP0dfreyzOQl6K1Wwc+edAsuVazARbRFqxBF+dfdTEKht3Cb5GB28C5nQRMz/
	 v5fo4PejFljpg==
Message-ID: <sashiko-outbox-214549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 20/42] apparmor: use fc_init_pseudo() for
 apparmorfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-20-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-20-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:05 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D20

