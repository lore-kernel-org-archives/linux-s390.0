Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5033260B
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422257; cv=none; b=Ubm8415/NflToFiW20tF5u6yFT/6yMOlC3zbJgypAurOObuP18EQ0OE0O3G54UFP1jNT4nWtEoAoCZK8kO4pcdzdzLoUopN5mluBS1bD+s20fNXv+Jz/TaPh8VpkYJyMF4Kp3mQw9BuIZmh6BzdGbS8ot1RVolqLp83NY9wKgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422257; c=relaxed/simple;
	bh=3zSef2JpkT+2+Qe4+04YN7CKVBLWHquzinKrAeqBT/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QfEHQiWahhtdGvl9LnTKuS10SSbLtql8eAvgHRBiCUoDVV/4FIFEID3baZU++2YYdvLED2VjHBV8r98PupGQCcYot6fxDE7hbeI130ZVXjR3rBqXasQhtmXZo3mC/f4LAgVBRHZu7CDH+gUwAQ/bAuhVKlf/PFUpIa4DJloSyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBQpignI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBQpignI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CD11F000E9;
	Thu,  3 Sep 2026 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422256;
	bh=3zSef2JpkT+2+Qe4+04YN7CKVBLWHquzinKrAeqBT/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBQpignIOmw5JWPATkMF+KlEPuku4z7df+uesKPHDTTg52IJxOcvJlORONFNTje3b
	 tT2yrl9ySdL19brEmEGwBxnfzN2D6O/RgTt1NFNYIcGTsqbzzPgOsEez+G3ADpcMfr
	 0EN+rqfNqK38YF3v4V0FSBTmtuUxNanTYlmPTkddc4SfDdf2+TEzhPb1MScwGBu7pk
	 0N4iR8Q173ry8F3P94pFYYAo5BABGYlKZdRkOMyFbrjei32zR0BCi7iSRuvFrsEfoV
	 nAG7MA7+U/cJOQDpsJOFDny+VXGFei9umaG0ZU+eknlEEGF+ugHnDRkUqwbowIHO/1
	 EGSPVh3nU2ZVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/15] x86: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-5-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-5-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:57:35 +0000
Message-Id: <20260903075735.B3CD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>=20
> Move the symbol to a kernel-internal header.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D5

