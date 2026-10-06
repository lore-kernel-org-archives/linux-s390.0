Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CE46D2CF
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302059; cv=none; b=fpuSBnY2SCZ4XZebmWMnVv7ZEofJGp8UXy2O2r5cwc2MTxsyDW17I3UHFgMmIDelRapfOPwdK1XevAh5T/waol4dWnx5Cizd89FKnZApLfhzPK19ygH9GLSYMSAMJ2iHUXNLMFt5DC5XNS5uR+WxhESqrbUR6jnfoDxX83JmExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302059; c=relaxed/simple;
	bh=8GfPD/TMHjInFqHhlYH+qIQHoWZ4ROJeHR/X1PPqgNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ax+XcqJD0ItZO7GenJP4MxbU5hjEE5G8+dFG5uEfp3SzvQXRsQ3kfaYfPtXSHSQtCNbaLfvFV++ViWEmTG/yVJIB9amay/gDpskRzxQPEutGJmC/NrumlcddIgJi8OkAOP5sDIPZPzxbniLo5DAvsD77Q3ne+kY7eJo9Sn7LUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVdJyUbk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVdJyUbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21ABC1F0089C;
	Tue,  6 Oct 2026 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302058;
	bh=8GfPD/TMHjInFqHhlYH+qIQHoWZ4ROJeHR/X1PPqgNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVdJyUbkWM5xEQnPLLNcXyGLz9UV6HitFUS5GODR1xt6j8UUYddenG1FFldn0Ekpd
	 /WgBlw9MCRo6v4SFSHC3vQrOsSDLExP76I8FVAxCDBWe5/MsBxHMSkLqfbMneTIQja
	 DoHc1NraT/bUAP3Tz7p/6seTHPiIYmOpxPP4Vhl33eVzcnTb3Br5e4fOT+/FilxQYe
	 ou63AD2t1I+Z7+Vbnt1HFqbaO/l3CY3LGSQ4ZNYD8PEJZ9F8/PPL2FEAd5QJ1BBYyr
	 Ehbf3s2kCzZ1vRMYPFuLXVGLET7OMau0BZgf0WtwTkPdASJtZ5rVtYBovPsOdbuDlO
	 UzfmRmIJbWVfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] s390/zcrypt: Fix out-of-bounds ptr advance in
 cca_query_crypto_facility()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261006154603.9699-3-freude@linux.ibm.com>
References: <20261006154603.9699-1-freude@linux.ibm.com>
 <20261006154603.9699-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:54:17 +0000
Message-Id: <20261006155418.21ABC1F0089C@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006154603.9699=
-1-freude@linux.ibm.com?part=3D2

