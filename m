Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52FA3AFB1B
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560351; cv=none; b=hHTRnYeyWg5OvQPN4HN04lrae0LpML65/f/yu0eaPLIkeV/KOJAjOSPjNuJRxb21eehbBolN8VhvfTyFG/RIwrb3N1zhMev5Hw3hmTHvE3xe0fQ4FUV/84eewYRltXul3ZZZRwuPxdePuKV8BKUUkeNw24aHGVfk7K+klx3cGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560351; c=relaxed/simple;
	bh=uL5bp8rtSkxNm7RlgOH8uTtqsknYla+JYkS+cGUEIRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oShsP5ZMQ1BnacO8AkRPghsUTRY5lC0bWQkGV57ZExtQOBeMxzCxWIsQBQz5r995qODDILZuVmZp2L29g0K77fBADhvyFqF4fxFd2mNTMJGsMzQVBdqaiIivhcQVXBrlDoSmQtODHqVLwofdmSqFHDqepgKwHw4h+fvOY1GuSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fN1sskmg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fN1sskmg"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5WFEC858644;
	Mon, 24 Aug 2026 08:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aRvARu0ajlqM4piDI
	Td7K2rBygg6kppEPJw7iMAJOlM=; b=fN1sskmgbrXB2BR3fVQ+4H/+uZ2TGsxji
	g+zCIo4oGuFxkjIT0Yp2KfXYA6pdN+3oJJxRZfOemV51czsRzhVkVymtiYdGfp1O
	bEtuawDn34O9hRMDvArlz/n5Hiv43VyZBejvXZxlrONqfmQuYlPbKfuT1y492FYz
	K4bC8LZYPG7c9KfTWWVsd7BkMHdzdZNEzkFzm2yG/XJjvqKvCf0xzAIRMK/kfjXb
	nFQ8LM2PF9EA0S+rR3OmsvDYWiVCXCUmyppDyABt2xljx14E1k4oW3azrW7FJvSn
	vaXovalWjshqpICGJcihS/zDkIpqoL0Q2P220xUB6U2bNvM7qo4SA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hgax3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QHhT014770;
	Mon, 24 Aug 2026 08:32:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pvyv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8W6NI35586460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:32:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C18A720043;
	Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97EAA2004B;
	Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 06/20] target/s390x: Adjust addressing mode checks for sha512 and sha256
Date: Mon, 24 Aug 2026 10:31:50 +0200
Message-ID: <20260824083204.40877-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX+04AJMxhi9Xd
 1XpYTH9ttwtlb4/QsVlsZqsqBCjmCxtspQDTPAsUokCFanyVWbePH6HtRB33d8awcsUljKjg4ct
 sebmtmhidE9slFmtP1lZGx+HglWi0sM=
X-Proofpoint-GUID: v22AKTaigAgv6q_Xw7fEH-mqenl8N5x2
X-Proofpoint-ORIG-GUID: v22AKTaigAgv6q_Xw7fEH-mqenl8N5x2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX82ssCj0Bq89k
 AT+t8cydAEpQBJuVne415sL7Rkel/Y/pWanLy0W8GcIVXbZEAxtyB0+yoV5MqA3ypch/dNRpW/v
 SAy8rx+iNutcc5A5JnA+vJUxGJ0J0vfnJUPhTSTkcXtO9c6IXGjUGoVn5JdpELEBNalQY4dtWgt
 MyKDNncnYFB1nayhUnYnOTPBB3NJYK1K+dU1a3lthPGfhzt9V3C1rTVxcKbZ2PN1s3t+brAAenL
 zxVeI/jSXZtKTRPz2R0t7t+wkkUzj6wL5da37o2fq73zvCRrRxRdP5xeCIe0nW2cOLRWyMFzmA7
 MQ7tl9EtVe0jkOy89x5ABwnFejD8GQT+pBtkPCnPSQFv8jkcrRKf/lOKv0r093+MnINHgW+3IfW
 lunEyNqaCPcLFdZU/pMmO/sCeDKMgTOQIhJevkaEgXMFCPP48DRBM9ENMyv4A9ksg9smNmoKSQU
 RB7ThAtqOAjAfIasU1w==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c018b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2oDd-pRd1qGgCFYxvY4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074

The handling for different addressing modes in the both sha
implementations cpacf sha256 and sha512 was incomplete. Rework this
addressing checking to clearly have support for s390 64 bit and 32 bit
addressing mode but raise an exception otherwise.

Also bail out early (for KIMD only) if length is 0.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/cpacf_sha256.c | 16 +++++++++++++---
 target/s390x/tcg/cpacf_sha512.c | 16 +++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/s390x/tcg/cpacf_sha256.c b/target/s390x/tcg/cpacf_sha256.c
index 67321b565c..de305b6838 100644
--- a/target/s390x/tcg/cpacf_sha256.c
+++ b/target/s390x/tcg/cpacf_sha256.c
@@ -111,14 +111,24 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 128 }; /* 128 * 64 = 8K */
     uint64_t len = *len_reg, processed = 0;
-    int message_reg_len = 64;
+    int message_reg_len;
     uint32_t a[8];
 
     g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
 
-    if (!(env->psw.mask & PSW_MASK_64)) {
+    /* check addressing mode, raise exception if not supported here */
+    if (env->psw.mask & PSW_MASK_64) {
+        message_reg_len = 64;
+    } else if (env->psw.mask & PSW_MASK_32) {
+        message_reg_len = 32;
         len = (uint32_t)len;
-        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    } else {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* for KIMD only: early bail out if length is zero */
+    if (type == S390_FEAT_TYPE_KIMD && !len) {
+        return 0;
     }
 
     /* KIMD: length has to be properly aligned. */
diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
index edd8dae78f..cad8e0e1bd 100644
--- a/target/s390x/tcg/cpacf_sha512.c
+++ b/target/s390x/tcg/cpacf_sha512.c
@@ -126,13 +126,23 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
     uint64_t len = *len_reg, a[8], processed = 0;
-    int message_reg_len = 64;
+    int message_reg_len;
 
     g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
 
-    if (!(env->psw.mask & PSW_MASK_64)) {
+    /* check addressing mode, raise exception if not supported here */
+    if (env->psw.mask & PSW_MASK_64) {
+        message_reg_len = 64;
+    } else if (env->psw.mask & PSW_MASK_32) {
+        message_reg_len = 32;
         len = (uint32_t)len;
-        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    } else {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* for KIMD only: early bail out if length is zero */
+    if (type == S390_FEAT_TYPE_KIMD && !len) {
+        return 0;
     }
 
     /* KIMD: length has to be properly aligned. */
-- 
2.43.0

