Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E140EB9D;
	Fri, 21 Aug 2026 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342021; cv=none; b=mwW2+rzCJI46NTh+yQGgUVqKgdOatzIQPUK5qpyIIiO+rTERB7aCmYBKKvwqSjSoMzlqtojw1EoS5IfZxMQTnexiljRD/Z3Yq+3XY/FWRLmL4cuSoUrnTe8/xtyGIOw6zWpmpGjzcKqXPuhRxRrTvyZ5YfUx3WswS7Xv2pq/U8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342021; c=relaxed/simple;
	bh=zfkrCG/grEsqBerQEjKKNJBX6y9+FEaLBw9oftt91nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvzCL49P/FlBj2vUgotqjsWzZbqkfGMa4TvBjyuRjLWE/uTG+TBual9UB2pm6zdN5Ml5/cT9jjgxGBgetJYmOpniDdCA0/F7ck8G8XgBOdiwi8qIpAEzess18Nd/zJUwLAtCK1URuDD52zgj3yjApCT9/5dD7+o6Rkm+WmEO8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T7vlRFjM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T7vlRFjM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVjs3491844;
	Fri, 21 Aug 2026 19:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0slGNflhrASa31G14
	eLJHOXwNvhEtUH0F5bLRdVkFUs=; b=T7vlRFjM1inAGfvxdtdyJHpzun/EHxP3+
	lY1uWqgJ4Jo4AQb0l4g3YJiNDULwN7BsJ2LmjvvKfr4KEAGt3SFZHB+0VP3+3xTt
	oCRLz//RuisXnltwhn+OUStZ6JbT/9eev6Z0nWiv6SxpXKhwBRkl4eaLgwxbMT0E
	bdW6UnubT61ghw5jqCueOtXN6IQMldfFSvviP9EW95XMPMdWPK0jUQed7S96dKS6
	6Dralb1yQZ1OsxIq5RYSaxtzyqSGUJyUILBgKMZW9zYHm5oDP+HZbhMzZuSDHNwh
	VVdfI3OUU7R+dNUF80ZhJuXEszpM7u+BvZDEqwi4O//nyn3Zbj7Kg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0kvcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfRI5016689;
	Fri, 21 Aug 2026 19:53:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhpnkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr8d542861032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7F0320040;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 999722004B;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
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
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 13/24] unwind_user/eh_frame: Show file name in debug output
Date: Fri, 21 Aug 2026 21:52:48 +0200
Message-ID: <20260821195259.2688377-14-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2CbATQqS6hTrEGGwpRM1UyfOT3Gf12eC
X-Proofpoint-GUID: G937tc7y73pR_qeBgyYIJ355qus_8-MH
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88acaa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=FE0x1-_S9R1QEdhOvlkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXwJRuihnlj8Wf
 ForN2vrzsiGNmDI9ObJzVCi67VkA2TaRuigxfeCZfHA3SLLCp+3UQdowz4fWa73m83b4oWwEhFi
 3xFYwYNsvUgjBkfR7RcdyqVkS8Gljc0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX5UP4lLFVF8nE
 drB90e9PbFqfohlCi7WCl+vVbbM3i0Im4guFMHmcZrt1Hb2IJzOULvrbVTgK4EIdgDzsoxRvEqa
 184e90aGvy5cDucAd5XyNKELUbrEEGZd3ay3m9ucLxlV4oquVbaS1qD48k63tn7MRH8AbeqBsQU
 ImxqLTnCQj8EVG9ywWIZtz/dzxuah8DNHg/8cazgKj+L7GbE1AE2ERliMIXRhH8kCSNkQA2W/Hi
 l1KS3YpA40dmHZPiVcoaSYDC6PSTlmIjY0RYWpKf5iLXZhb6UFFmvsZwuJTgpQK3ax28XzlfL7j
 tGB1bUdFoYw+ELkyGGtEOYo2RCXsgE81qcKMd5z8bbTZxhQUVK04rSdH/pNgbD0UO78TTCSmdp1
 2fDfdNXqk+OFhl4lPsdilBRM4JSIZhRlRX8qPfuCP9CqH2DORtOT/MXqTPswjYNvkXUdqDMy6+w
 PD/J3HpzHq1GztSOo6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

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
index 740316b19df3..70b4f9d12828 100644
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
index 327849ea4a69..96237a96d263 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1207,15 +1207,18 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
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
 
@@ -1342,6 +1345,8 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 	sec->text_start		= text_start;
 	sec->text_end		= text_end;
 
+	dbg_init(sec);
+
 	ret = eh_frame_read_header(sec);
 	if (ret)
 		goto err_free;
@@ -1349,8 +1354,8 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 	ret = mtree_insert_range(eh_frame_mt, sec->text_start, sec->text_end - 1,
 				 sec, GFP_KERNEL_ACCOUNT);
 	if (ret) {
-		dbg("mtree_insert_range failed: text=%lx-%lx\n",
-		    sec->text_start, sec->text_end);
+		dbg_sec("mtree_insert_range failed: text=%lx-%lx\n",
+			sec->text_start, sec->text_end);
 		goto err_free;
 	}
 
@@ -1372,7 +1377,7 @@ static int __eh_frame_remove_section(struct ma_state *mas,
 				     struct eh_frame_section *sec)
 {
 	if (mas_erase(mas) != sec) {
-		dbg("mas_erase failed: text=%lx\n", sec->text_start);
+		dbg_sec("mas_erase failed: text=%lx\n", sec->text_start);
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

