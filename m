Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926451;
	b=hGJCIN5tsCZVCuv8jrrkGkVAqE6rB9CpHLPtTav5+h9tEgS0rrjQa9/h5NYjFpa/HSOy
	 mzkdYM3ZFWuFrATB5JlGmu3k3VVAS3ykRF7y2RzxV89BZD9Pi1rCEWcsdr9U1acX3AN1K
	 fA7S/m7JYWTjRPtly/25OE/sQZLSmNz7IcMclhC2QcpaOIGQHvLE6j8vdw+so6NY2SICq
	 FNNyzy6vTiL52LdB58W7CVIDuLj5eW+22+0/c1GNfV7WpQhOhdgmRsOUQv4CKj2NeVuWR
	 Qjxb0N5U2tP96GZJchsfp7TPXLFPfGJdQ0m/MxWLM0kETBz+aq366jrlUs96OSlXTUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2nihGnGj8fzImesesmLeHZoAcJKpuQC7+/ytcZs2Kfk=;
	b=1hcEMs8NXQL1VqbYvqbe70nX6gauV44H6OWi9MYyK8xX+ursWFsVA5HzD3Ui2pap3XRP
	 55O1Jo5vRekKleJcVNf2GAvO0184Wa1jn7JQb2mPBOK91vbYXxuZWSnJC/e0w5nhxoRFy
	 L82pvWsWBhxxV+zjGZeNW47y67SxfxaLpNDt2IWVmKsfrfoM2PzMAZNehFdCPX3K9ryBx
	 W0foYNGouqo0kb5KdzLLXvci+d/IFACGgcd0HcxC2FYUBTaDoL0teP1tuS/mx0MxsCUXS
	 QeBS99yKS8KkDyX7VhHzTD2WM18SGDPF745Zdu+vZncYYKVCzICP7ULk8ekylDsj82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgNEVKW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA75606A32F;
	Fri,  6 Nov 2026 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgNEVKW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33111F008A1;
	Fri,  6 Nov 2026 00:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926451;
	bh=2nihGnGj8fzImesesmLeHZoAcJKpuQC7+/ytcZs2Kfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgNEVKW9hc7jlAx09pl0+ANE3RGHrI7v9wPRrsIBz11WDei6wt+UKQk+vZnFZnSut
	 l1JQSw1UGu14Wr43AUOaIWYTLCo5JeoJui1IIuJ/CDieH2DH6UtbkjJW88CjbeuV4Q
	 galRm/4azY+haPJf2Qs79m6679/diux3gvssGQ8d77g3//qTKRfBAgLesk/cqlTINq
	 2bJl5clRJY1vzgs9ClxVagCHxNTGROq6WJOmsp/e4SLw+XO2n62rgqxG0hVwFuzMxh
	 8EFmdZcBjWA6+4vSLTxrY7xJDNReFIyrHvcvkVfPnFPGqO1TvH1J6A2Vvsni7w0X45
	 MswGBv0ppGOJQ==
Message-ID: <sashiko-outbox-200462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 07/11] KEYS: trusted: TEE: Synchronize session
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-8-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:10 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D7

