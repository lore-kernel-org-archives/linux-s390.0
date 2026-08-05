Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA675479867
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943195; cv=none; b=lBl5Ni/1mdmFmZN2ROxeWDlIrwiIx61Ho2Rr4mONY5XQnfQ9/A78/9nwJ2BVuDzcA9xm/GPcw3NqlXW60oQ68DVt3R7o6z904N8QA4Zpt2FLronqkf+AhDLu9CTrAyVWRcZsFSp9g8y9betErfzKfsb9sC9vExVXZ+08OIZOGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943195; c=relaxed/simple;
	bh=205Vyosvu3RpFkm0jOdZqFYaChv7qSA73HSmADl8x04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/H+juizUbGqseQaV7CdrLpqNrZhr8xd/7JDCnx598EdL4B9CeDasopnjbmGdHc7UwEZoYVLxPDjLpUI08gYzsAoarUIU01hlxruE9iGwB2vgthxZjhxEUNW7rtn9jE/n4HP7hrxqqkLLXHwE7bfMw630LVwdq/sHSEg6GCh7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdflNy23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdflNy23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D7B1F000E9;
	Wed,  5 Aug 2026 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785943177;
	bh=205Vyosvu3RpFkm0jOdZqFYaChv7qSA73HSmADl8x04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdflNy23uqEuXtRfFINkq4HKrQONG+MGS+YRD/PyuxeeFhxHdfXPwffHI6VgEnSES
	 vO9Uxtz/hSaYoMaA7JdBdEKrtkAEvqOge8Be/83NBdP8grfoq8I8vBWGIyxhk1qWmL
	 4Vlt3cORwG7cFxjxQc+Mlnwt11+C1YC8H75arbwJEhYOQFBKknMyuyd0Il+0Tg/qgu
	 SU10HBkzco/mQEpf7ELTAMrxQDLF0Hgb7DfkNtKOOmqZDfp2VudoCL5doLke/ha/3R
	 FnFWP1CTZc2EAWL5JGXomX9UHN2ey3n/JgpjPx8VDrkgU2cPednFqRAVVkMU+ssZs2
	 VolNrzNez00sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/crypto: Fix skcipher_walk return code
 handling in aes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805145310.13130-2-freude@linux.ibm.com>
References: <20260805145310.13130-1-freude@linux.ibm.com>
 <20260805145310.13130-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:19:36 +0000
Message-Id: <20260805151937.42D7B1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805145310.1313=
0-2-freude@linux.ibm.com?part=3D1

