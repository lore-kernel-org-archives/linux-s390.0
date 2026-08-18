Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F22D061C;
	Tue, 18 Aug 2026 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064627; cv=none; b=KOsY7qSQm4yDBzF7dgVVQi5CHmDzPN6DbSsr3A/3kOrhRUzwlX2my0E35x5lMZDfIvfXASwEn3ktzNb6rlO8QNi/XVE4WqsuD/lWP9Uclflgn8zRP6psrlLm6pQpKTi2YHmKSIo949QtwPzE/oS3RsApmkMJvQWZgh5oKniPnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064627; c=relaxed/simple;
	bh=3XZ8+FFkuUlTb7Ev+5yyd08oa4ce+P7F59vGHeADNRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxGkmxgCbhfk+e3fgpVviUNu3hyqkqWzbsXIO+G5TIR9MKRhoUQ4YBl1qg9mq9WiNhEcpXzaWLfLcQj3HcckH8xqAn6JfQa3WhuKmEQJBuESgpbVDjyhze/zLQPQE1Q16NTg+ck4gBqAJMl06+cLeLjKyxMpsdd0LvHlDKseWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qg6V/dKC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qg6V/dKC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3cPf542428;
	Tue, 18 Aug 2026 14:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bv8Ybh6/FIjlbgEZa
	ghAOTI6IsNfSapayGx53KZF0lU=; b=qg6V/dKC+dmRZhZAX5DWJNvXJKwLE/HZO
	b8tmZhF5qQvmaRzsB+zlr8rFjyaBfRDCxxTx9s9ChZY583B+5Q0jX4fxZwCmlgXV
	IwnARM4rMypwR/wzbZcrGko8hwl3BUo9DGOG+EBSKRfpkWWvIMb5FQtvqxd+TDci
	FimSbMjnzR3n2PeSup0S8TAiW1mQsy/cOdF6/KbFXowGG93j0YSAGiDb7UmHVcmU
	FE01zU40Y3bcIirbJKjK2b4clqmjyHMLh3tkDGCkWNs6l4MxYyyDb5la98oUTw+I
	rxvVP96AuR2dFcGHp8rXXUd5UHoorysuqx58LIZm6wjFzhyrJUqVg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8bt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfOTM028585;
	Tue, 18 Aug 2026 14:50:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw3uw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo1In50397632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AAD02004B;
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2261920043;
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
Subject: [RFC PATCH v1 13/25] unwind_user/eh_frame: Show file name in debug output
Date: Tue, 18 Aug 2026 16:49:42 +0200
Message-ID: <20260818144954.2320378-14-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84711e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=FE0x1-_S9R1QEdhOvlkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXzNsLFh3dzp8R
 wGjYT1DAbKYWCsTsQzsEeBjmOnegGqSPqUvNm/yJi90yr4xiOb2dIs7Koh+5MuCZjIIMoGi7By8
 5TmHPRhUF3xpgB1g/AyCthy7+AkrYt4=
X-Proofpoint-GUID: nuxLmZv75gVG-zD6bsmwWDAz4saOLbrI
X-Proofpoint-ORIG-GUID: unIaWvijCQKKZTD8TUIdAEa3dbYdf91U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXxoDih1/Ka9E9
 D/qf8A/YmKi9N2xYe0d3E9shJIhfACjEmgTqBm6Z4rE04cu7etdf3ZODSU80NQSIlnzLtTlxmzW
 NrAgLYvETcoel+40KOdVNBFU/W7w0wg2af/V05QHDsUYGF1BV3Sb70lis1fg117C+SCj1pXzDfe
 Xgue95a23+GmrVy+7pUgnR3jF/YWRsW11jKJJry4NBdgGbW+i32gELjjG8QKcNyDm+08VkSMGJo
 3BFQZ6B16rkiMUwsWyY0DurNO7QiZgOfRpP/rYBgXPlStSZ+F4ZT7Gkwj9QEwdKTy1/TBDb+Xuf
 s7QSHZIzaH0FgiyS0coUAW1L+c0Y7REdqitQb1JWK+1fOGfiMMZY4+77qFCCJjX6vOJeYzBvGMe
 gPeSr8vRMmDz3ietzDEWu7ZBxHGa6m53aCMuI8VJLvhpo6YKrqs3OBYaDFxCMzBrMwtXjNoC1/z
 5R0kISBiX4Z5oQf1ziw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

When debugging eh_frame issues, the error messages aren't all that helpful
without knowing what file a corresponding .eh_frame[_hdr] section belongs
to.  Prefix debug output strings with the file name.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 include/linux/eh_frame.h       |  4 ++++
 kernel/unwind/eh_frame.c       | 13 ++++++++----
 kernel/unwind/eh_frame_debug.h | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
index e33041e4f9c0..b2f98cd6166f 100644
--- a/include/linux/eh_frame.h
+++ b/include/linux/eh_frame.h
@@ -11,6 +11,10 @@
 struct eh_frame_section {
 	struct rcu_head	rcu;
 
+#ifdef CONFIG_DYNAMIC_DEBUG
+	const char	*filename;
+#endif
+
 	unsigned long	eh_frame_hdr_start;
 	unsigned long	eh_frame_hdr_end;
 	unsigned long	text_start;
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 7657291324c0..46ffb535ca53 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1154,15 +1154,18 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
 	 * e.g. EINVAL (corrupted) or EFAULT (inaccessible).
 	 * Keep if ENOENT (not found) or EOPNOTSUPP (unsupported CFI).
 	 */
-	if (ret && (ret != -ENOENT && ret != -EOPNOTSUPP))
+	if (ret && (ret != -ENOENT && ret != -EOPNOTSUPP)) {
+		dbg_sec("removing bad .eh_frame[_hdr] section\n");
 		if (eh_frame_remove_section(sec->eh_frame_hdr_start))
 			dbg("eh_frame_remove_section() failed\n");
+	}
 
 	return ret;
 }
 
 static void free_section(struct eh_frame_section *sec)
 {
+	dbg_free(sec);
 	kfree(sec);
 }
 
@@ -1290,6 +1293,8 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 	sec->text_start		= text_start;
 	sec->text_end		= text_end;
 
+	dbg_init(sec);
+
 	ret = eh_frame_read_header(sec);
 	if (ret)
 		goto err_free;
@@ -1297,8 +1302,8 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 	ret = mtree_insert_range(eh_frame_mt, sec->text_start, sec->text_end - 1,
 				 sec, GFP_KERNEL_ACCOUNT);
 	if (ret) {
-		dbg("mtree_insert_range failed: text=%lx-%lx\n",
-		    sec->text_start, sec->text_end);
+		dbg_sec("mtree_insert_range failed: text=%lx-%lx\n",
+			sec->text_start, sec->text_end);
 		goto err_free;
 	}
 
@@ -1320,7 +1325,7 @@ static int __eh_frame_remove_section(struct mm_struct *mm,
 				     struct eh_frame_section *sec)
 {
 	if (!mtree_erase(&mm->eh_frame_mt, sec->text_start)) {
-		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
+		dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
 		return -EINVAL;
 	}
 
diff --git a/kernel/unwind/eh_frame_debug.h b/kernel/unwind/eh_frame_debug.h
index 5a3e4e7f065a..40a80861d4d4 100644
--- a/kernel/unwind/eh_frame_debug.h
+++ b/kernel/unwind/eh_frame_debug.h
@@ -3,6 +3,7 @@
 #define _EH_FRAME_DEBUG_H
 
 #include <linux/eh_frame.h>
+#include <linux/mm.h>
 #include "eh_frame.h"
 
 #ifdef CONFIG_DYNAMIC_DEBUG
@@ -10,9 +11,45 @@
 #define dbg(fmt, ...)							\
 	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
 
+#define dbg_sec(fmt, ...)						\
+	dbg("%s: " fmt, sec->filename, ##__VA_ARGS__)
+
+static inline void dbg_init(struct eh_frame_section *sec)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	const char *name;
+
+	guard(mmap_read_lock)(mm);
+	vma = vma_lookup(mm, sec->eh_frame_hdr_start);
+	if (!vma)
+		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL_ACCOUNT);
+	else if (vma_is_anonymous(vma))
+		 sec->filename = kstrdup("(anonymous)", GFP_KERNEL_ACCOUNT);
+	else if (vma->vm_file)
+		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL_ACCOUNT);
+	else if (vma->vm_ops && vma->vm_ops->name && (name = vma->vm_ops->name(vma)))
+		sec->filename = kstrdup(name, GFP_KERNEL_ACCOUNT);
+	else if (arch_vma_name(vma))
+		sec->filename = kstrdup(arch_vma_name(vma), GFP_KERNEL_ACCOUNT);
+	else if (!vma->vm_mm)
+		sec->filename = kstrdup("(vdso)", GFP_KERNEL_ACCOUNT);
+	else
+		sec->filename = kstrdup("(vma unknown???)", GFP_KERNEL_ACCOUNT);
+}
+
+static inline void dbg_free(struct eh_frame_section *sec)
+{
+	kfree(sec->filename);
+}
+
 #else /* !CONFIG_DYNAMIC_DEBUG */
 
 #define dbg(args...)			no_printk(args)
+#define dbg_sec(args...)		no_printk(args)
+
+static inline void dbg_init(struct eh_frame_section *sec) {}
+static inline void dbg_free(struct eh_frame_section *sec) {}
 
 #endif /* !CONFIG_DYNAMIC_DEBUG */
 
-- 
2.53.0

