Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4D38E10D
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089575; cv=none; b=mZD+88EiQ3wylfC7agtOcFeGHaZIV9I78gatkZnsU1h7WulAcyM77gi200JeAhDv2up0iXZuMEOICveIMjw/vglsr6suQLF4lPnELsnXGMu/pHbIgZ7bjErZhHg0bl9p58pZz6uNZY51YmE3WP2mSaLtdorxiyvSBtN1f9d0exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089575; c=relaxed/simple;
	bh=1R7msjHSmTG/2uO3oYIInFkTi1ERP76I/8NVV+UDL1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ifN2UxvTJs59yiknS+tE3YVXIpvYtJ6jC6+tC+PkYmush/X9yUxLCoTFQOfiTdh26pUaK58Bt/BnWf9OKBg70CiuBlFDyQLX1iqdI8EhI2vo7VSo4Pem5W29CUHsGtjGd+67E8i7dGuMZMcBuPmzaqdTnGnwUpeopSqmgSXkhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLwr0cXP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLwr0cXP"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bd3bf5dde4so516852eec.1
        for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772089573; x=1772694373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vucVmOFSxssu4W4+hD04IB0isnzzlwVXoGbpC2l+3Iw=;
        b=GLwr0cXP1leI0GVWJ9lNk52GfIww9JL+A1Vf17tmO+w5fbnDGQiT6Sakg/rHF4qDjo
         Cenbny35Z57pU54e9/QWmygik3ul/ayGty7TqwUWBkfMhw5x2iq48EuHsSteg1Z1IaSd
         x/ISsXuNwaqE2eLbu0fmKPi7pHDKlvhjRwgIFPBtN6qrSyQFPUNUaMNMZHwgnpx2C//j
         VT0zZCXIyMR/470tRdXuDUvmEN63ZzmgEOHiJsDuMDfwYPVJVmwZukQgv/HAEtMDbXHS
         TY1pxffp4aGNr/v0albCqjsIwjyqz4/EXvc8+iHVl1ZgkvMPAummF4Iu/JwpcqttvNTP
         STwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089573; x=1772694373;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vucVmOFSxssu4W4+hD04IB0isnzzlwVXoGbpC2l+3Iw=;
        b=kVmykftMQXq9igGtjByBWdCThN0cFOBqOiv28uOFliu8aRBKlxo2jLrZq0DFLUMSai
         py2GWPtao3jO6gGEBNgAd2cH+XN4kzF9RbUw3IeYbcPkwe8nANOEjURK3Cx5CRdruQ07
         xUyKVsR7NnFeicuZRhBH1vD2ybbQB7mMPKTwdcEIUKUOawpms7qXbXzoC80RdTr8USuL
         QpHo0Qw2AjdpvFnz575VyaF/VvtnznPDn8nETdT5Go/0H29+ByUeiS9a3wVTnUdyOZmW
         /T7W9SYP0B0fHDw4FcEwfiTq34HdDUhG5Fs7dyfXtyHG31n1T/ANb1BwURvrVQONzfFm
         1gsw==
X-Forwarded-Encrypted: i=1; AJvYcCWIMPHWq+g8X3WJfcwVsaPctnwTka/Ync5iQcfOz/FDdpIssMZ94nJK1k4PKQ9ZkoUaxMqMWCxMh7x2@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGwhExOq2lT1sRWCnvNrcjl+Cv6VLnTkYkzaD62Guo/SLjKBI
	v9p69qykPMYoKoTHzQnTrmK/dFTeowycyxPN5vEn4LvXBfaqEwTOc8hUQEkhPQbwMVFz5EtDgsV
	ffAfOAQ==
X-Received: from dlam21-n1.prod.google.com ([2002:a05:701b:2095:10b0:127:89b6:8d2a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60aa:b0:127:3b16:bf4f
 with SMTP id a92af1059eb24-127869c9ac6mr1332481c88.40.1772089573227; Wed, 25
 Feb 2026 23:06:13 -0800 (PST)
Date: Wed, 25 Feb 2026 23:06:06 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226070609.3072570-1-surenb@google.com>
Subject: [PATCH v3 0/3] Use killable vma write locking in most places
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Now that we have vma_start_write_killable() we can replace most of the
vma_start_write() calls with it, improving reaction time to the kill
signal.

There are several places which are left untouched by this patchset:

1. free_pgtables() because function should free page tables even if a
fatal signal is pending.

2. userfaultd code, where some paths calling vma_start_write() can
handle EINTR and some can't without a deeper code refactoring.

3. mpol_rebind_mm() which is used by cpusset controller for migrations
and operates on a remote mm. Incomplete operations here would result
in an inconsistent cgroup state.

4. vm_flags_{set|mod|clear} require refactoring that involves moving
vma_start_write() out of these functions and replacing it with
vma_assert_write_locked(), then callers of these functions should
lock the vma themselves using vma_start_write_killable() whenever
possible.

A cleanup patch is added in the beginning to make later changes more
readable. The second patch contains most of the changes and the last
patch contains the changes associated with process_vma_walk_lock()
error handling.

Changes since v2 [1]:
- rebased over mm-unstable, per Matthew Wilcox;
- removed mpol_rebind_mm() changes since the function operates on a
remote mm and incomplete operation can leave unrelated process in an
inconsistent state;
- moved vma_start_write_killable() inside set_mempolicy_home_node() to
avoid locking extra vmas, per Liam R. Howlett
- moved vma_start_write_killable() inside __mmap_new_vma() to lock the
vma right after it's allocation, per Liam R. Howlett
- introduced VMA_MERGE_ERROR_INTR to add EINTR handling for vma_modify()
- changed do_mbind() error handling for avoid EINTR overrides;
- changed migrate_to_node() error handling for avoid EINTR overrides;
- added EINTR handling in queue_pages_range();
- fixed clear_refs_write() error handling which previous verstion broke
by skipping some of the cleanup logic;

[1] https://lore.kernel.org/all/20260217163250.2326001-1-surenb@google.com/

Suren Baghdasaryan (3):
  mm/vma: cleanup error handling path in vma_expand()
  mm: replace vma_start_write() with vma_start_write_killable()
  mm: use vma_start_write_killable() in process_vma_walk_lock()

 arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
 arch/s390/kvm/kvm-s390.c           |   2 +-
 fs/proc/task_mmu.c                 |   5 +-
 mm/khugepaged.c                    |   5 +-
 mm/madvise.c                       |   4 +-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  22 +++--
 mm/mlock.c                         |  21 +++--
 mm/mprotect.c                      |   4 +-
 mm/mremap.c                        |   4 +-
 mm/pagewalk.c                      |  20 +++--
 mm/vma.c                           | 127 ++++++++++++++++++++---------
 mm/vma.h                           |   6 ++
 mm/vma_exec.c                      |   6 +-
 14 files changed, 167 insertions(+), 66 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.53.0.414.gf7e9f6c205-goog

