Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203051;
	b=WnLOrc1mBBkSgfLI9dYg4q1RQTm2hF1LgVTY8jabo3XaQXwwIIT8xh6h1a2iM8mS0bgP
	 7pqQfkN2egfVThnaYEanX8XwQTixsYMMcoHs0TXaO0MNLLl11nJ71hIEuEeLGTaz9N53M
	 O93DgMFn+kVD/fS2fk9vkvG5dhSAYLKRNRwFlGvQ7TJaKO1zRy88dPGTDPZ3zUzNgfCr/
	 QaGnONiOmzColQWR7yty7lqIj30NIIboC5YLx75HUqqR7gOvCPJnYQL2O1WAcHT+pe229
	 NduI5y0896Yu0m6VnbVX5DiTVNuAHWAwsbuBvPBS3zp0SaNtFB7NlYWNCiQMOkJFjgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203051;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OEeKqe9HslIK7Y/i+++z8SmzLdxvpVPzZ7R7nw7YHZ4=;
	b=LIWafqioUXQnxNcT7Ke//sGEZKdxFQO8SI1x3B1dy21WNdaUbuyzWC7sFa9EYNLf0cdm
	 tLOUKT0Vlvxh9S8mirOmT58c7W9IECgsNrH36QjdImdGp2mF0Pc29SKuuseVKYt//6PvO
	 uJd+rYmNfM/pFOeNf+R9J+EGDWMgCENkYGsPlFjOZKZD8OYSTTiDedjRW2rFXmie+Qntn
	 jky5sWfoS+XK9Eu36q9E+atbc9p+YxsK81Kp15+B2Buy9cYyArattczwBECVVIuLKg04q
	 gXe1klE2QVVxUdNS441pVpOySyhi/ObFh3Ey3ACc+7oDknpQXHL/60nTJ8PPv61f05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAxEa9va;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB82606A321
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAxEa9va
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BB91F01825;
	Wed, 28 Oct 2026 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203050;
	bh=OEeKqe9HslIK7Y/i+++z8SmzLdxvpVPzZ7R7nw7YHZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IAxEa9vafOnCB0vqadE79IQOE7RDpR21PpzOODx2bHzoTYw36sfmwHHeJWTiXvKYO
	 GCWnX1g9Wz+XuL6c65hffDvM74fhn7ubD8/ayAVygAGv2rYgRaNMq8jqlJZ9XODDbb
	 GrV7auN/Mcu2SiZdW1Y3XyS+Irvw5SotDTVj5BmX9/0QbY5lKWrSj1VRJu9XMrf5lm
	 Jkk1gVOE8WEKJQPchdsRe/Lg8zTrZI0dt3mKT7cMxC+KuE/mOzkGqLujsGyaoXOQMQ
	 wIMRh5Mwagbu6IbMfInZB6VePLbyV3mu26fPFz6oT0yAU1A3OoDcRiUCYj9+4Kgrx5
	 UTENvZ1vrWUiw==
Message-ID: <sashiko-outbox-188106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/5] s390/pci: Improve function measurement state
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028154352.15108-3-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:57:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When a zPCI function is disabled and re-enabled, the firmware implicitly
> disables function measurement while the kernel still believes it is
> enabled, leading to a disconnect between the user-visible state and the
> actual device state.
>=20
> Add the statistics_on field to struct zpci_dev to track the desired FMB
> state. Introduce the functions zpci_fmb_request_on() and off(), which
> defer to zpci_fmb_enable() or disable() to perform the actual firmware
> change. This decouples the enablement or disablement step from managing
> the user's requested state.
>=20
> Preserve the state in pcibios_enable_device(), pcibios_disable_device(),
> and zpci_reenable_device(), so measurement is restored automatically
> after a re-enable. New devices start with measurement on by default,
> unchanged from before.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028154352.1510=
8-1-oelghoul@linux.ibm.com?part=3D2

