Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957F3F482E
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006976; cv=none; b=FIvWpCL0ZyRYek970uzvXv188DQ/szo5r+IIzXM6gO/OS3ROAoiTSd8ow32dFasgAipzpGBwWWNaG6h7r2Itx4/uvqkteDLGCPb95uz7AHUs5JDX0sdGeLzABKVQKkKa+I6ijhWeaetLed2DJKeDSLfW/bgIzIni74UNlNVGgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006976; c=relaxed/simple;
	bh=OBDKREuG3lqG9SiHdBpG9VXt57KpfYzxz80cZzVFKkE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZKXOredh3d3CF8U/sCByvJqd5k7c2LV9s3a4u9ZQ7gw/IP9t955BzpKq1Sh/AvnyAYkm6jvCxStS7YluqYpk5QzpyNeM+wq4bnKADrqRDx8z3m4b1uuSC2Phvg6tH9+KRStYXIdTxfIYytMJQe24K1NpGDd8LVGwUo7Hy7e2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJNjBjFe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJNjBjFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8E11F000E9;
	Thu,  6 Aug 2026 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786006974;
	bh=OBDKREuG3lqG9SiHdBpG9VXt57KpfYzxz80cZzVFKkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fJNjBjFe8SR8+VagMsDe6knc9Wza+GI2zwRT1b5Q7y4MdjAj/aDgDnwktWkNEMYz3
	 hapatxfY0iYDC196KW7eIBQ5xG/rlMR2DgPxEe9K3ZrYdXNESV9BP9MUkDxeRO76kx
	 4EgXICN+g3zbbqa2xyye7gXUKyzJtHClB0HgJLY02gRMj7C9+0YI2p9BlWQBBq6+9V
	 suoMRgRKjjoMFVCFNCHH4uEPr+E5CAWSKZIm5bsODU43XTTVmN7XnPIrNb4lRjFWIL
	 AXzQugy/6aC1xGkTYeowK6ov0ZWhPEKJ3lFKCjRvm5LDBOG8G/DQSdGgGbY1hY4HYs
	 k23LL+JOqGHuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] s390/crypto: Fix skcipher_walk return code
 handling in aes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260806084950.17679-2-freude@linux.ibm.com>
References: <20260806084950.17679-1-freude@linux.ibm.com>
 <20260806084950.17679-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:02:53 +0000
Message-Id: <20260806090254.6F8E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The return codes from skcipher_walk_virt() were not properly checked
> before entering the processing loops in ecb_aes_crypt() and ctr_aes_crypt=
().
> If skcipher_walk_virt() fails, the walk structure may be in an undefined
> state, and attempting to process data could lead to incorrect behavior
> or accessing uninitialized memory.
>=20
> Add proper return code checking to ensure correct handling of the walk
> initialization and walk advance and eventually return to the caller
> with that return code.
>=20
> Fixes: 7988fb2c03c8 ("crypto: s390/aes - convert to skcipher API")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806084950.1767=
9-1-freude@linux.ibm.com?part=3D1

