Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFD379C28
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570825; cv=none; b=VXb6eMHzORvyX/Ny0n4dR0G+PjgjUHfGdEu/n7bJgr0Y9iaRKn8X0K557nw6gTLBqHkLhMrZc2Ktn3XUHxYzEVn7Ld0Pw77vNpKUe09bWEWlaKZk9If6loX5N4GC6ZMC00rKFzd2tKvXQXyU6EeHMolXcUEsK6Zb94enrtdlcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570825; c=relaxed/simple;
	bh=uMIKuIDBKiM6AywTh8SPOlRTZMIQf529eDaNCHNLlNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTINAmnee+LG5VqofOZpg3qh7TaAkHBnXbuw8phc9oSZ98W9wQN6ftmHsfNO4/4iLqeTRw11TKyWbXw32a2ifw0vkTr/Mq2A5+e6zr3pM6e0sKX2yIkdkZBcA4E61tGbiZLULvdXtK7bu+aVBH5gXaug3mYpOeX9XF4f45K/caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eQDBEUmy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eQDBEUmy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adff872068so27728925ad.1
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 00:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778570823; x=1779175623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fx4e8OAen0NF75+J/YmhI593eekBwMCjX/uv6e51cmw=;
        b=eQDBEUmylSLkn8psS4Em2w1/9+UVxb3KK9BoccrY5ByMdxGMrFTEgskFBYJ5qju5Ld
         imV9Q7MnNG8q1fnc6nUsPdvYpJDskGMNBC3a4cGqPXiTYIPXVDNSMCWryfuz4l5ULPSA
         sRSAu6heGcn/AdBQnIaufqqprMd6TWHaYfDlWDB3jkPh8QdPdnx7PjD7aMAEeRkIfPkI
         V1Dnt7itoziyh11HxA7wwb8Ds+2yP+2BXXP4bhJ4kWh1i+sZGVhbFro/i0LcDIHZ8M9q
         gMNxrlNDxtuK/MyOywkNVkkZUG8H+tNYIGj3qhedTI073u+Ct5+kopMS0TzLtT2iSfir
         vH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778570823; x=1779175623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx4e8OAen0NF75+J/YmhI593eekBwMCjX/uv6e51cmw=;
        b=GX7xWeqXDZPsPrVSspdMHXLTp2heZZ/OSCdqK7cTadUYbnoTxm2BoBHAxVfF5g75wG
         +AoxfzXlXPYDwD1WzMZnVvvbf6lznd2OqCJKGuDtKHRT7X1zw5kKC8Jxd+gdEUuX3SVr
         PPmFMiC+2cUouGg6ZCmy9LT/xbYQRFvZO3aO8huZvrPUyenGMNj8vOrTKH2gWZV6XwVm
         LMOyfwSUiZyU5HsJianxuGDvXWSjzTiraVaTVvxS+NuSkZTWGNINg5Ldy/06Js8TQJsd
         EpNsNTuqZjY5z5tA3jQTEqLboAQ99/6TERQj393s18i+BofDKXtPOLsXbC1xbYjEAMIr
         f8Cw==
X-Forwarded-Encrypted: i=1; AFNElJ9HzyjF4g9KJ4ugZ2qOfOLlydjiYpFKPqptETRjKGc+AJpgI6XwTdts5EkYMaWS6Ve4m+tK9QKTLO/8@vger.kernel.org
X-Gm-Message-State: AOJu0YyStfdqJS0H6VEwmGsAY/vgQKIL1B6E8qLZLVo9mDc2YJ7VJOg4
	cTie0uO2S837/Z0Tjp4UjU0v0tgeUwWt4nCyx9Mju90EIaoBf20t1/rCJ4mynlTp/FM=
X-Gm-Gg: Acq92OFZTII3n3TpMKvU4H6TapezwtWSwbbuIQvyqmRjBS6U0jItIiWxGHne20khXWC
	SQpvldUOuMoYDi5/cjDQKNSNtLAXSitBqxseQt5nefuvkFH6SUZsujbkb1TWng5m83i30n7IN4r
	F4P+75O8qXbfewBAgiUa17ltkoS83dfI68/nD5rH1eyBqbM5GV1eT8uNZ8jwg5WMmreJ1GzHtDM
	DGF3sKm2UrBMOWJpmh1YdTkwLxz3FKOv5Z/+Smw4AznNd6i/wlpGMvlXJbgLZcmEwK3bwVWx9pO
	b0NCfHE2j/cN0Y+fbHTygFfhbiKxOFWcl4pF9QiPuu8hamVcbTH2FQmieN/qRhgLJm+amP7R5Zh
	f4cfFsf9tVz9T0InYpW4pX3YoiukBNTRSK6xHolFw9O81V+BpMaFoc0BG/jQyeHJKYA48Vgf24V
	hr6L8AcImNsjn4NviOwA==
X-Received: by 2002:a17:902:c401:b0:2bc:ebb1:e3a7 with SMTP id d9443c01a7336-2bd012b3330mr24218975ad.32.1778570822529;
        Tue, 12 May 2026 00:27:02 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::343])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2700dsm129200635ad.2.2026.05.12.00.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:27:02 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev
Cc: Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Donet Tom <donettom@linux.ibm.com>,
	muchun.song@linux.dev
Subject: [PATCH v2] drivers/base/memory: make memory block get/put explicit
Date: Tue, 12 May 2026 15:26:35 +0800
Message-ID: <20260512072635.3969576-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the memory block lookup helper to make the acquired reference
explicit, add memory_block_put() to wrap put_device(), remove
find_memory_block(), and use memory_block_get() as the single block-id
based lookup interface.

This makes it clearer to callers that a successful lookup holds a
reference that must be dropped, reducing the chance of forgetting the
matching put and leaking the memory block device reference.

Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Tested-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
---
Changes in v2:
- mention the removal of find_memory_block() in the commit message
- drop the redundant extern from the memory_block_get() declaration
---
 .../platforms/pseries/hotplug-memory.c        | 14 ++-----
 drivers/base/memory.c                         | 38 +++++++------------
 drivers/base/node.c                           |  4 +-
 drivers/s390/char/sclp_mem.c                  | 17 ++++-----
 include/linux/memory.h                        |  7 +++-
 mm/memory_hotplug.c                           |  5 +--
 6 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 75f85a5da981..94f3b57054b6 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -164,13 +164,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 
 static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
 {
-	unsigned long section_nr;
-	struct memory_block *mem_block;
-
-	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
-
-	mem_block = find_memory_block(section_nr);
-	return mem_block;
+	return memory_block_get(phys_to_block_id(lmb->base_addr));
 }
 
 static int get_lmb_range(u32 drc_index, int n_lmbs,
@@ -220,7 +214,7 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
 	else
 		rc = 0;
 
-	put_device(&mem_block->dev);
+	memory_block_put(mem_block);
 
 	return rc;
 }
@@ -319,12 +313,12 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 
 	rc = dlpar_offline_lmb(lmb);
 	if (rc) {
-		put_device(&mem_block->dev);
+		memory_block_put(mem_block);
 		return rc;
 	}
 
 	__remove_memory(lmb->base_addr, memory_block_size);
-	put_device(&mem_block->dev);
+	memory_block_put(mem_block);
 
 	/* Update memory regions for memory remove */
 	memblock_remove(lmb->base_addr, memory_block_size);
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 11d57cfa8d72..5b5d41089e81 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -649,7 +649,7 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
  *
  * Called under device_hotplug_lock.
  */
-struct memory_block *find_memory_block_by_id(unsigned long block_id)
+struct memory_block *memory_block_get(unsigned long block_id)
 {
 	struct memory_block *mem;
 
@@ -659,16 +659,6 @@ struct memory_block *find_memory_block_by_id(unsigned long block_id)
 	return mem;
 }
 
-/*
- * Called under device_hotplug_lock.
- */
-struct memory_block *find_memory_block(unsigned long section_nr)
-{
-	unsigned long block_id = memory_block_id(section_nr);
-
-	return find_memory_block_by_id(block_id);
-}
-
 static struct attribute *memory_memblk_attrs[] = {
 	&dev_attr_phys_index.attr,
 	&dev_attr_state.attr,
@@ -701,7 +691,7 @@ static int __add_memory_block(struct memory_block *memory)
 
 	ret = device_register(&memory->dev);
 	if (ret) {
-		put_device(&memory->dev);
+		memory_block_put(memory);
 		return ret;
 	}
 	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
@@ -795,9 +785,9 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 	struct memory_block *mem;
 	int ret = 0;
 
-	mem = find_memory_block_by_id(block_id);
+	mem = memory_block_get(block_id);
 	if (mem) {
-		put_device(&mem->dev);
+		memory_block_put(mem);
 		return -EEXIST;
 	}
 	mem = kzalloc_obj(*mem);
@@ -845,8 +835,8 @@ static void remove_memory_block(struct memory_block *memory)
 		memory->group = NULL;
 	}
 
-	/* drop the ref. we got via find_memory_block() */
-	put_device(&memory->dev);
+	/* drop the ref. we got via memory_block_get() */
+	memory_block_put(memory);
 	device_unregister(&memory->dev);
 }
 
@@ -880,7 +870,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 		end_block_id = block_id;
 		for (block_id = start_block_id; block_id != end_block_id;
 		     block_id++) {
-			mem = find_memory_block_by_id(block_id);
+			mem = memory_block_get(block_id);
 			if (WARN_ON_ONCE(!mem))
 				continue;
 			remove_memory_block(mem);
@@ -908,7 +898,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 		return;
 
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		mem = find_memory_block_by_id(block_id);
+		mem = memory_block_get(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
 		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
@@ -1015,12 +1005,12 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
 		return 0;
 
 	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
-		mem = find_memory_block_by_id(block_id);
+		mem = memory_block_get(block_id);
 		if (!mem)
 			continue;
 
 		ret = func(mem, arg);
-		put_device(&mem->dev);
+		memory_block_put(mem);
 		if (ret)
 			break;
 	}
@@ -1228,22 +1218,22 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 void memblk_nr_poison_inc(unsigned long pfn)
 {
 	const unsigned long block_id = pfn_to_block_id(pfn);
-	struct memory_block *mem = find_memory_block_by_id(block_id);
+	struct memory_block *mem = memory_block_get(block_id);
 
 	if (mem) {
 		atomic_long_inc(&mem->nr_hwpoison);
-		put_device(&mem->dev);
+		memory_block_put(mem);
 	}
 }
 
 void memblk_nr_poison_sub(unsigned long pfn, long i)
 {
 	const unsigned long block_id = pfn_to_block_id(pfn);
-	struct memory_block *mem = find_memory_block_by_id(block_id);
+	struct memory_block *mem = memory_block_get(block_id);
 
 	if (mem) {
 		atomic_long_sub(i, &mem->nr_hwpoison);
-		put_device(&mem->dev);
+		memory_block_put(mem);
 	}
 }
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 126f66aa2c3e..b3333ca92090 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -847,13 +847,13 @@ static void register_memory_blocks_under_nodes(void)
 		for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
 			struct memory_block *mem;
 
-			mem = find_memory_block_by_id(block_id);
+			mem = memory_block_get(block_id);
 			if (!mem)
 				continue;
 
 			memory_block_add_nid_early(mem, nid);
 			do_register_memory_block_under_node(nid, mem);
-			put_device(&mem->dev);
+			memory_block_put(mem);
 		}
 
 	}
diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 78c054e26d17..6df1926d4c62 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -204,7 +204,7 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
 	addr = sclp_mem->id * block_size;
 	/*
 	 * Hold device_hotplug_lock when adding/removing memory blocks.
-	 * Additionally, also protect calls to find_memory_block() and
+	 * Additionally, also protect calls to memory_block_get() and
 	 * sclp_attach_storage().
 	 */
 	rc = lock_device_hotplug_sysfs();
@@ -231,20 +231,19 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
 			sclp_mem_change_state(addr, block_size, 0);
 			goto out_unlock;
 		}
-		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
-		put_device(&mem->dev);
+		mem = memory_block_get(phys_to_block_id(addr));
+		memory_block_put(mem);
 		WRITE_ONCE(sclp_mem->config, 1);
 	} else {
 		if (!sclp_mem->config)
 			goto out_unlock;
-		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
+		mem = memory_block_get(phys_to_block_id(addr));
 		if (mem->state != MEM_OFFLINE) {
-			put_device(&mem->dev);
+			memory_block_put(mem);
 			rc = -EBUSY;
 			goto out_unlock;
 		}
-		/* drop the ref just got via find_memory_block() */
-		put_device(&mem->dev);
+		memory_block_put(mem);
 		sclp_mem_change_state(addr, block_size, 0);
 		__remove_memory(addr, block_size);
 #ifdef CONFIG_KASAN
@@ -294,11 +293,11 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
 		return rc;
 	block_size = memory_block_size_bytes();
 	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
-	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
+	mem = memory_block_get(phys_to_block_id(sclp_mem->id * block_size));
 	if (!mem) {
 		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
 	} else {
-		put_device(&mem->dev);
+		memory_block_put(mem);
 		rc = -EBUSY;
 	}
 	unlock_device_hotplug();
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 5bb5599c6b2b..463dc02f6cff 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(enum memory_block_state state, void *v);
-extern struct memory_block *find_memory_block(unsigned long section_nr);
+struct memory_block *memory_block_get(unsigned long block_id);
+static inline void memory_block_put(struct memory_block *mem)
+{
+	put_device(&mem->dev);
+}
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
@@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int mgid);
 typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
 int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 			       struct memory_group *excluded, void *arg);
-struct memory_block *find_memory_block_by_id(unsigned long block_id);
 #define hotplug_memory_notifier(fn, pri) ({		\
 	static __meminitdata struct notifier_block fn##_mem_nb =\
 		{ .notifier_call = fn, .priority = pri };\
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 462d8dcd636d..890c6453e887 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1417,14 +1417,13 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 		struct vmem_altmap *altmap = NULL;
 		struct memory_block *mem;
 
-		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
+		mem = memory_block_get(phys_to_block_id(cur_start));
 		if (WARN_ON_ONCE(!mem))
 			continue;
 
 		altmap = mem->altmap;
 		mem->altmap = NULL;
-		/* drop the ref. we got via find_memory_block() */
-		put_device(&mem->dev);
+		memory_block_put(mem);
 
 		remove_memory_block_devices(cur_start, memblock_size);
 

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.54.0

