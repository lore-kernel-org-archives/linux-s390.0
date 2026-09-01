Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727B191F91
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261782; cv=none; b=uKJUAcLrkiXWNfRe8N5mD6VWA3hXZtsBScnAOMWKkfYiyX5qnQm4T2u4DN6YD2c4VOkyzn8NuG0GeHYAED6kcjk/6zDmum/HtsP417Z5NMZWD/ueSK0rAX+rMJqCcAaWdtTRRkh5cnHEV9VDFMD5+eJ+YCVK4mNOD2cFPZe4saQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261782; c=relaxed/simple;
	bh=zNMV9nDutrnvTuEov4czRGLTYdB/J+5u43TAFSlapIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ghUII/Ymil5AO/iIwa85yVbbeOI8PI+Xoupf02fIyq25MvQiMMJK6CTGqCSXN9v+/RCqt6A3uZwGQUKL/HdkLJlqPCSBBs4H48xCsyxHhjDT0sz0gamfXi2ZsvuP4TqbFYIIEfYcMwJBNmUbF1wNYK9+KaeHyIAlKjF9ODKKQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3kBUkaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3kBUkaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B261F000E9;
	Tue,  1 Sep 2026 11:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261780;
	bh=zNMV9nDutrnvTuEov4czRGLTYdB/J+5u43TAFSlapIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3kBUkaTsWvxg6U/zf/AUje5CN8wKSbr7ATdTf8RiTqtOa3H0pCNsqFprSNaQe9ZV
	 c/6jcS8C1G+BcOdNgJPsEzBcjtA2DtWj23fZwsrJuKraTiAY9/qrTywD1Hm50Sx294
	 3dRUrMIxARpQ0nhrLLuu5rgApsf4LgIKRzRiGF9eyY0Od3y8NBHKtEIhQiNrgxSkAm
	 5vgNqM9myQacwSFVw7bLumncuDLDTrCjhbo4JO4eAj67MpYToZriGm4jVarNP8n6Cu
	 lsAkV1+vxVYm8IoAkjy17+OCEp5f5EMIlw6Zcvm4GLWVLJbhV6yqnC6S7qGTqiUsKM
	 x31OBuTnteEGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for most
 2-level architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-2-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-2-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:22:59 +0000
Message-Id: <20260901112300.51B261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit e3ecf7c7d082 ("mm: pgtable: convert some architectures to use
> tlb_remove_ptdesc()") updated a number of architectures from using
> pagetable_dtor() + tlb_remove_page_ptdesc() to using tlb_remove_ptdesc() =
in
> __pte_free_tlb().
>=20
> This is meaningful as tlb_remove_ptdesc() allows for RCU page table
> freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>=20
> The csky, hexagon, nios2, openrisc, sh (except X2) and m68k-sun3
> architectures all have 2 levels of page tables, so the only page tables
> ever freed by mmu_gather are PTEs, so this update suffices to ensure that
> every page table freed by the mmu_gather mechanism is freed under RCU.
>=20
> Therefore, update all of these architectures to select
> CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D2

