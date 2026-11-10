Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302681;
	b=4QO4NIar23UpqkfWW7EDil+3o+dqPUYD/niVBcBzqe9dPN0fXWKBOOz23DwYHtYc0Ycu
	 GUXmttgzlrwInnBnKiJXcTzAZaHf9wzz3H+LPAF1at83qRlf4tDuAj6WFVKzNDcYK+ing
	 Wu7YtPVUcWn4FTTLnT85eylQEYHOZCqJCdF1oI+Cdi4z3qgAQovRAc9LJYLbNQasAwdIT
	 pNbrAHyYXdsLgDHhZ8CdHXs0BuJFSDvbUFVXyiyad693TrrPaL27KhL4l2294+0Rbb32q
	 kYSylmLNzIq45ElaVSWXk91gW+SHPPXmyossdrHHmpHgrF5GIcXbICJaEK+ISRUb24A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2IPeUIZQcC/x6KA8wPMXElPAXcO/tUo6hwgOk2P+ft4=;
	b=R3231yxgyy9+XJx21kvN6ol5smLC2pPWN0Z2Ys2RCl9aetw+imUf8+sIPFAx5JBHx8mP
	 B900nvNXHAd6PMx9xOBrfkqIXNA7f3OpUyJPVwKHzAhZy8W1zbC3msfjo8yfiNd2NEPwu
	 Nm+WC15D9A+QMLsM7MKk19vLsNRGDO1ZlaXkupTuFrTlbtMeFYuCUbAeRIcAwPhc11HPf
	 N3LbIeOGV++WyUeBeQ74iDx9Ce6V9GwF2hTCetXNueS989g1mZScMa91/jjKyKSWpqxRS
	 UHMS4xNxxKKdgfYcpd6Mu1XUrGWr2z/fiOBNWTn9kxNER1DnyQII3sFLWkjQM+PpF8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luZRCOZf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694886070B27;
	Tue, 10 Nov 2026 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luZRCOZf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B321F0089F;
	Tue, 10 Nov 2026 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302681;
	bh=2IPeUIZQcC/x6KA8wPMXElPAXcO/tUo6hwgOk2P+ft4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luZRCOZfYl/QcOxeH5FcUFgQaZxB7U5pXB5diS0x8QIxxcxgLzR/neZDQcLgkBeVG
	 5sOXFtAGuHhq/AUoI+5N4jCtZrmiejQeeSfys96g6rrEdiEASPOPG+Upp+07NhAgug
	 O6wVf2gFlne+RYRVYcJFiod6uwMFuCTxpOytrXylSLPghG82q2MgQy57qwn2GI9Wzy
	 szOsVySoyaFPbXL8+nMgkF5SyHDroXIIip/ZrYUlpEYB8MPKBczLB6DUCo5eDpXFxW
	 UCNIIYiyjPI9rroU1nSIxS2LCkkuGNRlKVa/9ILNCtU+EJVEmubbn/yBmfWFcv2Tbn
	 jSrhxoHIe/KBA==
Message-ID: <sashiko-outbox-206732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/41] binfmt_misc: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:40 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize binfmt_misc as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D7

