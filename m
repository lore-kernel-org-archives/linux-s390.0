Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0C456DE8
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302803; cv=none; b=ltk4YPkd13dPkUuITfluRlXIOLy6Gx3njZgaD+V1/0WJg7A7MMtcJurzWqHy4IK3S1CukkdtE/qjTx4be7srRZUZTrHlRZKwuucGKjCEUIHAAzHtqIJBdfvirbKcw1SmN2FJ3U0pmeC9oSEcQM10Ls1vfbxz5rMPc1OOHJ0ztRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302803; c=relaxed/simple;
	bh=bHq3Xkny5FH0NgnsHaLV8MhMtZUD5UWr7lhUO3xIVHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=odYHEuaolZnkr/JEMxWWKoK9xaDuUYSwQY3fCEVH607wjPupxug4UhtbzMi+Fa7JEBPWvkIYeMtXIKaywvhAh17W3sHAIsAxMYDAmUEFGUFF4u+q4xVhs4nrSTxr6yelXdFiuJ55dcrhkGIF4wSkjUKIZ6OLWLJH2SToiqmSvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVd1lIW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVd1lIW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769551F00A3E;
	Fri, 21 Aug 2026 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302794;
	bh=bHq3Xkny5FH0NgnsHaLV8MhMtZUD5UWr7lhUO3xIVHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVd1lIW+N7W22TwpsFTMjMRh18wwC4ZQ3vXk7O+HLcS1jWzjAQsJL2EwTVwGGYd9V
	 E3pMwIK44v0rPHzMb81TPLoeNbVrwe1SFx6ykZl7fLkvS13L0Lrs0VZ9Am5HuzPd4T
	 LgrpxgbCQUgn+mkM6vjCwWdTDPXoNVMIRpuNvJVH1ZWWVYUMFNp4sDNDHhioRliLyl
	 wb6AvsX1dzDjwwUMK69waNPGZA2CWcDxaBnehnrT0ft81ryBv32OWDURz3mrtSh8nz
	 SfOfuqLOqy2y2v+FV+/u7oaeijhMkONH2rgu3TjmV9/RnPJlHOZ/r8N9zP98IdNDyB
	 mjSet/63xd/yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] s390/crypto: Map EBUSY to EIO when key
 conversion fails repeatedly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260821084648.23222-9-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:59:53 +0000
Message-Id: <20260821085954.769551F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When hardware persistently returns -EBUSY after exhausting retries,
> the error propagates to crypto_finalize_*_request(). The crypto API's
> completion wrapper treats -EBUSY as a queueing status and swallows it,
> preventing the completion callback from firing. This causes callers
> using crypto_wait_req() to block indefinitely.
>=20
> Translate persistent -EBUSY to -EIO after retry exhaustion to ensure
> proper error propagation and callback invocation.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D8

