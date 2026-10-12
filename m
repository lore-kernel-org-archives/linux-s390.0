Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D73B19BC
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815209; cv=none; b=YBtu+LwMEfWABw/iZZZI1tymMFM/NQTvO729wGP1D+bOLMKhPtMVkP3gnVVEtQRvw5QCCtASC/2eD5BP5opiYXdNQFA5ESUlFc4H90b1gX0EkgVB738C0XrMSWGDaKy7RpmaaZN5zzRL06IFMchm00nps6tgBogwDOTEwYn3ZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815209; c=relaxed/simple;
	bh=vw5ol3eL60ulRDW6i9TPamjd+P+Bb3iyQ5IL0LKv70I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Hwb3T8EU0numRsh3dCD3LUpdHxpQ757yx4FHP1VRh6A/oIvlr5cYuSSBz/rFIyKOcvVtFxmyY/kg3/t7mzzQcjsynMeb+dsGVAaerJB8WYCHPphntmBayzylwQQXaw2E+ndy90Rm9wdEhz6AKB27KU9zrA66j6VMGWg8KaMQ8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOoJntyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOoJntyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9EF1F0089B;
	Mon, 12 Oct 2026 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815207;
	bh=vw5ol3eL60ulRDW6i9TPamjd+P+Bb3iyQ5IL0LKv70I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOoJntykhB5DNzSGqDVs6QI/BA1XlIOYnkNvIQha3Y/alC/XmXJ2rMNChWiqjYBjT
	 b01LdLVQ9qWsI6QGwrixvWbcO6xEmS7Pl17bkZCVw45WwLVaPosUDNixJLrVMV1xUc
	 NUrXBjuNmOvacXXtRUfQtszBO6SUy+qepORAOMlNm5QiV9nT2m42FesM9GWA+SGi3s
	 6wUmnP4aQE5msZOYCGuMwwX+Gn42N6hL6O6ascC56FqUSbask9CZrBorM1MJ5sZvvV
	 5Y0iWwzB1RwWSBsDqjuQKQfriZ839VjQYhyYqXgviM7aaN/ui5/OiysvPho2OEBMv5
	 Z5WDteIJmXcZQ==
Message-ID: <sashiko-outbox-168257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] s390/pci: Adjust alignment in insn trace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-1-1812db73dfa5@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
 <20261012-rpcit_trcfh_upstream-v2-1-1812db73dfa5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:26:47 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently we have 64bit wide fields start at odd byte-offsets in the
> insn traces for pci_error in the s390dbf debug area, which are hard to
> decode in hex dumps. At the same time, trace entries are padded at the
> end.
>=20
> Drop the packed attribute on the struct definition to exploit the
> compiler's natural alignment, introduce explicit padding before and
> after the 64bit fields for humans, and add a static assertion to avoid
> accidential overruns of 2 lines in the s390dbf trace.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-rpcit_trcf=
h_upstream-v2-0-1812db73dfa5@linux.ibm.com?part=3D1

