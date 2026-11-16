Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828047;
	b=hvLsCddgx/M/3qsKRStZHnv4ziZxps+JPOMgnZSFDdvn7X6B3fPZpwktgRoO1rVVFiGd
	 xFK9/1v+pia1i3LCJXLRWpltkubF9CkE/VbZdlQFKByujGdP6q4037E9aZSgGUzTY1c+Y
	 ex2RW+4PeCKYjWRa0kpxnn2vxwlSR+uRvQXpbFF2YV7Q2h2mbZ26+iPo/McAm1RyEut3G
	 lnVu5dyg8Sa2R1JoLIXtQS++lGQTtn2LeaBurAvp2VXkjRpkz/KsXBlKsXVv2doeFn5An
	 JxHdOIehlhYGrcfJY+v2L7B9l7FuWn7jByB9rnP99TocDBIjNCDpAGFuMqdKb9XIyWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828047;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S5ndPx6IuXsNRclhmcpSYHh/hkSw8b4gpnsKT6+tYes=;
	b=iFZUDHe+1MZCHkcFFQDaedRoCo04ZqT68+3BJ5N+9pXJiNqEMDP1TNiJZS6JZD46BSNS
	 xZuFq+RHxymNe/VlpKGx7yiEEh7BKLb9t23MUI098YL0uDwxpAUlHI3/aYokpt+cyXR9W
	 tOA5vUQs/PBgkL0Uxixc19yNRcndGLGXAuMqCZ3uee/Nc3N9yf9sy/CNlmo9/zaOP1Mx/
	 HoxGatHiHsrobOspTOcp+nZF+TFzdaItZ6OkvWeeERj8Ua1iaLhlel+kSdfZutqOJ6wFX
	 bMH2P5uo9tx70KDbicg6hduoUhgjAv2y3eL5uTKaKZcGd2s16Yi6E9W18jL++hPEQRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki5FnXLa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393236071803;
	Mon, 16 Nov 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki5FnXLa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1921F000C7;
	Mon, 16 Nov 2026 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828046;
	bh=S5ndPx6IuXsNRclhmcpSYHh/hkSw8b4gpnsKT6+tYes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ki5FnXLaZLOaJexf6yKi/cWzEg0gXA8h5UeVHduaUaFTxb9q+agd2vJNXtWLn3lrx
	 lBnZcWREnjBS1NoT0cCL2BdxrzwHd39cKvBOVywKeFsCa8VJ9sdg+5TnQXNUY5fg3k
	 yAG5t4eoqRAg+8HkCvF2P9UeStVKkuQ3Jsn5oYk2/M/Km83qoDN+fO01HxfnC3w9rb
	 ywf7tIJSSsp5nTdvXU+Wxu3txEekR7kHz+cCvnHWBMwkR5GjUPPwmQJLK7GhPsafxP
	 uagqcP0NDly0oro4/yLZKu/PbaTguXkQKSMVbjwUX2fRV/9FMX0XoyM+lB1vk8X1Ir
	 kvHNRf273T5xg==
Message-ID: <sashiko-outbox-216897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 23/44] fuse: use fc_init_pseudo() for fusectl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-23-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-23-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:20:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D23

