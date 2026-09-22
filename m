Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0705625E6
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092456; cv=none; b=T6Z/AOvtT/EUxyulp9bzVZ88eCBN3fTmUxfrmHnFYBtRwuFhkHG5x1sYmGxs5rfTw8sEofaGZa3wpNdOVhmxN1BA1D4vGjc3q3t8DY0U5v1ZvDc0uGyTOxo1qI8T86g9HIg1MQNuLZwIwjuhhQuXmD3JTVGxpIqUf7pROaSlcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092456; c=relaxed/simple;
	bh=ZAWmI/2X0AljPBBs88lwRz04d4KuEx4e4M4fgAlw0iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QNfa/+dm/rUf6rrJWskI33ATqiB887/fgjDLCTXx4cVQTgrX92so5TWrqgtFE/DUfaUq+I6fAwBmjw/6ZnK5tlG++yF/zjxIacovuzKrx4KXjVS2NMoFtzKdLpejq7+hZ+9f8KW6nlUoS3K1QETa9cQlwfDYsXfzbHVV135hkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fySw/7MA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fySw/7MA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4F1F000FF;
	Tue, 22 Sep 2026 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092454;
	bh=Q67SflzNp5Fw8SNqjjD2VhUYvlUmt2gMAZEESI6E19g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fySw/7MAUM1H+wN6Hl25/aVD7/7Dx4sZLNkXHgiEsBbDfWuxKCb6OgL4WWsOTAfmJ
	 av4NQ0pJy4MtSBJyt5DtYAszeb2Zkqaac/WlO/pjIMkyGmdrhZC4zMx2YpVsq2sKPH
	 FSxdEmi/HEWhiTVK1rK5/TRPpG4CsbAEteNrCHERyxTBByDTagphxqIcLhuu0v6a26
	 7rUy+MGtoL+/Oc9xI9/8QLP3TDh4B/HWIPmfOc6s8w+Lv8xV5jXc7z924LHRx5FgsE
	 utynGNfuEacQ4/c6tChdUoR/XLELHmU8hr6BWXRsCt719bXoPh0b2NkuCB+LC0E9mJ
	 6dOaRzPypSo5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/12] mm/khugepaged: deposit a newly allocated page
 table on collapse
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-1-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-1-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:54:13 +0000
Message-Id: <20260922155414.61A4F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: missing error code assignment on alloc_deposit_pte() failure
--

commit 554c24d600473369b27779719cc9b7a86d682229
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Subject: mm/khugepaged: deposit a newly allocated page table on collapse

This commit updates collapse_huge_page() to allocate and deposit a fresh,
zeroed PTE page table on PMD collapse instead of reusing the currently
mapped one. This resolves issues with RCU-safe page table traversal by
ensuring standard page table walkers can traverse safely during the grace
period.

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
[ ... ]
> @@ -1310,6 +1327,12 @@ static enum scan_result collapse_huge_page(struct =
mm_struct *mm, unsigned long s
>  		goto out_nolock;
>  	}
> =20
> +	if (is_pmd_order(order)) {
> +		pgtable =3D alloc_deposit_pte(mm);
> +		if (!pgtable)
> +			goto out_nolock;

[Severity: Medium]
Should the result variable be updated to an error code before jumping to
out_nolock here?

If alloc_deposit_pte() fails, result retains its SCAN_SUCCEED value from
the successful alloc_charge_folio() call above. Returning success when the
collapse actually failed could cause MADV_COLLAPSE to incorrectly return
success to userspace, corrupt khugepaged statistics, and cause mTHP
fallback logic to incorrectly assume the collapse succeeded.

> +	}
> +
>  	mmap_read_lock(mm);
>  	result =3D hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=3D*/ tru=
e,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D1
