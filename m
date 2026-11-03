Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718457;
	b=pJ5OfC2EvsMHAAOee5wEfaVKkDZaglzUpEjNKVyKLnnblZUux4Gar0WwJSq5S4xgFev6
	 ABttPNUAgRyV08q3QrJiSE8FNxoGFN2PBDdnRWCITzPIaSfn4UgNLAcjeQ1z97OijD4I/
	 Y1AN9LqI6w1VJW+Uscmw/EmZ7YWNToR4LbANbnVk3cHdSDBax4eFqC+vgOjfiejEDSNrj
	 3hl9rw2vudXxbxZkdg4aNzLuxpyCaiIu3pTgxoeHrstY3Ir3OTfZ/n8bBPt7J8gc4Gtlh
	 HC+El5gU76QxPaAdsPBiMyUlPETMJ420i2FsuFzJyOzRgwpx8XJG9IQ9UDHh4QKjT/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718457;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c1Q5G+RRZbIZMzLQSIVPxTB02ejNe9bYN9vIlWDysQY=;
	b=HNtiYpUYWudaxPSCNoz31vABfM6r4SYBzaT6zOn6kuXbQTtqUesLMdDR3+NU3b9VFQdK
	 lAaZ/DsPChf3V6KEvA/UZ3CqCZLFDsyDkAi8++y1KHBAb8zvCNT+XYomuso1szcJmtSEa
	 JaIadb82lynORa/jsITMDfSDpTQVgt3QQ9YTirR5Sfjpcxk9+2CmrhPKDW2STo/S4wN87
	 Vr2WRn87gcXteVnGcIwS2A3zQxyohI7PFbqGCWOAW2UhKIiZ70rvmssHF6H3uI+z3TY+f
	 2nxYofiYVSgGe89irCbwZ4SbYhzoXPROSwKHeHXz/x19bUyaN8BLaFbTA6yXMndzikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VExISkA2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04388606A78E
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VExISkA2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961561F000C1;
	Tue,  3 Nov 2026 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718456;
	bh=c1Q5G+RRZbIZMzLQSIVPxTB02ejNe9bYN9vIlWDysQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VExISkA2i4qiEMgvdQv/cVCo0ZXEcyDuTyvJ/kvBUc1lCSi9Zmkh/BgjiNDSTKKCZ
	 kW1lLi9nUoqqPRpZr8FxkTUJNa5eJhMN4/xgZyo639Kv6ORdzlSpyVD6wHTP7ZC+Zi
	 9aEI4+YUPFxf7t5XbmK3/S45+RvEGiW4ogfL+Yfp+67PqGeUsoDVhcUjCaSS/SzQHP
	 bEp0hf/edYs3d8zyQ5yCc8J7vFoZE97MDYKF0fk73jHHGxAt8OAD9nU2tV4r5vaJuy
	 DW60sZXDJpl86hbl5Rd9/9WIHmBYthrdE93FXTq4j9iFYtRy2luy0qF8bzR9HHHFdN
	 dC6L77g129mjQ==
Message-ID: <sashiko-outbox-195555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 4/5] s390/pci: Fence FMB enable/disable via debugfs
 for passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103150114.68873-5-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
 <20261103150114.68873-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:07:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
> device is associated with a KVM. This will prevent processes on the host
> from tampering with the FMB while the guest is still using it, which may
> cause partial counter resets and inconsistent reads which have no parallel
> in the architecture.
>=20
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103150114.6887=
3-1-oelghoul@linux.ibm.com?part=3D4

