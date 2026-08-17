Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4B224AFA
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976558; cv=none; b=mdUIknqC+C2n4MSxLWE+iEFTnQWGeYdkf7oLPfhgCE6Jx7oDHG4uv9sh6uWVFFOOb5ACEJvUIEwjvV6EO9Q/zeyTfs0/JQac2jT0FcymFkqFiRVy7qNZmX4CmLiDJvMhsPtaK/xpRKYbFyjIc2f1HrqM5m2KBXKZafCmJU4Dmos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976558; c=relaxed/simple;
	bh=cNJeVb84olW6J36+U0OiBATmpe7m/uwL2EnfvCidURs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LFgj1Mi769Nukfzt6xE/+S9Be34Vf1+AUdAp72dJ5iIVW29FIOSlUjRq37HfFGAOyBi9VhLMPYme3vJRpDr7CHQnOEHN+VdiOBOijBkluszENhN/YEzSRliQA97NrxKq2k1dDq7MSQEIObKLy5waKYWP/AOShCKIAJ2HblQ4nzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezotEcHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezotEcHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09E31F00A3D;
	Mon, 17 Aug 2026 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976557;
	bh=cNJeVb84olW6J36+U0OiBATmpe7m/uwL2EnfvCidURs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezotEcHZQhRSJUMge8QOEPcZ6x/fDbQ0Y/WMwKiWiTN5jZ8chc+FgwvJtHUoKS2Z0
	 yiKlztVJSoYF3WqWN2ZReYuMngW0PrXDthDSCwCGyquoXGzsgw27pScRglI2nAVOcO
	 kiNFbPiBU9LXQ+1cc231+9jqanpwjyXCfZKEl6iESlsY0Tb6RXCO9dIu4UB5WITC8T
	 qmtDTZzfZ5JcSKm5pUalZsWHYYr6uzVIqav3NGEam1UZwqprsUCr36duSv+XW7Ca+y
	 U4O9YXRSqQaY9GXiZC/N6j59fZ1bfvtyBH5/hkjWNzGlXzqp/+ParP/Ebhkxn+J3sZ
	 zIlWws6H9N3aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] s390/crypto: Fix return code handling at
 skcipher_walk_done in PAES algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260817141654.77940-2-freude@linux.ibm.com>
References: <20260817141654.77940-1-freude@linux.ibm.com>
 <20260817141654.77940-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:22:36 +0000
Message-Id: <20260817142236.B09E31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All the 4 PAES cipher processing loops were not checking the return
> value of skcipher_walk_done() immediately after calling it. This could
> lead to error masking when both the walk operation failed and a
> subsequent key conversion was needed (k < n condition).
>=20
> Add immediate error checks after skcipher_walk_done() in all main
> processing loops (ECB, CBC, CTR, XTS modes) to ensure walk errors are
> properly propagated and not masked by subsequent operations.
>=20
> With that comes a slight rework around the skcipher_walk_done()
> invocation. It is now necessary to check if the walk has already been
> finalized (walk->nbytes is then 0) or not to avoid double
> de-allocation of resources held by the walk.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817141654.7794=
0-1-freude@linux.ibm.com?part=3D1

