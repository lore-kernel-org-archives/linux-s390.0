Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B431715C
	for <linux-s390@vger.kernel.org>; Sun, 22 Mar 2026 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774158195; cv=none; b=KGjmHknspCw2QHnueDzUeOjqz8MOSyZA5cEi9Fx3xi0HfTZsDTnW9Jbzf/Q17k/KSEUdiFQ/2KmqAwDMuj/7KaQS5nuFr4ZB/EIKwaQwLG9HbtQVh6J4iT4CBBqdt8c6uY/K8L2wsdoFPWrEbD4FWfv/iLCLXQNXl4Taj8nEsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774158195; c=relaxed/simple;
	bh=H2pKYJxeplG8EKq5UasYh+jeCq1I/c8uo099Tr1cCLM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vFuVeKEyV8coJS/WX+K4+RM65obcvf7UWLOEJRcyqyGAHlW56X7zCXWIDNwaur3Zvu75UYJ6EUTB2DOue12RxQ0VfIkt4+HSlAyUYMIPZurRp3Ym8OWaUiE6pZvAXrRjGMsRLDGSOW1CmRr8+D6co9YadzqgVB3+GRZwnAKCAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2KrpRuG; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2KrpRuG"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so2046772eec.0
        for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 22:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158193; x=1774762993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vcHDXdXeHcBh7JcXxd/NIeUk+f66988A9WXmJh1lMtA=;
        b=Q2KrpRuGS2Wg3Q4yG9Z8QLzFbsk4E08OTfbnL9TFCbu8sNB3W2T205rtKk5Y9l0EPE
         a5npfA4iBnQnFwhI+sYFdzmPmxtUlx828k4SRH0kuGDSQcl3Q3U+blqr22eku2nLosbK
         y4lIbvEHuKsudghdK+vR1XycBOTcA4U72HpCksUIzLR/A65Qu3D6RCfUJaIpKur8JAP+
         L5bFenOX657DB0KsiYCFwd3mPv+Mx1oj9vqcl6wAMUx1Gw9YbycwsDw/RJUYSxy0uQS0
         8REaazoLG89cUzYCMYB6/nmamunspiKzjGQ4872m3fe2Up3cMnt60FAEiUdmAiAzr/oZ
         xBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158193; x=1774762993;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcHDXdXeHcBh7JcXxd/NIeUk+f66988A9WXmJh1lMtA=;
        b=Jp/ZNp9dTXymiVcp7fIHWytC2GXNwrJAp/Q4ASeSdfEr5YU93jZY+xxPXiPrkKumDA
         9eWOkYSicTtcPYLuAW6Xnwidkb7HLLBoc66F+I8i5Wio+BQvDquPtnKoxOjmsxiWx1OT
         XU6JjcJMH0aD8jD0NtxQ6gr8Kln3Nt0wJ5pAGiou08aTzj6bcAo53/tcLmgRtbL3DeBf
         zgYzsN+tS5TKFXAjMBGXt3e/4ERGxAuzQEJ98P8xvRXNyj5m6Cv4mK2zkfeIlQooYSOx
         3UcM7Pomvv/UIdcC2uJ1+R179CHmydWiokKny6R4s2cNEyT07ekB29bGZhnVq64oNCzk
         79gw==
X-Forwarded-Encrypted: i=1; AJvYcCXRGfF00GGEs8VQRBB1X92XTqTwmlQ0pQaKm0rGnwaqqtUom9Oc+AOEbURbYFtlt9Yh1TDO49Fiz04J@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gnXoVMlL9DvxK+eGVAdkYuNjNcgBm3QXDFAEJdwfoHF4q54j
	jLItDeZ6PCgekqdkpRGD3Z4Yo2muVMCF9iYWlwKKp8YTVbjR7ELKoQ+s0cd4Z9Zqw6ypv0p5Rj3
	O8KehTA==
X-Received: from dly25-n1.prod.google.com ([2002:a05:701b:2059:10b0:12a:7703:c328])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:490:b0:12a:6a64:81ef
 with SMTP id a92af1059eb24-12a7267d891mr3739492c88.9.1774158192658; Sat, 21
 Mar 2026 22:43:12 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:04 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260322054309.898214-1-surenb@google.com>
Subject: [PATCH v4 0/4] Use killable vma write locking in most places
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
readable. The second patch contains most of the changes. The third patch
is a small error handling fixup. The last patch contains the changes
associated with process_vma_walk_lock() error handling.

Changes since v3 [1]:
- rebased over mm-unstable
- added Reviewed-by, per Liam R. Howlett and Lorenzo Stoakes
- moved locking before vma_iter_prealloc in vma_shrink and in vma_link,
per Liam R. Howlett
- added a separate jump label for vma lock failure case in do_brk_flags(),
per Liam R. Howlett
- fixed cpusset -> cpuset, per Lorenzo Stoakes
- added comments explaining vma_start_write moves, per Lorenzo Stoakes
- amended patch description with explanation why vma_start_write moves
are safe, per Lorenzo Stoakes
- added comments listing EINTR as a new possible error code,
per Lorenzo Stoakes
- moved comments in mlock_fixup() and apply_mlockall_flags() to more
appropriate places, per Lorenzo Stoakes
- replaced check for EINTR with fatal_signal_pending() with a comment why
it is safe, per Lorenzo Stoakes
- fixed error check in mprotect_fixup(), per Lorenzo Stoakes
- moved vma_start_write_killable() before allocations inside __split_vma()
with a clarifying comment
- changed mmap_region() to set err for each failing case,
per Lorenzo Stoakes
- changed label names in expand_upwards() and expand_downwards(),
per Lorenzo Stoakes
- changed "if (err < 0)" to "if (err)" for consistency,
per Lorenzo Stoakes
- separated error checking fix for s390 into its own patch,
per Lorenzo Stoakes
- removed special handling for EINTR, per Lorenzo Stoakes
- dropped changes trying to propagate EINTR during vma merge,
per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20260226070609.3072570-1-surenb@google.com/

Suren Baghdasaryan (4):
  mm/vma: cleanup error handling path in vma_expand()
  mm: replace vma_start_write() with vma_start_write_killable()
  KVM: s390: avoid kvm_s390_handle_pv() error overwrite
  mm: use vma_start_write_killable() in process_vma_walk_lock()

 arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
 arch/s390/kvm/kvm-s390.c           |   2 +
 fs/proc/task_mmu.c                 |   5 +-
 mm/khugepaged.c                    |   5 +-
 mm/madvise.c                       |   4 +-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  13 ++-
 mm/mlock.c                         |  28 ++++--
 mm/mprotect.c                      |   5 +-
 mm/mremap.c                        |   4 +-
 mm/pagewalk.c                      |  20 +++--
 mm/vma.c                           | 133 +++++++++++++++++++++--------
 mm/vma_exec.c                      |   6 +-
 13 files changed, 173 insertions(+), 59 deletions(-)


base-commit: 8c65073d94c8b7cc3170de31af38edc9f5d96f0e
-- 
2.53.0.1018.g2bb0e51243-goog

