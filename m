Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81614198E91
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512523; cv=none; b=Bm3QwZxNOkMQExowmlE9or8E5l5W1zABuWsDJKpDAk/yCcWPGJvuHM/RPNntqvO5odkGsv5BhwNDM3wAPDvZDAO+EfCmyGQBuKc5JNL2I4Ne1waPgbfiV/YYLDPZdbZXScRhLm7h2ygkK/FIhnfu77IXzGtrUkeIP3HjAJwvvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512523; c=relaxed/simple;
	bh=SQd+VZ4O0rynu6+m7mKKooZvOWskGbg2FcoyS/3PQF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c/glz2rpADFk0RBfFQWqY61cv0DoYby7NwXryV+E0GPPU/5I0ohMkS9grxWMYNOZWHYvO4OI3btK55GZBMB6VJu3MAHt2S1Wf71tA5Wt6fZ5kbrGH9mhi1OUyOJ1+a4QbNN9lrxUMZOs7ggDdR6+r/PHDUFtI8aLkfvRv/cmkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dopI5plG; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dopI5plG"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1279caef718so663657c88.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512522; x=1775117322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DpXsG0Sw3JfIN9g3oAH6M8VS1bS1PNOXhE36FO51Iqg=;
        b=dopI5plGcQ8Qp5CnnfOCorbuBwu4UYlMRaGr7zwI2yiBqVEV72CBa56RIBGjwbbVjr
         abw6KGEnbaKAdvA7AxiH3y1rbav0EHZCp1VQ+T7MTaW1HeyeQJxjje/BQ9Np/GmMKOlO
         2tRpgibyyi3I1D0T6IBOu/f0Mil3A0rNziTwEcZVLm9F+ZoFC64C9egBkGt3CfTQWqNy
         MQaZURAEcuA/IhGW6fA4Kw2CK53/JvZ9Ux4Tsepp33XMSJwdcZ+5CyW5JzUiKEKT/9gv
         lVeZDJxWePqgxrHXJAfr8ukWFfq6FLYD1aR6r/dEnriHkfHaUMjsJeX8yxfD+kEla5Dh
         Dwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512522; x=1775117322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpXsG0Sw3JfIN9g3oAH6M8VS1bS1PNOXhE36FO51Iqg=;
        b=FeSX6hjgvC+/F//hVUODHB1k30/BGsQeFcODnTnMxSDnpYs+EJ23DlEM2x3JaGn8tK
         27wTDb3KL9ea9lN2jPtHslxvjXhpJBxNga8mo03LVcK8WmpgwLwvEFkjPrUfsRQm9oC2
         BePlsqKa6WFC7C/RNr6w10LERyml0slLqoFYIiWqE1qn41QaQ6/2D6M5ZNN6UW7sgBiF
         jNx7RG0h4+U6OwoEprccMn1vAlUnR6bZBdFjcVrHiUKEwOe1c7gBoBp3dK5KVcpz8TIi
         Uxq1JJTFO+wSqO3tDBPljwzmC3VH3YVBd8/DyoWwau5B8Rr8Fm6v9BQogx6Y/cthE7ME
         5vmw==
X-Forwarded-Encrypted: i=1; AJvYcCUoad2dtPln7B0Mr/Wu11DtrhoXcwHAM0EkcmKiwz2jRaKXQZZdOwTFVKPTHOwl3WvgHQxZI1/iDa1g@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhgSsjquHydfCguV6DRm5yFtQrLtaQKp7Ps8X9G3AgoLMp9DE
	b0P5PNK3oIXRn3F3R4oWKgiZNNvS9hZblqOzubyb0jBbCu1I/N56w4EWTHUMownh+KxNF3IWYE0
	WYC1mEw==
X-Received: from dlbuy10.prod.google.com ([2002:a05:7022:1e0a:b0:12a:6d14:dfd9])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eac3:b0:11b:b622:cad9
 with SMTP id a92af1059eb24-12a96eceb8emr2826837c88.21.1774512521385; Thu, 26
 Mar 2026 01:08:41 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:30 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-1-surenb@google.com>
Subject: [PATCH v5 0/6] Use killable vma write locking in most places
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

Changes since v4 [1]:
- added Reviewed-by, per Barry Song and Lorenzo Stoakes (wherever the code
stayed the same)
- split patch 2 into 3 parts, per Lorenzo Stoakes
- converted vma_start_write() in mseal_apply(), per Sashiko
- changed vma_start_write_killable() error handling in
set_mempolicy_home_node(), per Lorenzo Stoakes
- added comment why mm->locked_vm is fine even when we exit early,
per Sashiko
- moved vma locking before vrm_calc_charge() in move_vma(), per Sashiko
and Lorenzo Stoakes
- set give_up_on_oom on error in vma_merge_existing_range() to propagate
the error, per Lorenzo Stoakes
- moved validate_mm() out of the error path in expand_upwards(),
per Lorenzo Stoakes
- dropped the patch changing S390 error handling, per Sashiko and
Lorenzo Stoakes
- reworked error handling in clear_refs_write(), per Lorenzo Stoakes
- uninlined process_vma_walk_lock() while changing its return type,
per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20260322054309.898214-1-surenb@google.com/

Suren Baghdasaryan (6):
  mm/vma: cleanup error handling path in vma_expand()
  mm: use vma_start_write_killable() in mm syscalls
  mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
  mm/vma: use vma_start_write_killable() in vma operations
  mm: use vma_start_write_killable() in process_vma_walk_lock()
  KVM: PPC: use vma_start_write_killable() in
    kvmppc_memslot_page_merge()

 arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
 fs/proc/task_mmu.c                 |  12 +--
 mm/khugepaged.c                    |   5 +-
 mm/madvise.c                       |   4 +-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  12 ++-
 mm/mlock.c                         |  28 ++++--
 mm/mprotect.c                      |   5 +-
 mm/mremap.c                        |   8 +-
 mm/mseal.c                         |   5 +-
 mm/pagewalk.c                      |  22 +++--
 mm/vma.c                           | 146 +++++++++++++++++++++--------
 mm/vma_exec.c                      |   6 +-
 13 files changed, 190 insertions(+), 70 deletions(-)


base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
-- 
2.53.0.1018.g2bb0e51243-goog

