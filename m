Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828117;
	b=bN1u76oTM0VMKA0EQlwebNxrlUJDs03tN0F8s5FFE3J/NNffx2ARKT0A2BJibuUX4uaC
	 tv+xMf/0iRfP7jTssfv/iq9VzKv3cg/p5lTz1Z6lzIzaLL8wXYKX87lfgD0f84X6A54GY
	 tOQHuKxRnc8crQaTmOn4MF6PQb9JCH1JIaUQdiglsOOb5cD7fldDw5EbA6CCBHYkiiCZo
	 +kidykQusOy6HHgKKaIQ5TEexPhg/rPO744i1tWwxEN+JrYmUrcZ3KueQzQBsm71KjYDn
	 ajzYT760FN26z4VzjvHlN3iee8SVEN/xabRNZvOLIwIbKI0M5bKM2cCdylJAUC8+2VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hEAGv7dsM9CUCskmmYPtTr9QrMw+qGpQIqk5/QI+rok=;
	b=ulR6nRHt4wr0c3dWrC6MoobThTUOflTtAO2HPU+/Jz8TY/bdlPfV+usPuv9UiS5SBaF3
	 fBSvrWNulswdAoxkOINFw53fuuQ5P6AwpMkht+oFQk+UjdnLY0YE7UTgJrPNtIHkAxCzf
	 9wrYaMdiLyEmr0VA3hNmIraEblw+xfNevJP8vgDiAtOJNqyTbfxkHTqPaRU5cFtiHL93I
	 jw5ItKkDsHtr3vPxLqXT3eiKATGAYhIDMmjK203R/ZKhIAWqPA3n4vOs5bwLISIOoEz+R
	 OQ+mwEdM7Ugfui95FwHC76MhsGGCPtZU6DCvzrWhXF+u//wxqEzSbJscIOfS/eIVTLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImPMH8E0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95704606B180;
	Mon, 16 Nov 2026 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImPMH8E0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35501F000C4;
	Mon, 16 Nov 2026 11:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828117;
	bh=hEAGv7dsM9CUCskmmYPtTr9QrMw+qGpQIqk5/QI+rok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImPMH8E0f4L5hEzNiMDm70vAg9adSL4pT8tjGdLoozn1pCSQET/yIV5B0BaBoNu0D
	 +IRhq79CkkqAdCucktGGI6dC4IU3nBv707PFwSOtsiH+2IR0t9vgy2KuRdxqVjt7L4
	 7JiIsYxOznsS1rO8empHEimRE3N2AkMt5tNlSUNAaefLRuyeMI27O1seagr8gOh2cb
	 /lhcm0tLkrXZuvN4wSsRqLV5V1RhPUQwypPQMtQFZAYUHI2mDjNX7CySuFb8XyV/PA
	 z03rsPk5EE8S1NoFFyA0BCqDqUqQIRnwExUxjHcRFncLrY5ZcIqrB6oYcI5BTFn2fc
	 gaD/pSvfh26qw==
Message-ID: <sashiko-outbox-216904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 24/44] efivarfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-24-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-24-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:21:56 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D24

