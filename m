Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4F3A0E97
	for <linux-s390@vger.kernel.org>; Fri, 27 Feb 2026 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194314; cv=none; b=kmaFgHp3pFEqnhwY+EkoCKTLfbKc6ePA8gNUpGFXynXPPs4YbaAbuioUmNHRHBDxJJlip5r4xMme6oRbwbvcmDELzQDrhZalJoGK3HPT1mi+dmAebkel3envZJmOYFi/8AEGh39W4KqujHidpJk4CVuH5IhfaHmoQyPGREBF9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194314; c=relaxed/simple;
	bh=Qox98f5KSPJa6cfmRhkeqK5IHZD+00pWzAvsF6fCTk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZnsnijuPjSnNxszihkwIi50DaA2pijlCYWlpWV/P/r11X60FhclbYNxKpdsi6nGF6ovjmlj/Zk+SXJGKQzRU9cy0yO2WLYSypIZuMhxdDd/Yh9o/ptKZJ61PEQazxoAVqGD7gVKXJzBpr3L/w//HGiCPEpvPIf1r7AHC5T/mAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G73YvlTI; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G73YvlTI"
Message-ID: <4672053f-c9d9-4694-81ad-9b5fe741013a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772194310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9VnUUVWt2OivEInnP/5hnH7A1kF+epUMtvXzdzCsRg=;
	b=G73YvlTItW/u/rHPyW7CK+7PMpVtGhIzMOv1+2p9NrT7k4zRVoaOf2NzDUgdgP0DB933Kw
	FryLANPcbvAUfbuhOq0PAoZA9+6fSEp1UeRgwgS84+HZU3nq7i3sqNUZ2hl1aMgf8gchpW
	Ttxn5+wmgqiIl17kKNPBrc5OfS3bRa0=
Date: Fri, 27 Feb 2026 12:11:46 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 13/21] mm: huge_mm: Make sure all split_huge_pmd calls
 are checked
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org
Cc: fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <20260226113233.3987674-14-usama.arif@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-14-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 26/02/2026 11:23, Usama Arif wrote:
> Mark __split_huge_pmd(), split_huge_pmd() and split_huge_pmd_address()
> with __must_check so the compiler warns if any caller ignores the return
> value. Not checking return value and operating on the basis that the pmd
> is split could result in a kernel bug. The possibility of an order-0
> allocation failing for page table allocation is very low, but it should
> be handled correctly.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>


Kernel test bot reported that I missed one split_huge_pmd call. I will include
the below patch in the next revision.


commit 9e1bb250ea8ef0a39c738cd4137ed6c98131ebb0 (HEAD)
Author: Usama Arif <usama.arif@linux.dev>
Date:   Thu Feb 26 10:45:35 2026 -0800

    mm: proc: handle split_huge_pmd failure in pagemap_scan
    
    pagemap_scan_thp_entry() splits a huge PMD when the PAGEMAP_SCAN ioctl
    needs to write-protect only a portion of a THP. It then returns -ENOENT
    so pagemap_scan_pmd_entry() falls through to PTE-level handling.
    
    Check the split_huge_pmd() return value and propagate the error on
    failure. Returning -ENOMEM instead of -ENOENT prevents the fallthrough
    to PTE handling, and the error propagates through walk_page_range() to
    do_pagemap_scan() where it becomes the ioctl return value.
    pagemap_scan_backout_range() already undoes the buffered output, and
    walk_end is written back to userspace so the caller knows where the
    scan stopped.
    
    If the split fails, the PMD remains huge. An alternative to the approach
    in the patch is to return -ENOENT, causing the caller to proceed to
    pte_offset_map_lock(). ___pte_offset_map() detects the trans_huge PMD
    and returns NULL, which sets ACTION_AGAIN — restarting the walker on the
    same PMD by which time the system might have enough memory to satisfy
    the split from succeeding.
    
    Signed-off-by: Usama Arif <usama.arif@linux.dev>

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca19..f5f459140b5c0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2714,9 +2714,13 @@ static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
         * needs to be performed on a portion of the huge page.
         */
        if (end != start + HPAGE_SIZE) {
+               int err;
+
                spin_unlock(ptl);
-               split_huge_pmd(vma, pmd, start);
+               err = split_huge_pmd(vma, pmd, start);
                pagemap_scan_backout_range(p, start, end);
+               if (err)
+                       return err;
                /* Report as if there was no THP */
                return -ENOENT;
        }
