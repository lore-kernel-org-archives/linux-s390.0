Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40D4F474C
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092119; cv=none; b=ebEmhUMaan+jxYepeXy4RXniNZs3jBAmlUMy/lpPJYwbK1T7p2VCIz5juLfatQyiHwAoGE5FpQvygu2nPnDKuXyRAqHxKhye9Ql9+ufYs2HPBK1F/VNCM2zD85xsxxni016XwLEb77nz/V6z9GX0Rw054ZpKKpR9SZNxlr9Xneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092119; c=relaxed/simple;
	bh=PHDRsBp1ZbQ4+XLk48JJ4B8nT0Pd4d43U/Mwn2uUAFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fKaSkTRKRmya5lLopStFnF/02EmGKagTl6kq9nA6q5I8jd3ndPi/L31Ia2EB8kb7T4bW6wbPHQtdKG91hs9zm7bKuwF7r8nAMjBY23k+xR2sT1A8EmQQHP6EgsARyth/ofF2G1vVG5266pG5nmb8WKWjGUzmZxOkY+46sfhSX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOtjYKHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOtjYKHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58151F00898;
	Tue, 22 Sep 2026 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092118;
	bh=PHDRsBp1ZbQ4+XLk48JJ4B8nT0Pd4d43U/Mwn2uUAFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JOtjYKHCkbv5JX0KcMxYRDljKq4cDC582DPjANpcaXEgURApjOan+iJnszixHeG6q
	 2c0N82HAYcnSbjFsK71FUnB4iUw+ZocH8admN+C+Qkk5hKmfYtz2Gm3bW/FcBuCkWK
	 USganZ9rPZ4O/G+Q3kv3iT5d5srbm5IoY7NlsnjbpfeoSlTWV+qBjbetocrtONioXU
	 ECFG+Jsl8rc36sLmDWywjloZaCFDHubRWpGgpNMo6+8MzN9gUtkRSfPgnZV0ImCSLU
	 pvnAKToy55+l2e+Nxmrn+dewDQTU6X1AkuT31/QZcCnSLoHw2uA519MNUwgh8B3EIk
	 CqTSDZFhAO2uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-coldfire
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:48:37 +0000
Message-Id: <20260922154837.D58151F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Similar to sun3, the coldfire variant of m68k uses 2-level page tables.
>=20
> Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
> that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
> RCU.
>=20
> The page tables occupy a page each and have no odd semantics, so this
> change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
> m68k-coldfire, so do so.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D7

