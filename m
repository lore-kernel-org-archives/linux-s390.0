Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52694A2A50
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210053; cv=none; b=G5dMRn3nPrHwzPAswcAUEScbw+S2t5IzOZCeBGbds9FPUbZHN3Mw4r1xi7CBeKZK3ttdQHxySdbQ7gQlXTmzLCTcWNbgIfa+G9L2pVmzocq0CZJO7mBBZVoqTOvZgRvD08W0QsF47xFR71TnOIwpoudSmny1rmbQVO88UMIyeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210053; c=relaxed/simple;
	bh=TxM13kWMnNawTyK2dh/lhhVGikCyjnpXX8cigauvLR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pfnfuYrqK8DttTc8NAiUor3UIq4xwlgr1qUxLgrrAQjwpIY2MuXSd/W4JOgxy3eNnqexR5tLfHCAf3+eEvkKYSiuIlxHoPKqFEZLFcq0o+tFfceS6Jv91X5m1gMfevLqcDXLPbcURgy0EPJVxMWrB9rgwumAb0ASyFODiT32TXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irSYCLDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irSYCLDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928671F00893;
	Mon,  5 Oct 2026 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210037;
	bh=TxM13kWMnNawTyK2dh/lhhVGikCyjnpXX8cigauvLR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=irSYCLDclwsItzvHqpvdZgn9v6qNABvT+5wy30emLlTQvyN1+2N+m/lfCs5s52kHC
	 jZfhxezI9VAIrPyDbG/4RMBgfM1YwxUqWkNLbfiN937z/FmZ8qO4hUBvvmjeiVH+nc
	 npCDagsY6ZBm/862vDOyYxFz3vC9gLGaztyL1b020sNyTO0N3uzdwVSuayowBNafVe
	 K5lqHudjvC8qvPcLKIiW7FU04pUkGIIpm4wtotEEj4It7POp8LK8eDitkbHZgY5E9B
	 +ifcqrDkkG390SNTqUBSZyPDgxlz7VpRf705mmmhIAEuSYMUyTModoJ3Cx3+ISgYqL
	 hOPFiLtBAPftg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] s390/crypto: Handle cpacf_kma() return code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261005141417.65822-3-freude@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 14:20:37 +0000
Message-Id: <20261005142037.928671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Now that cpacf_kma() returns the condition code, check it and bail out
> with -EIO on any non-zero result. In practice CC 1 and CC 2 cannot
> occur: the GCM function codes are clear-key only, and the scatterwalk
> loop ensures block-aligned chunks with LAAD/LPC set on the final call.
> However, it is a defensive improvement, not a bug fix.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005141417.6582=
2-1-freude@linux.ibm.com?part=3D2

