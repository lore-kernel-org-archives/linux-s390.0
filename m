Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0793812FB;
	Tue, 18 Aug 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064630; cv=none; b=uv5KzQEXEpM8ifRLyamAafCSZ+un46x+8QH7Ee+LHZ04fHKAYl40knHt0JlaOOpUl1vBVV0HuvTtYFU0a7P7yinQZTro5Ylb8ZpaHdoSL0HPwjz/hsboJfLSVcsCWG6Km+8E355b6Zn7wlJMQ0dIp2ucpkFXlNehp8GTVED+bak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064630; c=relaxed/simple;
	bh=XR453XhIO19JWXAk8nUubmPLn12emjh6ohKNJQQpvYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzNM15uFgo1P/bpktRmtemc/J3wfUFLZXlpCqaGnQ+olIKabwPKgZu5zQjRT9ovyXQBZq/V5QEFb7d2k2+NoV5udt5v6d8TqoiidHSPKvr/dghgEGXYua/2sTJ7+u6Y01zS+oJ6UipUdgKlXvSjmGeOlTg03r1GCGaNX4sUMmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H6jz3cXo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H6jz3cXo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE45jg402315;
	Tue, 18 Aug 2026 14:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GJLD2TZ45N6A1n1Xg
	MOqI2mQ+OFpWGVkrgw2Ca8i1x0=; b=H6jz3cXoN1A81lDHrCCu7IHNb+jy4WGX3
	usd0Q7FXjA+QQme72xeJRyxaR91GVfNVkDsZy6uQer2ORV05YYvXRe0BxrWPEg/F
	2p4JVOLyToDmCeIaqRifD/HVj/w4uGFvrMyUuND0tR82GiRBasJuk3xnQJUOclnN
	D2e3kVRZw+C0cdOBgnersuxySPLbpDKv6aB9TLqLL4mWKMACHr6MsXGogMmQdwNV
	dRCSqbpRdjIuVxkQhgminmZqLotrggGcslQXpalosGikwcPrxljfVsvN/JoYzfoA
	tpZ0YeGw9TdAezlRjZwivJjXun46i0CXoU2BRYkkuxFeDETANnVVA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm0qn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfOd9014762;
	Tue, 18 Aug 2026 14:50:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek3r7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo2dA40501682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1307020040;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE0D920043;
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 15/25] unwind_user/eh_frame: Duplicate registered .eh_frame[_hdr] section data on clone/fork
Date: Tue, 18 Aug 2026 16:49:44 +0200
Message-ID: <20260818144954.2320378-16-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX5jVN3ktEcs1V
 OhWW2EBXCvWAge5JHXOvKefYmgvaU/dhI6DiFxw7ZbTMqJqEUsFa1huYE+rya0AKfwmgT+Be6XS
 wj6aIacuuZR2wu1xjgAzg0N7vj8Jf2KWlLVXmNO6PYt3vXr11fjMuMkh0yg2yHz5OmWdL409PD6
 EkfjqSWttZH/7+oM9chYfGOLjxA1rn933Em7jcCQKjyDR5npkCtlS9VOPbD+FrGVgpXGbECtxen
 0R2zCl9ThJHGxoi8G/P9Q2ZP8nPtYCudTIjvfjfCJtQGWVL6txWK6RZ/PmZof2esPGP8u2YsofN
 lC+5mllzzMOmdeNBCAxX614ErOgoO1Lvh0Y8FG7CihI3eGy2bjOVDEVRWL9kd+3AKNGY47adP9C
 oBl1FkjJKHaamHYcHFrIdGFU/j7A1brdH1pQC1ysbxuhimu4dz8EBHzcZzjLfEltcISvEoPx/TH
 NYIN7cVZzrWjkdqLRog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX97QOLeRjz0Pq
 +ffb6p4A+uD0q7hAbL+1vbs6HgvAFL6SSKii0HYL25RC4IvFPXFuRx2k4z1wxrwZVZiWsQaFyC/
 Uy3potsp2Sm5dTAR5vOIYd0CzHArLOc=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a84711f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=D1Fd06331sE75a_1HDMA:9
X-Proofpoint-ORIG-GUID: PZdPFrW3orv6Dc2V2XWL8nrxifOG2bVU
X-Proofpoint-GUID: EjqnkSvI_2aQrppzZvaNOp76Fz2yV9HI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180107

When duplicating a process' virtual memory mappings also duplicate all
of its registered .eh_frame_hdr sections stored in the per-mm maple tree
to enable stacktracing using eh_frame of the child process.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 include/linux/eh_frame.h       |  7 +++++
 kernel/unwind/eh_frame.c       | 48 ++++++++++++++++++++++++++++++++++
 kernel/unwind/eh_frame_debug.h |  7 +++++
 mm/mmap.c                      |  5 ++++
 4 files changed, 67 insertions(+)

diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
index b2f98cd6166f..65f87c2714d8 100644
--- a/include/linux/eh_frame.h
+++ b/include/linux/eh_frame.h
@@ -30,6 +30,7 @@ struct eh_frame_section {
 };
 
 #define INIT_MM_EH_FRAME .eh_frame_mt = MTREE_INIT(eh_frame_mt, 0),
+extern int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm);
 extern void eh_frame_free_mm(struct mm_struct *mm);
 
 extern int eh_frame_add_section(unsigned long eh_frame_hdr_start,
@@ -49,6 +50,12 @@ static inline bool current_has_eh_frame(void)
 #else /* !CONFIG_HAVE_UNWIND_USER_EH_FRAME */
 
 #define INIT_MM_EH_FRAME
+
+static inline int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	return 0;
+}
+
 static inline void eh_frame_free_mm(struct mm_struct *mm) {}
 
 static inline int eh_frame_add_section(unsigned long eh_frame_hdr_start,
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index c9161229196c..7f572d1711d3 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1450,6 +1450,54 @@ int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
 	return 0;
 }
 
+static void __eh_frame_dup_section(struct eh_frame_section *sec,
+				   struct eh_frame_section *oldsec)
+{
+	sec->eh_frame_hdr_start	= oldsec->eh_frame_hdr_start;
+	sec->eh_frame_hdr_end	= oldsec->eh_frame_hdr_end;
+	sec->text_start		= oldsec->text_start;
+	sec->text_end		= oldsec->text_end;
+
+	sec->eh_frame_start		= oldsec->eh_frame_start;
+	sec->eh_frame_vma_end		= oldsec->eh_frame_vma_end;
+	sec->binary_search_table_start	= oldsec->binary_search_table_start;
+	sec->binary_search_table_end	= oldsec->binary_search_table_end;
+	sec->fde_count			= oldsec->fde_count;
+	sec->binary_search_table_enc	= oldsec->binary_search_table_enc;
+
+	dbg_dup(sec, oldsec);
+}
+
+int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	struct eh_frame_section *sec, *oldsec;
+	unsigned long index = 0;
+	int ret;
+
+	guard(srcu)(&eh_frame_srcu);
+
+	mt_for_each(&oldmm->eh_frame_mt, oldsec, index, ULONG_MAX) {
+		sec = kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
+		if (!sec)
+			return -ENOMEM;
+
+		__eh_frame_dup_section(sec, oldsec);
+
+		ret = mtree_insert_range(&mm->eh_frame_mt,
+					 sec->text_start,
+					 sec->text_end - 1,
+					 sec, GFP_KERNEL_ACCOUNT);
+		if (ret)
+			goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	free_section(sec);
+	return ret;
+}
+
 void eh_frame_free_mm(struct mm_struct *mm)
 {
 	struct eh_frame_section *sec;
diff --git a/kernel/unwind/eh_frame_debug.h b/kernel/unwind/eh_frame_debug.h
index bcb2d03ab9ab..e72e011ba539 100644
--- a/kernel/unwind/eh_frame_debug.h
+++ b/kernel/unwind/eh_frame_debug.h
@@ -41,6 +41,12 @@ static inline void dbg_init(struct eh_frame_section *sec)
 		sec->filename = kstrdup("(vma unknown???)", GFP_KERNEL_ACCOUNT);
 }
 
+static inline void dbg_dup(struct eh_frame_section *sec, struct eh_frame_section *oldsec)
+{
+	if (oldsec->filename)
+		sec->filename = kstrdup(oldsec->filename, GFP_KERNEL_ACCOUNT);
+}
+
 static inline void dbg_free(struct eh_frame_section *sec)
 {
 	kfree(sec->filename);
@@ -53,6 +59,7 @@ static inline void dbg_free(struct eh_frame_section *sec)
 #define dbg_sec_ehfh(args...)		no_printk(args)
 
 static inline void dbg_init(struct eh_frame_section *sec) {}
+static inline void dbg_dup(struct eh_frame_section *sec, struct eh_frame_section *oldsec) {}
 static inline void dbg_free(struct eh_frame_section *sec) {}
 
 #endif /* !CONFIG_DYNAMIC_DEBUG */
diff --git a/mm/mmap.c b/mm/mmap.c
index 2311ae7c2ff4..7715a799810e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
 #include <linux/memfd.h>
+#include <linux/eh_frame.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1844,6 +1845,9 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 			goto loop_out;
 		}
 	}
+	retval = eh_frame_dup_mm(mm, oldmm);
+	if (retval)
+		goto loop_out;
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 loop_out:
@@ -1893,6 +1897,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 			vm_unacct_memory(charge);
 		}
 		__mt_destroy(&mm->mm_mt);
+		eh_frame_free_mm(mm);
 		/*
 		 * The mm_struct is going to exit, but the locks will be dropped
 		 * first.  Set the mm_struct as unstable is advisable as it is
-- 
2.53.0

