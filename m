Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3F49505C
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008790; cv=none; b=tSfLnLBaTZ8ILnLQdlxmFsR3nylcv+1t5m5qEQRkUswtbWz+W05BS7JjCQ5thfA8S75gEG84RMqtRdddPc6ostZ8+8cDuE9brWiHALJbKYvSwWYcYk3UzrmREwmvTOg81dmgXx7BH45qxjOI5w9BwtyRxUIIa0nMJkol/hzF8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008790; c=relaxed/simple;
	bh=UVSsx/uVXBSTxDl3KBBR/+V7dEsYGD8v0ZnhPbd03bo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ndqfIA/vv7lGiw5X/fjJ3DwO9oTweAx4phn/tkj3bGX5MFFV88Mmh26oYF0vfyaGcf5Vs6vX3W2Qt43s6xMbqLBVGA4JaXtf/N/cGknG60U30HTKZKKGzRwVoXRZDIfeOzvDTJGt6CHmMBLuoSNpb5OleHG0nOF8/RdzsoOUSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYHeW6Hx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYHeW6Hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5250F1F000C4;
	Wed, 14 Oct 2026 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008782;
	bh=UVSsx/uVXBSTxDl3KBBR/+V7dEsYGD8v0ZnhPbd03bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYHeW6Hx11zdKUK1Kb+lNi6mDaRD2oTja6qGSASXlUk211R/U9y4mNwmKK7DcR+qY
	 DVM4vP3bD0J0i3hXf9CpZCCLvEM+tPB4OrkfDfGe/fu0A1L2GyDA7XciR1jAeN9aFr
	 cvu1w6ubOUp4qmrKdlwXt8pDgt9S4aUcHK77qliTAXY0mUts7c5IjfHPXqDdcAa/FN
	 aWg49dqipmOObv1YwW6UdNJGOkG2bjM3VRS8Kva/d3xfndjj9z7st0ZIgEJr3xt7jk
	 QcdCCpx99SJBL6Q5yKg3NZ8+g5O8qEAVshD+2jAd8Ces2ySlBwRdBuPfcu9BO4bKfS
	 y/H3+LnftQ7Nw==
Message-ID: <sashiko-outbox-171849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: drivers/s390x: select uvdevice tests using
 the target architecture
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261014200149.1365017-1-sashal@kernel.org>
References: <20261014200149.1365017-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:13:01 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014200127.1363=
472-1-sashal@kernel.org?part=3D1

