Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6254781
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976553; cv=none; b=FTI/e3riMVUgKCw1a86fIDTkwBxD4OSqIWr90kTIOCQDDzInSOjI+bVBqNjDI0OWCHQAZra5a0spiebFsWnHQzE0yzmWmtno1Xwvv2ZZnq0sxxatnPny6dOAWu5y59aeRbi6FAor5u1llbRDk6/haopajTL64ewwMBSD77qQz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976553; c=relaxed/simple;
	bh=S5J4fRsKwHwv6tkH0pwSj6zLqpLJLCmtpKhsTEAlo0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gUemDdAY/cuktrZ1mTtcfOMXghFT4DYQhpGpMJK7FEMeeSN7d3O1UzmrNp8geegYF70nWmcM2RuwcoOn2/Cr4NTscNrDDvnCbmWuwGRZRqrP0kp2jvyszMwvsZkHofQHn8V7jlMe2NTpDTkhgHLJjThtE/eLB4LgehHmT1FfSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA4Mpw1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA4Mpw1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0051F000E9;
	Mon, 17 Aug 2026 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976551;
	bh=S5J4fRsKwHwv6tkH0pwSj6zLqpLJLCmtpKhsTEAlo0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FA4Mpw1nGfgeBXxCmZ3ryjvLORIco9qWRVEyj/jfzhMEKtwAFXHpmWs4dp0uD/cQ0
	 1/cgJVlEokaLILo5Y3p0CAbIZ0o7UNHF6NNzOTzuDIVprLPBL6DTVGekcxx6400REs
	 29Do11t/i0C4OjFv88eTmMUH0M3yI4a8TNqpqq6I4f0pOUXYKuw9TKqOA8sTOWJQ99
	 DdbWFKvPIcm394FQHX0sxLctyLL8at0dftj+A3qzs3kjoztlmpLAaxNT40YgdBKKfd
	 aPRgpwBG2qqlqlcMCuUP4byXV8eNvpwwwxpdxKCHTLXBXrGlM/TyvtEgVSerQy+5g0
	 xgGZMhCb782tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] s390/crypto: Fix missing cra_flags in paes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260817141654.77940-5-freude@linux.ibm.com>
References: <20260817141654.77940-1-freude@linux.ibm.com>
 <20260817141654.77940-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:22:30 +0000
Message-Id: <20260817142230.CA0051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The 4 algorithms implemented in paes_s390 never had any cra_flags
> set. So add code which sets the cra_flag to CRYPTO_ALG_ASYNC and
> CRYPTO_ALG_NO_FALLBACK.
>=20
> Fixes: 4ccd065a69df ("crypto: ahash - Add support for drivers with no fal=
lback")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817141654.7794=
0-1-freude@linux.ibm.com?part=3D4

