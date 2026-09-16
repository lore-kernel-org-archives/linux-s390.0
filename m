Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE4514779
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572351; cv=none; b=WvTrnBV0xyQ0x0Ao1ApipBygzlTcNCTtMRHyaNQ19H5Rf5WdhNbkfih9zMrrCuuYOQdJ2faTnUxXwsPlsKfpw+bh40UEqzIk6jJjH5YV91R7LLgVEyp5GdMTZVDSXpCSzLt6R3Yomh5Ic47GSLWHey+Re1hftVkgwsQTL0zPakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572351; c=relaxed/simple;
	bh=ZSaKE9P0Jfiew1Ptws2tGscz/3YvO908rZyDvToHZTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u5q6mghhqpBTKebpxHuttH6JNPiHz425MKzbafd9leEp4WrVrVoM5uZB/pZYrPwn4idyvMaD1miVwJYA1D3tlukTVjuDWnwo8oj4rU8/I6JghRTvkYd0LK9zktch5PWZcXbdJve6SuQhxKHyogCnwg5EKmbId6bbgY9mPO88+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bltGgq6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bltGgq6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7691F00898;
	Wed, 16 Sep 2026 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572347;
	bh=ZSaKE9P0Jfiew1Ptws2tGscz/3YvO908rZyDvToHZTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bltGgq6b2Mx4+aOG4pQgkTN+hl69JAVWiyn1cT+v1n/iWKsjvflwkRMqVH+81VEC5
	 gCZqjKg2xU1hJ88UStLas4Hze1se6uxgfD3Rk+L+J7G8gsqw1s6PSzJBU9Z0kC29yK
	 l/2Pt+T6qhqUUzQmgnGsb3/jAs7cUhJt2KAIdelkOu3N56gd+ZHiLnWYz6sJzADeuN
	 k84xJIUsryDBq4BvhYEMRNnh9u08M1A4Stbiijqw6AUTl/OVWNoFmIHm31kmzDPKz1
	 dWnGQR3S3iSe3HLQr7bL1cXRgh4ysrrdlRgAHEwXzKI0phsR8t64DbgQl5HmFfED0Z
	 0qCzEMYQ17+dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] s390/pci: Fix missing device lock in
 zpci_report_status()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-2-61a2f980e71d@linux.ibm.com>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-2-61a2f980e71d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:25:46 +0000
Message-Id: <20260916152547.2B7691F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When pdev is non-NULL, zpci_report_status() accesses the device's driver.
> To get a consistent state matching the recovery, the device lock needs to
> be held. Do so by expanding the existing device lock critical section.
>=20
> The lock only needs to be held when the pdev is non-NULL, so extract
> the pdev-specific reporting into a helper function which also adds a
> lockdep assertion to detect calls without the device lock held.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCL=
P")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-fix_zpci_r=
eport_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com?part=3D2

