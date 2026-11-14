Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662310;
	b=RH4ywiL6i8T6G9UKitPG/MFrj7ihxgTTYAHdKnj3jXjNMdAEnA/xRJpKyCop1pkBDYbu
	 2LsTKRk4cyvh28giLcotNNLzK8A9nYcA2CM/JFmfhdvJEL1COghiaaJ9LWUQp0fCVWrrz
	 u0mkVQdQzwbJLptWOFTsOngXQ7nw1IIlhz0nnYLw4eNEtFguA7Wv805x0BJkZI05yGD3P
	 /BK6irDrQQ9x2GWuJEhsbq3lIFZjxiR6cHANOp2ddKOFx168c1jECg+EbWCI83+nucbqa
	 gydOrsExNOAxBXY/FSVi18Lpcov1PprHljgr9QU7vNeU/fO/BzM46jIRUVFh15qpD3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a9w2Uim3adaRpW4xJ7sD20mjQxvV3QFKNjYMiaxuqps=;
	b=cDZ99r8tvNT3YrOirhMeMafE90pOCmm5yxRMGZHC6KlbqfbJxgsD4Rtrlvi54Q8kfE8t
	 Mr7hMbfanLSbgrM4nyXn1RDlHCb7CQONim8necz6tQg+8BRJsDoYwIdzryP0sAbYQd7UQ
	 cyLEEJYzmaWyoxaz+6x58rGQlnqpu26iFTTKUBgAUkL2MzVO+FWaSuY9/d+TJX+K3tcfg
	 hWKhuwHpo8ygdNwmnhm9yXy/XSuIgyC9uaNaUXie/1tgOUVHo8GLcUCq2fFVtgI2ZKo/R
	 AX42ZwlMLaabDfRffXpMnDyK3vMnsOiYWd3rG0ing6Rin+zWONK7T1scYNWXl02DT2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Df/JeJH6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF42606A887;
	Sat, 14 Nov 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Df/JeJH6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3FD1F000C4;
	Sat, 14 Nov 2026 13:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662310;
	bh=a9w2Uim3adaRpW4xJ7sD20mjQxvV3QFKNjYMiaxuqps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Df/JeJH6tOhdvEKBlg5tlu7/WCcC7bQslQsMRfeIGI4pItMepZAeYVrqj15SQjfMf
	 lhSy1rnNMJy8iE9lKO7pK58F26t3X+yVZhw554OhE279ctWRYHL1tGpFoHlgVhdzZ5
	 SVNjEolSzS60WNjpHTAIY/NhGgsKX1Ehck1OYaBYgy6uoqhY4kBGGUubLTWb4EeIZy
	 1B+miBHBL8rRHTvk9IsyLxAnn4g+jBXMasaaKLXrKOXOmB57oelwb635eA1B4KQ+HK
	 VfLUlvfxa55KOKUmLhTW1docw0BE7u3TOm3Ry6HIA6eh6oiGXsUOIWeUXyiqCL32zs
	 YPFf9uqAiz6jw==
Message-ID: <sashiko-outbox-214528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 23/42] fuse: use fc_init_pseudo() for fusectl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-23-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-23-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D23

