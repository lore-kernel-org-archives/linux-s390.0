Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAB41DDEC
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367814; cv=none; b=MjdRXVt+lGMl8MzfkXGnzjf89GgSGjq27Bn2hdcltlabAS3F13gsqUNcdXTOMKBCloztSHCQfEECBIO70W49EURKmse45C/pWd8T4AqatWpUH8vb3Q/evO+aLGabq3UWOzYKzcmL11jepfm+1v9YH6eUipJc3gDqFBbGLwPRYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367814; c=relaxed/simple;
	bh=mmUmwTPPE21G1KgBRc4ykvgeaEAkmZrSDAEslHAwMNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=etx4Dv/8i8aEGfAoDbAWkvRP8Mqp1R24C7CQ5LOSY3gRLpjMR/8a1wCThPnvQoPOAxguAQkTouUCo6dI90FZzHQMSX8ka1IibM0S/WDfYk3htt4Jo9DeghQk4gqw7x9OhXbjeeuFCnTmLryJmZN7G4zk/1jWZUrV+CbXamAv7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWPolnmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWPolnmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5168F1F000FF;
	Fri, 25 Sep 2026 20:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367812;
	bh=mmUmwTPPE21G1KgBRc4ykvgeaEAkmZrSDAEslHAwMNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWPolnmuCruYN0oAIyaffojRoC8b1f9NEYSJbpSg5OwIZufhWohxkw+aMrdULshes
	 H28lDQP2nQoKDvYdxqa/1cGfGD2zMgXVMHk25ZE3ibOxMQ1w8Ziwx7oTU6tVgu27KR
	 z75a6szNK4XWY02Fx3j7QEbno4DKVMVyWaAatV4eq8kiTRpmxDFqIe3pTprk45E4qP
	 xEL+Tm3j5/htN67mzl6qYwtAwkErn0ulv5EWIQ7d2jVMzCdIszpz3a6TnAJDENkqo4
	 boRjg4oLVtyH+yh/kEz91mcYkuUcUM60NwJNHTBRcfYMyNKxrBs6Iq1R8ok7p2CpUH
	 8Sn3hHRX9aeHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 arm
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-4-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-4-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:23:31 +0000
Message-Id: <20260925202332.5168F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit a0ad5496b2b3 ("arm: mm: enable HAVE_RCU_TABLE_FREE logic") enabled
> CONFIG_MMU_GATHER_RCU_TABLE_FREE (then named HAVE_RCU_TABLE_FREE) for SMP
> arm architectures with LPAE enabled.
>=20
> Regardless of whether CONFIG_ARM_LPAE is enabled or not, the same page
> table freeing functions __pte_free_tlb() and __pmd_free_tlb() are used.
>=20
> Non-LPAE PMD page tables are folded into the PGD and freed by
> pgd_free() (PGD freeing is not part of mmu_gather page table freeing in a=
ny
> case), so this is a noop in this case.
>=20
> Since commit 358d1c39c82a ("arm: convert various functions to use ptdescs=
")
> both LPAE and non-LPAE PTE page table freeing uses tlb_remove_ptdesc().
>=20
> Thus all page table freeing is performed under RCU with
> [ ... ]
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D4

