Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926444;
	b=ZEwD0AF9MAgs+K9o9Kd1C1aQww6LEFeFdiZaiJ9q75/dn7C4ucBpBGVC5yl9mhd6jKFv
	 IPH9GlnxUMLBrqZc8tLmsdPK62KFD/MoaE7wTpVdM3DKuUwgxHurVnVUhkeuXOkRh3TJ1
	 ibI8CvumgqitISZKTiQfaauDjZ432Woc67HV9fqjSYmPEMfP8HsRi0p7rqpQYON6tm+Z/
	 bHza4f/VJJSJgA2Yg4lldnUdu7XeuPSm3NgOwPOoBeqc47Ufyo8345pPd+JlcUx81B36V
	 7Q4a9h7EJ1QsNpDaIc/Ce6gWp5f5AZUKEHlANvomeg7v6dU/7C9pnx3IMRGWEm1MXpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926444;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eqRb1oVetEJSZmJtgKLFMW9aTkkTQpYCN76i9anT6DA=;
	b=3ITlzz+OfxVZRa48xGFn70fAVRDPmirV45lJkVNq5T6avXGZtAG9yYs/Dkv6ekmIKDx3
	 12350YGF+m8eCHNWq5CUjprtLwBIetnvnKOR2GJ9guaFU2EqGVd3zr4EaR8M2QIK9uKky
	 d85//k3CaIDrguWa6T/0RHbQKu3Nus/jQ6iCYM6MbQi5x8DtraDMdKd+nNiKwifKH5WQ8
	 mEZGN7c3h3q3fTOgFm7gcUKb9KylJ39kPqJAqNpTg5CdJlbglNqFzGhpGmkxTU4HP2IFP
	 6e/cgyQhQ5l6Ndsvv4fHzDDpHtsD0BEeXrA0wPIBvSTnpVi4hznKTbZkSasjGHsmdWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXV2jYrE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C18606A326;
	Fri,  6 Nov 2026 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXV2jYrE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE7D1F008A1;
	Fri,  6 Nov 2026 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926443;
	bh=eqRb1oVetEJSZmJtgKLFMW9aTkkTQpYCN76i9anT6DA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXV2jYrEcTtdBX4QaCVgZdlgH5fK0GWP+V8c6DDrMzletoM3gMkA6FmcCJH+VQoUm
	 9NLmLy1ny9IkiSlO0Vseg6J/3OHC6oosSIJNek4WEegIkOKVdbnc1OSZFsnn4FNR3O
	 WJN9xgGqCwVQPcbqi/wzXR8k88uVpv0nET6sZtBcgi8SbOweP7a5sH6mlcIKk4e2Tj
	 zoSiejR3UVmqr/pTLIGS9J2cByXUppSMJPtaY31xsoZ5RR573tZZ4/5dkhLsKSl6qu
	 PJyW7S88Vy0hSwx5OUTTGV4Zh4usJ/ML7iywXZpdzf/hWB2pON77Fx+Wq8sJa55FFR
	 df+VKZ5r9sDTQ==
Message-ID: <sashiko-outbox-200457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 02/11] dns_resolver: Move the key type into a
 separate module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-3-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:03 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D2

