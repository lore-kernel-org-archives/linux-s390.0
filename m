Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC04C227A
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978760; cv=none; b=MNd6WdaBM75jW6qzNS9G5vEkw8SfPNrzz7ZE84LwNTW5zIrxtJBQ2XKvn3E2oZlWH6FTEC3X7emnlTbBhG+J7CbPBDiLuBAv/KjCKR6M1CopZgLr+oq1xUsZ6tZzayFxlCzD2ZNSLwpv0N4oj0bAAX38J1FxpVSajMQEXOMDBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978760; c=relaxed/simple;
	bh=wS/Lt94fSjXwrb2bjTpNeuYChpzQktnDwQlCd81NDSc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MNHGHms9fUeTcpi6DjCgegvYzFTfdJdjckSHEZ96zKLQB30LzK2ggvKoK/UEP+iCidRXrxJi1EbOwV6H+J/Smp/XpkdHnN+4M9UkKy0prL/om8K6RO6mX+FkcL/0oHN2gSBYjQwNg6VQOhZFmGShizdUAqgwDYTwCOvFrd1LrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyPUEsn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyPUEsn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509BB1F000FF;
	Wed, 14 Oct 2026 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791978751;
	bh=wS/Lt94fSjXwrb2bjTpNeuYChpzQktnDwQlCd81NDSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FyPUEsn5B/kX3tMzJIpv6sf0qPUNtV8dmzIkniz/QC6E/LRVPaOKP+GmYAIL8FQCJ
	 aEb99Wsq3mrYSBspawTRCaQXz1kjrPrTGkK2t+6pVxabNSNTgKkdCRcFSqQj/so2mg
	 iGzE1MaUelKTNQcgNppUSC1HIl8MSbBiLnTDNceI0p7uJo62RqeRzzdlA7gMxqTCIc
	 6tBWeQX/3Ba/xysLQCxfQBHj0DvzwkWu8GYfk/m7NZgix41mcADeeIaiSLm2A6Na+N
	 lTXWuje15VuS1yafDOgHtnAkrhewdL6QIdD+LNdoOqr2Jg4Gf/QTU/txnoz7jteenV
	 0TQf9aA4NYjug==
Message-ID: <sashiko-outbox-171231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390: Select ARCH_MEMORY_ORDER_TSO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261014115006.537790-1-hca@linux.ibm.com>
References: <20261014115006.537790-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 11:52:30 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> s390 is a Total Store Order (TSO) architecture. Therefore select
> ARCH_MEMORY_ORDER_TSO which was introduced with [1]. As of now this has
> only a small effect on futex_robust_unlock(), but that might change in
> the future.
>=20
> [1] commit 6149fc36c09b ("uaccess: Provide unsafe_atomic_store_release_us=
er()")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014115006.5377=
90-1-hca@linux.ibm.com?part=3D1

