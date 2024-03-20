Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A678595C
	for <linux-s390@vger.kernel.org>; Wed, 20 Mar 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975629; cv=none; b=I+3yIOgSLCk82U9Q55o4krc2UR8RZ3Mkx9Z5Zb/1oqZxp9lmTEkrTM4HovlmV5HUq08SmuSZkOZA5POklBjU8DAmK3ESZ/w9Ms6B5yNzX9s4NP03DJxKiCc/Tskjewh0rQe8uM4LW4q96H0LE0Ml44cfZQdaexS61Gd5dOS9jWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975629; c=relaxed/simple;
	bh=Wzbp5CoLq+TlB/2GZiFI68cX7jwm5+ZbZe1o5scyf8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alK9OfwxDMzhQYYnB/rOxYwfOQerq9aKTl7b+bP3ZDuJjKLvhptUN0C48wt1jvs8ASJUD5wWP11jl8XUrB3WV8ebZjzzBeWjtof6PTQMJ82DjUBy3TCVORYJr0dCxBBP++0rCvpNqMtbJXlzDZIFS17/F2LTrOO33YH82whVqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jLNnq767; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jLNnq767"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KN0Np6011320;
	Wed, 20 Mar 2024 23:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GfkBb4Mb+TgvYiffVWYxNuz5303cyB1HEs9M9/kXyeM=;
 b=jLNnq7677JdcUEpVAhrxPslMd+N83LzeKOeaDRzamnhk7ulPBrSFRTmWsWYUAUF7G7CP
 HOlTkAS8pvZ4sIspNzPe0pN+Bg8HvKlinLjc/wPLJqa9JhccW8A/eBffrb3TWyVv9yxQ
 bPrdFK6a2fmVy/x8Ahoa4g5lCw//CvpH8qOqpNFZzqR5nbmEUTSR/Qd10OkeF+1phoOT
 AaNCalVKdjKot4pmgzuzcRlij0G1GrmBM1XMFCHQIsM2K+cVx68kN4alMsYcISkuyOg/
 JDpEMaJv6G4vH00P/mpRT+k8OHcL8VtgiRdKQXmm5QSIKJOnEesGFRcJ4jsIwYXR9viW ow== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x006g1bwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 23:00:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KM0xFj019861;
	Wed, 20 Mar 2024 23:00:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqyks1sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 23:00:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KN0GNI22807286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 23:00:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2EED20040;
	Wed, 20 Mar 2024 23:00:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309CE2005A;
	Wed, 20 Mar 2024 23:00:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.8.38])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 23:00:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] s390/atomic: mark all functions __always_inline
Date: Wed, 20 Mar 2024 23:47:48 +0100
Message-ID: <20240320230007.4782-2-iii@linux.ibm.com>
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
X-Proofpoint-GUID: wbHZKaiVkbKe_mqPqnmhDmxtmQYjAYIg
X-Proofpoint-ORIG-GUID: wbHZKaiVkbKe_mqPqnmhDmxtmQYjAYIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200183

Atomic functions are quite ubiquitous and may be called by noinstr
ones, introducing unwanted instrumentation. They are very small, so
there are no significant downsides to force-inlining them.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/atomic.h     | 44 +++++++++++++++---------------
 arch/s390/include/asm/atomic_ops.h | 22 +++++++--------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 7138d189cc42..0c4cad7d5a5b 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -15,31 +15,31 @@
 #include <asm/barrier.h>
 #include <asm/cmpxchg.h>
 
-static inline int arch_atomic_read(const atomic_t *v)
+static __always_inline int arch_atomic_read(const atomic_t *v)
 {
 	return __atomic_read(v);
 }
 #define arch_atomic_read arch_atomic_read
 
-static inline void arch_atomic_set(atomic_t *v, int i)
+static __always_inline void arch_atomic_set(atomic_t *v, int i)
 {
 	__atomic_set(v, i);
 }
 #define arch_atomic_set arch_atomic_set
 
-static inline int arch_atomic_add_return(int i, atomic_t *v)
+static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 {
 	return __atomic_add_barrier(i, &v->counter) + i;
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
-static inline int arch_atomic_fetch_add(int i, atomic_t *v)
+static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
 	return __atomic_add_barrier(i, &v->counter);
 }
 #define arch_atomic_fetch_add arch_atomic_fetch_add
 
-static inline void arch_atomic_add(int i, atomic_t *v)
+static __always_inline void arch_atomic_add(int i, atomic_t *v)
 {
 	__atomic_add(i, &v->counter);
 }
@@ -50,11 +50,11 @@ static inline void arch_atomic_add(int i, atomic_t *v)
 #define arch_atomic_fetch_sub(_i, _v)	arch_atomic_fetch_add(-(int)(_i), _v)
 
 #define ATOMIC_OPS(op)							\
-static inline void arch_atomic_##op(int i, atomic_t *v)			\
+static __always_inline void arch_atomic_##op(int i, atomic_t *v)	\
 {									\
 	__atomic_##op(i, &v->counter);					\
 }									\
-static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
+static __always_inline int arch_atomic_fetch_##op(int i, atomic_t *v)	\
 {									\
 	return __atomic_##op##_barrier(i, &v->counter);			\
 }
@@ -74,7 +74,7 @@ ATOMIC_OPS(xor)
 
 #define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), new))
 
-static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
+static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	return __atomic_cmpxchg(&v->counter, old, new);
 }
@@ -82,31 +82,31 @@ static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 
 #define ATOMIC64_INIT(i)  { (i) }
 
-static inline s64 arch_atomic64_read(const atomic64_t *v)
+static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	return __atomic64_read(v);
 }
 #define arch_atomic64_read arch_atomic64_read
 
-static inline void arch_atomic64_set(atomic64_t *v, s64 i)
+static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	__atomic64_set(v, i);
 }
 #define arch_atomic64_set arch_atomic64_set
 
-static inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	return __atomic64_add_barrier(i, (long *)&v->counter) + i;
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	return __atomic64_add_barrier(i, (long *)&v->counter);
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-static inline void arch_atomic64_add(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__atomic64_add(i, (long *)&v->counter);
 }
@@ -114,20 +114,20 @@ static inline void arch_atomic64_add(s64 i, atomic64_t *v)
 
 #define arch_atomic64_xchg(v, new)	(arch_xchg(&((v)->counter), new))
 
-static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	return __atomic64_cmpxchg((long *)&v->counter, old, new);
 }
 #define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
-#define ATOMIC64_OPS(op)						\
-static inline void arch_atomic64_##op(s64 i, atomic64_t *v)		\
-{									\
-	__atomic64_##op(i, (long *)&v->counter);			\
-}									\
-static inline long arch_atomic64_fetch_##op(s64 i, atomic64_t *v)	\
-{									\
-	return __atomic64_##op##_barrier(i, (long *)&v->counter);	\
+#define ATOMIC64_OPS(op)							\
+static __always_inline void arch_atomic64_##op(s64 i, atomic64_t *v)		\
+{										\
+	__atomic64_##op(i, (long *)&v->counter);				\
+}										\
+static __always_inline long arch_atomic64_fetch_##op(s64 i, atomic64_t *v)	\
+{										\
+	return __atomic64_##op##_barrier(i, (long *)&v->counter);		\
 }
 
 ATOMIC64_OPS(and)
diff --git a/arch/s390/include/asm/atomic_ops.h b/arch/s390/include/asm/atomic_ops.h
index 50510e08b893..7fa5f96a553a 100644
--- a/arch/s390/include/asm/atomic_ops.h
+++ b/arch/s390/include/asm/atomic_ops.h
@@ -8,7 +8,7 @@
 #ifndef __ARCH_S390_ATOMIC_OPS__
 #define __ARCH_S390_ATOMIC_OPS__
 
-static inline int __atomic_read(const atomic_t *v)
+static __always_inline int __atomic_read(const atomic_t *v)
 {
 	int c;
 
@@ -18,14 +18,14 @@ static inline int __atomic_read(const atomic_t *v)
 	return c;
 }
 
-static inline void __atomic_set(atomic_t *v, int i)
+static __always_inline void __atomic_set(atomic_t *v, int i)
 {
 	asm volatile(
 		"	st	%1,%0\n"
 		: "=R" (v->counter) : "d" (i));
 }
 
-static inline s64 __atomic64_read(const atomic64_t *v)
+static __always_inline s64 __atomic64_read(const atomic64_t *v)
 {
 	s64 c;
 
@@ -35,7 +35,7 @@ static inline s64 __atomic64_read(const atomic64_t *v)
 	return c;
 }
 
-static inline void __atomic64_set(atomic64_t *v, s64 i)
+static __always_inline void __atomic64_set(atomic64_t *v, s64 i)
 {
 	asm volatile(
 		"	stg	%1,%0\n"
@@ -45,7 +45,7 @@ static inline void __atomic64_set(atomic64_t *v, s64 i)
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
 
 #define __ATOMIC_OP(op_name, op_type, op_string, op_barrier)		\
-static inline op_type op_name(op_type val, op_type *ptr)		\
+static __always_inline op_type op_name(op_type val, op_type *ptr)	\
 {									\
 	op_type old;							\
 									\
@@ -96,7 +96,7 @@ __ATOMIC_CONST_OPS(__atomic64_add_const, long, "agsi")
 #else /* CONFIG_HAVE_MARCH_Z196_FEATURES */
 
 #define __ATOMIC_OP(op_name, op_string)					\
-static inline int op_name(int val, int *ptr)				\
+static __always_inline int op_name(int val, int *ptr)			\
 {									\
 	int old, new;							\
 									\
@@ -122,7 +122,7 @@ __ATOMIC_OPS(__atomic_xor, "xr")
 #undef __ATOMIC_OPS
 
 #define __ATOMIC64_OP(op_name, op_string)				\
-static inline long op_name(long val, long *ptr)				\
+static __always_inline long op_name(long val, long *ptr)		\
 {									\
 	long old, new;							\
 									\
@@ -154,7 +154,7 @@ __ATOMIC64_OPS(__atomic64_xor, "xgr")
 
 #endif /* CONFIG_HAVE_MARCH_Z196_FEATURES */
 
-static inline int __atomic_cmpxchg(int *ptr, int old, int new)
+static __always_inline int __atomic_cmpxchg(int *ptr, int old, int new)
 {
 	asm volatile(
 		"	cs	%[old],%[new],%[ptr]"
@@ -164,7 +164,7 @@ static inline int __atomic_cmpxchg(int *ptr, int old, int new)
 	return old;
 }
 
-static inline bool __atomic_cmpxchg_bool(int *ptr, int old, int new)
+static __always_inline bool __atomic_cmpxchg_bool(int *ptr, int old, int new)
 {
 	int old_expected = old;
 
@@ -176,7 +176,7 @@ static inline bool __atomic_cmpxchg_bool(int *ptr, int old, int new)
 	return old == old_expected;
 }
 
-static inline long __atomic64_cmpxchg(long *ptr, long old, long new)
+static __always_inline long __atomic64_cmpxchg(long *ptr, long old, long new)
 {
 	asm volatile(
 		"	csg	%[old],%[new],%[ptr]"
@@ -186,7 +186,7 @@ static inline long __atomic64_cmpxchg(long *ptr, long old, long new)
 	return old;
 }
 
-static inline bool __atomic64_cmpxchg_bool(long *ptr, long old, long new)
+static __always_inline bool __atomic64_cmpxchg_bool(long *ptr, long old, long new)
 {
 	long old_expected = old;
 
-- 
2.44.0

