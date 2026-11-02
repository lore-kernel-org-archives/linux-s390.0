Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625890;
	b=bDFu5SuxEXR3HzEkVoCCZbpq60StK5kpZ5dFpyA5G5jdIcktfGhOvzNyhyuiRSGQnEM7
	 U1pCujLeao1+avfMHvcSEqhuEFzyodBOgw+6Th46t28FGVfoc3ct7l2QoiQIgCmV5sPXw
	 pfZi/Va7/Hyb18Vy63OqWN2DiyPRnYrLIXPjCF+VCj6qKzLFhDk2T3s5CpfbODAh6ktGs
	 rJGFL8VMrX3X/bVDvmeRYSK3SM4993OYfqJeGkr9oxPinjfqhcq3ySb63JZyLmSqkK3RT
	 hVAnrMcoqfubjhsTGBt9r3b2dRh6koS2By5HApBsfQPIXlr96dkC+hpf4ObnhizLehA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625890;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PFdEbpMzyrUyOoAPQkPaKowKrJxy58xu6akDhFUV31U=;
	b=HTkjjVgqEJJp9VxvZVETi1hoXJrNpKF7gC9SsWGoU2sGPFZfHFIM7HXoQvdveiQZ8KVf
	 XwBUoFK6Tlu7sJOi13T9ODAI10LCPPsM3Q5MUvxeT37v3mEe/qK0AlrRGhx+KIs5RBX1s
	 4owOA23Efe+9OTBr80nkdv5I5QLm8r7xn3UTiAvQmDXUkuQyXQ7KAMoJLgRJygXDpF4e0
	 6tnulQuOV5C49CM/UfpJUPrhD5Ham7evJaUA3cVIbhbnTYNLNbsBRO8BipAf1Jy3SI/Wf
	 MCFnoS6byhglyAMxAe+uy526bf/Sh6ATD0C7o0h9DvNpmg5q4hc3WF3/OkVSC++lE6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tsNHEGy7;
	arc=none smtp.remote-ip=91.218.175.124
Received: from mta0.migadu.com (out-124.mta0.migadu.com [91.218.175.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA55606A324
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 13:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA55606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tsNHEGy7
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=14eoNhxcSXoUqAVClMXRlOVC5qS0wm1dHShObxBrvnQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793625887; v=1; x=1794230687;
 b=tsNHEGy7YD1vRjByHNMbZlh/7ScUbsxdjblYaunIdvljJ6gzjao+9sPt3JrebH474B7/8107
 O8uSIYUzGokSi0V5mqDQJ1yEsciYSGOPnfUdkFHJVgGqjCKrgnoIuN40ZGq3W2jvq04wMrSPhW4
 rlTx/Wpy2KxCLLYebDEt5C1s=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 19717573b0124653;
	Mon, 02 Nov 2026 13:24:47 +0000
X-Mizu-Trace-ID: 19717573b0124653
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	riel@surriel.com,
	harry@kernel.org,
	jannh@google.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/4] mm/ksm: use per-VMA locking to reduce mmap_lock contention
Date: Mon,  2 Nov 2026 21:24:16 +0800
Message-Id: <20261102132416.300084-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Xin <xu.xin@linux.dev>

KSM scans VM_MERGEABLE VMAs and currently protects each scan with
mmap_read_lock(). Per-VMA locking allows KSM to read-lock only the VMA
it is actually interested in, so that unrelated mmap()/munmap() activity
in the same mm no longer blocks ksmd.

This series is organized as follows:

  Patch 1 removes an unused 'vma' member from struct folio_walk.  It has
  never been used since its introduction and is pure cleanup.

  Patch 2 adds a 'walk_lock' member to struct folio_walk and extends
  folio_walk_start() to assert the required locking mode.  Existing
  callers are converted to pass PGWALK_RDLOCK, so there is no functional
  change.  This prepares folio_walk_start() for callers that hold a
  per-VMA read lock instead of mmap_read_lock(), which is needed by the
  Patch 4. No functional change.

  Patch 3 replaces the boolean 'lock_vma' argument of break_ksm() with a
  KSM-local enum ksm_walk_lock and builds the mm_walk_ops on the stack,
  so the function-pointer table stays const and there is no shared
  mutable state.  No functional change.

  Patch 4 introduces find_mergeable_vma_locked(), which uses the
  universal per-VMA locking helper vma_start_read_unlocked() to look up
  and read-lock a VM_MERGEABLE VMA without taking mmap_read_lock().  All
  KSM call sites that previously used find_mergeable_vma() under
  mmap_read_lock() are converted to the new helper, and the locking in
  get_mergeable_page() is switched to PGWALK_VMA_RDLOCK_VERIFY so that
  folio_walk_start() can verify the per-VMA lock is held.  Because ksmd
  no longer holds mmap_read_lock() while walking, __ksm_exit() must also
  write-lock every VMA (in addition to mmap_write_lock()) to keep
  serializing against an in-flight ksmd walk before the page tables are
  freed.

A microbenchmark was run to measure the time KSM takes to merge a
victim region under mmap_lock contention. Under interference from 4 churner
threads, the merge time of the per-VMA KSM-optimized kernel is
significantly reduced by 50%.

Changelog:
  v2:
  - Patch 1: rewrote the commit message to explain the introducing
    commit, how the VMA is actually used, and the audit performed;
    dropped the Fixes: tag.

  - Patch 3: 
    * replaced the boolean 'lock_vma' with a KSM-local enum
    ksm_walk_lock instead of exposing the internal enum page_walk_lock
    as a parameter;
    * build the mm_walk_ops on the stack rather than
    mutating a global struct, so the function-pointer table stays const
    and there is no shared mutable state; rewrote the commit message.

  - Patch 4:
    * Fixed a per-VMA read-lock leak in find_mergeable_vma_locked()
    when the VMA is not mergeable;
    made __ksm_exit() write-lock every VMA (vma_start_write()) in
    addition to mmap_write_lock(), so that it still serializes against a
    ksmd walk that holds only a per-VMA read lock.

Xu Xin (4):
  mm/pagewalk: delete the unused member
  mm: make folio_walk_start()'s locking asserts scalable
  mm/ksm: make break_ksm() more scalable
  ksm: add find_mergeable_vma_locked() to use per-VMA locking

 arch/s390/mm/fault.c     |   4 +-
 include/linux/pagewalk.h |   2 +-
 kernel/events/uprobes.c  |   4 +-
 mm/huge_memory.c         |   4 +-
 mm/ksm.c                 | 124 +++++++++++++++++++++++++++------------
 mm/migrate.c             |   8 ++-
 mm/pagewalk.c            |  10 +++-
 mm/rmap.c                |   4 +-
 8 files changed, 116 insertions(+), 44 deletions(-)

--
2.34.1

