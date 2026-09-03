Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB84477E1
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423162; cv=none; b=s6oRkH2jEMp+gC8RtZF2OQdi4nLJOxbCtXjAw2ezhQ++MkDxvGo8/HOXYJKkbU5EDCISSqHoeURnGrnBOUaAqgK2DDxjusrDM1fAznUNChfNTinC6oKF/e+c3dg+FSc89ABmGWNBDWHb7ACP/o6RyOjAVoIlVlHadh+MHX85KTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423162; c=relaxed/simple;
	bh=3dx/Z+WWPLDXKami2b7JbPEl0LWgoxCvFcqR4muFbro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uo5HmBVDoygmVIAPiadyo0v5plYqsgOHMnl1fRPfwRKPCc0nsgpz7jr2CxlVGmQ6cXGZe9wmGNWb6X39rw8zNzdTGiC0Ch+3URj4GM+UmULrPcPA/1OBGOajXQ+LRgx03Wtj+WDvpvV9VaJk4N95iX4k0XRNTgzA21d54RoeEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtP+Zzcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtP+Zzcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F211F00A3A;
	Thu,  3 Sep 2026 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423160;
	bh=3dx/Z+WWPLDXKami2b7JbPEl0LWgoxCvFcqR4muFbro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KtP+ZzcmB5mOepHHwzaPt2oxyK8nUuUdpLjHYHsHzdg2Gj8zSGGrXCvGkwk96Nn31
	 u28jIAJValVDPwXJ7lDu3oIz/5ikHXmPRTFcdz7adaJ2qz/j2GBUshLwH/rwbqufq/
	 u5it0zYeQIS8FguJd/M86lp9aXoEmyT3+V6TAXJYJ6Qa+0v++mGzm7wgbCC2ORyisd
	 Qox9q/EjTRcJOKpB5Td5QooltfGrdtcyOi9KiI4cL6p767PIR9R4URaAOaZgzuiTRs
	 Wh+giVhmsj2LsafheM54n3b1oc6A5bdNQE5D96Lr2BfuwCBvJJO8MKbrxbryXJeYRF
	 Rco1ZRB0K7Gjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/15] sparc: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260903-at-vector-size-arch-v2-12-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-12-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:12:39 +0000
Message-Id: <20260903081239.D1F211F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>=20
> Move the symbol to a kernel-internal header.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D12

