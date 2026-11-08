Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143777;
	b=m37s1NsCj14cwGGIvtgei5gNB6f4E5aB0JYWvFUnwAHSWTt5lLONxVfO1PjL15gbCZbQ
	 +YFYQ42lLjhnH1f0QFlJ8HWZtvwSI1rIlTZ4byPX49nCrvpUx95lyYFgoEf4OPivqzLf/
	 3W3o/bTPSE+P4OQ86PHp+RfZ9A5Aa3ohuQ5KbxDhuFv3sc3Qog4qqu6wAvX1GlJLi0BFr
	 vP6jR66zSzex22BvJGjcMXMZEvVIoik3aX4WH/WWP2Nitt2j1psn/DJpGbOhxzGgTP1Ha
	 BK0Uwj2T4NbDdil39Gcigi42K9eTP45YXGOKUkwP8EmGNK39mChxn2nUgFmjB/O+Ivg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WVi6pcWLaFPXAz7MfNuNS4PLykaN2VBCvv1vhVBnezA=;
	b=fvn/E0oqGGd4AUt9hFNtwm0J45dsY5r6rEAR8BYYT29GQfW0m8XrhmYNjandEVmDqxLf
	 aBuSHrigKmaU6SFJUhOQ2ZURqrILqcSt6FxWDQHe8L3QYS9K6SzsVT8270irnl+Yiqk24
	 X7Si8E9+OS1XcdP0z+5dVWyJQy36AzCGGfKXYTP4CfGwgwB+LsPK4I63hPYgL94XpqZlZ
	 9eF4jSbw8svxnVB3z7cOIbImUF5piL8hBPEAAK9sOKeo7U/ZUTK8j50hnSAdpohPYlLcJ
	 sbRc/P0Ipdx5WXE0XL+vEAamx45Pby1IQYAJ/NXx86/7YbSaf2uAXtPQ8rSwEWR8RWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/yhGR+X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2174606A322;
	Sun,  8 Nov 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/yhGR+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D191F008A2;
	Sun,  8 Nov 2026 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143776;
	bh=WVi6pcWLaFPXAz7MfNuNS4PLykaN2VBCvv1vhVBnezA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c/yhGR+XtGbjknpvu/6jLqib/KQV+nxEYZKgWH6KXTI0Yv3e0Zl2fFrzlFsrSFJOy
	 HUJfd9Vbdydb2TBdZTunPF8n0mHrZuXGhPMj9AMIGU9UiT/XwjsY5F+KDqZBw3WG3+
	 cMLxQ0MbTtXS0gTI9cthpwMRlF4KIqP/wHyKDCsj1ueo0pLG+IDUcQPg7qBuopgs0t
	 bZRbhnnYINyYYwQBbkRsGoD6hPf7FEcv3RhlOJb2BpdxAIT085fF7plrTwxEEoed7A
	 DkSzaEXY6CbCFTe5bYuIALAz2R050VJ5GkJ/jxG17WhGwiXNRme3M0hK1zdjgmB2n6
	 nSCj0b2kxDCLQ==
Message-ID: <sashiko-outbox-203761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/11] dns_resolver: Move the key type into a
 separate module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261107131512.3603168-3-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:15 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Once keys pin to the kernel module of their key type, having the DNS key
> type in the same modules as the resolver will introduce a circular
> dependency preventing module_exit() from ever running.
>=20
> Introduce dns_resolver_key.ko containing key_type_dns_resolver. On a modu=
le
> exit, drop the credentials and call key_gc_flush() in order the drain the
> remaining RCU callbacks.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D2

