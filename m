Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785E1FA16C;
	Mon,  2 Dec 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128101; cv=none; b=lxKicUv9fAM3I54jsqE1okHGv02fsFsihANsxFyhFMP5RcUeVQb25qPuBWBXihKzWrkV43gyPjgn+PX0QHbVwdljjtexSGu52k7Y63zgsfmA5NhNoEofxR3Cp1erSO+fdhhvGguJl7x0f8K0Udtr8Ujsh+g8tbHTQOteRAyd8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128101; c=relaxed/simple;
	bh=Rf0ZjoDnR00pyvPccIKgbQEOUbeadoDktB9N2WQxguM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xcgk43shPbxcJ4Quq62r6Gy3cIfKiJaoYq8bbQqdvjeNw1Md7rb2eqyeVDFlZroipQjTzoBVzHn0dfiKHduI1ooZFXPSscCVetSx/Xx10OqZGKC9caKR9qMwsQyXvXvNwYOGoxnM7/vI0ryxkwx92CshaGLCZVe1xoLhXPSEYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LQWuR01L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LQWuR01L"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1Ka1ou025537;
	Mon, 2 Dec 2024 08:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PzEKgDn/rKSXqmNTX
	o3NBRYIUx3uyjVObkesFz0KD9k=; b=LQWuR01LmwBcb2be3LiGD17FjALpnnjDa
	5wehK/kPfLFi/ZURE+FSJ6y0CacVSOOBxwJ8jRpHoQ4l4VtrQSK9yx2L7d5bREx8
	OEM2z+/zpnVCJaHSDprEHW9zbEO+0iD06sY//q429GNmOUtXKhyZVsYMkHLYRL5D
	Mx3cVcIMTorNzmzhMC6kZgolb/hHl1gIWMxYCpbh1JHDdQU4eegapuZzHhC2d4Ht
	NRHtS/cvTirr4skFdYENNoOf6CcjUvZaVrRDf4XlS6kMY/K4crEFziIrxdVsZzno
	T1e83YOSpoPJzDvDCSPvb7VG13ioqOGcdHeFtwoRcU4/eniOnVVfw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbx7c1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:28:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B27WoQ0008576;
	Mon, 2 Dec 2024 08:28:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8j9wng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:28:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B28S8PU48693674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 08:28:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22D5F20043;
	Mon,  2 Dec 2024 08:28:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA9D120040;
	Mon,  2 Dec 2024 08:28:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 08:28:07 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [RFC PATCH 4/4] s390/sclp: Add support for dynamic (de)configuration of memory
Date: Mon,  2 Dec 2024 09:27:32 +0100
Message-ID: <20241202082732.3959803-5-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mNVRnZon9w0MjKg3c6OTZ7IdQtD_qvjb
X-Proofpoint-GUID: mNVRnZon9w0MjKg3c6OTZ7IdQtD_qvjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412020070

CONFIG_RUNTIME_MEMORY_CONFIGURATION introduced dynamic configuration and
deconfiguration of  hotpluggable memory with altmap/non-altmap support
during runtime.  Add support for dynamic (de)configuration of standby
memory on s390 by providing validation of s390 memory configuration
against user inputs by overriding arch_validate_memory_range().

Design:
1. If CONFIG_RUNTIME_MEMORY_CONFIGURATION is enabled, then support
   runtime (de)configuration of standby memory. If
   CONFIG_RUNTIME_MEMORY_CONFIGURATION is disabled, then provide
   backward compatibility and standby memory addition is performed
   during boottime.

2. If CONFIG_RUNTIME_MEMORY_CONFIGURATION is enabled,
   /sys/devices/system/memory/configure_memory sysfs interface exists.
   Perform memory block range validation against user inputs. Also,
   measures are taken to ensure that add_memory() / remove_memory() is
   performed on only standby memory ranges.

3. If CONFIG_RUNTIME_MEMORY_CONFIGURATION is enabled, provide the
   maximum number of configurable memory blocks on s390 via
   /sys/devices/system/memory/max_configurable.

   NOTE: When there is no hotpluggable standby memory and when
   CONFIG_RUNTIME_MEMORY_CONFIGURATION is enabled,
   /sys/devices/system/memory/max_configurable will return 0.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/s390/char/sclp_cmd.c | 80 ++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index f905a6643a0f..8c02097960b0 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -171,11 +171,15 @@ static DEFINE_MUTEX(sclp_mem_mutex);
 static LIST_HEAD(sclp_mem_list);
 static u8 sclp_max_storage_id;
 static DECLARE_BITMAP(sclp_storage_ids, 256);
+static bool runtime_memory_config = IS_ENABLED(CONFIG_RUNTIME_MEMORY_CONFIGURATION);
+static unsigned long long max_standby, max_online;
+static ssize_t max_configurable;
 
 struct memory_increment {
 	struct list_head list;
 	u16 rn;
 	int standby;
+	int boot_standby;
 };
 
 struct assign_storage_sccb {
@@ -390,24 +394,29 @@ static struct notifier_block sclp_mem_nb = {
 	.notifier_call = sclp_mem_notifier,
 };
 
-static void __init align_to_block_size(unsigned long long *start,
-				       unsigned long long *size,
-				       unsigned long long alignment)
+static void align_to_block_size(unsigned long long *start,
+				unsigned long long *size,
+				unsigned long long alignment)
 {
-	unsigned long long start_align, size_align;
+	unsigned long long start_align;
 
 	start_align = roundup(*start, alignment);
-	size_align = rounddown(*start + *size, alignment) - start_align;
-
-	pr_info("Standby memory at 0x%llx (%lluM of %lluM usable)\n",
-		*start, size_align >> 20, *size >> 20);
+	*size = rounddown(*start + *size, alignment) - start_align;
 	*start = start_align;
-	*size = size_align;
+}
+
+static void __init set_max_memory_configuration(void)
+{
+	unsigned long long blocksz = memory_block_size_bytes();
+
+	max_online = roundup(max_online, blocksz);
+	max_configurable = (max_online + max_standby) / blocksz;
 }
 
 static void __init add_memory_merged(u16 rn)
 {
 	unsigned long long start, size, addr, block_size;
+	unsigned long long basesize, basestart;
 	static u16 first_rn, num;
 
 	if (rn && first_rn && (first_rn + num == rn)) {
@@ -423,9 +432,17 @@ static void __init add_memory_merged(u16 rn)
 	if (start + size > ident_map_size)
 		size = ident_map_size - start;
 	block_size = memory_block_size_bytes();
+	basestart = start;
+	basesize = size;
 	align_to_block_size(&start, &size, block_size);
+	pr_info("Standby memory at 0x%llx (%lluM of %lluM usable)\n",
+		basestart, size >> 20, basesize >> 20);
 	if (!size)
 		goto skip_add;
+	if (runtime_memory_config) {
+		max_standby += size;
+		goto skip_add;
+	}
 	for (addr = start; addr < start + size; addr += block_size)
 		add_memory(0, addr, block_size,
 			   MACHINE_HAS_EDAT1 ?
@@ -435,6 +452,48 @@ static void __init add_memory_merged(u16 rn)
 	num = 1;
 }
 
+#ifdef CONFIG_RUNTIME_MEMORY_CONFIGURATION
+bool arch_validate_memory_range(unsigned long long start, unsigned long long end)
+{
+	unsigned long long incr_start, incr_end, curr = start;
+	struct memory_increment *incr;
+	bool rangefound = false;
+
+	if (start >= ident_map_size || end + 1 > ident_map_size) {
+		pr_info("Memory range (start:0x%llx,end:0x%llx) exceeds max physical memory (0x%lx)\n",
+			start, end, ident_map_size);
+		goto out;
+	}
+
+	list_for_each_entry(incr, &sclp_mem_list, list) {
+		incr_start = rn2addr(incr->rn);
+		incr_end = incr_start + sclp.rzm - 1;
+
+		if (curr != incr_start)
+			continue;
+		/*
+		 * Allow runtime configuration/deconfiguration for only
+		 * standby memory
+		 */
+		if (!incr->boot_standby)
+			goto out;
+		if (incr_end == end) {
+			rangefound = true;
+			goto out;
+		} else {
+			curr = incr_end + 1;
+		}
+	}
+out:
+	return rangefound;
+}
+
+ssize_t arch_get_memory_max_configurable(void)
+{
+	return max_configurable;
+}
+#endif
+
 static void __init sclp_add_standby_memory(void)
 {
 	struct memory_increment *incr;
@@ -456,6 +515,7 @@ static void __init insert_increment(u16 rn, int standby, int assigned)
 		return;
 	new_incr->rn = rn;
 	new_incr->standby = standby;
+	new_incr->boot_standby = standby;
 	last_rn = 0;
 	prev = &sclp_mem_list;
 	list_for_each_entry(incr, &sclp_mem_list, list) {
@@ -502,6 +562,7 @@ static int __init sclp_detect_standby_memory(void)
 				if (!sccb->entries[i])
 					continue;
 				assigned++;
+				max_online += sclp.rzm;
 				insert_increment(sccb->entries[i] >> 16, 0, 1);
 			}
 			break;
@@ -530,6 +591,7 @@ static int __init sclp_detect_standby_memory(void)
 	if (rc)
 		goto out;
 	sclp_add_standby_memory();
+	set_max_memory_configuration();
 out:
 	free_page((unsigned long) sccb);
 	return rc;
-- 
2.45.2

