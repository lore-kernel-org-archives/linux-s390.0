Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662402;
	b=4NbNZdJubYHSi2ZK5HS1K3eE8Zrlr214Y4+eSsoa8kUcnxnkGG8TjCDorHKcZrqqGeP0
	 S2kDpCwdhc0ii8xboqh9dcN5pBogUQDmTCY93LFg+ZB5TKQt+rVtTctyi60OnXqmA8a5r
	 x54RHnK8n4HxnnCrBb2U2J+S7f8ZQ+tEQoJV5Ulv/gZXNMa25se52rOcMRxbPe+832sB4
	 zaKZTbOGpQjZUeMalzd6yNdDEi7t73n7OAShABGt1mxBOsKf21y/J1VzhZGDNgWEkvS2u
	 /3O2CSDvD5WutpCWE/SsQx+iF73CPwRRqjPJSORogkmT3pwYE9QMtjEg+h2Vt79QozA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662402;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sfMXGgWIZ6s1CDIfxT4YFOQ1VHfQzJ0C3mNllMGtsUA=;
	b=bX/I0GVxESpsqJ/9qtPnCyIbrOUsQ9lGfQoUcReqW3dUnBZC46zf97ULQGciDyWcXEk1
	 2S3zaz02h4BbihYEWLrYCV2PoahMQgd4pZFMj8tvZhb+gmKDfWmjEnJLatY8I4KH24Wgf
	 doPr5FGDIZs09x8utH+OHO0Xe5MGiZW+SDQH06C8PTQVFlpEZ2lLzsZAqNiuZ0vYfb0tp
	 Dq9lwdlXxtqC39+uZxZF/OPHwf3UxCntUecizvBmDnlofuvD/N/gRAEuDEXm5w4JdALsG
	 2d0UPoVHItIUNHWwV6TP/KeI0eIvW6pQz4WeZX4RyMeuvlVPY8+VrocgzwP/zBdWd7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5rj7KZ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560B606A327;
	Sat, 14 Nov 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5rj7KZ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE6B1F000C4;
	Sat, 14 Nov 2026 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662402;
	bh=sfMXGgWIZ6s1CDIfxT4YFOQ1VHfQzJ0C3mNllMGtsUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H5rj7KZ9MmVPY7evDcYjYisjr72BtxeXQ7D0kjlixP4rl9qEdVBzdUDukTSJ9ABXh
	 OfmarJUKuU+BOCQs/YsaSq1314l2sJitn/Lb5TJlCwYe9YG4SsDQMF9hgdlFhQTRJa
	 OL2j+bXVjYjGI8JM3QAQByXSLBJWXGz+hdxwf74N1Ii8RndvJ096lAjyOkliZpVxus
	 9pmuEo7KCNzZF+hu4su+JnYcQTk9oOA3erXznGTznmmMLvQ0hMh1ShtxJurvZxJN2u
	 /dVHN2m/eBXnjmyl0Xa0w0zIJ5jb2uAJy7JZjm211ss4tJUikC4fRvwGiVcKTbCY1X
	 2qdwS0g9JX6Aw==
Message-ID: <sashiko-outbox-214545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 25/42] pstore: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-25-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-25-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:01 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize pstore as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. pstore never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D25

