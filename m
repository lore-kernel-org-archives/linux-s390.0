Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662438;
	b=4ss34rnAzgRaUIEtTYEGF5OUJYDOsW+PpEBjbU3IMktWzq/HJO7NAxb1h988l1sZu+6k
	 xjBzg8n+bNiuvIsbqEGspS1WI7CBwYdM1vtbbTuPnul5IjE6ZBTkWmW/b7ScKSkl2HdEK
	 ZGjLRUjl7WGr95pnwgB3uBSxPCU06A6rSXtigOvGnI8iPcSlxJHZHolA8klX2FmiQC/Pr
	 53MdOe+FrkfH0Y5ghRzMVy4Erf4EAROlCbmf+5Z0hkUPeK/ngUoWgoVuNfmWP0FpXQWbM
	 D2Xqt2dNRUEo2ieUG3jv8lBGkKQLE5/3CGTfwQDitp6lritDF+PhwHVJykcJbrT8jsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662438;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fKzeYiEMpzs9ZEaxwHqO+sCyXI9VLfVDWCl/p6buaqY=;
	b=F22G9XItKj/bdGmk0UKfMx86+taAJoExflKWx5YZir1chSX8hoDgTRI6EImBR9W6ZQNG
	 rMnppcgCQneUtAfBPvTKKPExVgUQYxbR9uxM9ZTOEjWv6wPFy1v1VR9E07j/KRKo9JYJo
	 Vnyv3D2sc/mJsgdur0o4sWh0bHk6fAVufAlmqxitBCSgzR94YIxxfpgY5Ck8/ZKfVc8Fl
	 vwIoiOM1YFm+3GDj9B6gcYRAxmJimWX2ETE5+/e3tOB2iPd5jjWwtswAYHfJoeeixgqTL
	 Y5quxYIw/ZsL5opVYfz4zv42fPCMveWZ89It+Qzkp8dIDZmUdi3Skiac3pClyzWsqzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTZgKay6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E253606A330;
	Sat, 14 Nov 2026 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTZgKay6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6351F000C4;
	Sat, 14 Nov 2026 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662437;
	bh=fKzeYiEMpzs9ZEaxwHqO+sCyXI9VLfVDWCl/p6buaqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTZgKay6PHlgWxAYHig6rkq03/QoD3uMmr/qHc0qGwqIP0H0Pa0C7cEai9wk1ngwa
	 SWOgRHPfOc/F7ZjT0fZOzj7EXYRGuTqhyuexOg8LT5v77XCMaO+xnPMiXZrs/wfeoi
	 mK5V/+9lvAmT6pU29JUKziH91iKT1V88AcZ6hD2uByIo+y8V5t7t2r2tSzrKjS/AO4
	 8qE6EeB34VEJHXlNUUUv2UYKab3tJbEbc/M7ohLQgdFj7Efm6yiR1ouVV/6we3srPV
	 GRPri2HAXiGPnKKBQ3HO4VTazB0wtDWYapmlM28GQi4nIWzFc15h82II+hkBfYyrb0
	 bz8JULt2ShRmQ==
Message-ID: <sashiko-outbox-214553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 18/42] selinux: use fc_init_pseudo() for
 selinuxfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-18-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-18-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
>=20
> But selinuxfs needs device nodes. The kernel replaces file descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear SB_I_NODEV
> again in sel_fill_super().
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D18

