Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9039A7EF
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373775; cv=none; b=OAImxYe8R/fAJXgntpMYlNiwedze9uSxTxKi3uW9j9cKWN3UXeEzdAIZx3pS78obrdHD8DyK1KCWbvpsyQMMxHUwWPSQJ7bB15wR0V3JiSFOQ8Lz2ZTEWik6XlZeTUprRB0OezFc40CjB3HAMj2HNcptljBagRWqlyaqlkKYzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373775; c=relaxed/simple;
	bh=lkL+ED29LEdM3ZrbwFW7SRE087yK2wq86xE4fVeAEGo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=J64tqlgOaqccPCJrfJre06M8wNdF6P+L2lcoly13ntIhNZjRZGaYXgyrrA0om0wjPBOxv6gjcpDudJnRZaQ3vFA/1SB0+YVbGzF8745f+JoEDiEcsX1eUbfhUCJncIof40iDaUvuy5W2Ja7U2rvm4XQr5a6Q732LPnC25JAqH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHiwd9h0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHiwd9h0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0481F0089C;
	Wed,  7 Oct 2026 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373765;
	bh=lkL+ED29LEdM3ZrbwFW7SRE087yK2wq86xE4fVeAEGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHiwd9h0UmXjlGCA3ZJfkxhEjYttMOC6z3g/bV05AjFNpPekEKkh3HR2/L3Kddvw7
	 lw0+88/j7TuCBOH62I9f39JjGovUca8SdBSyOH79FGp9FDGL4HRcDR6ThE77ohWbYz
	 zqfhWiZWBZs4IwS4gk+GYsRYhyYA0Se0RAJw8bip3Nb2o6u/6yTVdG4cdKkzKUTZZ7
	 JFlaAzpKZgQAPIVhr+hjL7pCigNLEItD3JLIESsukzDZp+vpzRLcxm1m6JLenA/dU2
	 +Ku7W+P1pPP7JANj2UpzGI3soPVNacAq6c9IFfJgchVIv3HwHu2euXaoU1KnKVGwjm
	 +zAaXLIitfqaQ==
Message-ID: <sashiko-outbox-162939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/15] mm/kasan: use hw_pte_t for the early shadow
 PTE table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <e24977fba12bae1a05e8eda80c6bebab423ae5e1.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <e24977fba12bae1a05e8eda80c6bebab423ae5e1.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:49:24 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Muhammad Usama Anjum <usama.anjum@arm.com>
>=20
> kasan_early_shadow_pte is a complete PTE table rather than a software
> PTE value. Declare and define its elements as hw_pte_t so the object uses
> the PTE table storage type.
>=20
> Read the first element through ptep_get(), which returns the software PTE
> value expected by note_page_pte(), instead of accessing hw_pte_t storage
> directly. This also uses the accessor selected by the architecture.
>=20
> No architecture selects ARCH_HAS_HW_PTE_T at this point, so the storage
> representation remains unchanged.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D7

