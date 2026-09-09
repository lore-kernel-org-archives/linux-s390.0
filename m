Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9D3A48E4
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944092; cv=none; b=u4+XpClOhaIfxmaNp5e5qV/inwG00TId/OnQGCY42XweYDvgtlod0GEBUhH6vZFA88i/I4P4MBKHCpYeU76WdGH+XwqvkkiBM6+rCT5CtcO1WJ2Iuqa9SHezyY/CuATtezjkv7ReKQnowoGjpjFstaCJc9FhgQYt2zYZx+4hTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944092; c=relaxed/simple;
	bh=/DTFsxtHhAi0OrOum/jZzZ1Zlpliwx0F0edvTUxJdeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fU7T1xSwbF+mNpQcdePLNTNyyAJ2bHOgFms9WR5E5+it3Lawg7CD8hoJzFoMEqLcj1vibiTPQSE2es5QKXbRhWO7uc28wfnEpUEC5GrgKVVeZ6cJM8tHiXT1JZKaJiZGuNY60zr8sRFWivqdhD8RVRtdmo9O7Gn9biwVySs/RJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkX2r3qZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkX2r3qZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA97A1F00A3A;
	Wed,  9 Sep 2026 08:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944091;
	bh=/DTFsxtHhAi0OrOum/jZzZ1Zlpliwx0F0edvTUxJdeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OkX2r3qZBAzL86v5hrZVGpkGX2yq/mWgCJAEWg2w2OUOgD/FxfTPMlo/S3SIqjlS2
	 MLeNbJ1uTT+jwfwhfbIPsNjsvbsGiQGENnR3LqwHVzySrMZ63/Lz4C5VT2/JOK495l
	 Mrm2naSPybEaxDl2XH3muxnO+P7AZ1/rYm4lrgX2o3YpmLnhT/csTN6zlV+c1EQ0ta
	 pMgu4R7Le540I7wODBwF7uDeW4b1c5kF0RdJWHz1NfoueDJPsloppVne7w0OLB9qVM
	 32FtDz/4JL82/L4l6T5ovZ27/U+RpsE3/oZUI8fsugs/SEIRo73MteTUaoZaKAZ83k
	 GA0G4aAtazSkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] vdso/getrandom: Define fallback
 __arch_get_vdso_u_rng_data() in getrandom.c
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-3-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-3-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:54:50 +0000
Message-Id: <20260909085450.EA97A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __arch_get_vdso_u_rng_data() is only used in getrandom.c. vsyscall.h
> has become a dumping ground for different kinds of fallbacks.
>=20
> Move the fallback function definition into getrandom.c,
> similar to other fallbacks.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D3

