Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662308;
	b=NDEhDBsgEkp6kHOO8LsaVZSnFIUGaKUhh8eSwd8nKeGPLkcEtfozWeaEclvrbxfi1ahI
	 QSE7n4vKUUGvR16xr4qzWfwKP37GToeqPqqrUOTYODX7ZdrpoHpQchO0F9oOO6SDi3liO
	 Gg8LK8XouffDiTaS+2+aXZ+0ajkNjGGCkzIYBwIAx8h2ECxUN0fVb5t5Ci4Ck3QYfpY4r
	 7IVEnYgLRQfnPEJZ0cC7uZSFHlYVKlwzptXbEKyXhzXzTRGeMig9upR0oPi7OX9dfeX2w
	 zjOQf1HFtYw7yOeXpTtqlMftRhuLRrP1cSI6hPuSSIJGYI4VuxwnPAj4ogzrnPJGcug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IFOp3mFQ5GAFxorSMcyZVsdQSeIB9F+7klNUeouEQI8=;
	b=mVST4SxHy2FSGB4SkQAR3ZGhPiqrZnQkdTPMiLCjKQTgw5bydgPjnrr6h8Gwc+RKzqyE
	 l4TqF8QL0wV+NvJ50cCwL2e8Pbp4dWO+vQ5Qa70Oyvu7TVq/rY+6Ikf/yRrxgXZ+rZhjN
	 s/H7uMP+jhOLzTlWyMpfer6DqCMOhNQr6uZy8gu0LQkgv2eCTQn5VuWZa6eiPg9kDt+Df
	 bv6NWqMvNudnk6McowIgiCeesV7FkSDHIe7i3Juowr5RE3B9I1a97LFRmJNz7bBcTppf/
	 lbG/Xl1FUvqxZRFqefGd9QOiTMv/CNE+/169H9krRLrcBWbEzsswpRtPADaXOWUlUDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV8WnwHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F45606A332;
	Sat, 14 Nov 2026 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV8WnwHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747AF1F000C6;
	Sat, 14 Nov 2026 13:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662308;
	bh=IFOp3mFQ5GAFxorSMcyZVsdQSeIB9F+7klNUeouEQI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BV8WnwHL3druIXIAPDp+65D2CLJch7f9ug+LFAU9pOcWkYYPAJVyzCQKFCEEXbPui
	 A1YfLyPMw6AitFDA1Xr9FIK1+b61NSaCcIgbxAEGHMKPhZKRIXowVvmeDVnu9MFH1X
	 QzWWwK9boyGaSOMHwgJkh0dGsP7oFJKuJUFziCFd6tsIJ3atobJTDAz/DnPhmnby0E
	 nS5Ouu6RYIWnwANx5cBeTAwJCIfOcLlaJ2rB2Mz2m/Um2FsJL7jLmQta9PXc/CYpqX
	 ZYX7X0AIc9UdFKXHXluyYbI2lCOD8YuYsfBaJYxqU5EgLaetzjw797RhIvqRqqiCwd
	 pk+wJiOPG3oXw==
Message-ID: <sashiko-outbox-214526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 08/42] mqueue: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-8-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-8-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize mqueue as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D8

