Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203169;
	b=w/6xkhR71geOOTO/D9N+c8rDbca510flwnEvZwsJeG+d68bj6yrq8FSOxPLdbbe0u1SG
	 GMPePafqMRbSRyvoW9ij4Kf6JEGScFXdIa/BZZz+dmNn3X/JB9+gfUpaD6kTeG4LM//pm
	 f7Ok6DIIxTYpbLqhX9zXbevDbtROsLcZJOpFIcy7zzqa/txWoYkZGYh3ilGqnxbLQsBX1
	 Kyso/qszK4Aq3Cb6AszgXP/G04G+iCrdIc2yhrJ2z6wGOC2v+PTdFddObV1r1EsNfDYiR
	 t4jOPCXtYfBawg7FLFrysVHUfauNxVHN1G623jXPNi20QeBytnh5YE9I4QlmOVxbjbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NcF6oaa0suRxO9mGS3NqlA2Rv7/sCnwwmqT+zGHLmZM=;
	b=nldtPhLZHsp5dZKGEZJ9i+VO0xYv6rRoDpAF16eaNFnNG/Fp0MSAXTu/ln5SwHXoE/fd
	 kGMTI/rZwMvg8pxyl52gilRbQBW3KXlhe//bAS/wwDUmRORHVcP647K0hAOMDUDDxa1ew
	 C2EX7cuHIRuYhogeHbJfiwrgmWXvYY5JykfkqYa1kxN8tRDhlZxfgA5fcKH18I/augJ16
	 5SjkwO1raePUW1K8q2JqFUQPrO6AJUdQpbhDDUdnQz69+HpqMWNkALpmLZzFwka6+moea
	 1qpE4641jF5T/CLwr41euUfaJVHnhLNVSqiZgFFMtcxALHBGX7pcSNb9lcX/oTf+ldw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idyM7EC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0D606A31E
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idyM7EC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00661F01828;
	Wed, 28 Oct 2026 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203169;
	bh=NcF6oaa0suRxO9mGS3NqlA2Rv7/sCnwwmqT+zGHLmZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idyM7EC9xVKBKaPqPKwou+CJM3wKh/N6TvL5Z7QV6Vp10RHu9jlymCwKnfswDnfRC
	 MOoXwvig0atLs6nN+73c8j5xKIkMvpIHJeGEzf99or1IHxPw0WvhHmutBsHhQUNA6k
	 VcG0ZpZSEPburoQl8iKoJJwtIt9nw8K+/6w6oXRmHk0ds1/FS0lqBPWzqGOz/vAzIt
	 IwX47A0mbEhE211nWP1nzcMc0X959aPs0gbYzVW5at0rpQvJt7mX395SvZeCvktccK
	 6jZH8I4Z6BtRWy0tAZ5SLGZkvNhL/2qVztDbGbwa8K3zkOV1FseCqPhdukp10XmTMz
	 0DtAv1NkEtjwA==
Message-ID: <sashiko-outbox-188111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/5] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028154352.15108-6-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-6-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:59:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce new VFIO features for zPCI devices to provide FMB passthrough to
> userspace.
>=20
> Allow the user to enable or disable the FMB using the SET-only feature
> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
> in the case when the FMB is enabled.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028154352.1510=
8-1-oelghoul@linux.ibm.com?part=3D5

