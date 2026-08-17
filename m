Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22F4B0497
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967343; cv=none; b=svlUY2pE60+iN5NsgEScXmbG3Cu//TFhwYJW5ra2pOs9OjtB4b+5iKSqsP/Gd69VM5NSbbOnUZoB8I2tL6TB+b/tcqJ20/l9FHhNkxJR0uv5oPdU7/OfvewUA9H7HxH1CDCKyPl0oNCb7CBLggU8aPUcZuIu/v3EYe5HzglUdVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967343; c=relaxed/simple;
	bh=k6G1EU0X4+iaL2Pzy2hk+orkp6YiGzwKt97YR8js/mM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XUx6JTd6wMdh/wRFSSwv5EwwsKTFtItLoDTPXWDtR7YZ688mu2qYbQ3mHpnaknpwUfmOzM2j0jvEBndtF3QproveeGa0GClHlSLShHf+SD8C3bg7BXXVF0WE9pM3H1rKjblQsE3J2pWpiPczTfifp9oFsp1yj+J8J0ASIUcawC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC7YrwC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC7YrwC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3771F1F000E9;
	Mon, 17 Aug 2026 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786967342;
	bh=bUDIUV8r43jNmGsvsMV7TbzL05qFq1XLIk3Aft+TbXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JC7YrwC8vii2G3k7ofDsdQ2+PFfTw/IcIln3S3k0A1d845Io9mGDrTrBzSuQbTtGH
	 S7O7tTCuWGHJIt+jkfKm4F52JipHT9G3rtOooUMAj13E7JgXuzFvH7awCmv1CihpKr
	 boraBAxC8MZSZTgcbjEsjXI5ZDizwOSjcEVTjxGjx7cBXMgJ4IDnVxeoMfl5UNMWcO
	 WnDibrzyE3gGzOfRRFmzs5fpIBiLadHowLKyowMlfcwVh0C/vwOhXBjJg6RMzjRLGl
	 4DG+8x0k6o1Kw/S1i7CPJCl2EFikJ14FnUfcbGojk5DH6wzjduzTP8LfIsbdl+OiLG
	 0Spk+OCBb5LRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] mm: Make lazy MMU mode context-aware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <5ee7bee9fa47e623a8cecb11b97392d38adb843a.1786956464.git.agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <5ee7bee9fa47e623a8cecb11b97392d38adb843a.1786956464.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 11:49:01 +0000
Message-Id: <20260817114902.3771F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Setting `walk->action =3D ACTION_AGAIN` when `pte_offset_map_lock(=
)` fails creates an infinite loop for non-present PMD migration entries.
--

--- Patch [1]: [PATCH v7 1/4] mm: Make lazy MMU mode context-aware ---
commit 1d7b684aa5a3ef0f53973a6ad48d5f71e845692f
Author: Alexander Gordeev <agordeev@linux.ibm.com>

mm: Make lazy MMU mode context-aware

This commit introduces lazy_mmu_mode_enable_with_ptes(), which provides the
process address space and page table being operated on. This enables s390
and other architectures to apply specific optimizations when entering lazy
MMU mode.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5c54aebe21182..b8c8d7dda0950 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2883,7 +2883,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsig=
ned long start,
>  		return 0;
>  	}
> =20
> -	lazy_mmu_mode_enable();
> +	lazy_mmu_mode_enable_with_ptes(vma->vm_mm, start, end, start_pte);

[Severity: High]
This is a pre-existing issue, but since you are modifying
pagemap_scan_pmd_entry() here, I wanted to ask about the page table lock
failure path just above this change.

If the lock fails to map the page table (for instance, because of a
non-present PMD migration entry during concurrent transparent hugepage
migration), the code sets the walk action to retry:

    if (!pte) {
        walk->action =3D ACTION_AGAIN;
        return 0;
    }

Because pte_offset_map_lock() will fail non-transiently for migration
entries, does setting ACTION_AGAIN here create an infinite loop?

Could a local user trigger this by reading /proc/pid/pagemap concurrently
with a page migration, causing the thread to hang indefinitely? It seems
that gracefully skipping the failure by returning 0 without setting
ACTION_AGAIN might be safer.

This same ACTION_AGAIN retry pattern on lock failure appears in several
other callbacks:
- smaps_pte_range(), clear_refs_pte_range(), and pagemap_pmd_range() in
  fs/proc/task_mmu.c
- mincore_pte_range() in mm/mincore.c
- mlock_pte_range() in mm/mlock.c
- queue_folios_pte_range() in mm/mempolicy.c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786956464.gi=
t.agordeev@linux.ibm.com?part=3D1
