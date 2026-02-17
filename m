Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4036EAAB
	for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345975; cv=none; b=kjgaWcKFwomURAtmOc6IW+3pJxuM5HRMYlMtCDASClNKdkfONxo3elXd0PPzEDPwB8hOM/B8nqVY9V0roiT9pJHYUQGjHzeKD/LKuS53roWy4T2ngT8UY4PRYQAv195jLUwqv0tvTEGYaQK2asSoLRVykmre047t+qN7QYq6cx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345975; c=relaxed/simple;
	bh=HAnMN+TsnixmoToA8UrLxfl2Tg4SZY6PvAOYZzLEnE8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AGtvz34OvDzX7AfuTcy2y7cij7FbLPIJIREfSg/0IyLopWA/w3ugpoUN+K7zMkOb1O5A2h5AFjyyfXe054fiL61fNj7og0pES7jKRJuDTcOf0pMMeE35V6P2baPkr3O8MBcmkHrbTUpToyC7lPLuOTid61jZO6MffOmagS02VyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1RMK4M9; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1RMK4M9"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1273665df8fso7149275c88.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 08:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771345974; x=1771950774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJd/jsI1Ahr6ZvCTFiQFd3QULQDNn4kGH1XUoRnqvFw=;
        b=D1RMK4M9j0ahrRfLk2h5yB4TJB+vxxqxZgRoIjhJNg5DtLFELrpBeJmYxnixAOLNzv
         K/6ARGGXHuTsQZtBmw7CX3bqKrEygcmPLqCfLPAhEtahj44muXGoPih7Qs6z5nmL/80p
         sNJ/37TY4yWSlI26dzMVpvFD/cqWENHePyS7uwzvpatV7UBLZXqlfUtrRf6wRpiLhazF
         Y2VDBvVfQbWb71eFU7VHvAKsbrAuvjs0dNZ3+jvYyCexduEX3JF8vyQPZz1IWfNrRwP/
         c2vU//jIwQoyFXxym18yML0umCC/R6HpJE60cL+JKFYF8QAfba9m43zT/JHNvrJighFZ
         LXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771345974; x=1771950774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJd/jsI1Ahr6ZvCTFiQFd3QULQDNn4kGH1XUoRnqvFw=;
        b=ulGwpfXVHQ7hV4eiopKN42kSczxFqReVEQ6YYGdfARXF2SKqD6dajdmqMdrbpmwJRK
         /7m8Zr2NOE0wd4oOxCEKrEYtLaZrJbJMX0VGu7A0omARD7s+Q35kHtclCXbcyTy8nTC6
         65t4l/xjyTrDIm9E5NtJ8lcNcsmKQlvxz8HaulfUee+28Pk8eZlAGUH0yDnbh5EW3Zyr
         AVBAyvJsjz2BNN1h0w4s10cBCnVyPw4CX07qs8SolbPaDYW1yobcRXsjEHFrRC71t8Qh
         MC623Hntznw1OCDax3KxTr650P2qnA9OXT9eGlQ/VmmDvtHeRD4NiqhpR0WhyygpgWpX
         Ysow==
X-Forwarded-Encrypted: i=1; AJvYcCW+vbiS1MXvggefx5wu+a8k7HxDbmTln5JqvVcf4/dvYuvYTsLT0+aaVRh1lgyHR2HerZU3HSQ009GD@vger.kernel.org
X-Gm-Message-State: AOJu0YzLd+lA/jw5ynhssJ/eF5AZJdOM0oVBBs7cqu2r+sLWdfV9+cmS
	wN7vp3urCSg4iimkFIBaWHMEEnUryKg0V405CLv/X8Rjln1fNUXDo3Icj8kCySc5TU7v+jeuJa+
	JX9GWQw==
X-Received: from dlbur9.prod.google.com ([2002:a05:7022:ea49:b0:127:e77:9377])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b9f:b0:123:3488:899c
 with SMTP id a92af1059eb24-1273ae56e4dmr5617423c88.40.1771345973444; Tue, 17
 Feb 2026 08:32:53 -0800 (PST)
Date: Tue, 17 Feb 2026 08:32:47 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260217163250.2326001-1-surenb@google.com>
Subject: [PATCH v2 0/3] Use killable vma write locking in most places
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

3. vm_flags_{set|mod|clear} require refactoring that involves moving
vma_start_write() out of these functions and replacing it with
vma_assert_write_locked(), then callers of these functions should
lock the vma themselves using vma_start_write_killable() whenever
possible.

A cleanup patch is added in the beginning to make later changes more
readable. The second patch contains most of the changes and the last
patch contains the changes associated with process_vma_walk_lock()
error handling.

Changes since v1 [1]:
- Moved vma_start_write_killable() inside set_mempolicy_home_node()
to be done before mpol_dup(new), per Jann Horn
- Added error propagation for the missing PGWALK_WRLOCK users and
split it into a separate patch, per Jann Horn
- Moved vma_start_write_killable() inside __split_vma() to be done
before new->vm_ops->open(), per Jann Horn
- Added a separate patch to change flow control in vma_expand(),
per Jann Horn
- Brought back signal_pending() in mm_take_all_locks, per Jann Horn
- Moved vma_start_write_killable() inside __mmap_new_vma() to be done
before __mmap_new_file_vma(), per Jann Horn
- Added Reviewed-by for powerpc, per Ritesh Harjani
- Added s390 reviewers and the list due to changes in the last patch

[1] https://lore.kernel.org/all/20260209220849.2126486-1-surenb@google.com/

Suren Baghdasaryan (3):
  mm/vma: cleanup error handling path in vma_expand()
  mm: replace vma_start_write() with vma_start_write_killable()
  mm: use vma_start_write_killable() in process_vma_walk_lock()

 arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
 arch/s390/kvm/kvm-s390.c           |   5 +-
 arch/s390/mm/gmap.c                |  13 +++-
 fs/proc/task_mmu.c                 |   7 +-
 include/linux/mempolicy.h          |   5 +-
 mm/khugepaged.c                    |   5 +-
 mm/madvise.c                       |   4 +-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  23 +++++--
 mm/mlock.c                         |  20 ++++--
 mm/mprotect.c                      |   4 +-
 mm/mremap.c                        |   4 +-
 mm/pagewalk.c                      |  20 ++++--
 mm/vma.c                           | 105 ++++++++++++++++++++---------
 mm/vma_exec.c                      |   6 +-
 15 files changed, 164 insertions(+), 64 deletions(-)


base-commit: b08472d036a36893ecf68296d87beb58d21f4357
-- 
2.53.0.273.g2a3d683680-goog

