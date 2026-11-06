Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990586;
	b=quJSwvwUx2m9Xg4s1QoLraUHQl8o7oK1dC3YT+bNNTiBEsdPthUfq/n5Mtem8to7TYQz
	 e8PMq8ZiqualNOA4mwdJnLVf+ebRp80xapu8jyhIVlOQt72M1uyQ/xpUvctIed9ftRaSf
	 j49XLk+est0u0XNf5FfUzxX2iuxAV75HgIkZto6sRysmyyUT9Z1GbLdapTYnRuFGy4nYi
	 DgfK9Z+DplZMdOUINGoXNxUL9cSK6kPswCdF0zDJB7Ru0Sa4qcn8Jweq22aXfi1vV9NmT
	 K08X43Kq/fudYaI5CxhrkQtsf0HbDQ453wRKoKaQnjjDI8viWHuKeqyZusNHbkck3/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qmN0atWAN3An7+bcolqsibinTAm8GPOht2ykX3zJyTc=;
	b=U7mUfyL8y+ulatSzfRfFYvoH+XTGdxI6plRveExvTggxXSfQLKlBSUPoXVpNf/g6BTMM
	 MyR+3rHWAjj4KcjlOyFCTieIt/Ux+HZO1lAl32C8MqkfhxVjSngq0JkYcKSLek5imXPTU
	 4sYu3ix8ZFYM33N4rKPSXnrXBPicA//v3xi6zxqctZXk6FhEEeNEsWY6JtCWoNJx6kPaF
	 fRRGwnV2Xiwy0er86jlFq7MBMBb9rd18Ml0sExLAoK0spzcRPZBtnh/bx+TWorv1NA2/9
	 9Kte9gRgZD3gptWusEPZCaklfTq8Q9vhvf2SiaZIHPoeUkoOgY8xaziIehpGEocm+RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZP56SFba;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8E606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZP56SFba
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAB21F0089F;
	Fri,  6 Nov 2026 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990585;
	bh=qmN0atWAN3An7+bcolqsibinTAm8GPOht2ykX3zJyTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZP56SFbaWitPPFrBDsAx9Gxax+dAAR5t4onN4MxZVvrZYebKFbTYy29oH9KYEyUfc
	 fcVbVdkpfi0VWSP+dB1fPd+2l/bY6zQmgVlsdUyCJCD1TEtGtRw9SyxkPas8RAKn9c
	 q/qFQcBz8IoSmW20eluym4vY9bJY1pZXOFlUcvWAFzZwz2YE91tYUW+vbhrABF6Arh
	 /jjg3H7O3Ii08FrezZQXxtEZ814JADOzFPzK1zibopJrUk0ORI1p7+fisFnU1IT7C1
	 Ws1qlNTZdDRsBPA5VocE5mqj8l9u/2lU/YEy0kwZwG4A7wGQ2pMS7mpuy10jfB57rs
	 uI3+sqWFjxK3g==
Message-ID: <sashiko-outbox-202061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/32] s390: mm: add PMD swap-exclusive helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Usama Arif" <usama.arif@linux.dev>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105183940.2236717-7-usama.arif@linux.dev>
References: <20261105183940.2236717-1-usama.arif@linux.dev>
 <20261105183940.2236717-7-usama.arif@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:43:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Prepare for keeping a PMD-mapped anonymous THP mapped by a PMD across the
> swap round-trip, which makes PG_anon_exclusive have to survive in a swap
> PMD and not just in a swap PTE.
>=20
> s390 is the one architecture where a swap PMD is not a swap PTE in
> disguise: it is an RSTE with its own layout, converted to a fake PTE swap
> entry for the common code. Give it its own exclusive bit rather than
> borrowing the PTE-format macro, and document it in the RSTE swap layout,
> where bit 52 was listed as unused.
>=20
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105183940.2236=
717-1-usama.arif@linux.dev?part=3D6

