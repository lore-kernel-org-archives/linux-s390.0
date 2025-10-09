Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836492E718B;
	Thu,  9 Oct 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015952; cv=none; b=mGkE5HVFA5LzNR9X6gcXFWsoFf0MDQ/AgcW7RzNf41hhAQpSw/I9Sf11Wi1vjte5dqAemu0DZBV07ckOvpEv0jMmHnSK4CcankSMqmyKKoPEN2sLWJcs5Jqf04IOdoHPHlSVbVFiLCuTV+WBC26vw9rLVDALjPzoNw7dJCQ7RwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015952; c=relaxed/simple;
	bh=dA37uS3YtbilzAnWUNn1K4im31eoyTB95/zngLeG9pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnNffSV0Oqv6r33qapFeW64B4G4J90zG9+pnJOwdaFDegXWAOEq0/Hi2PHS2FqE+9yGUiuJFoaLOWOOCYnGJN3SSprSu/dWzL6oZINBtLRFyp/zWeXAElTfIv98KKQCTq1TG11IM9y5zeofqjpIh2mCGtP7tW53zaXevLcM+vMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Du4Pmqfv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Du4Pmqfv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5995D1Yl012246;
	Thu, 9 Oct 2025 13:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0bvhvquXJlGMrWyEJ
	NqHpYrGGoYDnvmTBQiNmJBrPyQ=; b=Du4PmqfvnSsktTreTh4QWMYS+d38bWdGG
	Rgj1XMzUs/2MArYY4RWv3FkavMS06NK+Dq+zkO7xnkYA3lsoeOwSGnJq8CZGzBR3
	7NG5PAzX3qs+itq+ALLD0TKNgOu+guT4+I64NMxA4/VZ6La8NTdQNKCRtixLGYd4
	HhDR1fOgIN+FFgx7TdImr2Dmy6930q1wrj47z/xfYzcaNSJloXUG5sLnGPfYz/KE
	sOGmPsHYje3Ut4Jy65qP2mbx3vBmWrsDOxd4F3ymzlh0f3u41ZfN5MxQkunfZVX4
	vqhNPLXC3p/ilmbrDNjGwxDEsAzSC2EPPw14OoUdUoKYitCvxB7Iw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv7ycxdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 13:19:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599CMJ6L012985;
	Thu, 9 Oct 2025 13:18:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamvn8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 13:18:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599DIucH23397022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 13:18:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 024B920040;
	Thu,  9 Oct 2025 13:18:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B787E20043;
	Thu,  9 Oct 2025 13:18:55 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 13:18:55 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v2 2/4] s390/sclp: Add support for dynamic (de)configuration of memory
Date: Thu,  9 Oct 2025 15:18:37 +0200
Message-ID: <20251009131839.3739108-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
References: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XSeOwOWhV_ud2t3ZLD-3Ka6yVa7LN-bX
X-Proofpoint-ORIG-GUID: XSeOwOWhV_ud2t3ZLD-3Ka6yVa7LN-bX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/M+SGmGCZbKk
 WUFt3L4RSI/eeog+Mbtn4yxHeR7JSER90LUccaSlOgmroeHByouTJMRuFsMKEeWTOWkGOg0hoif
 yHVEmQB4bhG5b21ggEYfNfsj7ic3jmkl/5aklGWeFDguBbKV19mGsLeYEBRGot2rrbRVqM6PQJt
 GWmglg2mlHI4tmH/G7X2tliCr3SoPbkXuUbk3N0HsvrP/Sw/EzpH76Kn8JVFtSiWI+rMxYwZIVZ
 8Bgi1eNmLay/WoPRVWiZhdE/xSp7R0An/O4CHK9czK0G7j6JdfNno7oXfYFUqCDtA7U/9koUS0M
 R3N8w44k/9KDH3jJKEv4kO85GmBBOBJ07hlLeB6X+GD+KrdqPJm2MBJuB5FCpzdyaXVneeNd7v5
 V6B+8/7rATRazw+2ktFF8oN/BxOmKw==
X-Authority-Analysis: v=2.4 cv=FtwIPmrq c=1 sm=1 tr=0 ts=68e7b644 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=GHt7ZKPcJgLmr8k-lvIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

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
 drivers/s390/char/sclp_mem.c | 290 +++++++++++++++++++++++++----------
 1 file changed, 207 insertions(+), 83 deletions(-)

diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 27f49f5fd358..e1302b1c98ac 100644
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
 
+struct sclp_mem {
+	struct kobject kobj;
+	unsigned int id;
+	unsigned int memmap_on_memory;
+	unsigned int config;
+};
+
+struct sclp_mem_arg {
+	struct sclp_mem *sclp_mems;
+	struct kset *kset;
+};
+
 struct assign_storage_sccb {
 	struct sccb_header header;
 	u16 rn;
@@ -163,92 +177,165 @@ static int sclp_mem_change_state(unsigned long start, unsigned long size,
 	return rc ? -EIO : 0;
 }
 
-static bool contains_standby_increment(unsigned long start, unsigned long end)
+static ssize_t config_sclp_mem_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	struct memory_increment *incr;
-	unsigned long istart;
+	struct sclp_mem *sclp_mem = container_of(kobj, struct sclp_mem, kobj);
 
-	list_for_each_entry(incr, &sclp_mem_list, list) {
-		istart = rn2addr(incr->rn);
-		if (end - 1 < istart)
-			continue;
-		if (start > istart + sclp.rzm - 1)
-			continue;
-		if (incr->standby)
-			return true;
-	}
-	return false;
+	return sysfs_emit(buf, "%u\n", READ_ONCE(sclp_mem->config));
 }
 
-static int sclp_mem_notifier(struct notifier_block *nb,
-			     unsigned long action, void *data)
+static ssize_t config_sclp_mem_store(struct kobject *kobj, struct kobj_attribute *attr,
+				     const char *buf, size_t count)
 {
-	unsigned long start, size;
-	struct memory_notify *arg;
+	unsigned long addr, block_size;
+	struct sclp_mem *sclp_mem;
+	struct memory_block *mem;
 	unsigned char id;
-	int rc = 0;
+	bool value;
+	int rc;
 
-	arg = data;
-	start = arg->start_pfn << PAGE_SHIFT;
-	size = arg->nr_pages << PAGE_SHIFT;
-	mutex_lock(&sclp_mem_mutex);
+	rc = kstrtobool(buf, &value);
+	if (rc)
+		return rc;
+	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
+	block_size = memory_block_size_bytes();
+	addr = sclp_mem->id * block_size;
+	/*
+	 * Hold device_hotplug_lock when adding/removing memory blocks.
+	 * Additionally, also protect calls to find_memory_block() and
+	 * sclp_attach_storage().
+	 */
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		goto out;
 	for_each_clear_bit(id, sclp_storage_ids, sclp_max_storage_id + 1)
 		sclp_attach_storage(id);
-	switch (action) {
-	case MEM_GOING_OFFLINE:
-		/*
-		 * Do not allow to set memory blocks offline that contain
-		 * standby memory. This is done to simplify the "memory online"
-		 * case.
-		 */
-		if (contains_standby_increment(start, start + size))
-			rc = -EPERM;
-		break;
-	case MEM_PREPARE_ONLINE:
+	if (value) {
+		if (sclp_mem->config)
+			goto out_unlock;
+		rc = sclp_mem_change_state(addr, block_size, 1);
+		if (rc)
+			goto out_unlock;
 		/*
-		 * Access the altmap_start_pfn and altmap_nr_pages fields
-		 * within the struct memory_notify specifically when dealing
-		 * with only MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
-		 *
-		 * When altmap is in use, take the specified memory range
-		 * online, which includes the altmap.
+		 * Set entire memory block CMMA state to nodat. Later, when
+		 * page tables pages are allocated via __add_memory(), those
+		 * regions are marked __arch_set_page_dat().
 		 */
-		if (arg->altmap_nr_pages) {
-			start = PFN_PHYS(arg->altmap_start_pfn);
-			size += PFN_PHYS(arg->altmap_nr_pages);
+		__arch_set_page_nodat((void *)__va(addr), block_size >> PAGE_SHIFT);
+		rc = __add_memory(0, addr, block_size,
+				  sclp_mem->memmap_on_memory ?
+				  MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
+		if (rc) {
+			sclp_mem_change_state(addr, block_size, 0);
+			goto out_unlock;
 		}
-		rc = sclp_mem_change_state(start, size, 1);
-		if (rc || !arg->altmap_nr_pages)
-			break;
-		/*
-		 * Set CMMA state to nodat here, since the struct page memory
-		 * at the beginning of the memory block will not go through the
-		 * buddy allocator later.
-		 */
-		__arch_set_page_nodat((void *)__va(start), arg->altmap_nr_pages);
-		break;
-	case MEM_FINISH_OFFLINE:
-		/*
-		 * When altmap is in use, take the specified memory range
-		 * offline, which includes the altmap.
-		 */
-		if (arg->altmap_nr_pages) {
-			start = PFN_PHYS(arg->altmap_start_pfn);
-			size += PFN_PHYS(arg->altmap_nr_pages);
+		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
+		put_device(&mem->dev);
+		WRITE_ONCE(sclp_mem->config, 1);
+	} else {
+		if (!sclp_mem->config)
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
+		WRITE_ONCE(sclp_mem->config, 0);
 	}
-	mutex_unlock(&sclp_mem_mutex);
-	return rc ? NOTIFY_BAD : NOTIFY_OK;
+out_unlock:
+	unlock_device_hotplug();
+out:
+	return rc ? rc : count;
 }
 
-static struct notifier_block sclp_mem_nb = {
-	.notifier_call = sclp_mem_notifier,
+static ssize_t memmap_on_memory_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct sclp_mem *sclp_mem = container_of(kobj, struct sclp_mem, kobj);
+
+	return sysfs_emit(buf, "%u\n", READ_ONCE(sclp_mem->memmap_on_memory));
+}
+
+static ssize_t memmap_on_memory_store(struct kobject *kobj, struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct sclp_mem *sclp_mem;
+	unsigned long block_size;
+	struct memory_block *mem;
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
+	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
+	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
+	if (!mem) {
+		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
+	} else {
+		put_device(&mem->dev);
+		rc = -EBUSY;
+	}
+	unlock_device_hotplug();
+	return rc ? rc : count;
+}
+
+static const struct kobj_type ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
 };
 
+static struct kobj_attribute memmap_attr =
+	__ATTR(memmap_on_memory, 0644, memmap_on_memory_show, memmap_on_memory_store);
+static struct kobj_attribute config_attr =
+	__ATTR(config, 0644, config_sclp_mem_show, config_sclp_mem_store);
+
+static struct attribute *sclp_mem_attrs[] = {
+	&memmap_attr.attr,
+	&config_attr.attr,
+	NULL,
+};
+
+static struct attribute_group sclp_mem_attr_group = {
+	.attrs = sclp_mem_attrs,
+};
+
+static int create_sclp_mem(struct sclp_mem *sclp_mem, struct kset *kset,
+			   unsigned int id, bool config, bool memmap_on_memory)
+{
+	int rc;
+
+	sclp_mem->memmap_on_memory = memmap_on_memory;
+	sclp_mem->config = config;
+	sclp_mem->id = id;
+	kobject_init(&sclp_mem->kobj, &ktype);
+	rc = kobject_add(&sclp_mem->kobj, &kset->kobj, "memory%d", id);
+	if (rc)
+		return rc;
+	return sysfs_create_group(&sclp_mem->kobj, &sclp_mem_attr_group);
+}
+
+static int create_configured_sclp_mem(struct memory_block *mem, void *argument)
+{
+	struct sclp_mem *sclp_mems;
+	struct sclp_mem_arg *arg;
+	struct kset *kset;
+	unsigned int id;
+
+	id = mem->dev.id;
+	arg = (struct sclp_mem_arg *)argument;
+	sclp_mems = arg->sclp_mems;
+	kset = arg->kset;
+	return create_sclp_mem(&sclp_mems[id], kset, id, true, false);
+}
+
 static void __init align_to_block_size(unsigned long *start,
 				       unsigned long *size,
 				       unsigned long alignment)
@@ -264,14 +351,17 @@ static void __init align_to_block_size(unsigned long *start,
 	*size = size_align;
 }
 
-static void __init add_memory_merged(u16 rn)
+static int __init create_standby_sclp_mems_merged(struct sclp_mem *sclp_mems,
+						  struct kset *kset, u16 rn)
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
@@ -286,24 +376,61 @@ static void __init add_memory_merged(u16 rn)
 	if (!size)
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size) {
-		add_memory(0, addr, block_size,
-			   cpu_has_edat1() ?
-			   MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
+		id = addr / block_size;
+		rc = create_sclp_mem(&sclp_mems[id], kset, id, false,
+				     mhp_supports_memmap_on_memory());
+		if (rc)
+			break;
 	}
 skip_add:
 	first_rn = rn;
 	num = 1;
+	return rc;
 }
 
-static void __init sclp_add_standby_memory(void)
+static int __init create_standby_sclp_mems(struct sclp_mem *sclp_mems, struct kset *kset)
 {
 	struct memory_increment *incr;
+	int rc = 0;
 
 	list_for_each_entry(incr, &sclp_mem_list, list) {
 		if (incr->standby)
-			add_memory_merged(incr->rn);
+			rc = create_standby_sclp_mems_merged(sclp_mems, kset, incr->rn);
+		if (rc)
+			goto out;
 	}
-	add_memory_merged(0);
+	rc = create_standby_sclp_mems_merged(sclp_mems, kset, 0);
+out:
+	return rc;
+}
+
+static int __init init_sclp_mem(void)
+{
+	const u64 block_size = memory_block_size_bytes();
+	const u64 max_sclp_mems = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;
+	struct sclp_mem *sclp_mems;
+	struct sclp_mem_arg arg;
+	struct kset *kset;
+	int rc;
+
+	/* Allocate memory for all blocks ahead of time. */
+	sclp_mems = kcalloc(max_sclp_mems, sizeof(struct sclp_mem), GFP_KERNEL);
+	if (!sclp_mems)
+		return -ENOMEM;
+
+	kset = kset_create_and_add("memory", NULL, firmware_kobj);
+	if (!kset)
+		return -ENOMEM;
+
+	/* Initial memory is in the "configured" state already. */
+	arg.sclp_mems = sclp_mems;
+	arg.kset = kset;
+	rc = for_each_memory_block(&arg, create_configured_sclp_mem);
+	if (rc)
+		return rc;
+
+	/* Standby memory is "deconfigured". */
+	return create_standby_sclp_mems(sclp_mems, kset);
 }
 
 static void __init insert_increment(u16 rn, int standby, int assigned)
@@ -336,7 +463,7 @@ static void __init insert_increment(u16 rn, int standby, int assigned)
 	list_add(&new_incr->list, prev);
 }
 
-static int __init sclp_detect_standby_memory(void)
+static int __init sclp_setup_memory(void)
 {
 	struct read_storage_sccb *sccb;
 	int i, id, assigned, rc;
@@ -388,12 +515,9 @@ static int __init sclp_detect_standby_memory(void)
 		goto out;
 	for (i = 1; i <= sclp.rnmax - assigned; i++)
 		insert_increment(0, 1, 0);
-	rc = register_memory_notifier(&sclp_mem_nb);
-	if (rc)
-		goto out;
-	sclp_add_standby_memory();
+	rc = init_sclp_mem();
 out:
 	free_page((unsigned long)sccb);
 	return rc;
 }
-__initcall(sclp_detect_standby_memory);
+__initcall(sclp_setup_memory);
-- 
2.48.1

