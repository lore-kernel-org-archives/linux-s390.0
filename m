Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB6390224
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850524; cv=none; b=iOwcYn+4SKEhxhDr6zeaLuxyYUInB0jYBoDrFXr1I3gxxpe5LyT/l3haSWvpx+3b5E/pGiEZMjOBQXaUGhVsK6T+lUMWKcaQqzUsJX4FfQ5Gdb1AG2/Y7k+ilm3EyyZFVVgbVRB5nR+BMV09xt+29N7fCVao5bJ6zXjMkr6K6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850524; c=relaxed/simple;
	bh=3urJXwvVVqG3ygcexWHxXLvUoQnT3FEOpClhvB/cEsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oMIknGfXcOBu8OdAkzWxzDoF/HaeJlBBsW4zTNdyPnPDwGH6eR003ZzVHcUtIZCDTDVfT8gOzEda1Z2UGb/LtEWBmF1S2QWm2qLcdqsnObzpeNiHV+E/Blvr4F8ohYoz8wG0AF/jVLYUv+YaPKMYoudA5d8jnehuTztQV8qGL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRTMeTW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRTMeTW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380371F00A3A;
	Tue,  8 Sep 2026 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850522;
	bh=3urJXwvVVqG3ygcexWHxXLvUoQnT3FEOpClhvB/cEsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRTMeTW2k2LNrbiQMltU2yZXwYWa+htTsT5V1XhTV9s+Py07PO04m/cp2deBCWbrp
	 TdQqUYxv7KxulfK+9L9YGPxZCf3XIWuET2/YfrBnvnTct3+9oy2aXafGvj3rxnFWWr
	 lsinsXJkP5hmhFwtjgDtXRGStsbQ9PD7wny92rGpeykADCbpOWYTO/LK9VApCeWT0i
	 mmmGstCLXstVbVWvhulSurKfVUzo2oqN5CzNrna3nJvaXSesoS4uumidPVPnxB2Lfo
	 Wo4zxOln7iCtNdXaFfrnIIUg2DX6pcojA4UwmxfrE/NnJJH70B34aq/yWPJ5XKdxbw
	 LZ1lzp4Ati98A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/24] powerpc/elf: Add 32-bit REL16 relocation
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, ojeda@kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-16-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-16-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:55:21 +0000
Message-Id: <20260908065522.380371F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> These are used by userspace and are necessary for the vdsocheck tool.
> They share the numbers with their 64-bit variants.
>=20
> Also update the copy in tools/ so they can be used by vdsocheck.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D16

