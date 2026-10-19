Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451271;
	b=JigHfWe/58gMixejKE1BaVq4ceE46als+zzyAQy0SxFV9KuBLivpGtOHpgtf/svhyU0f
	 9tG45YiUmdcaBGDqaVEuDt8gBQuHLv9//WZSNMJK2n6PkDtL1rbUCKOFlnk9Fg15GLhyp
	 qwqoeoeTEWe74hrUfsMU/iuEfvlVNeN5fC1raEqAHOmUxCHM+zZ67HaOJppQKRTL1fe26
	 cx9jaaO1D18QTtWJwu+8oS10g+xVXrmb9BWy+4JUUhxMgnd/zdUVOe+fGrpBJ4qvVlW/1
	 NNXtjawvVoVuuvsgC1OcxdMegkqFPcIdjrZb+Khm15i8kW32qhaJUbGyhUqa5Zdfusw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cSXgC6O8N2aj5dfoxESO+wcVhdqYVlH3hC7bfE54fhI=;
	b=AennqJQUwIL9uCoO2vGkNMn4AmkxA8/ZQKHShLRGg2XFNuI3BFsxPdbiGQpE/fY/pU5G
	 VYd1h2XKrBSkuLLb3emn4bpFQnZgzQOgDRV8Ld0bwrSK7TFuUYYovZfMUR4WID4SDe+ee
	 udHwf5TOhRLq/En6bLb/tf2fAC10/BZ/36yzjeyC2QsdOnQURpIgTgq6VyLdahKCIRbL/
	 etmdQ7b/GIDWLWaoLsP9lxn4vjEO0CaP3AyR3NJfsXt+IWoWL8Iiz5JBxefyuJ923lFOn
	 yptvIPN/ElD89j71zmbYTHQEbhV17Cgf7ElknzGxrEyhJ6GYNbvvq7h7vSm9snfJx5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hqx2C4m0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DB606A319
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hqx2C4m0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0A71F000C4;
	Mon, 19 Oct 2026 23:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792451270;
	bh=cSXgC6O8N2aj5dfoxESO+wcVhdqYVlH3hC7bfE54fhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hqx2C4m0RIOPKqMda6cz3sLDIGY1+NEDboZUXSj/XKfYUwBEZkxIrJ/9wOnpDBcvT
	 5vxd2LOWgjJRNx0KOdRtEJ/UaKG+k7iggxalJ5zEX5y/6tc0X+bGWOCqMcvB9IkIJl
	 QNdSoDNjQZ8Ckq9rCc84gV+1iIf5m1PDdVaLA3rPQOplAWEus1VSdriOSzF5gX3YSN
	 jL4UoAQh4AsELbHG6+b1O6t9VquomrKE9j/QdhhbGaQMEnyaIKxpWby+s+LP+mfp/V
	 njRruAHcZxWM91a9U3lzI77PM+CwleacYNuiLpTrOfu3pOcOq5QjOP2CDO1kM9yuf5
	 BFF5SPeb9FXsA==
Message-ID: <sashiko-outbox-178333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/tape: cancel delayed work on device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261019225606.1864082-1-tristmd@gmail.com>
References: <20261019225606.1864082-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 23:07:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> tape_generic_remove() drops the device reference without cancelling
> the pending delayed work tape_dnr. If tape_delayed_next_request() is
> still scheduled or running when the struct is freed on the final
> reference drop, the work function dereferences freed memory.
>=20
> The cancel cannot go in tape_put_device() because that function is
> called from atomic context (under get_ccwdev_lock with interrupts
> disabled) and from within the work function itself, both of which
> would deadlock or sleep in atomic context with cancel_delayed_work_sync().
>=20
> Add cancel_delayed_work_sync() in tape_generic_remove() after
> dev_set_drvdata() clears the device pointer and before dropping the
> final reference. At this point the spinlock is not held and the device
> is no longer reachable for new operations.
>=20
> Fixes: 4111796d89b8c ("[PATCH] s390: channel tape fixes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019225606.1864=
082-1-tristmd@gmail.com?part=3D1

