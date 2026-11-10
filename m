Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302762;
	b=FAKXeemntJiVY9btrMfJkC8BIy4A8kBkLthHzDuVWOUVw3S6w9vUq/eXTdJC8/lIVavE
	 VJDE+dEaSdu6ifZUmXm2li4/Ev/NOd9lGneMKvu6EMvEeVJDZYHBltPt/ucpL44d0cW+n
	 PEU8g9cpOcaG/v4rPKdMgBrIMYMpH1RpLoaBLyTt2mfP4N+4hNaWHwwZRy18kfhoaxToc
	 rnLOjQmNsYgo2XX8IShnUlzROpxTRHu26OR7xNfjznX67+hsTlzd+b7RtvLr1cjhtunP3
	 Ue9tx2ObF0qeGL0tgXnQwxw7c1MSltd3Jvz1akk7lOx338mQaH1CWTv3grlnIX2E8mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302762;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xMWTk+1VSpxAE/dWDE0kurAC4VHgQ0XpphVOACfKnlo=;
	b=QO79KqQ/Xgy9zyPNljZRfa9eagJA/1R4FvBUWZyTHY6QYjojpcSYeJhMFbpBWFdX7AvN
	 GZFzhlV1F95Ss1vELdMYqh09fsbBVZ5col633o065hqQWW+fNXLSbmarYGCNy6T9owRxp
	 cjcY/o2hskB++dQKx8vcYxDYTVtPg6Y/TV1+NMYtAlAIWrl0tvkxyUf1D6rfWdY7O4af1
	 WFf2U+dHMlGLtzhHKCSjGaY0uWQPQ/Ydb/Pw08JNkif9VxK8iscYdRIFs7qOQ38/Vtvbn
	 mqhhObilJ6BF7xkpeeNaOFK39safIy5w/MfuC8i3SsdA838StJ2U7MtxvAItYn62MqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcI0W4ZW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA1606B2E5;
	Tue, 10 Nov 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcI0W4ZW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BF81F0089F;
	Tue, 10 Nov 2026 09:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302762;
	bh=xMWTk+1VSpxAE/dWDE0kurAC4VHgQ0XpphVOACfKnlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FcI0W4ZW8rv2RuwFhRLugPxNIedRicmCCsF2x0PBLXl40O7GBh9PuEQcCiYpLtg3p
	 /mxKxHRzBcSEHstlQ7GPqL67PCTyuG8AHPxWta8l1/CSxV6WR0qZJpxY4T5puHgpxY
	 oZLA1app6DrK8QFTsdvgPt4B4omm6VAHJq27mdRrQQzZIq/qXFOceInzBg4qXVuM9C
	 U89yLXkSU/yF3OwcRSVSPrE6EYBrlB+rlrMqR0gjlw4gXyVk9/t8Eo1VBhCqof6I+m
	 tjJ9NO9Y7O7Ztnf+LcokMBFS/bK1onD3nxyF2SScwJmz6fwt3klZ8NdF7i+K6Fr1Sh
	 5tFb/GbD+xg1Q==
Message-ID: <sashiko-outbox-206743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 18/41] selinux: use fc_init_pseudo() for selinuxfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:01 +0000
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
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D18

