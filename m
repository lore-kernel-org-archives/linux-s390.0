Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984166;
	b=QpeQ0RF9YxU6lZy+xYmZnVfYi30/UW2PtWwLcdLBEXygKsbz1hkfMWR8NkLyTm+9ZZqo
	 S8H+71taLPRIvM7beNeRhLYL6X6zyWi4nFOpWu1MG6DI8l/DZS6E+6obH6Crw03WwDeAa
	 Fypev4e3w9Yic3BaHk8kWD4z2lYjWpQK4SD/1bMRyNfkSyIcwjWgRp5XKizOLtOG17qFy
	 9jdp2L/8M3Qkw23z2NtRoroTcTbh35BLUPL8IYzcQOlkkQocx4duLRT11T/G9YEaXq4Jj
	 yIlfId5hPO9LLLpU7CpkgVn5halS1JduQ/XmqP35aDutgQ0LhVZGldeng/w0FgtUwBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984166;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ch/H+FsRy/4q1oFR8DiaFVzrv/sZFRB6G32Ee2X6h4w=;
	b=KznKbGehJeHgG6g1/+vMCU80ac3gmlwKzVef0iY9RAXnDX0mDAETptH9YaIztqSEPPfI
	 EpBw64g8ppbsfdN/mXgLyqVWGgRKfhvbmAjX1LsFcBtshKLmVSVtFUCS5YW7eh9tFj5UT
	 Fv0IFzmzUqFxlcxEso8HUB3P75tpBTnOX/E9az0tzgIdtP9ybasQcti/6aqhDuLDyVSZS
	 zTtFvJbLlY2StPZPz2j3u3xmYSiN/Af1Kf1leEYA41ZpR2Ls1yAI/b73agF9nVTyuv1ln
	 7Doj6TVj3H6Ha7sg1BI0TritSI8AGvK6YpAIvzS32pDQjqsB5xhAPvQKjcuUYIInfZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9m7od3c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5F606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9m7od3c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737231F0089F;
	Fri,  6 Nov 2026 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984165;
	bh=Ch/H+FsRy/4q1oFR8DiaFVzrv/sZFRB6G32Ee2X6h4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9m7od3cDcmOlsfoTqzg7nSdBt7EpgSY8JO6t7NWuQeYlwzkUqywWeXSWW2iBvN67
	 hRhjltrwMAFsaBhTGKk53KwZYoSvGaUvnv8rka9SXui7deFSrhXrFcyUvWJmNbO68Y
	 S0RWlA0VB6GMiXoofgs66MWO4PFoH/XPSdhtE+ph74jVPwHXryokCoyAfffsap9awl
	 FkKwulzaopMmsq30BoPOJJjC/MBASLJ2guDd9Ozwa12Ab8bZyVMNizVGBisenCJ8mO
	 5PJWNl3SkrgZkb5x9wJA1lqqkQrR5YLztE95jyCfeWDVZnLnFWahLCqifl6w4FQR24
	 6NiGQ5iZtA23A==
Message-ID: <sashiko-outbox-201874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 6/6] selftests: drivers/s390x: Select uvdevice tests
 using the target architecture
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261106164958.431978-7-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
 <20261106164958.431978-7-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:56:05 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Sasha Levin <sashal@kernel.org>
>=20
> The uvdevice Makefile decides whether to build its test from uname -m,
> which describes the build host. A cross build for s390 on another host
> therefore silently omits the test, while the non-s390 branch provides
> no-op build and installation targets but no emit_tests target.
>=20
> Select the test from the target ARCH when it is given and from the
> host's SUBARCH otherwise, accepting both the s390 and s390x spellings,
> and include lib.mk unconditionally so that other architectures build,
> install and emit an empty runlist. ARCH itself is left unset so that a
> native LLVM=3D1 build keeps using the compiler's native target.
>=20
> Drop the include path derived from tools/arch/$(ARCH): the test only
> needs asm/uvdevice.h from the installed kernel headers, and the path
> does not exist for the s390x spelling.
>=20
> Fixes: cbac924200b8 ("selftests: drivers/s390x: Add uvdevice tests")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106164958.4319=
78-7-borntraeger@linux.ibm.com?part=3D1

