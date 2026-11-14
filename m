Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662469;
	b=HCdxTiEjJy9uU/W0+zhpWvBF52XshFo4PlzracC6SNUMsRL3EFya16BqxLv13cMwUBYs
	 RAMP3bVYlCGzXa942C/L+KuYls4xNC+nMlo+L4/zRSvedevvRMCPJD9L1WGJl5jy6CAyh
	 a6KUpIO8cpqIyCaKfx7RiQoAXofIRbC05qJeTgbuR6NAZDF2yZSRGKQ3jCkVSRv0Kjiy2
	 W1wT/ZQ6+ihJdehLIiyQ5edie7HhV5RRWVPzisMiVBase4NY2NXlndaenKZAlS3BYBndZ
	 5750z5+pWx2Lvh7n3JR9h0EsnfJzekSf7q7kOO4+bxadlTPO/r0IFDrdJx37/65t4+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662469;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/TSvoB9RvrlzQ46RI3imblOKefNHLUkISKSUdrO/rig=;
	b=SEKZUREcIaN8Fnjb6FiZ1/Oe7QtAJ49B6dL6/yTabjjJXdfHpW96w3eISpl7sVFTCUqO
	 Bw1bEd8V+g/+n7gdWjUzfYmiICoJf4YL5vGZv5OL3AyQGz5CU6tQav5UDbdvWr5llu1Wr
	 bkZ9yKqnY/Y/jSV2NpxOnyymU2rOxgjN1ELLcHQMfrlmVZTaS+dBhg4l8cTG9VIGQ/Lzl
	 vryIDp2kIilhiQe0ijjEqA4Oaup5YMamSd8G5uD4oXFtqAV++1tqgbrJoZdYaTrb5a7wa
	 puXhulc8wJ9Ojdqaxbtfz894J12wOxVlcFkEWa+52LVw8srCgpqjmda3El9lsBdPlxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxRBmtzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC7F606A329;
	Sat, 14 Nov 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxRBmtzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700421F000C4;
	Sat, 14 Nov 2026 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662469;
	bh=/TSvoB9RvrlzQ46RI3imblOKefNHLUkISKSUdrO/rig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxRBmtzMsBLPHR4LW++Z4IeAYri9p4spMfytYOFfu5M+1NtYCZP7GKC1+iDneQSbf
	 rULS/ao0ROU6YV0/eZV2YepZINDBIAUf2C/kaSFIu7IVkA4Ur+S+NdcB9WsgL8JHXl
	 CxvBO+oFjilm9cQA6HZJclBKJaYHl6/BqvT3E/M1xir00REig2iPJJUUemfM+g5z8d
	 GdB2Don5zqBJY2gIKipaFy29wOnrpJy++W3h9bfGYD2LXbM5JFfdl2OwVztXBoSB5H
	 EUeEnT5qK7+EL8VnLlWg8AL7ry6Iqu6YcxFQm3dyOl3M3TsrU8Bj/kd72m1i5WBqS9
	 eGmLcneMDnKxw==
Message-ID: <sashiko-outbox-214554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 12/42] rust_binderfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-12-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-12-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:21:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize binderfs as a pseudo filesystem instead of raising SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D12

