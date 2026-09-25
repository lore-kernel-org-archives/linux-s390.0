Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7710D4E1C77
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368195; cv=none; b=Cn/Vj/JIvPyHCLghl3ZfeldkYLhze2JyMyO9Ik2w1EENvnVoht+4H68q6OVtNbr4NH8xkROdjBSDwMYYcWhZCdnk6Ogjee6F8OnEsOVcTljxo1054AJGbirxpPZMZ8VqDn80YJyFJ7FnnR5pbsLbn+C/DtL6Y3P/A3PufY9VNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368195; c=relaxed/simple;
	bh=4elNbLAX3XhOkXTlz6960AemSEjpO3R/7s+09KfeSEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nvorbkAFJV2xq1iVCWF7a8kHYQ4tmBvfTeK35/u897pBPiF/0e2sQQFN/v4v9YAAT9otwpNeYV1S+VCZWT4kraiRaLUrW7VobaPfaps1k4T2dApp2TpGsINvFhe42zV5u3A9oxUOUY4svokY6ri92VBtT3yp3/0cJnRfjOajJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLFJx/OQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLFJx/OQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5B71F000FF;
	Fri, 25 Sep 2026 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368194;
	bh=4elNbLAX3XhOkXTlz6960AemSEjpO3R/7s+09KfeSEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hLFJx/OQo1XBo3QW9dd+OprsnQMlLubUl7ZGcM+mICXy9owDYSYgBxD+5DVJ1kYe4
	 +k5N/WGKtpzWGdNl7E7Mn8ptMKwQEBxngY4PjKDGqquLlisJ82nr40W4iXdBL06Xeb
	 sxBX8nFdJJJGL+HFF8z5abp3stQwlWGXreBO9QvyfRk02fJ5SSK5nUrlrsxOHoY9r6
	 p0fB/RyS5iON5DMAmg9Fr0e+ifwcID/7TqsGAC/cBXRsML2Gu/PK8OWLW4l9GjrRwK
	 xW00S1Yww28bqCze+mmPApLOOr57LR+gv/HzyAokZpKJqStyBkYu5xZpvAThAdHEyi
	 4FG3bu17W5TYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 sparc32
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-10-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-10-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:29:53 +0000
Message-Id: <20260925202953.EB5B71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Careful handling is required for sparc32 which implements page tables as
> part of a shared backing page.
>=20
> To support this, a custom __tlb_remove_table() function is required, as
> specified by CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE.
>=20
> This allows __pte_free_tlb() and __pmd_free_tlb() to specify which page
> table level is being freed, which is transmitted to __tlb_remove_table()
> through setting the lowest bit of the page table to 1 for a PMD and 0 for=
 a
> PTE (the page tables are 256-byte aligned so this is safe to do).
>=20
> Next, since the page table freeing is done via RCU callback, and thus mig=
ht
> be executed in softirq context, update the spin locks to IRQ save/restore.
>=20
> Then, in __tlb_remove_table(), figure out whether to free a PMD page table
> [ ... ]
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D10

