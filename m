Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662349;
	b=JsnK1pZSM3v3E9B+PrUN7HbtDXdYOYhB1/4cvvWV4vj2TIvUHDHIzPyAnDZNnbDtGbMl
	 sDi4JszvoW4O/O0paYafDxMluITX+ECKSDZPPf2zrHtILlXp0IRe4sl8PfHoeSkzxDeH7
	 Nz2lcKPTAMCLLlDSNdH528y3yKKPcX9SVs7pO32FTqYSZ0GAj/hZJl839wBLCEhkxRBNi
	 qAXi/G4VqrvETLCb1fXCgDpayhOKOYIbhul8sRP3TJjkfFARtFAVY/F2fOnteIqYDzLNM
	 CEbROAikcYctBMLpZWXrD8VLzGwyV7hA5boQHOteGKiRaO9yAb0hkN189XG12qnDs2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662349;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xU5RYVNlG4HxyUvDb3Z4u2EJHhMvwJHDtM+BuQ6qtlE=;
	b=UekIXev/N+hUYgugG1uPVxVfyqIp7OJoc8s4qiGB7ZBnXL0+/1Bnj/ktYFawksnWdZKn
	 AwS8BcWHiBB9bz46IYIi5ZC9vT6zidKwFHPXEuujpgoSDIahmNM5bZZbADkJFG+ZhCTJ3
	 i7LS+iy1qfbOoP2goknPtZN3KQcYI48invEyPzFwvZsbKjUvtYUeIOFV5Ub9wpReACcv7
	 n5nvQQwjJXnirHkIzSl7hbfcVu5S1BZloG1a6AEwZiLpMqizH0ngcW72H590YGYb2pi2Y
	 aL2JCIByV67q6+oxT6xQ6gLXzzzK8U1g5MrzMbXFoZOabXmxfXe71ShUmOwPwZmF1tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjSkmPZt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E77606A329;
	Sat, 14 Nov 2026 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjSkmPZt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC6D1F000C4;
	Sat, 14 Nov 2026 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662348;
	bh=xU5RYVNlG4HxyUvDb3Z4u2EJHhMvwJHDtM+BuQ6qtlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZjSkmPZtaiNVpSZb/IJ1/IdpguNIUhIFWJP7FET7KmVsi/c2yWN1+iRaKxy1FmbDd
	 4ut5ziFfyJbe9cnpJ9ovAjruu7JVcMGg/lByrmqmchzPC40iT6E2tUcmGwxRbHkT/n
	 OnTi5oAtBjFJQClUYcXmPQaf+WNXxTzt6jkXieSUq5QPK25HrV1sPvewmfsdcokDjj
	 AmHG83r5XkgtCGZPvAYn7ojQ0ScXazEtYdCfBqMypEp8Mkogdpwz2JCcXMC4+jxmpx
	 n3wNmgeIbodJqftRa9oMjnCGSIKFnbbcTSB4p0QxqgFrY3lCv4o6lvREGQg1S9LKpN
	 RuatJlxgSn68w==
Message-ID: <sashiko-outbox-214537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 19/42] smack: use fc_init_pseudo() for smackfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-19-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-19-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:19:07 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D19

