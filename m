Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662385;
	b=kbIRO7o9wICl70K16VJ5rx3rw3Nfg/IBXfigjN8rz8tRgTYOSBj2q4zKfYrc9EraRh2Q
	 txiTBfAtxc7wVWiDjM3T/3ITNC0T71nnU+vmI1FGEdAWYVu3bb6LfDvJMEqth4u58mhZ+
	 D6uQ/rmr4sc2UIgAYDcxFk4XiEbGJRxMPhCx1k0cw5l6S7zBqZD87tnolUABFEP4Yky4v
	 aaHdWEHVKkSGfqPZoszVzSnHNETe9RGtHW70jcW4LGXgxTrNOi1lThNh45KRzuaVXx6X0
	 zD2K4N04cE7ijTSBf/p7dCJ+JusmKsfuq/WS2w4gBwVqefphijsYpxJKeFNAM9FJYWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZiHeZ7gnfeQNe+STZ+Jqg7jZZN8Vfg3FR8VAem0chiE=;
	b=BzYBZYU7ftG6RROPWn+erJfeDABu6HDELXZFPRuDHCVZFan3XFsHKZHpiITB1w6Orr5v
	 E5dEBoZlD2qA+rBwDenVkyqF5txBOkUNXzurdxKzc3VJNvowvYp/vdd6Ke2P4qT7iG55h
	 x+tGzjDY3R7vTmXR/i9bgJMUDQY5/L/Xxl8Fv7J1WHh+BGpfK+MzofQzkJZVJeAjrfeti
	 Q5DbD0KEX4hCaccaLkbziAx8H6qCqii7LKrOW9Gv3/BCyqrCF2ojXaw3ZKdfMEIWD1wWt
	 4MmQ6lOS9AA1jCeKXzI8fi50T84eMFoE2Lc4MTymp82jgnxtajdbdu4Rh0YKZolGepQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H/kRewBS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72751606A329;
	Sat, 14 Nov 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/kRewBS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752221F000C4;
	Sat, 14 Nov 2026 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662385;
	bh=ZiHeZ7gnfeQNe+STZ+Jqg7jZZN8Vfg3FR8VAem0chiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/kRewBSqrBOLFOCpPZu3KK1KU2j9g3FhdHrd6OPe5lWt09kxHrUHUvxcmBL64z2w
	 aT4uQt3hDSTxEmROEdgT1Lc+Etda2x0qS8AlGjjfDc41ZZym5oVtRlIxGZNjz/D0eK
	 Irnk9KIOIp/Wozo3FfYH8/klNHKeORFE1QEgilVKrm1Fy8SOzsMj4e3MaeEGsyc+30
	 7FKFO6Y8Om1IT4XQMvg+TNCTsRJkb7dG4yuy8Rst69FZVLRl3vGL7vzG/+vzHjxBlA
	 IclpcDLcAX8Jtcpnc4PUrW6VVilwY20xwC+EaAsMAispZ9YGGmRR8/yuwEmorvdPVj
	 YJZsHTSLCXFlA==
Message-ID: <sashiko-outbox-214543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 13/42] devpts: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-13-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-13-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:19:44 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super() keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D13

