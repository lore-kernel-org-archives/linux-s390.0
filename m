Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5613790B
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777022; cv=none; b=rSctuIfsgeBaDEGtsqgV4bNYwQpM9bxcHRWGv8c5fTngLxwNDwCCerRwuyDunkfQL1nt6fTk+evuTOwesyEEyUtymLlkQuar5C8LmJzi5fI0i9jcuy7F6Mx68rW+Bitx/pPwsN8mMllQzmrRJF1JD/me3OjT8ypx158o57TcYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777022; c=relaxed/simple;
	bh=3vXcn7KbgELXQXxFYT6rKVpR6d1E2Y9qfzDfw2GMymY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qcfDFC88Imea9Kl7XNUSDijdRM/UbL8PbUWTZqem3ooT1AIf6yhcZDRhW7a6sK/DVX8Oco0hqYPd0Bm+c0t0PXRPhM/fwUmrt9llSaq8szQn+hLYmtc/4eeZuyP+D2XXqJ+0ssHcMbH/7GtwupT1FfTL3Cdrwk/g+u0/+k5Tu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH4CQsYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH4CQsYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D321F00A3A;
	Mon,  7 Sep 2026 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777021;
	bh=3vXcn7KbgELXQXxFYT6rKVpR6d1E2Y9qfzDfw2GMymY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CH4CQsYa22BDTTbdXwOkaoH5KIpkv/6kFx+0v20ZrW/aS/+nK1bN7/ekoJMFAGLxl
	 726hSmaf31rfyijwrBGjj3guKgLBAop0O2CU767MqVWBRXNtEfUtHiNIF6Ek843aF7
	 zl0Cj1KgIymXFN99Zl3D3snfX083ID4i7lzxNu9wNjitFqR+WUfjyx2SfqBSrdiAMm
	 LFclMna4EJKAhI4rXs8adXoeDX7NyMnycaLg0bF3Ml9wS/WILoKppq7mDqtJ+tLk05
	 5kT3PwI79Ut3bXyHg4Y4mZBlkplbRVNDtQM4wEFDIGQgvsvCWdL8JGS3vQMeKHM82f
	 Xa+DvTntwvy5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] s390/chsc_sch: Use __free(kfree) for synchronous
 CHSC requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-4-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-4-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:30:20 +0000
Message-Id: <20260907103020.E9D321F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use __free(kfree) for local buffers in the synchronous CHSC ioctl
> handlers and replace their cleanup labels with early returns.
>=20
> Keep the asynchronous and on-close handlers unchanged.
>=20
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D4

