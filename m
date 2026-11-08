Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143783;
	b=uYcn4yTlnFOSvHZnO+a7iDUUDyh0SKh+NOs7736+BiS12RDAMxcUuSoRBxb/W46eH+Vq
	 PvB9NslA1ATMPy0xT0wvCrnUY7IZpttFuASQwIsvhuL3XsoX/86vmMEzqUlFZtdvbGS/c
	 /ZyBdL8JMzgLa4gt9f/nVTRUagC3JNA2TND/yQqSPqpn4k6pzrpHr3rxi4nTCjdtpQeyG
	 1FyVrxZ/WmyNTfRLnZabWdWGMWrCCZdhf0mSn8tMd4XeoEdCAeX/CsTbuP8I3e0xQ2iZ/
	 2x4XW8RfxmRqRE3JX/or4Fd4CxO1nKIAFTKlpMduorglkzgETMvw+fME8bFv7xFe17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143783;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x0H73APANSkg4hK1fxmyKB5fSeWxT9y1OQF6z8NZOMw=;
	b=aGohKQEyTQTjO8BQGCFdup13ktIRFXaT5xMEt30bDE3g0OBUBY8nx+p3JNCS1Ltf7d3K
	 Sxybf7pmGQ2uOm13E/yNjehpdLfEv5RT/ov8ugiM1/U4OLBhYNiwuvA1MsfDBR6LCyl3n
	 6PVpaleS2qtaqbWgTch4iPjKqF0HIf5+YiS/ZiOLmhoV9kgH7uJ3220AlgXYSFu8tbPGv
	 cJ6wMVF/zkYEn/qE0M2stTsmFesDdpaFgVit162K4tFD+SgnHTmkTjYa1v+OX7HoE28u2
	 xngdJnCgQcQEAJIp1o37Nq60XYrUeLA2zDEyC7zD2A4G9r21Qdw6T9SmUrWPhH7O5mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYdsMeX7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38C606A31C;
	Sun,  8 Nov 2026 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYdsMeX7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352DC1F008A1;
	Sun,  8 Nov 2026 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143782;
	bh=x0H73APANSkg4hK1fxmyKB5fSeWxT9y1OQF6z8NZOMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oYdsMeX7mPMIBVFXjPvWKgCvpoDCFL1kBviYcBXL6c7N5VtNM69LfKMMdFMJIiGJS
	 d4EXZ/UWszQ4L2JRHTQ3FjnrkGfZcmKYt9PjMEJrYb4o0EmqsPc6C8nChlhvtMIztv
	 GrS/SBzC4qrE/Lq0olhe2JK1iFRAxuN6yI7v4TXMIoRUahU+/HYNGxI1S0FNmC2aT8
	 tVWuXvRFizdYu+1cwZbZ8vmJpR1teX9ovYB8d30r3huCpspDlSDUWPAxqcl94QKTr7
	 zgbZlWWalmQn/9IyugaJD2/XQ24N9eMjWnTcC/iwJXUQRhoXVgiTCwLJYyRBryKPk9
	 3KIofszJgrjwA==
Message-ID: <sashiko-outbox-203766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/11] KEYS: trusted: TEE: Synchronize session
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261107131512.3603168-8-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:21 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> While the sysfs bind attributes are now suppressed, the parent TEE device
> can still remove the device while the instances keep trusted.ko loaded.
>=20
> Update the static calls before invoking backend init() and reset them in
> the case of a failure.
>=20
> In the TEE backend, guard session context state with a mutex, publish
> pvt_data.dev before registering key_type_trusted and sanitize pvt_data on
> probe failure and removal.
>=20
> When an active TEE has not been bound, reject seal, unseal and get_random
> with -ENODEV.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D7

