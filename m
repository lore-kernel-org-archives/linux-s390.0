Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2F5867C3
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156726; cv=none; b=lbhnuqmIn+ZNgwVpxKjbFbcNlqI5OnTz4iWKyYJRtjljD/jaI0aqopfcrpcGxeQVRUZFRvddVWVbr9aKqKs52ZPQOlzfaKKf7qQyIpGmmw4lNnTylh5pBbtRDJZxFqESOhhlI34DzDdBxhsQxpvxsulgNL0NV+ACU/oqgImInXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156726; c=relaxed/simple;
	bh=pX/nJeXhWqCDak+XCBbw2VThhwjrHkIV6zWLzqxOJYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aiqgmLgJXEsq+FGUFjhkKpQSMFii/D21z8BCOb7w8/NC46l3c/ERvwsczkVV/DsSbalcjBJ9gAoo3zNSS9UaI4kZPwIolzf6NUoddanE8GezeokkdS+yDngRLW5wypU7+sLZ+sn7FzpACL8gLrssJln64KIDYVlIlqr1ETOszLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPXj0hoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPXj0hoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404DA1F00893;
	Fri, 11 Sep 2026 19:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156713;
	bh=pX/nJeXhWqCDak+XCBbw2VThhwjrHkIV6zWLzqxOJYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LPXj0hoUXlGhrY1VWnThozb8JqJ5J1QKVunCgTKOB7mul+e2sbtrjWMLjgSvbwWLo
	 nOmS6OMtFfXQV1QIZ45cNdIcEv9Le5Of7VWGTtQh9RhQuy3oJOZuS+65Fcu7KqOOUO
	 SyMXu6QA4AzvvAg2eNTCr+h4OJj9FcFfcEU6TVPjBDgWAhpunE//wIJAHpivgByzHK
	 Fw/1Hw5L88tdK/oGVlfPlEnZrMQpcY8WKxtRTU3tUiJkdmnYvK8IDhcArgvCyxU/jJ
	 KDkPw+X1ijTWO9vnKs8Pci5lI9MBvZA70mR3tm8ODJJOmRhnOXbp64J9SvHAhU5KGb
	 nOJWq08J/elDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 sparc32
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-10-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-10-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:58:32 +0000
Message-Id: <20260911195833.404DA1F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D10

