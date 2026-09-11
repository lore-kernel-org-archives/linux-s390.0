Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8F3E40F6
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095457; cv=none; b=YeEZoGa4K/7EqAedr/FQcRKaZC2Uato5dDLbD10ZGJmnXiRWbRLac2uD+E1e0j9Pdii2B4xs4/WsDmNzfsq42XX81DituR2JqKwLKp4WDVJAuw1I3nBSEnnQIr2crt7wvyZfSZhMMxrA/OnGO5vbZ7gOvBuGTR0B20dgwYJIG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095457; c=relaxed/simple;
	bh=TFoZstVg/qTnm2TnC6SXqAluk3+Bs08p/4W0Gs3WSIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCdze6fVET8QQI7KCiX65ktSCWW8LCTTnc8k82JiQsjViKaG1pBJNzhCx5rja+/vkILs+gQzdPdLCeDBy5MRLfA8nXNxPF7vbhHAoRuUfB2i1zWsW8eIzcubg6N4apJ2lH6GyfaBQYIGdV960lYGc9MPy54JHlYXc8SLrTDguaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSIXeO2U; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSIXeO2U"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf49dc298bso2773605ad.0
        for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 19:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095453; x=1789700253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fZGhKbaKpC/0bwb/aBifkG6HcLnnMOlc1Eg8oJ/QHc=;
        b=lSIXeO2UdtxRqEyKWDb732inVduMxwPnluCJiwrDDnR51bHV1qQOHdAwyNM2xnXt+D
         qGV0HH9BZwgy54FX0RT1qbkoM00s/fVsgR4UcAclDaPEnX6XG51z08vFHSh6IYqdNo3f
         Osypefg/QNtf+pskVwMq4sSsUotKhUSNqYpnUq3YEDncaG74wgsiMaPJG3PpL6YRpScx
         cKCHCoZUGbrolbat/3Ir8eewzNHihe9lJBxH4ZsRvz/pPK8K9zdRbU8DyTsNUTqOODn2
         knGmXFMhj8LET2K/KqkuGQbDVA8vUcxyv9nEek1kemghpYe1OGYb1aTJJaYQNVRQovnh
         1A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095453; x=1789700253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fZGhKbaKpC/0bwb/aBifkG6HcLnnMOlc1Eg8oJ/QHc=;
        b=aNNHysIutJm3EnDNafMWENR546fjhfyfaSYLK1C8biknFVgL9wk6oWUg0dHm1zKuxa
         9lTMRXtF5ouzOLo4sD5YrgOpFyJUlVOQEt2J+Gp7vwmBLi6fxsprK7X0h/DYaqLBoLOQ
         vUyUXLUlGBc4RKWvvKNxprU/C/M+UyAXA7X+AXuYpJyrKUTCdTjAnVTbdQ3qfdfjkv4d
         Rf1VKaKG4m8r44TGXlI8VQHPrHlt9a/3gksDMJRv+Lstb/t+VZRDyqT4INu1Jjp65P2W
         SDf3XjGLxEDHGwd+X+aGSO13h4lUcSfpKDHSA1tVan1hWONEJiVt1D31JXkxRYK7dwr8
         dEyw==
X-Forwarded-Encrypted: i=1; AKwUvByq0dIpQFsxByNk0UMXsfalSnjMshrcNMwjK+qup0AyPt6GsEZwwC3m5SKem6Xy0wxJ+tToD88aZku2@vger.kernel.org
X-Gm-Message-State: AFuF++kL2b1TjjeLoQiD1MWJ8qBbqRV/bH9Mc8gwji+2mMYKTVZzaZLM
	zUa21U1iVj4xbHtafQRIzISRVTyoYEneBdCPMDOHWj9yiNqNjv3Jc2J4
X-Gm-Gg: AYBFou0ttu7VrAh9Ca0mHOS3/ZXVKdHMxI0icoJ99nawZvZE8CvzKlxijczSBV5jP5u
	Pa5TTWHkds/5LesMW6fn4ZnvtmybjFZLdK7Hb/4Qu617ud3SgSa4wnN57FAoD967Th1N00hGxkt
	nMPfW7vb1s52rpGIwD3IyabQO5VDX2C1S/hTqU8XhqA3mDjhqfTQNzpcfto0KLqvB3eOk3fv98C
	L5TOgnBzDXBDhZuIuqhmkZHBEwjiTztuH7og8ziRe85jo/e/NYFPVwQe7ad96Labco9RxP/AlGk
	/5Qpj4ESlupCdzkWATIA5NrbKjSBY8AIM+F5ipASDdgLv0zUJnpgjBTrdPIejEJh5jVws384t6d
	HMh0vwZZqsCtoNYg3i/KKtm4BtEbwoCRlFWDJIxpx+gCxOgVdYJCgRftewllqsgwxKbljmh7GCq
	SdkPpiL4nupablykVbkwFNhh0weoEvKqlEpsg4qOu3YkmGqJNKhEEIbLS94/AbB6BCgeQthSrz0
	7U6HowqC2wVX9G+pktKBWIOww==
X-Received: by 2002:a17:902:d4ce:b0:2dd:60d:8b7c with SMTP id d9443c01a7336-2dd2a336ab6mr39680795ad.13.1789095452393;
        Thu, 10 Sep 2026 19:57:32 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([2408:8607:1b00:8:8ce8:c617:f32:c38e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ce9c8besm3944495ad.18.2026.09.10.19.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:57:31 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baohua@kernel.org,
	surenb@google.com,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shakeel.butt@linux.dev,
	vbabka@kernel.org,
	willy@infradead.org,
	zhaonanzhe@xiaomi.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: [PATCH v6] mm: retry page faults once under the per-VMA lock
Date: Fri, 11 Sep 2026 10:56:13 +0800
Message-ID: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongru Zhang <zhanghongru@xiaomi.com>

The per-VMA lock fault path releases the per-VMA lock when the folio
cannot be locked. It then waits for the folio to become lockable
without holding the VMA lock and retries the page fault. However,
the retry always takes the mmap_lock instead of the per-VMA lock.
This can cause serious lock contention when a writer is holding the
mmap_lock at the same time.

Add a single retry under the per-VMA lock in the architecture fault
handler. This does not touch any page fault code in mm. The retry is
very likely to succeed because the first page fault has already waited
for the folio to become lockable. For example, this usually means that
any required I/O has completed. This allows faults that can make
progress on an immediate retry to stay on the per-VMA lock path,
avoiding waits on the mmap_lock when it is write-contended. This
reduces page-fault latency and mmap_lock contention. Some faults may
retry unnecessarily, for example, those in __vmf_anon_prepare() or
device-private fault handling, which require the mmap_lock. However,
these cases are expected to be infrequent and only add one cheap
per-VMA lock attempt. If the second attempt still returns
VM_FAULT_RETRY, the fault continues through the existing mmap_lock
path.

Based on the stress model from Kunwu Chan and Wang Lian in RFC v2, we
adapted a benchmark [1] to a 20-core Intel i7-12700 desktop by reducing
the thread count and adjusting the memcg limits. The benchmark uses
concurrent page faults under memcg pressure with parallel munmap to
amplify mmap_lock read-write contention.

Filemap throughput (higher is better)

+---------+------------+---------------------+
| Threads |  Vanilla   |       Patched       |
+---------+------------+---------------------+
|   40    | 1069.34 /s | 1400.13 /s (+30.9%) |
+---------+------------+---------------------+
|   60    | 1038.12 /s | 1683.37 /s (+62.2%) |
+---------+------------+---------------------+
|   80    | 1042.62 /s | 1767.83 /s (+69.6%) |
+---------+------------+---------------------+

mmap_lock contention count (lower is better)

+---------+-----------+---------+-----------+
| Threads |  Vanilla  | Patched | Reduction |
+---------+-----------+---------+-----------+
|   40    | 3,187,336 |  52,086 |  -98.4%   |
+---------+-----------+---------+-----------+
|   60    | 4,385,154 |  65,079 |  -98.5%   |
+---------+-----------+---------+-----------+
|   80    | 5,337,890 |  69,708 |  -98.7%   |
+---------+-----------+---------+-----------+

These results show that retrying once under the per-VMA lock keeps more
file-backed faults on the fast path, improving throughput and reducing
mmap_lock contention.

Using benchmark [2], we tested this on a 20-core Intel i7-12700 desktop
with a 2GB swapfile. The benchmark uses one pressure thread under memcg
limits to keep a 128MB non-zero anonymous mapping under swap pressure,
12 reader threads to fault it back in, and optional mmap writer threads
to amplify mmap_lock read-write contention. Each test ran for 60 seconds
and reported completed reader rounds per second under swap pressure.

Swap throughput (higher is better)

+--------------+-------------+---------------------------+
| mmap writers |   Vanilla   |          Patched          |
+--------------+-------------+---------------------------+
|      0       | 17303.09 /s | 17899.48 /s       (+3.4%) |
+--------------+-------------+---------------------------+
|      4       | 12596.23 /s | 16095.20 /s      (+27.8%) |
+--------------+-------------+---------------------------+
|      8       |     0.58 /s | 15420.57 /s (+2658619.0%) |
+--------------+-------------+---------------------------+

With increasing mmap_lock write pressure, Vanilla degrades sharply and
drops to near zero at eight writers. Patched kernel holds up much better.

Performance was evaluated on a Pixel 6 running Android 17, using Baidu
Tieba (com.baidu.tieba) and Tencent Video (com.tencent.qqlive), both
very popular Android apps, as the workloads. For each workload, we
performed 100 cold app launches with each kernel variant (vanilla and
patched). Each run recorded cold app launch time, measured as the time
to first frame, and the main thread's mmap_lock wait events. Shorter
launch times indicate better performance.

Baidu Tieba cold app launch time

+-----------+----------+----------+--------+
| Statistic |  Vanilla |  Patched | Change |
+-----------+----------+----------+--------+
|    Mean   | 3,672 ms | 3,580 ms |  -2.5% |
+-----------+----------+----------+--------+
|  Maximum  | 4,469 ms | 4,156 ms |  -7.0% |
+-----------+----------+----------+--------+

Baidu Tieba cold app launch time distribution

+-------------+------------+------------+
|  Time (ms)  |   Vanilla  |   Patched  |
+-------------+------------+------------+
| 2,750-2,999 |  0  (0.0%) |  1  (1.0%) |
+-------------+------------+------------+
| 3,000-3,249 |  8  (8.0%) | 14 (14.0%) |
+-------------+------------+------------+
| 3,250-3,499 | 17 (17.0%) | 30 (30.0%) |
+-------------+------------+------------+
| 3,500-3,749 | 38 (38.0%) | 27 (27.0%) |
+-------------+------------+------------+
| 3,750-3,999 | 26 (26.0%) | 18 (18.0%) |
+-------------+------------+------------+
| 4,000-4,249 |  8  (8.0%) | 10 (10.0%) |
+-------------+------------+------------+
| 4,250-4,499 |  3  (3.0%) |  0  (0.0%) |
+-------------+------------+------------+

Baidu Tieba main-thread mmap_lock wait statistics

+----------------------+----------------+----------------+--------+
|        Metric        |     Vanilla    |     Patched    | Change |
+----------------------+----------------+----------------+--------+
|    Total Wait Time   |  569.9 ms/run  |  469.9 ms/run  | -17.6% |
+----------------------+----------------+----------------+--------+
| Read-Lock Wait Count | 32.4 waits/run | 10.9 waits/run | -66.2% |
+----------------------+----------------+----------------+--------+

Tencent Video cold app launch time

+-----------+----------+----------+--------+
| Statistic |  Vanilla |  Patched | Change |
+-----------+----------+----------+--------+
|    Mean   | 1,907 ms | 1,840 ms |  -3.5% |
+-----------+----------+----------+--------+
|  Maximum  | 3,023 ms | 2,851 ms |  -5.7% |
+-----------+----------+----------+--------+

Tencent Video cold app launch time distribution

+-------------+------------+------------+
|  Time (ms)  |   Vanilla  |   Patched  |
+-------------+------------+------------+
| 1,250-1,499 |  3  (3.0%) |  7  (7.0%) |
+-------------+------------+------------+
| 1,500-1,749 | 32 (32.0%) | 33 (33.0%) |
+-------------+------------+------------+
| 1,750-1,999 | 39 (39.0%) | 36 (36.0%) |
+-------------+------------+------------+
| 2,000-2,249 | 12 (12.0%) | 15 (15.0%) |
+-------------+------------+------------+
| 2,250-2,499 |  7  (7.0%) |  4  (4.0%) |
+-------------+------------+------------+
| 2,500-2,749 |  5  (5.0%) |  3  (3.0%) |
+-------------+------------+------------+
| 2,750-2,999 |  1  (1.0%) |  2  (2.0%) |
+-------------+------------+------------+
| 3,000-3,249 |  1  (1.0%) |  0  (0.0%) |
+-------------+------------+------------+

Tencent Video main-thread mmap_lock wait statistics

+----------------------+----------------+---------------+--------+
|        Metric        |     Vanilla    |    Patched    | Change |
+----------------------+----------------+---------------+--------+
|    Total Wait Time   |  139.6 ms/run  |  66.4 ms/run  | -52.4% |
+----------------------+----------------+---------------+--------+
| Read-Lock Wait Count | 28.4 waits/run | 4.7 waits/run | -83.5% |
+----------------------+----------------+---------------+--------+

Across both workloads, the single retry under the per-VMA lock
substantially reduced mmap_lock read-side contention, leading to lower
app startup times at both the mean and the tail.

[1] https://gist.github.com/zhr250/c36c2c54d9351df37e12fd072d4926ef
[2] https://gist.github.com/zhr250/218ffe693f842346b56434483127422c

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
Suggested-by: Barry Song <baohua@kernel.org>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
Changes since RFC v5:
- Added measurements from 100 cold app launches per kernel for each of
  Baidu Tieba and Tencent Video on a Pixel 6 running Android 17
  Tested by Nanzhe Zhao. Thanks!
- Rebased onto mm-unstable; no code changes

Changes since RFC v4:
- Drop `VM_FAULT_MAY_USE_VMA_LOCK` and always retry once under the
  per-VMA lock, based on feedback from Lorenzo and Barry. Thanks!

Changes since RFC v3:
- Keep VM_FAULT_RETRY unchanged and add VM_FAULT_MAY_USE_VMA_LOCK as an
  advisory bit
- Bound VMA-lock retries with FAULT_FLAG_TRIED
- Opt in filemap_fault() and do_swap_page() to VM_FAULT_MAY_USE_VMA_LOCK
- Rebased on mm-unstable

Changes since RFC v2:
- Redesigned as a single blacklist-based patch (v2 was 5 per-path patches)
- Added retry_vma loop to all architectures (not just x86)
- Rebased on mm-unstable

Changes since RFC v1:
- collect tags from Pedro, Kunwu and Lian, thanks!
- handle case (2), for uptodate folios, don't retry PF

Link to RFC v5:
https://lore.kernel.org/all/20260814085300.399107-1-zhanghongru@xiaomi.com/

Link to RFC v4:
https://lore.kernel.org/all/20260804095135.45897-1-zhanghongru@xiaomi.com/

Link to RFC v3:
https://lore.kernel.org/all/20260626075019.1833065-1-zhanghongru@xiaomi.com/

Link to RFC v2:
https://lore.kernel.org/all/20260430040427.4672-1-baohua@kernel.org/

Link to RFC v1:
https://lore.kernel.org/all/20251127011438.6918-1-21cnbao@gmail.com/

 arch/arm/mm/fault.c       | 8 ++++++++
 arch/arm64/mm/fault.c     | 8 ++++++++
 arch/loongarch/mm/fault.c | 8 ++++++++
 arch/powerpc/mm/fault.c   | 7 +++++++
 arch/riscv/mm/fault.c     | 8 ++++++++
 arch/s390/mm/fault.c      | 6 ++++++
 arch/x86/mm/fault.c       | 8 ++++++++
 7 files changed, 53 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 0a09d4ff7718..70472744f5c5 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -344,6 +344,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 	vm_flags_t vm_flags = VM_ACCESS_FLAGS;
+	bool vma_lock_retried = false;
 
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
@@ -395,6 +396,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+lock_vma:
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
@@ -424,6 +426,12 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 			goto no_context;
 		return 0;
 	}
+
+	if (!vma_lock_retried) {
+		vma_lock_retried = true;
+		goto lock_vma;
+	}
+
 lock_mmap:
 
 retry:
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 75c3e463df2e..c7fd6f485b16 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -614,6 +614,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	struct vm_area_struct *vma;
 	int si_code;
 	int pkey = -1;
+	bool vma_lock_retried = false;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -682,6 +683,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!(mm_flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+lock_vma:
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
@@ -728,6 +730,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 			goto no_context;
 		return 0;
 	}
+
+	if (!vma_lock_retried) {
+		vma_lock_retried = true;
+		goto lock_vma;
+	}
+
 lock_mmap:
 
 retry:
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 2c93d33356e5..ef6ea847b1e0 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -181,6 +181,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 	struct mm_struct *mm = tsk->mm;
 	struct vm_area_struct *vma = NULL;
 	vm_fault_t fault;
+	bool vma_lock_retried = false;
 
 	if (kprobe_page_fault(regs, current->thread.trap_nr))
 		return;
@@ -219,6 +220,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+lock_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -265,6 +267,12 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 			no_context(regs, write, address);
 		return;
 	}
+
+	if (!vma_lock_retried) {
+		vma_lock_retried = true;
+		goto lock_vma;
+	}
+
 lock_mmap:
 
 retry:
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 806c74e0d5ab..06018b6d7086 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -422,6 +422,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_write = page_fault_is_write(error_code);
 	vm_fault_t fault, major = 0;
 	bool kprobe_fault = kprobe_page_fault(regs, 11);
+	bool vma_lock_retried = false;
 
 	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
 		return 0;
@@ -487,6 +488,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+lock_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -517,6 +519,11 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (fault_signal_pending(fault, regs))
 		return user_mode(regs) ? 0 : SIGBUS;
 
+	if (!vma_lock_retried) {
+		vma_lock_retried = true;
+		goto lock_vma;
+	}
+
 lock_mmap:
 
 	/* When running in the kernel we expect faults to occur only to
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4..ff861793dba9 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -284,6 +284,7 @@ void handle_page_fault(struct pt_regs *regs)
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 	int code = SEGV_MAPERR;
 	vm_fault_t fault;
+	bool vma_lock_retried = false;
 
 	cause = regs->cause;
 	addr = regs->badaddr;
@@ -347,6 +348,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+lock_vma:
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
@@ -376,6 +378,12 @@ void handle_page_fault(struct pt_regs *regs)
 			no_context(regs, addr);
 		return;
 	}
+
+	if (!vma_lock_retried) {
+		vma_lock_retried = true;
+		goto lock_vma;
+	}
+
 lock_mmap:
 
 retry:
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 46d828926009..dcd1ba24497f 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -271,6 +271,7 @@ static void do_exception(struct pt_regs *regs, int access)
 	unsigned int flags;
 	vm_fault_t fault;
 	bool is_write;
+	bool vma_lock_retried = false;
 
 	/*
 	 * The instruction that caused the program check has
@@ -294,6 +295,7 @@ static void do_exception(struct pt_regs *regs, int access)
 		flags |= FAULT_FLAG_WRITE;
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
+lock_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -318,6 +320,10 @@ static void do_exception(struct pt_regs *regs, int access)
 			handle_fault_error_nolock(regs, 0);
 		return;
 	}
+	if (!vma_lock_retried) {
+		vma_lock_retried = true;
+		goto lock_vma;
+	}
 lock_mmap:
 retry:
 	vma = lock_mm_and_find_vma(mm, address, regs);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index aa88370ce739..df10d5cea4ee 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1222,6 +1222,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	bool vma_lock_retried = false;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1331,6 +1332,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+lock_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -1360,6 +1362,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 						 ARCH_DEFAULT_PKEY);
 		return;
 	}
+
+	if (!vma_lock_retried) {
+		vma_lock_retried = true;
+		goto lock_vma;
+	}
+
 lock_mmap:
 
 retry:

base-commit: 3628c3df6cd2797b34714d23113cd44cb30801e7
-- 
2.43.0

