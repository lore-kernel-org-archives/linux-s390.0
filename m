Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101A3859DA
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850138; cv=none; b=DXQRVkgl20ouugkC28ciNzYICAVo2L3zxQmCK7V2X34c0myW7AThFOcMop36V8H/HuMZA1eI50BOtXWR1a+xKjUBw1UKD9Sq/Q9etKhLIihdKssCprbYkz5fwFzpIZTn2gLkIfLLnHCuqwZ8PLPt3rlUtIndPwZg6pxL5WZMnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850138; c=relaxed/simple;
	bh=S07tCwcJgpTzHeoWYpajlAr1H9/krM2tibvtenklvlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TF5WefrLRs162phzsDnhkue6kJFqf7WxU1Bb/e3xMZOiu2l+//cYRxBJeqfclF1PtEZji8FPGzQh2t9IVXs1cKSG9dK8VH80k6+WVyQHyrHgauTIQ2D3yAJ7CPu3iZKLbTxF66kHE5mPq7DOV9ov710cRQMw0MfBdRAM5HwX1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHGQYFU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHGQYFU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F1C1F00A3A;
	Tue,  8 Sep 2026 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850136;
	bh=S07tCwcJgpTzHeoWYpajlAr1H9/krM2tibvtenklvlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DHGQYFU5d5McXUnc0wdkIofJ7bv5hWr2qR6WUo6+CiLukcS6gyYAjOu3yVyPJ8VFK
	 9FAb8ca4K74m4Xh1W7kOIJ9vWHr9iUTSAPqlX4b0l8Wzd5ztb9etmnTkX/DvyWMReT
	 Ya3YM5Un7Dzc2/WId4sd1iFisgewijAZ6RQD//k4AvDEara61qkVtWHHQCszXyVXMI
	 XcayVkF4jmvrIAEkzt3jhPKKn02VPdRb4YQONR2vdheRdwGjS9TrbQIhRbQU9mGRgF
	 dPzGp03Zr2Ab6UTD99x1gvfCtjIZkOlntQu8u7puk1w6F8uFPxwwcE5sLmZ+88bBwB
	 0kvncowRddiYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/24] MIPS: ELF: Move relocation constants to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, ojeda@kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-9-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-9-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:48:55 +0000
Message-Id: <20260908064856.21F1C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>=20
> Move them from the kernel-private architecture-specific header to the UAP=
I.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D9

