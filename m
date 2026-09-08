Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD294BAA11
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871554; cv=none; b=ABAejh4fZoMVzz2E5rabao1K3W9BzLtYUtfghlfdWgy+q770fbU2UuEuPPQEp0irEJAE9JshXIDIVofBqKkm6yZrvcbJhI+FmZFTm+VYidPp6ohKIXsvgt1uOddTA7rBDoWBfbcwqY8PVGPVt601eHUue4ZLl0jcOgj4QgxNceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871554; c=relaxed/simple;
	bh=NFt1W/ZDUnMJRdwmXneL7pwaAMBY8HDHu0XqwNArGoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D/VrDasU9aR/keMJaisAFl1DNfjUfPR/DDml2scWCv0zRgI6Iu2Cmi8LK6H9thVeBkiA7FC/vFaIiWGnwf9pxelQ0vzj4gDt1coAz6JVlPd5UrO1LptbnxsnGevWH4EW4fO/FMro9WCqjEYr2Rr+jG8qwXdoEs3yy8ogIPZnMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL2GT6ps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL2GT6ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7451F00A3E;
	Tue,  8 Sep 2026 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871553;
	bh=NFt1W/ZDUnMJRdwmXneL7pwaAMBY8HDHu0XqwNArGoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dL2GT6psh6nvF0fbH9IZp57brYXZ68fY78fxJWHE1/aNs+OeNYTAEEgi0mqvWxEbW
	 7TM9eAlXd9yMmcUb1zpw3qv//NoaW76l99+O/pV6SWZX1G9yf/VwhD/FhrJPRbZjob
	 4ca0h2P13PHjGgb2WEZmC4U5aMYMxavgQ1PX9hYpsfo4yGB8q4h8tIvsfMXM5z1a0l
	 uQSMTzC0F+21r374arrJelLzdJLvhNjYKApAxHYMruPcrG1eT4sYI1As/XBacIr7WT
	 1Edt19AFtQHt3n3Ms7UkxBQYmBtCN2e8vGuLxH897Ge+dem22vJNrHog/jdwHwX8fX
	 duzHYQP556AMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-motorola
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-9-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-9-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:45:52 +0000
Message-Id: <20260908124552.BD7451F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> sun3 and coldfire are already supported, however motorola requires a litt=
le
> more care.
>=20
> Here, custom table removal logic is required, so
> CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.
>=20
> Firstly as part of this change, the page table level must be communicated
> to the underlying __tlb_remove_table() implementation.
>=20
> Take advantage of the fact that page tables are aligned by more than enou=
gh
> to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
> and store this there.
>=20
> Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
> then have __tlb_remove_table() decode this and pass it to
> [ ... ]
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D9

