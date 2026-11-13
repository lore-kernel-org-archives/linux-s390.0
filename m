Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589449;
	b=iWWSjprxwXzRdkSb1Cg0iP0wQ5yGelKHs3dF75vBB334aoIsUm2vuc1saVra0iaCjLQU
	 b6+TyjVurryUbNPyBuKHrwdMz9vzWtjSNbiimrezJGRW9Mj7Qhf+BsDEbPBiB60/RxhWU
	 lBJQ+MVSPBwhrfD3UcOtUs9RH5T3Xunpg4sMTPeYEXrhqTb6OTd4qXYimWsVuWD5y67h2
	 RCne2eOgrxNsqD5VNPYuyWX9gvAKdlgOQsu7OeHnhMJacTAUV8YLWIsk1aC0cSFEzsZYg
	 yZqh5kmPOP5aHzs8FFAGejnG6nuEUJ/UjOv4P5UkWkuGT4napx9z8AKu6JNBxJ/dWLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ncOtebWeGP645eDi8YU6/RLsC7NJTi5S17Sf2m/WnNs=;
	b=3epkD0kaRW0v/qk4d/aKv/0KS4EYh0im1k3ZjHG3XdWVXYrJDkbA9Dd1HklvnLAPRCe3
	 Rb8p3lOPo2EgH8kZwJk3Dk+3Hb/lu+LkTpU2gWMsi2iJzXNtiFGWt/9hLBMuHbyAEbaA6
	 XpZvsmqSF5krdhCtEmG+jCnd1pgFX1nd9vLK9iCOKIem+YrliEbZmid6IUDh5N2RLcHHx
	 Ktp77jZBcf0y9RC34Gpkh/Gfw40TkATaeqQUXu9aokaraJsvCBQ8Id06DOing8LTWpeYb
	 YyBjAH1nSV8JJ/tYytf4DRwuFEpo+iVfZd6UhvB9tI87d8Osxs3sEEgNk+NIbdo7Hew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VS64eYex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B3606A8AE
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VS64eYex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C81F000C5;
	Fri, 13 Nov 2026 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589449;
	bh=ncOtebWeGP645eDi8YU6/RLsC7NJTi5S17Sf2m/WnNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VS64eYexp2MirJpIGOrbP9WwiVaNjeci+A4XyRurnmugM92ukx+IrUZ1QvohVxog+
	 KB65v8LNiod4+JeRK//26fBAbaObjO+NEbllMcsmTlRBqJHCSDu3Pb88khwCOI+b9O
	 ML+lGqcqkuLcLYIQg/QQ/BckkOeMbrsKStDO0bPSqBjQPWuzBXgRed7AWTbPO2fqpx
	 8GNgXT8TOYboyy4x4xUDvbeaaGXOBp9N0WiYMq9CKlN3RfAipeLQtg6rZ2WUF7B0xX
	 0WyWydhvGOeeUgOKc/Y9wbm27L5PB66x4k0WuPZa+7YsNU86BQtbBHjsnCdl0fvDd6
	 XwqSSnSBZCehw==
Message-ID: <sashiko-outbox-213266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/3] selftests/ptrace: add a test case for
 PTRACE_SET_SYSCALL_INFO syscall skipping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113165509.229869-4-renzo@cs.unibo.it>
References: <20261113165509.229869-1-renzo@cs.unibo.it>
 <20261113165509.229869-4-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:04:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Check whether PTRACE_SET_SYSCALL_INFO syscall skipping semantics
> implemented in the kernel matches userspace expectations.
>=20
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113165509.2298=
69-1-renzo@cs.unibo.it?part=3D3

