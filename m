Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662418;
	b=pJ0QyNE/LOEmFYb5kU70/VsaAle/emKUT38BwsZnboUIHs89O2MF0gXWPoxI5HyTq0yl
	 qfpeEdE1e4jk9Kb3yJ9XVvnypZqdV4/f1WwZ0F/rADivkUA6+Td1JqSjFtLMhvRgcrrXp
	 L3kShBIZN6xHGlNLT4D6lSxeLN3+a8o+d9dqnpjAbwH79mnouR/QCYa1LDUClgOF9mtKK
	 9bxoEnFkqCEJdzOu1DpMWmOl4rTjPQX6YnIP8ztcq+2PMO0emqZgibJD93+hNIf7qfns9
	 VGVlBu+2tva95VKEK7/PfpFNv1LKhmLmL3oc0u2BsmbzboOu91781U+lBIla2wtNzbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t7NCrqRfSVtLKGqb2LpNwDanFr91vR7XvXfzmlX1Rdc=;
	b=nigkVCa8Ue/wIjnqnRtwzhGLarWZuuTLaXChExLmS7Bfp5o8BbTH1w9LQbEg/W1Xy5Q/
	 E/P5uAOp4420l0CEIdroKiGBvWi1cST+U+g6y8Z5viOUxNzIYzH8Z97/7NxmY+E+SgHbp
	 wkEJ+OdpcrjB+7PVyDfzHV9EXjsCxzbuin+4H463lENlR0bFhTeAUccGjrfH/M8vBymAV
	 AbJ45hOynkNq+ZQH3egpm7DrpVFzzIN8Y9beWmQNXAnJ7fQcM7lqXArJPRVEj136TbHEj
	 cg5KOu8Q+HIIyn25woSpcWyHZewrRSzspdjMgmoShivAXQ+bh4z/IQEKdWLFmkDuJTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7yLvIMf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31B606A327;
	Sat, 14 Nov 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7yLvIMf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5D61F000C4;
	Sat, 14 Nov 2026 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662417;
	bh=t7NCrqRfSVtLKGqb2LpNwDanFr91vR7XvXfzmlX1Rdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7yLvIMfjxJ9dfQlwRBEH9/uENEuDRjNTKyC3nMkchepn6FUWImH7kv80vpc2gTh1
	 nbtUSq/XCJZRlhGCbBpVitYi1lPyJRzv+D0W8biWQpnGID7zpCuq7CpkqD4PmGCDRr
	 m2Ql1MoEj7WMP2BfHXETm74/d+FX66Ukei4zX7aXoPCfwBN967BCz3HOVY4u4qt92I
	 AA88Ax/EBZgI6IwWOhuguOGvquza8MtQRQBwNeSbJCFU58eWXUl8VT7ZeaZPOVIARk
	 J6AjMJcIz0jPQMfNeiSJ0hRWmcUEQ4Fstm9ZHpU+MaQ9r+bEsFQUGgu8uHNQ4FG8cf
	 MVVWAX/QVknSA==
Message-ID: <sashiko-outbox-214550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 28/42] ocfs2: use fc_init_pseudo() for dlmfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-28-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-28-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:16 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D28

