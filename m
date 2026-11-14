Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662424;
	b=R48PzCSfT0gaKh6Fbo57yaAhkRJu/4KQpg8JtXrpL1zawwAmWpG+uk9DJz9/UCZXqSDA
	 2B+IFbMf8JO/6DFoUG3lCLSTWPNkv6gwy4LMD4PiXU0kPvb93ydq2koCMTpgkJL5kKCgv
	 nrxF8B5XHAcMd0wsfcfI1XR5ucv7KV3v/uGkoOY4kzAn7DuNU2+067ezJVIRl3LmKHDVH
	 gqWV40/O13xxGYrENYZKwjU2x2ccXYHQk3Zg9NbxL19er4ExKw46ZBKp8VREZQmGl/0sN
	 MMv1/l3ymPXe4KzjttbswoA7MYJjTtsbLVADxH3ggQJO56zlKAA7EFim4DfyqeNxqaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662424;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uTuI3gVFdh3FiUjUSPIMhb47qJMc9ROccF2HS1s54tY=;
	b=xEbB8pD+zqmJ38QnI0x5fGhHKnF0LPQXCLL+Fv2ZmxSNKJTNazDa7EbVt4G9sxYDdHKB
	 /jeuyDXhtkpAbYMDnHN/tlPMjztYkyJ83Fb3fVjFQQAbmTXTHfIkjOEONXTCUSXH0/XLJ
	 F29rRLmJhFoZIjWmatZ6fsXipegQtxDvUEa5v+LMaYjTfdEk57+zTW4Lq6/1ipo2MbuzG
	 rlxBXN4OJ37HeOkkIS0IvPwstdabjFF6N+1LrD+uobYGoYso6h2DgY7SEm4oCMcwIYCXU
	 +lNEPNaLuGxScNk6EzfbolwU1N6vFgOrty0Oi+2WJP5HQsUoqvrRxfNZ/DsMXRK4nrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIxCiDu1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A041606A331;
	Sat, 14 Nov 2026 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIxCiDu1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489CB1F000C4;
	Sat, 14 Nov 2026 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662423;
	bh=uTuI3gVFdh3FiUjUSPIMhb47qJMc9ROccF2HS1s54tY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIxCiDu1H7+V3/m3yd+mtNpaGWU0+PPrz6mK88T9kFBsDxnxlFFszYMoC5ctGmLka
	 atvUcJZ5YsDRxXyv/Q3W2pjt0YtFvBJgzWl3PuGJous5qTM66TKUncpkBPhJxpJgjA
	 o6cq8AuLGgPm3mSgzo/qvnhUk51pz9Ge8LnCkEMnmiRiFSV2oOTzYp/UM54HILjspc
	 /B3kwS1G1bpT+18UrPgUm/yyKX6JXcDYwz5HmuQFklg/LUBbSyucfKj6ySBr8AifZi
	 ME7vZDyRFpE0tIaSWMeMmq3tJ3PWjFtL/IlwUI25y41V8gmDZHg6TeUZZ4BUIuOTG7
	 wx+zmQ4aTcIig==
Message-ID: <sashiko-outbox-214551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 31/42] usb: gadget: f_fs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-31-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-31-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize functionfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. functionfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D31

