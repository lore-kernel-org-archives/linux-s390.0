Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662353FD3A
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872015; cv=none; b=L6UGR5Eng7/abSchQBXjmoC4N6tL4PbZ+keO+yvPnR1sLXUcIfb3SAJ/l0i6eL44LEQZziOSzwHXMVJSLI9KnSa4n8BY2UepmRVRiFv4cWymXqP7rAj+CZa8KSC2w5g9ArUGn9OYtA1JUqjWuEAK7B4thEGTv1tQBCVg6DvoJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872015; c=relaxed/simple;
	bh=1sJql01KgIz+xwb6XY/6pF0YfL5rGwXQt1sRUmRRHc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZpkq6BeIgwSTmpQNE5jQhmjfbrLOmyiDuuL7JzmhqEiz1PTb9YdjjBaO3gsIfWpOLIcvK5LdBh6bLlBlVXxkrJ8Us2iPIRAtj7+vCHX2NUtLEpS+QzVonwth/8licKkXSQGFPsj2V8ENiY6sru4MnK59NUccp9xItuTIeDKZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3531F00A3D;
	Tue,  8 Sep 2026 12:53:32 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 sparc32
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-10-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-10-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:53:02 +0000
Message-Id: <20260908125332.AD3531F00A3D@smtp.kernel.org>
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
> This forms part of an overall effort to switch every architecture to this
> mode, and with it complete, means every architecture now supports
> CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D10

