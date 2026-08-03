Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4B417BC3;
	Mon,  3 Aug 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773859; cv=none; b=TvdiMvffTe4YOi4LX/txmPvXlFE9dhN2arsAhStHA0F1VcCLOHGadBdd3zc51NJNMgn3aWuNyEeXh2VVuGNtr5Yz4mDa4U5PuIO11w97C/gCnQL/ubjMKv+/uFZu/GW5Bki0/S+EDefPh3WDzz4Vsf3vKzaJbB+r3vy7Kw8ei8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773859; c=relaxed/simple;
	bh=jfvel/UBA3KmF10d6IeFwvdHI/sWv1/jo3pHXLTGG9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EzPA0/LwThhAAJodx1R6/74TmiJMPUV2cWwxjDz9vNuHDNUYJTQJdF4x18MU+EI2JZ4NMx9Ywd0SIiQ5QEwqCA0VxrKuHkxTYpCoEQrEU44K79ZVLLnHKka0FXdMudGSFW1n8a7sOj8CoH47xb0Ar5z6H3vMGekh85t47AZxn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd05mG9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd05mG9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAA71F000E9;
	Mon,  3 Aug 2026 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773851;
	bh=jfvel/UBA3KmF10d6IeFwvdHI/sWv1/jo3pHXLTGG9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kd05mG9PK4o8X0rLo/4Xk2I/vWrlIxdYveXWzFG8xMF0cSm4PVt/UEW5MvEeGARwp
	 6J5EhEAgfrQ7p34znSq4gmxAihjM7gRYeD3oc4S7UMsSKREyYtZTcK+BbOfhhknPC1
	 wL8bzp+yofD6GjPKTaq+SdUdlQt4xRb1shjG0rzwlC5+OSXG0jOiWj2yj14IdyRSgW
	 gHWDnJ2Ndk21GFv2j51Jb8PuylimqFwY7huiUX0JRPyM92O9mwa03IcptmtG5QHwZF
	 vpPo7bECUGVfQfgav1Z34W+2rCm809egaVgAPceDiLhOkFWVq03wkXBryt6uDbSsJy
	 vUVx1j8Q/styw==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 03/23] s390/vfio_ccw: Fix out of bounds check on
 CCW array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803160924.236807-4-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:17:30 +0000
Message-Id: <20260803161730.EEAA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Eric Farman <farman@linux.ibm.com>
>=20
> The routine ccwchain_calc_length() counts the number of channel
> command words (CCWs) that are chained together in a single channel
> program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.
>=20
> The loop itself is "do..while (count < 257)", and while the logic in
> is_cpa_within_range() correctly adjusts between the 0-index array of
> CCWs and the count of CCWs starting at 1, this means it would look
> at a possible 257th CCW before ending the loop and (correctly)
> returning an error.
>=20
> Fix this by restructuring the loop to break as soon as 256 CCWs
> (thus indexes 0-255) are examined, without looking at memory
> outside the range.
>=20
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D3

