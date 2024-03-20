Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B485C48
	for <linux-s390@vger.kernel.org>; Wed, 20 Mar 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975634; cv=none; b=lLYi//mwbzj+zoXVNbAeeL8m7wKClMY2BR2EW9Qpr2unPEq0djW1J05xtSIvrqf04QqkCaxMyn0Q/gSuMpZmlRgjYUVnW8mBk7IEhMWUQ6Fx/zHQFbT/3KimZMPbjSJK6q+fVVfnBWGFyMzVBEKhaK9BuqHLIjm4FyphJcTd2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975634; c=relaxed/simple;
	bh=/NY8FmO7ZI1aK3e70masBM1dswP60jKoQyywixyxEgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyI6ENPWmPvIFuq86xRaPHOBKNncv/XYc80gZtRac5+Ra2BRqOpWPRYRvSfhrlKJtt52wrPR4C/EH16NNe8bCuwDsUXgUXyyLuWfMkgK0tckVP3qP22q7B4oGcuVLkFO1Tyw1ZIK4OAAE4CmGwM6VYm3qEp59Xf3vhRmDEHr14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FsSQ0uZi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FsSQ0uZi"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KMQJPb024730;
	Wed, 20 Mar 2024 23:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KVAlX/vg4g/Vw3cCeQBf7HQNVqcsz6sZF0Hw9NG3AsY=;
 b=FsSQ0uZiy+1OYzgPI3GIXkBf7oZ4r9LElQY2HILkMX0IBJZ2LANaqvTzzzzEpK0o3jh5
 mvE0uZESwGlpTtFzqED6xLPL09ktRHz1mz2gZNgCrzDpvZSPB7WSyUHL5fMgjco50aAa
 g97fpCXzvzlyna11bbgyjVf00DD6kk31mbDJ9AF++RZgKUIZxYUdI+hNzAi9DN8kne+G
 +eqnj64rvZK/7lsqRfb4uwWP+T5qbj77xulXcNE7NaONBXZ8EulpYIkCFGy94x0rCDrF
 32deZKYf3zMFJq5mvlmQy3hUb91ZOV5g+WEddck3iN4ngCUze6OuQ1H/BG5yqlD2WPLE CA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0644rbs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 23:00:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KMCcNF017266;
	Wed, 20 Mar 2024 23:00:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrthk6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 23:00:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KN0Hrk42533338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 23:00:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9A2720043;
	Wed, 20 Mar 2024 23:00:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 475F22004B;
	Wed, 20 Mar 2024 23:00:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.8.38])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 23:00:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] s390/preempt: mark all functions __always_inline
Date: Wed, 20 Mar 2024 23:47:49 +0100
Message-ID: <20240320230007.4782-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320230007.4782-1-iii@linux.ibm.com>
References: <20240320230007.4782-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XABTZXZAwGvyESP_J1XS_miNyvaqlFu9
X-Proofpoint-ORIG-GUID: XABTZXZAwGvyESP_J1XS_miNyvaqlFu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=878
 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200183

preempt_count-related functions are quite ubiquitous and may be called
by noinstr ones, introducing unwanted instrumentation. Here is one
example call chain:

  irqentry_nmi_enter()  # noinstr
    lockdep_hardirqs_enabled()
      this_cpu_read()
        __pcpu_size_call_return()
          this_cpu_read_*()
            this_cpu_generic_read()
              __this_cpu_generic_read_nopreempt()
                preempt_disable_notrace()
                  __preempt_count_inc()
                    __preempt_count_add()

They are very small, so there are no significant downsides to
force-inlining them.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/preempt.h | 36 ++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index bf15da0fedbc..0e3da500e98c 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -12,12 +12,12 @@
 #define PREEMPT_NEED_RESCHED	0x80000000
 #define PREEMPT_ENABLED	(0 + PREEMPT_NEED_RESCHED)
 
-static inline int preempt_count(void)
+static __always_inline int preempt_count(void)
 {
 	return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
 }
 
-static inline void preempt_count_set(int pc)
+static __always_inline void preempt_count_set(int pc)
 {
 	int old, new;
 
@@ -29,22 +29,22 @@ static inline void preempt_count_set(int pc)
 				  old, new) != old);
 }
 
-static inline void set_preempt_need_resched(void)
+static __always_inline void set_preempt_need_resched(void)
 {
 	__atomic_and(~PREEMPT_NEED_RESCHED, &S390_lowcore.preempt_count);
 }
 
-static inline void clear_preempt_need_resched(void)
+static __always_inline void clear_preempt_need_resched(void)
 {
 	__atomic_or(PREEMPT_NEED_RESCHED, &S390_lowcore.preempt_count);
 }
 
-static inline bool test_preempt_need_resched(void)
+static __always_inline bool test_preempt_need_resched(void)
 {
 	return !(READ_ONCE(S390_lowcore.preempt_count) & PREEMPT_NEED_RESCHED);
 }
 
-static inline void __preempt_count_add(int val)
+static __always_inline void __preempt_count_add(int val)
 {
 	/*
 	 * With some obscure config options and CONFIG_PROFILE_ALL_BRANCHES
@@ -59,17 +59,17 @@ static inline void __preempt_count_add(int val)
 	__atomic_add(val, &S390_lowcore.preempt_count);
 }
 
-static inline void __preempt_count_sub(int val)
+static __always_inline void __preempt_count_sub(int val)
 {
 	__preempt_count_add(-val);
 }
 
-static inline bool __preempt_count_dec_and_test(void)
+static __always_inline bool __preempt_count_dec_and_test(void)
 {
 	return __atomic_add(-1, &S390_lowcore.preempt_count) == 1;
 }
 
-static inline bool should_resched(int preempt_offset)
+static __always_inline bool should_resched(int preempt_offset)
 {
 	return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
 			preempt_offset);
@@ -79,45 +79,45 @@ static inline bool should_resched(int preempt_offset)
 
 #define PREEMPT_ENABLED	(0)
 
-static inline int preempt_count(void)
+static __always_inline int preempt_count(void)
 {
 	return READ_ONCE(S390_lowcore.preempt_count);
 }
 
-static inline void preempt_count_set(int pc)
+static __always_inline void preempt_count_set(int pc)
 {
 	S390_lowcore.preempt_count = pc;
 }
 
-static inline void set_preempt_need_resched(void)
+static __always_inline void set_preempt_need_resched(void)
 {
 }
 
-static inline void clear_preempt_need_resched(void)
+static __always_inline void clear_preempt_need_resched(void)
 {
 }
 
-static inline bool test_preempt_need_resched(void)
+static __always_inline bool test_preempt_need_resched(void)
 {
 	return false;
 }
 
-static inline void __preempt_count_add(int val)
+static __always_inline void __preempt_count_add(int val)
 {
 	S390_lowcore.preempt_count += val;
 }
 
-static inline void __preempt_count_sub(int val)
+static __always_inline void __preempt_count_sub(int val)
 {
 	S390_lowcore.preempt_count -= val;
 }
 
-static inline bool __preempt_count_dec_and_test(void)
+static __always_inline bool __preempt_count_dec_and_test(void)
 {
 	return !--S390_lowcore.preempt_count && tif_need_resched();
 }
 
-static inline bool should_resched(int preempt_offset)
+static __always_inline bool should_resched(int preempt_offset)
 {
 	return unlikely(preempt_count() == preempt_offset &&
 			tif_need_resched());
-- 
2.44.0

