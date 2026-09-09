Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237A43F4CF
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944187; cv=none; b=GWi4FP1FBptruSk4Qx1ibXKdvc+nzzwUQnS3g1y1S8Av1dBZS/SI1r10b8HmvErB9oJPLyLD9hNO2xh0BBjhlMuePrEA4zieKRk7r5sU+TKDiuBto7r9rRD11IATsW2Id9dLgAL5R0bVtfloZvzGvgdQPCtMeotxzzQ/H8QnypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944187; c=relaxed/simple;
	bh=q/VWjeibWmoU6J4+SGU1qX5ERlWZ9rINNnOalu8Hwmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=huxRKhsJOIxsrjfReYxRh/aPQaenvtvPyVmxAUvXwwCg0HdFXrWysYSbzBaXBXDa85tA30V62cQzWm/XS/pDQsNSy3IpuvYJ0hVWwQi1AANEQEJ7Uc2yLHTfAU/fdp52WJ5XwIwtKBnfZER2DK1ZWURkdbDToMBi+60tkSlf9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV6TsGhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV6TsGhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B961F00A3A;
	Wed,  9 Sep 2026 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944186;
	bh=q/VWjeibWmoU6J4+SGU1qX5ERlWZ9rINNnOalu8Hwmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eV6TsGheI7tfiIkc+Emyd2dFp+uwiaoaVlueyLhpON0/YBtkGeNxJRq8UjwV3q41p
	 9ZhXAtMON3iMDAtMGiFpe3D6Y9QMNAvOeA96qclgAwIwE83689DPWe/f6UuGa8qA4n
	 7kNZ10hv+j9KN8aoTw1FmHiB0JDilRDJhSx7vN7MILfVicbkDfosHSQ3Rh1xS6e22x
	 5ELrNvF9R3dihiLKH4YMRNmt5q0dCb82RRepR+GZTSeIlut1xaxKJ2kg+yST0IuFNT
	 QtNQVNLBSn6BVozLIjO3sITm7FrJDCmvagxyq5X2DsdcMYqAYDVSjgRiEuyJ1XB9Ms
	 Hjk0PxYreOZQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] arm64/vdso: Delete asm/vdso/vsyscall.h inclusions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-11-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-11-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:56:25 +0000
Message-Id: <20260909085625.E8B961F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The inclusions are unnecessary, remove them.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D11

