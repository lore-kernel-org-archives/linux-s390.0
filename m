Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302829;
	b=rESWWJ1xCIpXg4JanSc4kFo2EH2Lv/N6o1n08IZK81BQ+YOkZ1VaumnMpjDBGtKQdro0
	 wC4bdkIXN/xpnGf13aN+efYfh5nGNCGTCQ3znXj7lWdNMxG5EFC99YFicvEtOvcgfpwCd
	 3gNBC1Ybo0KjCYtUCc1744sUOv4yiFMNGSVGXnu2pfT6eKNz7crVR/yTm5uK7zS9DR+Ia
	 eQDsmNF/kQO7Ma75URMAWHgyMKhZ/A4/BD5y4n54cihngIFrk8xIGaYZ53I2U/7KYuUhW
	 nkx8qsoDSqwFxRXxGGlNuSJhGpZ9TixU70DrTPiudwVWlGdxcOzY0jujO8vFDAZeqaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uMnCYl/020beJxQT/9lrjR8b+h2gDbkrk8MdNqBNV3Y=;
	b=f3X7Vu3QoFn7PrAcX4wxeIhsvZpE9zkfol61kcKw5ZWiesd7UsHms7hmdKrr68yCo34F
	 ozMT5fG3M8dwtrHPqcnI9AkzeU4Fn5/EoZnDmLK5e1r56vSi4WvPYQk7uHDxCkvLIucrK
	 TEbZGDoR3R6mx3SYKCRWgXHaAxUpAXZ5eI/n1h+ByF5OvD+u9Rq4y2mLq0vmdQ+ZsGOBu
	 7Cm7jGWS2MPZJB3Awns0ZAvYxxLfw/D8DBcTqXNBveig4JG5pTel8uoenw+mW14xzdvuZ
	 O+zfSTKZ1rCBGw9KTGcfhfzNkq0c82qukkucyb1dbKs2CR2E8zhKn1hXVn8boViUFQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKpzZne4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59536075008;
	Tue, 10 Nov 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKpzZne4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C111F0089F;
	Tue, 10 Nov 2026 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302828;
	bh=uMnCYl/020beJxQT/9lrjR8b+h2gDbkrk8MdNqBNV3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKpzZne4lDFv/AYNO7kuDQe6/BhPsM6LWSHacU9jGxv9VijOP1tmjUlcKsbApXICQ
	 JVWgO2iZWpY3ULd1xzTUGC6jFGEeavfgqy89xH6rxcUMhTUOkdyF73ico6Q6fqXWC6
	 +z0m3loVOM5p3pJo9pUiBEx9BUIrnGGDw1Je6JBk0WtD9+kz55DsVmYQzJVU8yj+zT
	 xSreoRWIEuAaU37j6WXHzuZ8VLy0EQ/4BeJV+t8YOp8ru36aY4orNXf7nQeHWFd0/s
	 1qHGkntZIallwWO9dHve6+bn7LJ39EaJD3gaFGLuuFVKafAxGR9mNafj6WCmE393Ec
	 ZMaL5Z72WwnOQ==
Message-ID: <sashiko-outbox-206752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/41] rust_binderfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-12-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-12-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:27:07 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize binderfs as a pseudo filesystem instead of raising SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D12

