Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202469;
	b=y7SUhWqB3utmyGBy249mwPEQWbK9aVqUUJpgyvwUd2FIwj7F8zn59kruMi7KYjyD6M3X
	 Oa/TaQi+nWev3tfyTyBO5dFACg3Uc/sqct6SiRtuCdD4wDdO7/uXEk0ISScp9K5Te0+3R
	 Sxrk4pNXycA+w8PzkIu1QxE9bKQEk6mYMK9Tqkev8sjNsASsrEcjcg8F8x03lwxQlG64K
	 c8CoWbGxzO3D1707MeW3MTXCVeBT4+Cx4k9cN6+CBWgt26iV/MYuwSCcyNyu35xi2qu3S
	 H8IGbtE0CKTCgUeaB2G8YEZpQB+8c8tFGVzsAJS2wjsSdEApQGYNWYUwHIiA1FhoWPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202469;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3AlcEwv1MkJYtrslGFrM5QhqDxsnPHkMcLDIAlH9/0U=;
	b=WwCdG3lxCb7qsF7Kl2cz6Dh/HwmfuJFTuQ6q5XkAm5R2KvCHMdQ49hNme4f3X7h/8YI1
	 sDuBsjgKf1heXkTP3pR9sxaN2Q0y51m83HM7sWz3EGKe3tOwz2dTamO7h9Qd241vdnlgz
	 8pkM4RgQBnCiSh6QHuOqD/70KNy+Bz55pkJ0znwTRSK7VjRnyV4ObP0otEUCImpEwNz7i
	 RnUli/2jQGf5A/1dh/SpmbDJ89QCrqXaPP/KHzMIULFODC6bcsN2MwbDM4R+n9pj/nvBf
	 5Y1YGo3qKgAGIhcYVUlzzDW7xooeojrWoFKDgd6/aGi4oBCU0JruPLHDRqnjEZeiVeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgAmpuOf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58287606A31C
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgAmpuOf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BE21F01825;
	Wed, 28 Oct 2026 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202469;
	bh=3AlcEwv1MkJYtrslGFrM5QhqDxsnPHkMcLDIAlH9/0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LgAmpuOfr3b5+txNJJyMnZCgzPC4suDLfByLcmZhG4feW0OzdbkhS13Vfd1XJBYYU
	 cYbpj/x8kEQ0wyNu6d9Q1+BntqX8u+ntKLI19by6oOdFepLM3zlcTgqKg7jCRHNhVn
	 O3xDHx4P0n1cJWms+kA1Al2GvRGZ6pgQ7+Bj+UzZK6PoXUsGafJNDTENU1KdUSasbl
	 h4T4G6n4ig4NSrv2zadWdYmh5tfZOtTW6cQbp/QXhk3DKWj6WszdWd9BUoXIBGKdk5
	 D7mcySr+DyRfFmYYmNHiiwUSdCrQ7DyqlzpblIQtwQoq8yTqLVPXtpCd2Ur1QxKxyX
	 PEpAuXvO/TJTA==
Message-ID: <sashiko-outbox-188082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/5] s390/pci: Fence FMB enable/disable via debugfs
 for passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028154352.15108-5-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:47:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028154352.1510=
8-1-oelghoul@linux.ibm.com?part=3D4

