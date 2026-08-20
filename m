Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFAF476056
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235994; cv=none; b=WJJqZkxtQfXcF3GPetcEzeqpFnu/eLA0AzEkUqwEHJ1oYXe+lDRva5byTsvk6szbVLzktK8Txd0lImBP1SZWlXCSU99Uin/tEG9PvvY/NjyXIHXaSG5dJMom8eobghj+I610wVqs3k/Qtz5ALMysaF2vTodR+qfKBE/l0KcbkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235994; c=relaxed/simple;
	bh=MmIcykLc8RZnWhJVzUhOCLGPNKjHZx+oLvob503O+dY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SKCt62qCbCitjvNRZByWcxzqJkKuo3xLkeneveHjmfOBGn/W9Fm1d2oGepX3oHTRhPh7S85nLtmeDj6pZQiwzC/g+24RKUAyYJIfN63Q36mrbvK77awpUenG6mi41o9LSrMOcw0CofAA7IcPzJd9VcZRTMt+2+Tbd1lraym4XQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbVWnxb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbVWnxb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292031F000E9;
	Thu, 20 Aug 2026 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787235992;
	bh=MmIcykLc8RZnWhJVzUhOCLGPNKjHZx+oLvob503O+dY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SbVWnxb48nGKmOHDXW7nVlObwW7O2m+EXvHRTGJPdXIzhlqVMcCqlgWO8lJZYkpUG
	 81wMbewAkWa14LLEo9cxoLqo2xqZ0972j6edguXnI6zrJTUBfKEH6rggJBTtZ7yjgi
	 HNWA3GFqE6hownzj6/LgmPYOFSjrZ/Rsrt+ABdIu02k5UIRRhq/53AttXEXLG/KY+0
	 alOaeYTfReK4oREFpxp3/291OOKAArBm0j9+eWD8MglgUeeBso7m6n2zntbIiwH3ke
	 8e6/5AtkwYBA3sg/0BJnbDSHnkQmnxYElzZDpUWzoYabLldIZ39PsNB2HWzzJoAbj/
	 ChpFPDs8+547A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] s390/crypto: Fix wrong return code to engine in
 asynch callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260820141957.19091-8-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:26:31 +0000
Message-Id: <20260820142632.292031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When crypto_finalize_hash_request() or
> crypto_finalize_skcipher_request() explicitly completes a request, the
> do_one_request callback must return 0 to indicate successful
> handling. Returning a negative error code causes the crypto engine to
> assume the driver failed to take ownership and triggers a second
> completion via crypto_request_complete(), resulting in a double
> completion. This pattern occurs in paes_s390.c 4 times and once in
> phmac_s390.c.
>=20
> Fixed in phmac_do_one_request() and all four paes do_one_request
> callbacks (ecb, cbc, ctr, xts) by returning 0 after explicit
> finalization instead of propagating the error code.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820141957.1909=
1-1-freude@linux.ibm.com?part=3D7

