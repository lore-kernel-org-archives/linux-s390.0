Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB22FBDFD;
	Thu,  4 Dec 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866085; cv=none; b=d8+Oum42luSbE1+K1ui2GwntAv3XuGfLWPq38W3GkxJz8DfDXGSfjBICxD/2CMYvpUmpnb8f/aot0MaqjyJ49Tm07Kvtzssr6mO/vodycJ9pN1bBTFKS/59YjTaOGnv/rxtUyhiXh4En/z1V+Z51TWcKYnoeJY7dqiGWfEXQzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866085; c=relaxed/simple;
	bh=l0h9NwtqIzka2dRkGpbxvUA8DMdzpHh+xnPUsLtLJB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luY9QNtLr/ZV05SgzBLBlNKlWZoUFgRJjUe00gW1lacUEEE9ScFuxcoDoyq6OQGCUn0CkVTEIX1tgcqM/QOe6YpbHV3vr9D59sWc3j7YAPhAIS50S8+DPfeZ61JfMAy9sowIhxf6u2sgfanf+RjTszpWGemXDFnwI80f6zi11mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sg5B4f31; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sg5B4f31"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4EhQfq026734;
	Thu, 4 Dec 2025 16:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vrCbVJ/BQ0Ha1YJUK
	7A0X8T0CVcxlUZtnQZoJx5ZeY4=; b=sg5B4f31dnT+cB/xVmsNTz9UvhgHWG31a
	nK/uXDefq/P5Deoo2G7A+GLcot82ZmDd97L5zK6UI3wHND9wY+gRirliUA5DvcVt
	2QT3JHfRmaRXO1FpDjqEIMhQaRV39GPkgNax4lGuXeITCvnAbct0gC26MB5NgBcu
	KccjcAf5OAkbX5LsNv0Hlync2KQmrNm78E2XtvZQ6ojgScJk+1GgmVgWyeCYAU7l
	DLrsbaMMUkahvmFlj8/TO18X9yGe0yek57C6N8W2Q07GKELfRPduFqf+SgjtFgX5
	xsSZZwW8xK6xbfsTeX9k+nnnLMwkRvuReUadc+5JFsaqbsOH2e6QQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh79gwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:34:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4GHeK4021731;
	Thu, 4 Dec 2025 16:34:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4at8c6j0cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:34:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4GYXgc47448492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 16:34:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D09020040;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7746A2004B;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] scripts/gdb: add lx_current support for s390
Date: Thu,  4 Dec 2025 17:34:23 +0100
Message-ID: <20251204163425.370783-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204163425.370783-1-jremus@linux.ibm.com>
References: <20251204163425.370783-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=6931b81e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=LhY7sLBagfltCj_edY4A:9
X-Proofpoint-GUID: lq2CQxX25AMha2fQo8cWiSS3WAhS_2eK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX8gRVWYffS58D
 thzNWfYnSuHqHJCAOLxpJINIEIAPIoSzdXLnEzG8jhzFcJlVKhownecDJzsPvjPn6Q0SCrj+iTv
 3HWL0OiECuLdVN5h+EGbJOzJgepkU5oUHRP/DScho/mWxV+SdlgBMV5hRHIo7s3UUN//dGqjjXa
 FPdZEhkVPoABI0cvudpGe8XERDJ5o+rUKLxtoMVoXbPoRVwUc8QU4VMUao6fSSJ6I2/aRjugXxQ
 C03DuIqrYanh9IkCRZupprYwpSRU2y25b5Ou7F51/pxF0CJ4bq4fqXZH5BN/GC6a00Ibj509us0
 686266FEj/S+uYfqjUz0TdFkFFHOnNSJZhMLbomLHuggQ/8PrwqKSr/ypsRHFpW4WI9e8EI3t1S
 n62tN35MAGiD3IhQ+kxFDN2gLQ7KFQ==
X-Proofpoint-ORIG-GUID: lq2CQxX25AMha2fQo8cWiSS3WAhS_2eK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

s390 uses lowcore field current_task.  Depending on s390 machine feature
MFEATURE_LOWCORE the lowcore of the current CPU is either located at 0
or LOWCORE_ALT_ADDRESS.  The lowcore address of any other CPUs can be
retrieved from lowcore_ptr[], which is indexed by CPU number.  Note that
due to prefixing the lowcore of the current CPU cannot be addressed using
the address in lowcore_ptr[].

Add helpers to test for s390 machine features, test for s390 relocated
lowcore, and obtain the s390 lowcore address for a particular CPU.  Use
these to implement lx_current support for s390.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 scripts/gdb/linux/constants.py.in | 14 +++++++++++++
 scripts/gdb/linux/cpus.py         | 35 ++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index c3886739a028..68c45fb27635 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -24,6 +24,10 @@
 #include <linux/slab.h>
 #include <linux/threads.h>
 #include <linux/vmalloc.h>
+#ifdef CONFIG_S390
+#include <asm/lowcore.h>
+#include <asm/machine.h>
+#endif
 
 /* We need to stringify expanded macros so that they can be parsed */
 
@@ -122,6 +126,15 @@ LX_GDBPARSED(SLAB_CACHE_DMA32)
 LX_GDBPARSED(SLAB_STORE_USER)
 LX_GDBPARSED(SLAB_PANIC)
 
+/* asm/lowcore.h */
+if IS_BUILTIN(CONFIG_S390):
+    LX_GDBPARSED(LOWCORE_ALT_ADDRESS)
+
+/* asm/machine.h */
+if IS_BUILTIN(CONFIG_S390):
+    LX_VALUE(MFEATURE_LOWCORE)
+    LX_GDBPARSED(MAX_MFEATURE_BIT)
+
 /* Kernel Configs */
 LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS)
 LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
@@ -170,3 +183,4 @@ LX_CONFIG(CONFIG_PAGE_OWNER)
 LX_CONFIG(CONFIG_SLUB_DEBUG)
 LX_CONFIG(CONFIG_SLAB_FREELIST_HARDENED)
 LX_CONFIG(CONFIG_MMU)
+LX_CONFIG(CONFIG_S390)
diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 6edf4ef61636..12bf37d6a4e5 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -13,7 +13,7 @@
 
 import gdb
 
-from linux import tasks, utils
+from linux import constants, tasks, utils
 
 
 task_type = utils.CachedType("struct task_struct")
@@ -206,6 +206,11 @@ def get_current_task(cpu):
         if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
             current_task = scratch_reg.cast(task_ptr_type)
 
+        return current_task.dereference()
+    elif utils.is_target_arch("s390"):
+        lowcore = s390_lowcore(cpu)
+        current_task_addr = lowcore["current_task"]
+        current_task = current_task_addr.cast(task_ptr_type)
         return current_task.dereference()
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
@@ -225,3 +230,31 @@ number. If CPU is omitted, the CPU of the current context is used."""
 
 
 LxCurrentFunc()
+
+
+def s390_machine_feature(nr):
+    if nr >= constants.LX_MAX_MFEATURE_BIT:
+        raise gdb.GdbError("Sorry, the s390 machine feature number is "
+                           "out of bounds.")
+
+    machine_features = gdb.parse_and_eval("machine_features")
+    bits_per_entry = machine_features[0].type.sizeof * 8
+    entry = machine_features[nr // bits_per_entry]
+    return (entry & (1 << (nr % bits_per_entry))) != 0
+
+
+def s390_machine_has_relocated_lowcore():
+    return s390_machine_feature(constants.LX_MFEATURE_LOWCORE)
+
+
+def s390_lowcore(cpu):
+    if cpu == -1 or cpu == get_current_cpu():
+        if s390_machine_has_relocated_lowcore():
+            lowcore = constants.LX_LOWCORE_ALT_ADDRESS
+        else:
+            lowcore = gdb.Value(0)
+    else:
+        lowcore = gdb.parse_and_eval("lowcore_ptr[{0}]".format(str(cpu)))
+
+    lowcore_ptr_type = gdb.lookup_type("struct lowcore").pointer()
+    return lowcore.cast(lowcore_ptr_type)
-- 
2.51.0

