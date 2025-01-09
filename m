Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA14C7D;
	Thu,  9 Jan 2025 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736393526; cv=none; b=emCyh0aic8dz7866Ixp7xwE02hyDSnCnkr0sdNKtLihzaUio2UTZezv4VO+QQXq6z7H/ausKgOLzDxvDNVrjLSx/Icv8jr1FwRgkFYAMAxbIwxbaZTrtr7Tef070euQWhpiXQi6DnOSs/631nb7urV92bRVHgXItRME4qNLUc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736393526; c=relaxed/simple;
	bh=qmjimz5NXkvZrQIEiT3BVuGnFnEEAJoVPN+sCV31vv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=btqlxc1yenbyGL2uNs9LvDRVBQclI/1mMCDInD4KnW8BocMbFvOPW67snwptwkxpe72mwFJdUWBGAzsMcosFX+UH04wDaPVOwSTIhFV+YYVptIiQ4MNJrw08uARSMWT/rF+QWcfB33DL48MM9v1bHwCZUT8T8D3YZRk5eDjGXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PONWgRAJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PONWgRAJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21675fd60feso8541415ad.2;
        Wed, 08 Jan 2025 19:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736393524; x=1736998324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXLkHTQWgHzu9KjIvPLCv6JTi/EeuuALx+VRr/98s4I=;
        b=PONWgRAJZk3fvR0giqBqUQ58y3h7kZj3WHn6DGqYvedcwfgsCFpRX0ehArTLLNxIqr
         NSyTX6p+ehauGr86uDE90F5CXvQmC1z9iYKf7cWaS0pE8SMjmLmNqmohVAptVtJOTh3J
         QPh2FVqd7mm4u5IuFEqyuQWgOTNjttQa/RIVxstKmuPCMZqUa13LgdwoRCD0EMNXidBR
         yMek6nMMhatY6+zUEWQtwdBteddF4qlXoNiIfCv9gxcXRt/Gg68tEC1JJaEBprJ1TYdG
         3O7i9/tyvkU1iejhhspKHS0TGqyLA8GJkrzi2ZZBrwyIPo7M4//qeDw/fLKPi5GOJBIo
         3BUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736393524; x=1736998324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXLkHTQWgHzu9KjIvPLCv6JTi/EeuuALx+VRr/98s4I=;
        b=ZXEWlLw1Oik9MMe2D9ktCMhOV5Pw+ytA8MoZJw7wXUmJJmt2YVrJgO9oULiGkkp22k
         ++7hzb3eGVwMN6J8w7wmb8r+tSSciAUG1W2S59qDOoly3VxDZp8b+rgb5mlSiWHMmoD7
         S8tiwyaEVAZfuCoRVZ5S7Hw0RNJ4Wn0Qh++opNwHsKChoXHiildQ5IKK+MhzqgNIIw5i
         6Sp/IQzEXjhlCTOWDNUJlTqQp5GmE3jQHZxNL/CkYbOER8T4cHhBsCsry/BII8mZ71ZH
         /wB3G9fph+HSqE+Ux9/IieFinm8OeDtLXNyB/5EN/KXs1h9VOdvV4lSE+w3JkDv4fGEm
         DNzg==
X-Forwarded-Encrypted: i=1; AJvYcCUF4uhgN0J21AbUK3k7k3w93JmsfrkL7e11SplSAT0XQJHHtxJkK8dnPKxpPXUuNzIjum/MF5xHyZpb2VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4BkIDMho88x4lQIJTaiaaGdjUCYZIKD+6+O1kktiV7R12qAc
	RkbBH8p7nxGNRGEm62EU86M7ggB1P8EQNavjzaG9R5VSSfR9KUv9
X-Gm-Gg: ASbGncsJGd5B/bOAewiOGWGVjSQuuf1MTWUYFx45O8+RHwoP0DMu0NyU8zG4SgOE6Dt
	kU6haYOm9i7cgi38jMznHRIiZEyaX/Qr6PVLg0Eyq3upy24gFHzQCqvI5XuNWEr0v0xAVsYxa5Z
	bhQe0lGcgHb++g/zPe30hshPiakqIxYnhs1f2yheWcfiN5F4ljxExaxklT4a0PCizQ4KtZuumNK
	D8ErHOrqt0R+y1As2Ykt+PKaD5gA/AQ6VGB3X/VUA57BKrSRh8rwX3+QzgeP4/0MrvjgbfgMJ6r
	7mIx
X-Google-Smtp-Source: AGHT+IFWx3SO4h+JbQQAuUZJ3jBGwoAgqUM5IB48w8KUPjOfaHOhIfnoe7lR09EQQVbX4ymVPd2ccg==
X-Received: by 2002:a17:903:1c7:b0:216:2bd7:1c36 with SMTP id d9443c01a7336-21a83f48ccbmr72098135ad.1.1736393524236;
        Wed, 08 Jan 2025 19:32:04 -0800 (PST)
Received: from localhost.localdomain ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f4f5esm334455625ad.178.2025.01.08.19.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 19:32:03 -0800 (PST)
From: Guo Weikang <guoweikang.kernel@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Guo Weikang <guoweikang.kernel@gmail.com>
Subject: [PATCH] arch/s390: save_area_alloc default failure behavior changed to panic
Date: Thu,  9 Jan 2025 11:31:36 +0800
Message-Id: <20250109033136.2845676-1-guoweikang.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now with the memblock_alloc_or_panic interface, save_area_alloc no longer
needs to handle panic itself.

Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
---
 arch/s390/kernel/crash_dump.c | 4 +---
 arch/s390/kernel/numa.c       | 3 +--
 arch/s390/kernel/smp.c        | 4 ----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index f699df2a2b11..276cb4c1e11b 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -63,9 +63,7 @@ struct save_area * __init save_area_alloc(bool is_boot_cpu)
 {
 	struct save_area *sa;
 
-	sa = memblock_alloc(sizeof(*sa), 8);
-	if (!sa)
-		return NULL;
+	sa = memblock_alloc_or_panic(sizeof(*sa), 8);
 
 	if (is_boot_cpu)
 		list_add(&sa->list, &dump_save_areas);
diff --git a/arch/s390/kernel/numa.c b/arch/s390/kernel/numa.c
index a33e20f73330..2fc40f97c0ad 100644
--- a/arch/s390/kernel/numa.c
+++ b/arch/s390/kernel/numa.c
@@ -21,9 +21,8 @@ void __init numa_setup(void)
 	nodes_clear(node_possible_map);
 	node_set(0, node_possible_map);
 	node_set_online(0);
-	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+	for (nid = 0; nid < MAX_NUMNODES; nid++)
 		NODE_DATA(nid) = memblock_alloc_or_panic(sizeof(pg_data_t), 8);
-	}
 	NODE_DATA(0)->node_spanned_pages = memblock_end_of_DRAM() >> PAGE_SHIFT;
 	NODE_DATA(0)->node_id = 0;
 }
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index d77aaefb59bd..7b08399b0846 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -611,8 +611,6 @@ void __init smp_save_dump_ipl_cpu(void)
 	if (!dump_available())
 		return;
 	sa = save_area_alloc(true);
-	if (!sa)
-		panic("could not allocate memory for boot CPU save area\n");
 	regs = memblock_alloc_or_panic(512, 8);
 	copy_oldmem_kernel(regs, __LC_FPREGS_SAVE_AREA, 512);
 	save_area_add_regs(sa, regs);
@@ -646,8 +644,6 @@ void __init smp_save_dump_secondary_cpus(void)
 		    SIGP_CC_NOT_OPERATIONAL)
 			continue;
 		sa = save_area_alloc(false);
-		if (!sa)
-			panic("could not allocate memory for save area\n");
 		__pcpu_sigp_relax(addr, SIGP_STORE_STATUS_AT_ADDRESS, __pa(page));
 		save_area_add_regs(sa, page);
 		if (cpu_has_vx()) {
-- 
2.25.1

