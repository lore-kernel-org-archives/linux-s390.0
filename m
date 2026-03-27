Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230E3BADB5
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622090; cv=none; b=HGd49CgXujjzbw1FVGALM01NvJthGVBwRYfIEiqY/0c/D44vRkWV6HErHNZdom/C0kFsXFB3UQU31jPsAVbtq33jeMgPbCGEhZ4UdmrQNjmnZVyIaiZzSfo3FTxqpqlfb+fdc3YkO8Uab0+cdn5Eczt11/wVWRSiU+y1gj/wxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622090; c=relaxed/simple;
	bh=Iz/TReWp9gP0uJWCpmK+DDKJPT4AeIY0TGV49Ip5RdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRnRedlbPuFv+pUUGCCmdV9u4gClkvdhKaCX+fxlcKPHkEaOK3RD8FfHGVWSXAUXsrqjpL10KpVIgS2o+l65fQMLDvvUYfh2hJ5w9hJTQ2vj4w8YR7/DuH62DdWGShOZG4Sd8QeSKCRivY4msDLhZ4ebbCql8R2BpfhmNVeyNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ht24yVC3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ht24yVC3"
Message-ID: <9dcad942-8888-4b92-b445-c409ae490c03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774622076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RxlcroHX4swUzq/nWnXXiWfGa7xs/XFyF8fRtVw6wg=;
	b=Ht24yVC3pLp17e8idwEujSVYefmRd6nSPN9pv4Cv7PW9LbdCMNzEdxjN8/unn1G3jmzmPe
	140Zma49FWsDPlOi7joCdMgPDozMtDs0cQuuXPsZTyFMt3YLzHsn36Pm+6mwYgL0ZwjzWy
	NwGgmA4DHXFn2T8DW+pI1XvaMSBfw3s=
Date: Fri, 27 Mar 2026 10:34:30 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
Content-Language: en-GB
To: "David Hildenbrand (Arm)" <david@kernel.org>,
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
 <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 27/03/2026 11:51, David Hildenbrand (Arm) wrote:
> On 3/27/26 03:08, Usama Arif wrote:
>> When the kernel creates a PMD-level THP mapping for anonymous pages, it
>> pre-allocates a PTE page table via pgtable_trans_huge_deposit(). This
>> page table sits unused in a deposit list for the lifetime of the THP
>> mapping, only to be withdrawn when the PMD is split or zapped. Every
>> anonymous THP therefore wastes 4KB of memory unconditionally. On large
>> servers where hundreds of gigabytes of memory are mapped as THPs, this
>> adds up: roughly 200MB wasted per 100GB of THP memory. This memory
>> could otherwise satisfy other allocations, including the very PTE page
>> table allocations needed when splits eventually occur.
>>
>> This series removes the pre-deposit and allocates the PTE page table
>> lazily — only when a PMD split actually happens. Since a large number
>> of THPs are never split (they are zapped wholesale when processes exit or
>> munmap the full range), the allocation is avoided entirely in the common
>> case.
>>
>> The pre-deposit pattern exists because split_huge_pmd was designed as an
>> operation that must never fail: if the kernel decides to split, it needs
>> a PTE page table, so one is deposited in advance. But "must never fail"
>> is an unnecessarily strong requirement. A PMD split is typically triggered
>> by a partial operation on a sub-PMD range — partial munmap, partial
>> mprotect, COW on a pinned folio, GUP with FOLL_SPLIT_PMD, and similar.
>> All of these operations already have well-defined error handling for
>> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
>> fail and propagating the error through these existing paths is the natural
>> thing to do. Furthermore, if the system cannot satisfy a single order-0
>> allocation for a page table, it is under extreme memory pressure and
>> failing the operation is the correct response.
>>
>> Designing functions like split_huge_pmd as operations that cannot fail
>> has a subtle but real cost to code quality. It forces a pre-allocation
>> pattern - every THP creation path must deposit a page table, and every
>> split or zap path must withdraw one, creating a hidden coupling between
>> widely separated code paths.
>>
>> This also serves as a code cleanup. On every architecture except powerpc
>> with hash MMU, the deposit/withdraw machinery becomes dead code. The
>> series removes the generic implementations in pgtable-generic.c and the
>> s390/sparc overrides, replacing them with no-op stubs guarded by
>> arch_needs_pgtable_deposit(), which evaluates to false at compile time
>> on all non-powerpc architectures.
>>
>> The series is structured as follows:
>>
>> Patches 1-2:    Infrastructure — make split functions return int and
>>                 propagate errors from vma_adjust_trans_huge() through
>>                 __split_vma, vma_shrink, and commit_merge.
>>
>> Patches 3-15:   Handle split failure at every call site — copy_huge_pmd,
>>                 do_huge_pmd_wp_page, zap_pmd_range, wp_huge_pmd,
>>                 change_pmd_range (mprotect), follow_pmd_mask (GUP),
>>                 walk_pmd_range (pagewalk), move_page_tables (mremap),
>>                 move_pages (userfaultfd), device migration,
>>                 pagemap_scan_thp_entry (proc), powerpc subpage_prot,
>>                 and dax_iomap_pmd_fault (DAX). The code will become
>>                 effective in Patch 17 when split functions start
>>                 returning -ENOMEM.
>>
>> Patch 16:       Add __must_check to __split_huge_pmd(), split_huge_pmd()
>>                 and split_huge_pmd_address() so the compiler warns on
>>                 unchecked return values.
>>
>> Patch 17:       The actual change — allocate PTE page tables lazily at
>>                 split time instead of pre-depositing at THP creation.
>>                 This is when split functions will actually start returning
>>                 -ENOMEM.
>>
>> Patch 18:       Remove the now-dead deposit/withdraw code on
>>                 non-powerpc architectures.
>>
>> Patch 19:       Add THP_SPLIT_PMD_FAILED vmstat counter for monitoring
>>                 split failures.
>>
>> Patches 20-24:  Selftests covering partial munmap, mprotect, mlock,
>>                 mremap, and MADV_DONTNEED on THPs to exercise the
>>                 split paths.
>>
>> The error handling patches are placed before the lazy allocation patch so
>> that every call site is already prepared to handle split failures before
>> the failure mode is introduced. This makes each patch independently safe
>> to apply and bisect through.
>>
>> The patches were tested with CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_DEBUG_VM
>> enabled. The test results are below:
>>
>> TAP version 13
>> 1..5
>> # Starting 5 tests from 1 test cases.
>> #  RUN           thp_pmd_split.partial_munmap ...
>> # thp_pmd_split_test.c:60:partial_munmap:thp_split_pmd: 0 -> 1
>> # thp_pmd_split_test.c:62:partial_munmap:thp_split_pmd_failed: 0 -> 0
>> #            OK  thp_pmd_split.partial_munmap
>> ok 1 thp_pmd_split.partial_munmap
>> #  RUN           thp_pmd_split.partial_mprotect ...
>> # thp_pmd_split_test.c:60:partial_mprotect:thp_split_pmd: 1 -> 2
>> # thp_pmd_split_test.c:62:partial_mprotect:thp_split_pmd_failed: 0 -> 0
>> #            OK  thp_pmd_split.partial_mprotect
>> ok 2 thp_pmd_split.partial_mprotect
>> #  RUN           thp_pmd_split.partial_mlock ...
>> # thp_pmd_split_test.c:60:partial_mlock:thp_split_pmd: 2 -> 3
>> # thp_pmd_split_test.c:62:partial_mlock:thp_split_pmd_failed: 0 -> 0
>> #            OK  thp_pmd_split.partial_mlock
>> ok 3 thp_pmd_split.partial_mlock
>> #  RUN           thp_pmd_split.partial_mremap ...
>> # thp_pmd_split_test.c:60:partial_mremap:thp_split_pmd: 3 -> 4
>> # thp_pmd_split_test.c:62:partial_mremap:thp_split_pmd_failed: 0 -> 0
>> #            OK  thp_pmd_split.partial_mremap
>> ok 4 thp_pmd_split.partial_mremap
>> #  RUN           thp_pmd_split.partial_madv_dontneed ...
>> # thp_pmd_split_test.c:60:partial_madv_dontneed:thp_split_pmd: 4 -> 5
>> # thp_pmd_split_test.c:62:partial_madv_dontneed:thp_split_pmd_failed: 0 -> 0
>> #            OK  thp_pmd_split.partial_madv_dontneed
>> ok 5 thp_pmd_split.partial_madv_dontneed
>> # PASSED: 5 / 5 tests passed.
>> # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>> The patches are based off of mm-unstable as of 25 Mar
>> git hash: d6f51e38433489eb22cb65d1bf72ac7993c5bdec
>>
>> RFC v2 -> v3: https://lore.kernel.org/all/de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev/
> 
> Note that we usually go from RFC to v1.

ack.

> 
> I'll put this series on my review backlog, but it will take some time
> until I get to it (it won't make the next release either way :) ).
> 

No worries and Thanks!

