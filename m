Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457890;
	b=U9MT2VL1npcqaPt2qY376df3ITuZc14ayP346F/P19mOPZbBz0sfFivo3gu5LTwDjus4
	 dgIvmPyrt1WAywVpTi0cKVzPxPolapSSp4rh7am9CeJpgUX5j25XeLoS+F0N1tTSCw+PO
	 NHCd7R6luiX3RaMQODeHpYeYGf+Q4xqvjWFDWFuDIRMO/icUBcX5KamTID//+MK11cJY6
	 BeAdrSXiUWUMnBZ590+mieXYR0TCtwIpafhA8RVVear1M7aVfP9jfRS/GX8Dgczsn2rKF
	 L++/f0TmkHBfYwyQs90munWYj5rIqp5bsh4i1RbIEQvdp5PRyfYG66qiU5b82xBUZow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457890;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aT0x8tE8nw/GuVHuMM9szgmiwnm8pMFKUZW7fxVAlsw=;
	b=VSGeRFAnVQxPLIgkGHBmICGRY2kA3ogp0nX/6RdUNdQXLEaRuvZd/25fcgpqJK+JYSDD
	 FcwCZHaHut93hVs9ZU5d8Rk36FHNbQ73fWGfKn4hFin3ZPn0zj0jehcGHkfq+d6W82cxr
	 4avSkbnDUbvUXWupvActbzZRWllRo4AfLg+NMwN9k80sEX8ldDQG/vKZB5S39agWCE2zO
	 NRS8mhUW8zzzpCvqn+DiAvKd3PRLQGIGiNE8RBep/EDLiloNCAGH/hfBU2gbaXxqq9O51
	 cB+g0Fij1WBg9a8oS2chfmhq7ezpSzZjehqp0atp9kPY1MyoerPHGL48Vd7cUdDyqgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SspInJfd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B90606A31C;
	Thu, 12 Nov 2026 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SspInJfd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE321F00A05;
	Thu, 12 Nov 2026 04:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457890;
	bh=aT0x8tE8nw/GuVHuMM9szgmiwnm8pMFKUZW7fxVAlsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SspInJfd9IUmApWUOQz93khFkLP7WZXBKx06Nw7j52DlbTcrG3hrL+SKDlk9H+XPU
	 8na+rvu8A02AnbhM6ez/Vy+tXADkUHjOGjxaXFTeC9hFAtvhcNfUi8gWASMRAotTYg
	 JA1iF8vVTwZ9yhT32TR+5UNbJYrID+aSt2cZ0gqX6d2ONk8vkhTiuO3TpNgnOWhCPt
	 rkMqyopnjFc7JmWXco3YIIHealtsSbdxoJo0oxIQRS35qCwwqzs+IyPPUVR4DauBhY
	 ubu6Tm3uwD6KSY6txpQCj9hjlKnlt3L6I1x36UhYHea0Z7ZaGY7xvAuoAg+KaxmGjb
	 mvl/cNRV8lBfQ==
Message-ID: <sashiko-outbox-210350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/13] smb: client: Clear idmap/SPNEGO caches when
 the last session is unloaded
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-5-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> CIFS caches cifs.idmap and cifs.spnego keys in the module-owned keyrings
> that are only destroyed in module_exit().
>=20
> Once keys pin the kernel module of the key type, the cached entries will
> retain CIFS pinned after the last SMB session has been torned down.
>=20
> Serialize the session count transitions with a mutex and clear the idmap
> and SPNEGO cache keyrings when the last session is freed.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D4

