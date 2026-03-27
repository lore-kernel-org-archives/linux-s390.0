Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69938A73B
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644904; cv=none; b=q+LtPdDePNVUFNEWeCtzZM39RFizMb9CVERp1CUzXhQQX9beByk+C4DRSB+rUZx0gzKcLO0NeYngejhkziZZxvpnPSM/urTd+HnT3xhfbABP/U2Magjw5uLi0SWc5uo5iXYrByBq90wiJ6maqmZoQhHFC/u0flsGLYJhNoh1mOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644904; c=relaxed/simple;
	bh=bLDW7ocpivdedUtMlS9+zeEC0kBNj+LNYBRecq2aDkk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=inlK1GpYcnI8UjYGSkfAko3t3CqCa1KoUypjLKru04sKQ2sQ9sNAmzHFEwPmb7qGYheFX1WO/Nvp9/cAeIJkKnUlL7VEJgZsMCoOjZCqUU4Sw2HPVai3YBg+Frpg6AvI/BUQ+GOO/UjORQqgscKMJLYxJLfZ7eGY2ycn0TBfolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIgeL0+3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIgeL0+3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so5482212eec.1
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644902; x=1775249702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdmn94fDq5EabxgUHdZFE1PchWB5l0Hn00gGljt6mxc=;
        b=tIgeL0+3usm0cBbuJlPEDE1DR5GtwuekkqKyZFz6t64WPMm4kmKq77RNOI0HPZI7n1
         yLypwOV+Or4awm7rubp2H2kfDjaTcn1w/7XBzwknyj7u1RAzbTqUNim6pmFb8EA2Yj2G
         v1k9x3pGEy+8s6Qlj5yocVfombWrFpit7xxBpcSSbjSMTmDBw/BQjbRBC2vaAfcvbrax
         Z+T7aLOMNBQB4pbQyR8g0Ki1mQ+WiaI26G69yfM6vMR6ZY8hOXK+CU7HNZrjm+ZY2tGn
         Oz8Nie+28q8aybrBtOTM3QjreU+wAsb32Di8wzypLMT2AouThNOnBos5GtFoIy06i+hr
         8CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644902; x=1775249702;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdmn94fDq5EabxgUHdZFE1PchWB5l0Hn00gGljt6mxc=;
        b=o/zxDqP8lvZds/xrKIN9qbtdVC7TGEyHFRx12Zp2FsagdPml1sd/XUHuZK/EH0D4Zx
         M3BtCJ7MoxynvRD0E3tb9RG8c+BRMtUfTj7bUj3OWK435gM2H9ZZxmhueHbmmHPZhoSR
         xCHGb5vXOfob1iLbFiN/Z5SEs22t7yXqhxeHXuHCjrCYytxHxdYpNRjtVpNxUVOCrPzJ
         RMAzPaY33TIBvRuZQIAsKF+z1a7mrsQJ3XZ/zUHUsTG9Vk1WgoUsNRPmr6YyebQ16ZK4
         qRJYu0t8pXIDNvEkqHD8IyXnyi8BcDZ77BMEj9wDkEgJ54g+O87ZqwXET95nOk8Huio+
         RV8A==
X-Forwarded-Encrypted: i=1; AJvYcCV1HXvCEmzF+qD4E6WyNjUzFHZwJCsm2JwYsAVnWpzkNtSwW/7yJsQszrD0F5xkaCjKZ+kRGuualUWC@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLzUFJHbQ49oGQKQtQTsUGN7zLWZ//qv/HQTyomyNUd8z2Z/C
	r25jeZmQ7IzX0N9FJntMsAa7+5iKePEvCe3MBeV/I58eEsl5/b30vUB2OdPwXFjoVulctcUma36
	/dN/EIQ==
X-Received: from dybse8.prod.google.com ([2002:a05:7301:4908:b0:2be:77bc:5c34])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3113:b0:2c0:cff4:b456
 with SMTP id 5a478bee46e88-2c185e5a4e2mr2359718eec.29.1774644901334; Fri, 27
 Mar 2026 13:55:01 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:51 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-1-surenb@google.com>
Subject: [PATCH v6 0/6] Use killable vma write locking in most places
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
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

Changes since v5 [1]:
- Added Reviewed-by for unchanged patches, per Lorenzo Stoakes

Patch#2:
- Fixed locked_vm counter if mlock_vma_pages_range() fails in
mlock_fixup(), per Sashiko
- Avoid VMA re-locking in madvise_update_vma(), mprotect_fixup() and
mseal_apply() when vma_modify_XXX creates a new VMA as it will already be
locked. This prevents the possibility of incomplete operation if signal
happens after a successful vma_modify_XXX modified the vma tree,
per Sashiko
- Removed obsolete comment in madvise_update_vma() and mprotect_fixup()

Patch#4:
- Added clarifying comment for vma_start_write_killable() when locking a
detached VMA
- Override VMA_MERGE_NOMERGE in vma_expand() to prevent callers from
falling back to a new VMA allocation, per Sashiko
- Added a note in the changelog about temporary workaround of using
ENOMEM to propagate the error in vma_merge_existing_range() and
vma_expand()

Patch#5:
- Added fatal_signal_pending() check in do_mbind() to detect
queue_pages_range() failures due to a pendig fatal signal, per Sashiko

[1] https://lore.kernel.org/all/20260326080836.695207-1-surenb@google.com/

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
 mm/madvise.c                       |  13 ++-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  21 +++-
 mm/mlock.c                         |  30 ++++--
 mm/mprotect.c                      |  25 +++--
 mm/mremap.c                        |   8 +-
 mm/mseal.c                         |  24 ++++-
 mm/pagewalk.c                      |  22 ++--
 mm/vma.c                           | 162 ++++++++++++++++++++++-------
 mm/vma_exec.c                      |   6 +-
 13 files changed, 251 insertions(+), 84 deletions(-)


base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
-- 
2.53.0.1018.g2bb0e51243-goog

