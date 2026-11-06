Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981087;
	b=Fomnmho6Shc/c+4wFS0pvYcrn6Q0gmH5FQ7koG8DC5z58kbtwimX9ELrq1h3bT7D/5rO
	 P0FgiqCguX9X1NZQ7PbQGQWHd9BXEjEqGCHAKR7mXncP8nAU1sT38dWj0uc++WZ2hc8Nd
	 i6LGanCTCV9PQld8PGtGDD5k2V73e4nvvyuMXGooNk1/aTkfi7IrK113O/xDBgQZCZtSC
	 8OEorOYSVipqwbWJSrFt7kOqQz2kFLqoDrg1wmzG7FiDD2Fj0+yPey/h7MqOIovLzZCXb
	 Sxxv9VBaEQmdsImmrTZnqtOnrUECVgKUMhuASqXKAHfTYeofLJqn4SEUhYE3ioEXUSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981087;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=clcwQNwIzpfzmwqwnfCmj03y3M3gh99woWFSFkr6AiU=;
	b=mIEkmlkMpdpxb/ul4w/ZZLT24Rbo8/wLBPPs6olf3NU7H+6Sj6qxU81e14wB3UXNaRrT
	 gpp4MYWmCwcW32C18lXGI1EYtjhy9f7bpi5y1+2RLJEd8NIoQiFrI3QbB4/1b2uFhvIbo
	 PWTVHD45zPSWZTcPU/yFMQexa+w6iq7A7qyg0lxfR81PUs6S7pygIDco3KkpNs4XOm2jl
	 ga7FUos36UD33NrUQUgxdCQXKg9oqbZEkBcft2YYnWiziDfHkxAH3nNAs4yE1e412Cb7f
	 AXBkNhWqr63sPm4FWVkxc+H3Zj3zxBp1HpBMXGZnLEINZ633UF3fN9bOBNEW6QoU9Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY5bLu46;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EE606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY5bLu46
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224CE1F008A5;
	Fri,  6 Nov 2026 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981086;
	bh=clcwQNwIzpfzmwqwnfCmj03y3M3gh99woWFSFkr6AiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WY5bLu467BWIFzFboNLCag7jaG/0PuYAlz/QeUa6abpuEZvusoNYxRF13VsIs6gxG
	 C8NxGzjIPU226CK2poQJXg/j1XYWyxykv0hfsq5f+uTDZmENNpQ4MIU0vU46pUFjTh
	 qL5p0LBt23lhQSpQ7IKLDQ9Yfi0GoMpEoyvEDX8YXqgi16dTmr2Yf+6dHMuL3X3NnJ
	 uIXiMrQ/ZdJCz6ysNt9X/f+FgMl1bqj77bwEWGkNepd0SWMJbnZAyPN8ArwUGd+7Bs
	 iYDmccLCP55NT6R+nO7dZDkFOMxxwpeJBbvyw5KqJtfw2t/ltfuDuZ7Rz6Sd8zwGDS
	 XmBEYsdk6i1fA==
Message-ID: <sashiko-outbox-201764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 13/14] s390/vfio-ap: Add 'migration' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-14-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:04:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add the 'migration' feature to the features provided by the sysfs
> /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
> of vfio devices is supported. Since live guest migration is not supported
> for SE guests, the 'migration' feature will not be included when the
> feature attribute is displayed.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D13

