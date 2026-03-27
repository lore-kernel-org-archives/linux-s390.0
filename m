Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98039FCD1;
	Fri, 27 Mar 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601501; cv=none; b=lKvpJjLfDguYF90wvzPH79ditEDfwYuasBHM7IB2jkb8Dof9MMb0d+IvBzG43HUnsMKqPcWUREuHWHkbTM475LaviYKRDgX06h5gPDdjFAKURreTTXatrqQPnTS7ALAW2okYWsKj3NRrg7o5waAa9TjkcO10QsoLtksXzSfRcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601501; c=relaxed/simple;
	bh=eRE737VkH0m4yUEmKC0eyuQyryfv48ciiTpcgZ2tUoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hznjt/qVVqUALko8FM930Cfe8Fk0Hlq/3puX3T7/FBXKRH77v0Z/OJNzd1Mt6iAeK2gc51TfbWEJMtguor++nQ0E8rIaEaVNZbZBVVrw34JETj6lFwmrE2ygj/Gtnff1EiJ5LEfBfYSdq28bIPqfnuiDsAvWsNl9LwlqiUp/CJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iugcoP8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iugcoP8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98038C19423;
	Fri, 27 Mar 2026 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774601501;
	bh=eRE737VkH0m4yUEmKC0eyuQyryfv48ciiTpcgZ2tUoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iugcoP8/1cKAEUYF4bMLyAPrdeYNSdV5JHyyBJw9hxFHOheqNs5SgUbQkgYbC0f+Y
	 I6cojohGRLgw4KkRGfCVlZiKY9LptTF1IQ/elRwh3jjigFDtgTw5fJAdMZqESarMwG
	 H35wsUQ4yHt47O6lDz7SZV9KJ0fDKHEg7q5f+rbISwJKHPpoMgtvfnbCWarZZMaeug
	 fJXn1r+qEbm8j0NQJ40AP68M19ZxhLSGF8yQVq8zvYnYOF285qfzu2GGbF4pUvQS/Q
	 z80B80Sc1McwwE3j/nwWprmtB3xlk4y3ipMSnJz/32/37mawf2OZ9g8Eg3F5xxkqif
	 tpF2dcp/ZgxWQ==
Message-ID: <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>
Date: Fri, 27 Mar 2026 09:51:31 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 willy@infradead.org, linux-mm@kvack.org
Cc: fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260327021403.214713-1-usama.arif@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/27/26 03:08, Usama Arif wrote:
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
> lazily — only when a PMD split actually happens. Since a large number
> of THPs are never split (they are zapped wholesale when processes exit or
> munmap the full range), the allocation is avoided entirely in the common
> case.
> 
> The pre-deposit pattern exists because split_huge_pmd was designed as an
> operation that must never fail: if the kernel decides to split, it needs
> a PTE page table, so one is deposited in advance. But "must never fail"
> is an unnecessarily strong requirement. A PMD split is typically triggered
> by a partial operation on a sub-PMD range — partial munmap, partial
> mprotect, COW on a pinned folio, GUP with FOLL_SPLIT_PMD, and similar.
> All of these operations already have well-defined error handling for
> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
> fail and propagating the error through these existing paths is the natural
> thing to do. Furthermore, if the system cannot satisfy a single order-0
> allocation for a page table, it is under extreme memory pressure and
> failing the operation is the correct response.
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
> 
> The series is structured as follows:
> 
> Patches 1-2:    Infrastructure — make split functions return int and
>                 propagate errors from vma_adjust_trans_huge() through
>                 __split_vma, vma_shrink, and commit_merge.
> 
> Patches 3-15:   Handle split failure at every call site — copy_huge_pmd,
>                 do_huge_pmd_wp_page, zap_pmd_range, wp_huge_pmd,
>                 change_pmd_range (mprotect), follow_pmd_mask (GUP),
>                 walk_pmd_range (pagewalk), move_page_tables (mremap),
>                 move_pages (userfaultfd), device migration,
>                 pagemap_scan_thp_entry (proc), powerpc subpage_prot,
>                 and dax_iomap_pmd_fault (DAX). The code will become
>                 effective in Patch 17 when split functions start
>                 returning -ENOMEM.
> 
> Patch 16:       Add __must_check to __split_huge_pmd(), split_huge_pmd()
>                 and split_huge_pmd_address() so the compiler warns on
>                 unchecked return values.
> 
> Patch 17:       The actual change — allocate PTE page tables lazily at
>                 split time instead of pre-depositing at THP creation.
>                 This is when split functions will actually start returning
>                 -ENOMEM.
> 
> Patch 18:       Remove the now-dead deposit/withdraw code on
>                 non-powerpc architectures.
> 
> Patch 19:       Add THP_SPLIT_PMD_FAILED vmstat counter for monitoring
>                 split failures.
> 
> Patches 20-24:  Selftests covering partial munmap, mprotect, mlock,
>                 mremap, and MADV_DONTNEED on THPs to exercise the
>                 split paths.
> 
> The error handling patches are placed before the lazy allocation patch so
> that every call site is already prepared to handle split failures before
> the failure mode is introduced. This makes each patch independently safe
> to apply and bisect through.
> 
> The patches were tested with CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_DEBUG_VM
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
> # thp_pmd_split_test.c:62:partial_madv_dontneed:thp_split_pmd_failed: 0 -> 0
> #            OK  thp_pmd_split.partial_madv_dontneed
> ok 5 thp_pmd_split.partial_madv_dontneed
> # PASSED: 5 / 5 tests passed.
> # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> The patches are based off of mm-unstable as of 25 Mar
> git hash: d6f51e38433489eb22cb65d1bf72ac7993c5bdec
> 
> RFC v2 -> v3: https://lore.kernel.org/all/de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev/

Note that we usually go from RFC to v1.

I'll put this series on my review backlog, but it will take some time
until I get to it (it won't make the next release either way :) ).

-- 
Cheers,

David
