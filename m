Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7170279798
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139696; cv=pass; b=Xm40StxbUhzf1BBl+5gpbNgz3MDP6/htlUW5S+wyLcW0Dokfsab6WTHsSZSdTx8grIzQQWyY0O2gIjDvKJ1Lsb7T48ogRMsW1sNGhIp4eDO1PhmohoiGLXD92zzpCO1g6P0lK+OKutsmIGT7NYT5CJwNCddjIcNlwp/wCVJiWn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139696; c=relaxed/simple;
	bh=jhcXe1rca0rv/o92dCP0LQGzjtCONeoBwru4Ji2VJH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeqbXJ9Ck6MBkA/vJjYtcQZAMgDOP+SUMNm9BBxGH/HZVP8KssF33JrVo8GwcVNBpncQRUhrVdSXfqlfocAmlDSIYIzTbjyiEGMdjKKmLeJY4/jV59r36DPrBrT0hbOO2wDf0GLGHlDzQ9x1BNNXgsNeiOvtNBTZbQIZLUBKvvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWaAsEDZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuqX4tk5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWaAsEDZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuqX4tk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772139694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmxX/qYJNas+Kj/SszP9KMGgHjwU+T3IF8YxcVK/CRk=;
	b=BWaAsEDZfsOJHJt3iJ8DHIQtfo3qgePYeVCXhMfp22aLR2y9w0EemW5fTKScMRpyL6Bjd9
	REbLtyhv78vIi04oOuPhBOpPxIl+BWorZj/hR1erzXj+5yL4rkEx+OUKPMkg4lbzfP0HR/
	/7HQuoHkfWsRW207ANRUqPN0B8za+74=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Qver8N1iNayyWU4PHBGLFQ-1; Thu, 26 Feb 2026 16:01:32 -0500
X-MC-Unique: Qver8N1iNayyWU4PHBGLFQ-1
X-Mimecast-MFC-AGG-ID: Qver8N1iNayyWU4PHBGLFQ_1772139692
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ca2fce827so3062140d50.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 13:01:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772139691; cv=none;
        d=google.com; s=arc-20240605;
        b=FIeJLmkDJQRn4xK5eHGG7HjP0Gyu362vnjDn7oxVp2S7YOGz9kqqmCfNkbO6/7dPvV
         NSesvVSW7DhWfGXqf5yUiT5mX2dOZPfJm1M/hob1PCL4iR4FleDIR5hBi4O+bUj9SnW0
         CcwoFdq63WlQGUA1eu3H7v7ZOzpO3T7+Ie4NlTpcOUVGE6Nnct0nBlO2DXWWKo45K/W1
         8u5NEkXrCzxHNzn+7XUynL3LlyAl06RY1v0Yp84WgrBIpU5ExhcwkvzWu2pr/UQc7CiY
         NxgP8aw4Ml8D04VWPd3WNZzPMMXNRWaGTaLXiO54NhVpWVtJpisPL+XI1Bmt6xmGX64o
         gSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bmxX/qYJNas+Kj/SszP9KMGgHjwU+T3IF8YxcVK/CRk=;
        fh=1tczrUjF/cLfLTCW6npo/MfZQ3bxwCP/JJ7xHLjB/fI=;
        b=QQfQDDv3UqEDDecgC9m6+LhxBwgyzPMBV1VSYZML+Ixl0iTs/qwusjseliRmcpnxFp
         smk3wmf7tmHtYNIKm+Ig3ifwveZXAmEGTcBuWzIdKxgU7qkboL7P0IWCKVgRKfVy/dM2
         Hl6cd5vFmWctIIYeLog3Rlyoli3ceK72doMFWRgNLhJqyvFxy9pfDJHIMhq6XBjF3VgL
         IBaSFaUlZB99pLTbaExqNP1DHLaKBhhirycZaC3wO3DQp0IQHYiVc5YK1LxZlETxX0Pj
         O7NcUKNRHUaYGXBG3mxMs0czBV2BxSPLN74yKDnDvSlHfU4200VPjRAiUL+JMmh+BZh9
         Utdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772139691; x=1772744491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmxX/qYJNas+Kj/SszP9KMGgHjwU+T3IF8YxcVK/CRk=;
        b=EuqX4tk5br9g1iyxyGWxq/ymYc5gnzEqXhpIy6cZdD/TrJSeM8IEviQesUNCYtZQSD
         RYoxP+xNX7pMomV9lQOjg1LwudD72d9EWDPdY8U1pY5HzDnEJxEZh+LnhBHCPWIMa0O8
         abhy8TyeztcA32cyHCieIqk4Fwjmdld/nhuNfvoiyb0ZhAFkQUS8/fPULWZfVrN3Za0K
         Km0ilAkm262eRRnlhTNokj1EbtGL2iMMKLGrq3bRYSoWfIKfZaJx2IRPRqQdpDPsdAfi
         wtkD3RihNvcxtA7S9S/estK8TDwpQwZy+IS/dbd52FuFeCq0zpp7x/4NhW+8F+T9TxYN
         SeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772139691; x=1772744491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmxX/qYJNas+Kj/SszP9KMGgHjwU+T3IF8YxcVK/CRk=;
        b=mhhpxR86NmRoZQZs1e7UIyX5sa1odz6KxPTPprKF57Ts3wyEfQbpmfb2hqKh/JVKqB
         qIp+SH+BsuP2jA7MJjYHROwYF5wVFqs0mEt8MXDWBLsJHj8UpIhNSPydQZTTeiuGtb9w
         lRbKeGlJwrwIIZs01biGTvMwrlxNUWsSiq8y0OndkWLkFqE9MOpV2+adams60wpcAz0e
         7ICOusmFtrhb+TIt1HPTykldCr8CxkyXzXnGrRm8B0OlS5iUNyCyFFsMUq4I9lnRmbpy
         xb3W6bIA7dCEDfR8MQb9lQmyT6l5v3pb9XW4e4fI6fZlj92hu3WB1Lv1GZIXBz2xF0xc
         Gv/A==
X-Forwarded-Encrypted: i=1; AJvYcCU6ARJppv9NBh+eJvsogb1jbBqKazOjvh3D3fUxoCXTUteuPrU8BQTXC/qZDlh6DmGYmUXHJQ4C/5op@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2uO8U2OJniuJxO+gyzQ/sUO/JaCEgsP4m3eyV7g7giDhNRZMS
	BX5ofYjQ9b0uFz8gAiNMm/Bnbg+JMqRMKTGLGZSkBVdb2lbXwb3vlZ+4g/QPM9XqlmQE+5EBjvL
	mytzI1wZXzUOJN0axlcsF7zZUCL8iFATmTtxvA7yOUjAH5fYuEpdPPXDgv+XfiQCQxsm3zHSr9I
	3xatioA/0mnwsGmnBXjJMfgCacF+LH9YQa5FhRAYhBgJZn/gJb
X-Gm-Gg: ATEYQzxKKK2yScY8D38Tp4qUnEcmRoqRw4FD5WeNZJH8xg7lcKDMtEXie4MXW9IiOZ9
	IWYtSO1mVAkMXIyFmQXk0JBUpnzHIU4hBDdRGU+CduieqZpq7+ZWY+GIVWnwSl7jxgOP9Jmj6Jk
	HjKb5GpALbjI4RwvgnkGR7Sfi41YeKkwnfGSrMV4O/xERsypH0EkrbUtCJM3Z6xIe8brPdaOZyA
	v8M
X-Received: by 2002:a05:690e:bc6:b0:649:4f58:5cd2 with SMTP id 956f58d0204a3-64cb6e0c928mr3154532d50.0.1772139691060;
        Thu, 26 Feb 2026 13:01:31 -0800 (PST)
X-Received: by 2002:a05:690e:bc6:b0:649:4f58:5cd2 with SMTP id
 956f58d0204a3-64cb6e0c928mr3154488d50.0.1772139690404; Thu, 26 Feb 2026
 13:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226113233.3987674-1-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Thu, 26 Feb 2026 14:01:04 -0700
X-Gm-Features: AaiRm5209LV06f3Unt5ipFy-rNSZmlqNghFDY0XoCRoPEuuBfLMWoAzmF-tTAXE
Message-ID: <CAA1CXcAYt3OfW_uBTYZgr-dBhg99x=5pUs5uvqtpg+PNJ1KxGQ@mail.gmail.com>
Subject: Re: [RFC v2 00/21] mm: thp: lazy PTE page table allocation at PMD split
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, lorenzo.stoakes@oracle.com, 
	willy@infradead.org, linux-mm@kvack.org, fvdl@google.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, 
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 4:33=E2=80=AFAM Usama Arif <usama.arif@linux.dev> w=
rote:
>
> When the kernel creates a PMD-level THP mapping for anonymous pages, it
> pre-allocates a PTE page table via pgtable_trans_huge_deposit(). This
> page table sits unused in a deposit list for the lifetime of the THP
> mapping, only to be withdrawn when the PMD is split or zapped. Every
> anonymous THP therefore wastes 4KB of memory unconditionally. On large
> servers where hundreds of gigabytes of memory are mapped as THPs, this
> adds up: roughly 200MB wasted per 100GB of THP memory. This memory
> could otherwise satisfy other allocations, including the very PTE page
> table allocations needed when splits eventually occur.
>
> This series removes the pre-deposit and allocates the PTE page table
> lazily =E2=80=94 only when a PMD split actually happens. Since a large nu=
mber
> of THPs are never split (they are zapped wholesale when processes exit or
> munmap the full range), the allocation is avoided entirely in the common
> case.
>
> The pre-deposit pattern exists because split_huge_pmd was designed as an
> operation that must never fail: if the kernel decides to split, it needs
> a PTE page table, so one is deposited in advance. But "must never fail"
> is an unnecessarily strong requirement. A PMD split is typically triggere=
d
> by a partial operation on a sub-PMD range =E2=80=94 partial munmap, parti=
al
> mprotect, partial mremap and so on.
> Most of these operations already have well-defined error handling for
> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
> fail and propagating the error through these existing paths is the natura=
l
> thing to do. Furthermore, split failing requires an order-0 allocation fo=
r
> a page table to fail, which is extremely unlikely.
>
> Designing functions like split_huge_pmd as operations that cannot fail
> has a subtle but real cost to code quality. It forces a pre-allocation
> pattern - every THP creation path must deposit a page table, and every
> split or zap path must withdraw one, creating a hidden coupling between
> widely separated code paths.
>
> This also serves as a code cleanup. On every architecture except powerpc
> with hash MMU, the deposit/withdraw machinery becomes dead code. The
> series removes the generic implementations in pgtable-generic.c and the
> s390/sparc overrides, replacing them with no-op stubs guarded by
> arch_needs_pgtable_deposit(), which evaluates to false at compile time
> on all non-powerpc architectures.

Hi Usama,

Thanks for tackling this, it seems like an interesting problem. Im
trying to get more into reviewing, so bare with me I may have some
stupid comments or questions. Where I can really help out is with
testing. I will build this for all RH-supported architectures and run
some automated test suites and performance metrics. I'll report back
if I spot anything.

Cheers!
-- Nico

>
> The series is structured as follows:
>
> Patches 1-2:    Error infrastructure =E2=80=94 make split functions retur=
n int
>                 and propagate errors from vma_adjust_trans_huge()
>                 through __split_vma, vma_shrink, and commit_merge.
>
> Patches 3-12:   Handle split failure at every call site =E2=80=94 copy_hu=
ge_pmd,
>                 do_huge_pmd_wp_page, zap_pmd_range, wp_huge_pmd,
>                 change_pmd_range (mprotect), follow_pmd_mask (GUP),
>                 walk_pmd_range (pagewalk), move_page_tables (mremap),
>                 move_pages (userfaultfd), and device migration.
>                 The code will become affective in Patch 14 when split
>                 functions start returning -ENOMEM.
>
> Patch 13:       Add __must_check to __split_huge_pmd(), split_huge_pmd()
>                 and split_huge_pmd_address() so the compiler warns on
>                 unchecked return values.
>
> Patch 14:       The actual change =E2=80=94 allocate PTE page tables lazi=
ly at
>                 split time instead of pre-depositing at THP creation.
>                 This is when split functions will actually start returnin=
g
>                 -ENOMEM.
>
> Patch 15:       Remove the now-dead deposit/withdraw code on
>                 non-powerpc architectures.
>
> Patch 16:       Add THP_SPLIT_PMD_FAILED vmstat counter for monitoring
>                 split failures.
>
> Patches 17-21:  Selftests covering partial munmap, mprotect, mlock,
>                 mremap, and MADV_DONTNEED on THPs to exercise the
>                 split paths.
>
> The error handling patches are placed before the lazy allocation patch so
> that every call site is already prepared to handle split failures before
> the failure mode is introduced. This makes each patch independently safe
> to apply and bisect through.
>
> The patches were tested with CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_DEBUG_V=
M
> enabled. The test results are below:
>
> TAP version 13
> 1..5
> # Starting 5 tests from 1 test cases.
> #  RUN           thp_pmd_split.partial_munmap ...
> # thp_pmd_split_test.c:60:partial_munmap:thp_split_pmd: 0 -> 1
> # thp_pmd_split_test.c:62:partial_munmap:thp_split_pmd_failed: 0 -> 0
> #            OK  thp_pmd_split.partial_munmap
> ok 1 thp_pmd_split.partial_munmap
> #  RUN           thp_pmd_split.partial_mprotect ...
> # thp_pmd_split_test.c:60:partial_mprotect:thp_split_pmd: 1 -> 2
> # thp_pmd_split_test.c:62:partial_mprotect:thp_split_pmd_failed: 0 -> 0
> #            OK  thp_pmd_split.partial_mprotect
> ok 2 thp_pmd_split.partial_mprotect
> #  RUN           thp_pmd_split.partial_mlock ...
> # thp_pmd_split_test.c:60:partial_mlock:thp_split_pmd: 2 -> 3
> # thp_pmd_split_test.c:62:partial_mlock:thp_split_pmd_failed: 0 -> 0
> #            OK  thp_pmd_split.partial_mlock
> ok 3 thp_pmd_split.partial_mlock
> #  RUN           thp_pmd_split.partial_mremap ...
> # thp_pmd_split_test.c:60:partial_mremap:thp_split_pmd: 3 -> 4
> # thp_pmd_split_test.c:62:partial_mremap:thp_split_pmd_failed: 0 -> 0
> #            OK  thp_pmd_split.partial_mremap
> ok 4 thp_pmd_split.partial_mremap
> #  RUN           thp_pmd_split.partial_madv_dontneed ...
> # thp_pmd_split_test.c:60:partial_madv_dontneed:thp_split_pmd: 4 -> 5
> # thp_pmd_split_test.c:62:partial_madv_dontneed:thp_split_pmd_failed: 0 -=
> 0
> #            OK  thp_pmd_split.partial_madv_dontneed
> ok 5 thp_pmd_split.partial_madv_dontneed
> # PASSED: 5 / 5 tests passed.
> # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> The patches are based off of 957a3fab8811b455420128ea5f41c51fd23eb6c7 fro=
m
> mm-unstable as of 25 Feb (7.0.0-rc1).
>
>
> RFC v1 -> v2: https://lore.kernel.org/all/20260211125507.4175026-1-usama.=
arif@linux.dev/
> - Change counter name to THP_SPLIT_PMD_FAILED (David)
> - remove pgtable_trans_huge_{deposit/withdraw} when not needed and
>   make them arch specific (David)
> - make split functions return error code and have callers handle them
>   (David and Kiryl)
> - Add test cases for splitting
>
> Usama Arif (21):
>   mm: thp: make split_huge_pmd functions return int for error
>     propagation
>   mm: thp: propagate split failure from vma_adjust_trans_huge()
>   mm: thp: handle split failure in copy_huge_pmd()
>   mm: thp: handle split failure in do_huge_pmd_wp_page()
>   mm: thp: handle split failure in zap_pmd_range()
>   mm: thp: handle split failure in wp_huge_pmd()
>   mm: thp: retry on split failure in change_pmd_range()
>   mm: thp: handle split failure in follow_pmd_mask()
>   mm: handle walk_page_range() failure from THP split
>   mm: thp: handle split failure in mremap move_page_tables()
>   mm: thp: handle split failure in userfaultfd move_pages()
>   mm: thp: handle split failure in device migration
>   mm: huge_mm: Make sure all split_huge_pmd calls are checked
>   mm: thp: allocate PTE page tables lazily at split time
>   mm: thp: remove pgtable_trans_huge_{deposit/withdraw} when not needed
>   mm: thp: add THP_SPLIT_PMD_FAILED counter
>   selftests/mm: add THP PMD split test infrastructure
>   selftests/mm: add partial_mprotect test for change_pmd_range
>   selftests/mm: add partial_mlock test
>   selftests/mm: add partial_mremap test for move_page_tables
>   selftests/mm: add madv_dontneed_partial test
>
>  arch/powerpc/include/asm/book3s/64/pgtable.h  |  12 +-
>  arch/s390/include/asm/pgtable.h               |   6 -
>  arch/s390/mm/pgtable.c                        |  41 ---
>  arch/sparc/include/asm/pgtable_64.h           |   6 -
>  arch/sparc/mm/tlb.c                           |  36 ---
>  include/linux/huge_mm.h                       |  51 +--
>  include/linux/pgtable.h                       |  16 +-
>  include/linux/vm_event_item.h                 |   1 +
>  mm/debug_vm_pgtable.c                         |   4 +-
>  mm/gup.c                                      |  10 +-
>  mm/huge_memory.c                              | 208 +++++++++----
>  mm/khugepaged.c                               |   7 +-
>  mm/memory.c                                   |  26 +-
>  mm/migrate_device.c                           |  33 +-
>  mm/mprotect.c                                 |  11 +-
>  mm/mremap.c                                   |   8 +-
>  mm/pagewalk.c                                 |   8 +-
>  mm/pgtable-generic.c                          |  32 --
>  mm/rmap.c                                     |  42 ++-
>  mm/userfaultfd.c                              |   8 +-
>  mm/vma.c                                      |  37 ++-
>  mm/vmstat.c                                   |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../testing/selftests/mm/thp_pmd_split_test.c | 290 ++++++++++++++++++
>  tools/testing/vma/include/stubs.h             |   9 +-
>  25 files changed, 645 insertions(+), 259 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/thp_pmd_split_test.c
>
> --
> 2.47.3
>

