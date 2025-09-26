Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B92F747F;
	Fri, 26 Sep 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892560; cv=none; b=URaX5r7lMxdSKauVw1T2LkossbdxAmmSvR60S2sZB4Oj+QHpds2xce5br1EfOpqE1+hCAiApPGJV8NL+X/Qvj9KuHjHvXhh1yuG5O6cvWfIeFG10F2a0Iw6TA783VRv/cCm1SdXLBb4xouh9/n6swYdwoOGcQBNjQjy9dKp2OLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892560; c=relaxed/simple;
	bh=JHhjy8s8GeqjrAqPnBlHhkVqAFt4UXmwJNgXoyRhD0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1LvRwcwovaDxfu3FxDujwArUSMoLIEqnZa3vidh5Vc1MW4wc+za5Xhj4B+sB3CJEaRJQW0mlXum/9wcqXF71J6f6ZCakcVnZtyEr83lOhxf16TqpjlIVbxulpYgeKIYUCq9OAxBa1A9dwGrVBmkw1pw/BQVFlx+abj4j/I8xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZeuFrUnp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZeuFrUnp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q84hU5017942;
	Fri, 26 Sep 2025 13:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CCMInHtj909hnirOt
	T6cwhAW5aiD5aGOznaoZ/fwXnE=; b=ZeuFrUnp38E4uyL9pa6tcSwWt9TLkWMbE
	Cq/mlGmg0dh3VN56afRJQPWvOYGzTXmBjT3HHF20Ak1CibQrp5vJ7kVoTnB96XGf
	akdnjhni92ZWipcGKJqkce9nzdMFBkviFxVhuBjQ2ikRnvNVzRlv7yUsH9CmHCS4
	zBSGMMX7DhcOT14PKoqlmPiOIscrePgoVDmhrewoZdpURKWvHpVOcgm/mxsn4D7V
	o1DVaIx8+YKknQV+X+fJmp/W4VDHWOkXtilBmopdJCgbJTxUW2IruaVp85v8/xwM
	PfeMymrYMMd+Ic9etJZtRNANTgmWPQZfN9i0BS84YseYVrIZBHF3w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbdcqc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 13:15:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QAEbFW014292;
	Fri, 26 Sep 2025 13:15:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawm44xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 13:15:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QDFlPg51315030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 13:15:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32DD920043;
	Fri, 26 Sep 2025 13:15:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 002BF20040;
	Fri, 26 Sep 2025 13:15:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 13:15:46 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 2/4] s390/sclp: Add support for dynamic (de)configuration of memory
Date: Fri, 26 Sep 2025 15:15:25 +0200
Message-ID: <20250926131527.3260733-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=F/Jat6hN c=1 sm=1 tr=0 ts=68d69208 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=pwR9EbB1U1O9CTILHhwA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfXy2Gtu7DUbt3Y
 zeHnh/YNLdqGo5IaM392aFPK1BcChDKp+EGcxxMFtE5u9BqNlEmIKJ2EjJ07A0mshxDsXDY1YDQ
 sOhSLyDvNKQdLGmZcLe1utN8knanpILJfPcoCMbdPFiSkydZlPtyqXUfUCBdtDZdR17q/hqPPLy
 QeyY8I67ksbbdkgw7x58bCmgJxlmQbNQWI4HIXQPjrL9AGufocxbaf+4xPEMrUjdK0nLXej0r5G
 FY5jR0BElirMcXr6jXOcnGIkT5iEWsbGInAqvMcsaZqHHRHexegJtiu7poDVVy+X7lTy9Z/E39r
 EDGTke7lvHnC0Qa4pffLLcnbhd8+n0YXlPS3o4W8dlZw2EmGRpK0i+MJHpu4dKoeQK41ptFmbPK
 slVNn3iqT6WitrUoq53RSphR9796PQ==
X-Proofpoint-GUID: Ef3v96XAo9LvaLjWrxJxSrUkulDATlB7
X-Proofpoint-ORIG-GUID: Ef3v96XAo9LvaLjWrxJxSrUkulDATlB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

Provide a new interface for dynamic configuration and deconfiguration of
hotplug memory, allowing with/without memmap_on_memory support. It is a
follow up on the discussion with David when introducing memmap_on_memory
support for s390 and support dynamic (de)configuration of memory:
https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/
https://lore.kernel.org/all/20241202082732.3959803-1-sumanthk@linux.ibm.com/

The original motivation for introducing memmap_on_memory on s390 was to
avoid using online memory to store struct pages metadata, particularly
for standby memory blocks. This became critical in cases where there was
an imbalance between standby and online memory, potentially leading to
boot failures due to insufficient memory for metadata allocation.

To address this, memmap_on_memory was utilized on s390. However, in its
current form, it adds struct pages metadata at the start of each memory
block at the time of addition and this configuration is static. It
cannot be changed at runtime. (When the user needs continuous physical
memory).

Inorder to provide more flexibility to the user and overcome the above
limitation, add option to dynamically configure and deconfigure
hotpluggable memory block with/without memmap_on_memory.

With the new interface, s390 will not add all possible hotplug memory in
advance, like before, to make it visible in sysfs for online/offline
actions. Instead, before memory block can be set online, it has to be
configured via a new interface in /sys/firmware/memory/memoryX/config,
which makes s390 similar to others.  i.e. Adding of hotpluggable memory is
controlled by the user instead of adding it at boottime.

The s390 kernel sysfs interface to configure and deconfigure memory is
as follows (considering the upcoming lsmem changes):

* Initial memory layout:
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff   2G  online 0-15  yes        no
0x80000000-0xffffffff   2G offline 16-31 no         yes

* Configure memory
sys="/sys"
echo 1 > $sys/firmware/memory/memory16/config
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff    2G  online  0-15  yes        no
0x80000000-0x87ffffff  128M offline    16  yes        yes
0x88000000-0xffffffff  1.9G offline 17-31  no         yes

* Deconfigure memory
echo 0 > $sys/firmware/memory/memory16/config
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff   2G  online 0-15  yes        no
0x80000000-0xffffffff   2G offline 16-31 no         yes

3. Enable memmap_on_memory and online it.
echo 0 > $sys/devices/system/memory/memory5/online
echo 0 > $sys/firmware/memory/memory5/config

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online 0-4   yes        no
0x28000000-0x2fffffff  128M offline 5     no         no
0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
0x80000000-0xffffffff    2G offline 16-31 no         yes

echo 1 > $sys/firmware/memory/memory5/memmap_on_memory
echo 1 > $sys/firmware/memory/memory5/config
echo 1 > $sys/devices/system/memory/memory5/online

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online  0-4   yes        no
0x28000000-0x2fffffff  128M  online  5     yes        yes
0x30000000-0x7fffffff  1.3G  online  6-15  yes        no
0x80000000-0xffffffff    2G  offline 16-31 no         yes

4. Disable memmap_on_memory and online it.
echo 0 > $sys/devices/system/memory/memory5/online
echo 0 > $sys/firmware/memory/memory5/config

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online 0-4   yes        no
0x28000000-0x2fffffff  128M offline 5     no         yes
0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
0x80000000-0xffffffff    2G offline 16-31 no         yes

echo 0 > $sys/firmware/memory/memory5/memmap_on_memory
echo 1 > $sys/firmware/memory/memory5/config
echo 1 > $sys/devices/system/memory/memory5/online

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff  2G    online  0-15  yes        no
0x80000000-0xffffffff  2G    offline 16-31 no         yes

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/s390/char/sclp_mem.c | 291 +++++++++++++++++++++++++++++------
 1 file changed, 241 insertions(+), 50 deletions(-)

diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 27f49f5fd358..802439230294 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -9,9 +9,12 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/kstrtox.h>
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
@@ -27,7 +30,6 @@
 #define SCLP_CMDW_ASSIGN_STORAGE		0x000d0001
 #define SCLP_CMDW_UNASSIGN_STORAGE		0x000c0001
 
-static DEFINE_MUTEX(sclp_mem_mutex);
 static LIST_HEAD(sclp_mem_list);
 static u8 sclp_max_storage_id;
 static DECLARE_BITMAP(sclp_storage_ids, 256);
@@ -38,6 +40,18 @@ struct memory_increment {
 	int standby;
 };
 
+struct mblock {
+	struct kobject kobj;
+	unsigned int id;
+	unsigned int memmap_on_memory;
+	unsigned int config;
+};
+
+struct memory_block_arg {
+	struct mblock *mblocks;
+	struct kset *kset;
+};
+
 struct assign_storage_sccb {
 	struct sccb_header header;
 	u16 rn;
@@ -185,15 +199,11 @@ static int sclp_mem_notifier(struct notifier_block *nb,
 {
 	unsigned long start, size;
 	struct memory_notify *arg;
-	unsigned char id;
 	int rc = 0;
 
 	arg = data;
 	start = arg->start_pfn << PAGE_SHIFT;
 	size = arg->nr_pages << PAGE_SHIFT;
-	mutex_lock(&sclp_mem_mutex);
-	for_each_clear_bit(id, sclp_storage_ids, sclp_max_storage_id + 1)
-		sclp_attach_storage(id);
 	switch (action) {
 	case MEM_GOING_OFFLINE:
 		/*
@@ -204,45 +214,201 @@ static int sclp_mem_notifier(struct notifier_block *nb,
 		if (contains_standby_increment(start, start + size))
 			rc = -EPERM;
 		break;
-	case MEM_PREPARE_ONLINE:
-		/*
-		 * Access the altmap_start_pfn and altmap_nr_pages fields
-		 * within the struct memory_notify specifically when dealing
-		 * with only MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
-		 *
-		 * When altmap is in use, take the specified memory range
-		 * online, which includes the altmap.
-		 */
-		if (arg->altmap_nr_pages) {
-			start = PFN_PHYS(arg->altmap_start_pfn);
-			size += PFN_PHYS(arg->altmap_nr_pages);
-		}
-		rc = sclp_mem_change_state(start, size, 1);
-		if (rc || !arg->altmap_nr_pages)
-			break;
-		/*
-		 * Set CMMA state to nodat here, since the struct page memory
-		 * at the beginning of the memory block will not go through the
-		 * buddy allocator later.
-		 */
-		__arch_set_page_nodat((void *)__va(start), arg->altmap_nr_pages);
+	default:
 		break;
-	case MEM_FINISH_OFFLINE:
+	}
+	return rc ? NOTIFY_BAD : NOTIFY_OK;
+}
+
+static ssize_t config_mblock_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct mblock *mblock = container_of(kobj, struct mblock, kobj);
+
+	return sysfs_emit(buf, "%u\n", READ_ONCE(mblock->config));
+}
+
+static ssize_t config_mblock_store(struct kobject *kobj, struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	unsigned long long addr, block_size;
+	struct memory_block *mem;
+	struct mblock *mblock;
+	unsigned char id;
+	bool value;
+	int rc;
+
+	rc = kstrtobool(buf, &value);
+	if (rc)
+		return rc;
+	mblock = container_of(kobj, struct mblock, kobj);
+	block_size = memory_block_size_bytes();
+	addr = mblock->id * block_size;
+	/*
+	 * Hold device_hotplug_lock when adding/removing memory blocks.
+	 * Additionally, also protect calls to find_memory_block() and
+	 * sclp_attach_storage().
+	 */
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		goto out;
+	for_each_clear_bit(id, sclp_storage_ids, sclp_max_storage_id + 1)
+		sclp_attach_storage(id);
+	if (value) {
+		if (mblock->config)
+			goto out_unlock;
+		rc = sclp_mem_change_state(addr, block_size, 1);
+		if (rc)
+			goto out_unlock;
 		/*
-		 * When altmap is in use, take the specified memory range
-		 * offline, which includes the altmap.
+		 * Set entire memory block CMMA state to nodat. Later, when
+		 * page tables pages are allocated via __add_memory(), those
+		 * regions are marked __arch_set_page_dat().
 		 */
-		if (arg->altmap_nr_pages) {
-			start = PFN_PHYS(arg->altmap_start_pfn);
-			size += PFN_PHYS(arg->altmap_nr_pages);
+		__arch_set_page_nodat((void *)__va(addr), block_size >> PAGE_SHIFT);
+		rc = __add_memory(0, addr, block_size,
+				  mblock->memmap_on_memory ?
+				  MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
+		if (rc)
+			goto out_unlock;
+		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
+		put_device(&mem->dev);
+		WRITE_ONCE(mblock->config, 1);
+	} else {
+		if (!mblock->config)
+			goto out_unlock;
+		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
+		if (mem->state != MEM_OFFLINE) {
+			put_device(&mem->dev);
+			rc = -EBUSY;
+			goto out_unlock;
 		}
-		sclp_mem_change_state(start, size, 0);
-		break;
-	default:
-		break;
+		/* drop the ref just got via find_memory_block() */
+		put_device(&mem->dev);
+		sclp_mem_change_state(addr, block_size, 0);
+		__remove_memory(addr, block_size);
+		WRITE_ONCE(mblock->config, 0);
 	}
-	mutex_unlock(&sclp_mem_mutex);
-	return rc ? NOTIFY_BAD : NOTIFY_OK;
+out_unlock:
+	unlock_device_hotplug();
+out:
+	return rc ? rc : count;
+}
+
+static ssize_t memmap_on_memory_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct mblock *mblock = container_of(kobj, struct mblock, kobj);
+
+	return sysfs_emit(buf, "%u\n", READ_ONCE(mblock->memmap_on_memory));
+}
+
+static ssize_t memmap_on_memory_store(struct kobject *kobj, struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	unsigned long block_size;
+	struct memory_block *mem;
+	struct mblock *mblock;
+	bool value;
+	int rc;
+
+	rc = kstrtobool(buf, &value);
+	if (rc)
+		return rc;
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		return rc;
+	block_size = memory_block_size_bytes();
+	mblock = container_of(kobj, struct mblock, kobj);
+	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(mblock->id * block_size)));
+	if (!mem) {
+		WRITE_ONCE(mblock->memmap_on_memory, value);
+	} else {
+		put_device(&mem->dev);
+		rc = -EBUSY;
+	}
+	unlock_device_hotplug();
+	return rc ? rc : count;
+}
+
+static void mblock_sysfs_release(struct kobject *kobj)
+{
+	struct mblock *mblock = container_of(kobj, struct mblock, kobj);
+
+	kfree(mblock);
+}
+
+static const struct kobj_type ktype = {
+	.release = mblock_sysfs_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static struct kobj_attribute memmap_attr =
+	__ATTR(memmap_on_memory, 0644, memmap_on_memory_show, memmap_on_memory_store);
+static struct kobj_attribute config_attr =
+	__ATTR(config, 0644, config_mblock_show, config_mblock_store);
+
+static struct attribute *mblock_attrs[] = {
+	&memmap_attr.attr,
+	&config_attr.attr,
+	NULL,
+};
+
+static struct attribute_group mblock_attr_group = {
+	.attrs = mblock_attrs,
+};
+
+static int create_mblock(struct mblock *mblock, struct kset *kset,
+			 unsigned int id, bool config, bool memmap_on_memory)
+{
+	int rc;
+
+	mblock->memmap_on_memory = memmap_on_memory;
+	mblock->config = config;
+	mblock->id = id;
+	kobject_init(&mblock->kobj, &ktype);
+	rc = kobject_add(&mblock->kobj, &kset->kobj, "memory%d", id);
+	if (rc)
+		return rc;
+	rc = sysfs_create_group(&mblock->kobj, &mblock_attr_group);
+	if (rc)
+		kobject_put(&mblock->kobj);
+	return rc;
+}
+
+/*
+ * Create /sys/firmware/memory/memoryX for boottime configured online memory
+ * blocks
+ */
+static int create_online_mblock(struct memory_block *mem, void *argument)
+{
+	struct memory_block_arg *arg;
+	struct mblock *mblocks;
+	struct kset *kset;
+	unsigned int id;
+
+	id = mem->dev.id;
+	arg = (struct memory_block_arg *)argument;
+	mblocks = arg->mblocks;
+	kset = arg->kset;
+	return create_mblock(&mblocks[id], kset, id, true, false);
+}
+
+static int __init create_initial_online_mblocks(struct mblock *mblocks, struct kset *kset)
+{
+	struct memory_block_arg arg;
+
+	arg.mblocks = mblocks;
+	arg.kset = kset;
+	return for_each_memory_block(&arg, create_online_mblock);
+}
+
+static struct mblock * __init allocate_mblocks(void)
+{
+	u64 max_mblocks;
+	u64 block_size;
+
+	block_size = memory_block_size_bytes();
+	max_mblocks = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;
+	return kcalloc(max_mblocks, sizeof(struct mblock), GFP_KERNEL);
 }
 
 static struct notifier_block sclp_mem_nb = {
@@ -264,14 +430,17 @@ static void __init align_to_block_size(unsigned long *start,
 	*size = size_align;
 }
 
-static void __init add_memory_merged(u16 rn)
+static int __init create_standby_mblocks_merged(struct mblock *mblocks,
+						struct kset *kset, u16 rn)
 {
 	unsigned long start, size, addr, block_size;
 	static u16 first_rn, num;
+	unsigned int id;
+	int rc = 0;
 
 	if (rn && first_rn && (first_rn + num == rn)) {
 		num++;
-		return;
+		return rc;
 	}
 	if (!first_rn)
 		goto skip_add;
@@ -286,24 +455,31 @@ static void __init add_memory_merged(u16 rn)
 	if (!size)
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size) {
-		add_memory(0, addr, block_size,
-			   cpu_has_edat1() ?
-			   MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
+		id = addr / block_size;
+		rc = create_mblock(&mblocks[id], kset, id, false, mhp_supports_memmap_on_memory());
+		if (rc)
+			break;
 	}
 skip_add:
 	first_rn = rn;
 	num = 1;
+	return rc;
 }
 
-static void __init sclp_add_standby_memory(void)
+static int __init create_standby_mblocks(struct mblock *mblocks, struct kset *kset)
 {
 	struct memory_increment *incr;
+	int rc = 0;
 
 	list_for_each_entry(incr, &sclp_mem_list, list) {
 		if (incr->standby)
-			add_memory_merged(incr->rn);
+			rc = create_standby_mblocks_merged(mblocks, kset, incr->rn);
+		if (rc)
+			goto out;
 	}
-	add_memory_merged(0);
+	rc = create_standby_mblocks_merged(mblocks, kset, 0);
+out:
+	return rc;
 }
 
 static void __init insert_increment(u16 rn, int standby, int assigned)
@@ -336,10 +512,12 @@ static void __init insert_increment(u16 rn, int standby, int assigned)
 	list_add(&new_incr->list, prev);
 }
 
-static int __init sclp_detect_standby_memory(void)
+static int __init sclp_setup_memory(void)
 {
 	struct read_storage_sccb *sccb;
 	int i, id, assigned, rc;
+	struct mblock *mblocks;
+	struct kset *kset;
 
 	/* No standby memory in kdump mode */
 	if (oldmem_data.start)
@@ -391,9 +569,22 @@ static int __init sclp_detect_standby_memory(void)
 	rc = register_memory_notifier(&sclp_mem_nb);
 	if (rc)
 		goto out;
-	sclp_add_standby_memory();
+	mblocks = allocate_mblocks();
+	if (!mblocks) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	kset = kset_create_and_add("memory", NULL, firmware_kobj);
+	if (!kset) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	rc = create_initial_online_mblocks(mblocks, kset);
+	if (rc)
+		goto out;
+	rc = create_standby_mblocks(mblocks, kset);
 out:
 	free_page((unsigned long)sccb);
 	return rc;
 }
-__initcall(sclp_detect_standby_memory);
+__initcall(sclp_setup_memory);
-- 
2.48.1

