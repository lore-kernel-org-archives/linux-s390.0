Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308838F620
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092557; cv=none; b=c2aeld4mtqshGDstze4HuHIWR0yamn9Au3d109SX/f5pqFrOwfyHXp2b1WUBby4ALpD5YqWFyBjKaLcj4fFOVTner0uxU/y0pkTEfWl1WIfFvluf5VlsDg/r+Nj9sV2Gs7s0c8eWL6KGgSJ4KORSBxjfrfL3euey/OSuC6YfIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092557; c=relaxed/simple;
	bh=v5cFFTs2VnIO03cWKMYp4rbG02qCMYjdGzxOiiz4nRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G2TtEOJq2MM0siMx04YvKDNyAVzEXZFG6qvfbieeuDXtZTR8bvCmgR+3Bzc8Ou2hJ1LnYcAnFF+V3JVT/vBXXkmO626kpitjPEcvy/mObqf2WHqV8H8J0pr0jgwwEeArbjiNhN2euNaJ0qum9s4iaSIqmIdcMw9OTQdwLGdwbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuIqwMZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuIqwMZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ADF1F000FF;
	Tue, 22 Sep 2026 15:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092555;
	bh=v5cFFTs2VnIO03cWKMYp4rbG02qCMYjdGzxOiiz4nRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fuIqwMZSuqOEdmsi5fqp/R+jQHNYgYJ0/tjcH1G46uwRmaBHU2E78xw/p2X6rytmk
	 ILq9AuaS2b7jgrk9t+8NGhRMpraqJq2GbT4q2NcFPEkcZrEqhVWMprLtgVInjgdc3H
	 yoliyQ/Hr290umBDJXHJRzZ0Ztb5E15HT/Q42Xp+a55Au30kb38Hl/u3WuZnuSwR9Z
	 LiykWaZQvnYMjBCCQTTsLzC2PFxiW7IbPivfpQXblUBTILutSzSSW3/p/OC9U4DGOT
	 kYE2TdpvM4EO6S3bnx8DqX+jmADEuyra6OKFm0s3WUr++B9MrwMamgMe2C9Cb65zKD
	 +mc/rQS6LMAQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 sparc32
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-10-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-10-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:55:54 +0000
Message-Id: <20260922155555.58ADF1F000FF@smtp.kernel.org>
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
> mode, and with it complete, means every architecture now supports
> CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D10

