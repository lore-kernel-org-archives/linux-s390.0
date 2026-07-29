Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56D3EC826
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337235; cv=none; b=Nwv+Kj/KmjlhLdgOcrFyyNi0W4GUHplQgUhCb8Q9SNyPtabCvWTunU5IiqYoNglqU1SMDuOVzSOFBNE0NFa9eAnvk1B1f2aNqZ5OyPOMS6QuG8sgbrYP1aZpFGxmUc38xbZ+79iwsL0aDJmgGZzwGQ8dWU+PkUlxCsLU6D1Rty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337235; c=relaxed/simple;
	bh=ZIfwPE84LJtnvoxwxo44GQyFJTiEAE9e+EOCOCHORng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U/7eTSf8W6c36CkKY7cGyMfo+xSiMgRbfK9Oy+rBvoeYC74He96VP8BwglDlZqHmsDEpaEYehaaxeTSP2UCpzuhRx2uyjZTN6PbADR3eSR96MbzHo3Iz4SE+ge6Y3tw8WSMnsB2Rf6S5A4gamzqBOFXW8oDxe0Zo1HWHGMn0Oso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIhq6yIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIhq6yIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C0F1F000E9;
	Wed, 29 Jul 2026 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337233;
	bh=ZIfwPE84LJtnvoxwxo44GQyFJTiEAE9e+EOCOCHORng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIhq6yIwJ2up6OTxwMsLRseKUeLf3KqNkH+e9QHSMtSqRALp36mSqJKvWGPnqQg65
	 /eUUdOtBqjvHSDJbCgmv/maCaJm8KbBwezUUsFUEJbb7FetFUAwVwzNcHhK5FjuDRf
	 pSCNMTiRX46yJ3CPZmqvJcBb3uBFjaiVkQKt00HYjZvG++jaJ9rkxlLFnTTgSDC7uX
	 mfBfynxV1cphAYXNr2IX1kfK8sHwDPndR3BfeApuGWz4wEn0HHrfD/8YAjMsXzb5X6
	 iFr7DUbouNtPnE7gS4EUFBkPpgg6laaqDKPeptXTYBcZuLVdTSYV8Qb5jPS4Kpq0/u
	 W8RWI6eVsmDfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] s390/zcrypt: Pad trailing CCA or EP11 message
 with zeros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729143928.191969-6-freude@linux.ibm.com>
References: <20260729143928.191969-1-freude@linux.ibm.com>
 <20260729143928.191969-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:00:33 +0000
Message-Id: <20260729150033.71C0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The both functions xcrb_msg_to_type6cprb_msgx() and
> xcrb_msg_to_type6_ep11cprb_msgx() copy the user space message into a
> kernel buffer based on the message length. But on further processing
> the message is supposed to be 4 byte length adjusted. Thus up to 3
> bytes of uninitialized kernel memory are forwarded to further
> processing steps and may unwanted expose kernel memory to the crypto
> card firmware.
>=20
> This patch contains code to pad the gap between user space copied
> message and message buffer length sent down to further processing of
> the CCA or EP11 message to zeros.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729143928.1919=
69-1-freude@linux.ibm.com?part=3D5

