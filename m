Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7A457E49
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200860; cv=none; b=HbCojUY+eHTY05IQzGgjA30wHX4134WT+l3bL2o0HRxn93ufTY5baiY5eB9uSiJDiFkr1Me9waHQCHFEuh5zBPQITOVy4vOFvT56+0SuRvf3UyS3BPAji5JOM003skwH640cQF16E5f6dDKhXqOQNXpfounx0L2ONF/yXlSfveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200860; c=relaxed/simple;
	bh=YVFq2orf6LmwgvIloSjfwbtGvBD6xhu4xwOwUicffM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S+safF66PPfI/I/rY9dRhCsjKD3yR9mfStng0+vespmZpNVlZOybgSrz3mUeVNc2oF/y5x3Ss6SBHFsj5SXWqI7ADTv5SRXzUpciZKeu+A7hT5hhCB1PprwYg4LuRj72NPZlERmIwKFYfhUV4jGG+uJ41CNJwRcRw1jf/XR90Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZErFGj9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZErFGj9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8F01F000FF;
	Mon,  5 Oct 2026 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791200859;
	bh=YVFq2orf6LmwgvIloSjfwbtGvBD6xhu4xwOwUicffM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZErFGj9V9WqSnG7WeFmIftL4pFsdxjV5Hm5aT9SMAQ4tANkULTWF01YXJQ3G1EbxO
	 wpK77ZA0mjxsjNrmLL0b0RXBjRtrG/XIipoBI+mGQ4N/EU5PzvJThxQjQ3XQXwq2a4
	 PtcbrPq7x1b/fVGSm/fhE0zBYIgR/uhON+8AmyPSgz7+rd1BrbxHYEYyERqKPtJhNw
	 Zr6RVtVUixZXn0QIoqrJECiTrKKC5sSIWkQTnjmKivIInWo2CrP0kPbu+WXQq3Oh2b
	 30dFH6wTin+USAWJlEbn/sNoPatM4TgUbr5gofq1taSD5gFYUCwlSsCO1YfXdYzb1S
	 kgMA0D0vcrk5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] s390/zcrypt: Fix out-of-bounds ptr advance in
 cca_query_crypto_facility()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261005114018.62489-3-freude@linux.ibm.com>
References: <20261005114018.62489-1-freude@linux.ibm.com>
 <20261005114018.62489-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 11:47:38 +0000
Message-Id: <20261005114739.2D8F01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The FQ reply parser code blindly advanced the walk pointer by a length
> value read directly from the hardware reply payload without checking
> that the advance stayed within the allocated reply buffer. A corrupt
> or malicious device response could push ptr beyond the cprbmem region,
> causing an out-of-bounds dereference or kernel memory exposure via the
> subsequent memcpy().
>=20
> Fix this by tracking the remaining reply buffer space in a variable
> and validating each device-supplied length field against it before
> advancing or dereferencing the pointer.
>=20
> Fixes: 2004b57cde6b ("s390/zcrypt: code cleanup")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005114018.6248=
9-1-freude@linux.ibm.com?part=3D2

