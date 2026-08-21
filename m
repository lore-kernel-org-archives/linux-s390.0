Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EC40926E;
	Fri, 21 Aug 2026 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342026; cv=none; b=fpT93mmFCpGrPupe4MuzeOP7emnXOV94rtAYni8rqg7/a2c4dL+cd2/0KVOe7fxP6alNezCLFmF7rNBZbzUrNg52zl06+0gwyqu7YyzpTHL3hfn5AnWGdGFNeeAJ5uilALZNXxlgkCNW2UrhRF/JFL1sng9USr+Pszl1FPXT1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342026; c=relaxed/simple;
	bh=9Gf0mjWJVje9AvWrkpcwY8nML4OmYITCRsXGuGEPsh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htl6n+cHvZIgxmbklbKEK8JiwJe/r08opsdrhgKcEbybIQEyyI5yXhx98RLWUe06ovXnB7G1M0CuX3pU+xfELbBpGkX/gWjdWMfCtXw7Orm6Y6ZFwxYsKZkyYC/CgFrLpIYJpc+fuD1NvIGjm1ePKQh85PwSkIb4ukBcQgQf5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AGcNeIcV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AGcNeIcV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVUDd491584;
	Fri, 21 Aug 2026 19:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8rY+uuCnqVe7Q3+18
	p03523fKSiBzC3K17ktOGVPiEA=; b=AGcNeIcVB3h9W/JuQs7F46pUMDT2/GE/W
	DxkmGguNi1jNqirPesYkTkTe52SirvH7j41xAJWmjMjrJHglctvER32q7jbM/xmh
	59wkWpmFlSi3fLlYraCqTHRgpjEQAsBzmRflJaGIe9q3CbwzoyWF5tIr0HcI+yoB
	NkbIsxBlNEe6oqf8PowRscNy1YR9K9YzrHEhI596HNBcCDnGT7+JzCIhIu5/8rNH
	SnM89uohL5rWKJdHKwT/7aOXkf5wMwXWcnaukX1CT5pm3qNoM6vRxPweZ3laVzEn
	g1Ao8tdbq8SExWZaxaLeQWyYg0iBpRg1gayHOSMvVKWvYBl94Z0Bg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0kvde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfONa016663;
	Fri, 21 Aug 2026 19:53:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhpnm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJrCts46662004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A23C20040;
	Fri, 21 Aug 2026 19:53:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B90B820043;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
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
Subject: [RFC PATCH v2 24/24] unwind_user/eh_frame: Add prctl() interface for (un)registering .eh_frame_hdr sections
Date: Fri, 21 Aug 2026 21:52:59 +0200
Message-ID: <20260821195259.2688377-25-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: SuTCKgQiXsg2zUdBEiewlc9c_ulmQ1d2
X-Proofpoint-GUID: AkTCuL3l6dUSh2nfNRu__wC3MPuXeRgX
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88acae cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PpU6TSaerSOHJBOlBi4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXxLuhit6kjRTR
 aapVjOJSGBtlrFSVzvgJnzG0ScIyG3VJqJx3zYTj7kUP+e4PHrRd8VgSNK+tQMOFWd2J4do7Aif
 y1BYhR6SstpLmgv4ThwOVzVJF+YTFZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX8O8V/7reRjPy
 a+cTkM8rDl8ZqswtfBXazHK77gBzmtWOalDSy2AHffB509XvjAxlrgi5QTje4JfCI8gT7wUjUKo
 46L1rnjZoCkW8/wuXkMOS8VhlGKuK453+6anMkItSEFRMCEPM/9ylyVrjNAPG3fU5DUqN5JQVp0
 P2Z+fbUDDtIu4R6P9fsjTN6WbjhJzT5FeqVcmgdApwuKH8BP+DgskeJfdT1WU0jg3oGddRawjzu
 mp4sh/p9To+H2d5lSaWQ3+uVP4TdsOvvyc1K/0jmDHrr3wHur1kOk57QxfjvywsOqB0jkYMkBJr
 Z+Bu+etG5RpltJFs9Am5Z1X7CzSxnD6ibk+AkDHsYWoVG3M1WYpuVNasAEyqMKEFx5iz4te5cXu
 g/1HGzX9R+dfMtKIedbNQ3nHvWzTI5bRLj4SLkoq6tccMswHGx4DUAllWyrc6G4iNsGdQnxCGnN
 zLR8Xq7ZKS9Bpn72+xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

The kernel does not have direct visibility to the ELF contents of
shared libraries.  Add prctl() interfaces to register and unregister
.eh_frame_hdr sections that allow dynamic linkers to tell the kernel
where to find these.

Both prctl's take a pointer to a new structure:

  struct eh_frame_setup {
	__u64	eh_frame_hdr_start;
	__u64	eh_frame_hdr_size;
	__u64	text_start;
	__u64	text_size;
  };

and a size of the passed in structure.  If the prctl's need to be
extended, then the structure could be changes and the sizre of that
structure will tell the kernel what it is the new version.  If the
kernel does not recognize the structure, it returns -EINVAL.

  eh_frame_hdr_start - Virtual address of the .eh_frame_hdr section
  eh_frame_hdr_size  - Length of the .eh_frame_hdr section
  text_start         - Virtual address of the related text section
  text_size          - Length of the related text section

The unregister only needs the eh_frame_hdr_start and requires all of
the remaining fields to be zero.

Based on Steven's patch "[PATCH v2] unwind: Add sframe_(un)register()
system calls". [1]

[1]: https://lore.kernel.org/all/20260528151023.00f5ec4e@gandalf.local.home/

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - eh_frame_{register|unregister}(): Reject zero user_data or size.

 include/linux/eh_frame.h      | 20 +++++++++++++++
 include/uapi/linux/eh_frame.h | 14 +++++++++++
 include/uapi/linux/prctl.h    |  4 +++
 kernel/sys.c                  | 11 +++++++++
 kernel/unwind/eh_frame.c      | 46 +++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+)
 create mode 100644 include/uapi/linux/eh_frame.h

diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
index 3c88ab2f7858..3a61ed0ae739 100644
--- a/include/linux/eh_frame.h
+++ b/include/linux/eh_frame.h
@@ -6,6 +6,8 @@
 #include <linux/srcu.h>
 #include <linux/unwind_user_types.h>
 
+struct eh_frame_setup;
+
 #ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
 
 struct eh_frame_section {
@@ -40,6 +42,12 @@ extern int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 				unsigned long text_start,
 				unsigned long text_end);
 extern int eh_frame_remove_section(unsigned long eh_frame_hdr_start);
+
+extern int eh_frame_register(struct eh_frame_setup __user *user_data,
+			     __kernel_size_t size);
+extern int eh_frame_unregister(struct eh_frame_setup __user *user_data,
+			       __kernel_size_t size);
+
 extern int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame);
 
 static inline bool current_has_eh_frame(void)
@@ -78,6 +86,18 @@ static inline int eh_frame_find(unsigned long ip, struct unwind_user_frame *fram
 	return -ENOSYS;
 }
 
+static inline int eh_frame_register(struct eh_frame_setup __user *user_data,
+				    __kernel_size_t size)
+{
+	return -EINVAL;
+}
+
+static inline int eh_frame_unregister(struct eh_frame_setup __user *user_data,
+				      __kernel_size_t size)
+{
+	return -EINVAL;
+}
+
 static inline bool current_has_eh_frame(void) { return false; }
 
 #endif /* CONFIG_HAVE_UNWIND_USER_EH_FRAME */
diff --git a/include/uapi/linux/eh_frame.h b/include/uapi/linux/eh_frame.h
new file mode 100644
index 000000000000..8cca3792f323
--- /dev/null
+++ b/include/uapi/linux/eh_frame.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_EH_FRAME_H
+#define _UAPI_LINUX_EH_FRAME_H
+
+#include <linux/types.h>
+
+struct eh_frame_setup {
+	__u64	eh_frame_hdr_start;
+	__u64	eh_frame_hdr_size;
+	__u64	text_start;
+	__u64	text_size;
+};
+
+#endif /* _UAPI_LINUX_EH_FRAME_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index b6ec6f693719..801a209bab3f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -416,4 +416,8 @@ struct prctl_mm_map {
 # define PR_CFI_DISABLE		_BITUL(1)
 # define PR_CFI_LOCK		_BITUL(2)
 
+/* EH_FRAME management */
+#define PR_REGISTER_EH_FRAME		82
+#define PR_UNREGISTER_EH_FRAME		83
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index df69bd71de03..ee67badf267c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -65,6 +65,7 @@
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
+#include <linux/eh_frame.h>
 
 #include <linux/nospec.h>
 
@@ -2907,6 +2908,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (arg3 & PR_CFI_LOCK && !(arg3 & PR_CFI_DISABLE))
 			error = arch_prctl_lock_branch_landing_pad_state(me);
 		break;
+	case PR_REGISTER_EH_FRAME:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = eh_frame_register((void __user *)arg2, arg3);
+		break;
+	case PR_UNREGISTER_EH_FRAME:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = eh_frame_unregister((void __user *)arg2, arg3);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index d1656f5d40f1..063133d1bf97 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/unwind_user_types.h>
 #include <linux/unwind_user_eh_frame_types.h>
+#include <uapi/linux/eh_frame.h>
 
 #include "eh_frame.h"
 #include "eh_frame_debug.h"
@@ -1609,3 +1610,48 @@ void eh_frame_free_mm(struct mm_struct *mm)
 
 	mtree_destroy(&mm->eh_frame_mt);
 }
+
+int eh_frame_register(struct eh_frame_setup __user *user_data, __kernel_size_t size)
+{
+	struct eh_frame_setup data;
+	unsigned long eh_frame_hdr_end, text_end;
+
+	if (!user_data || !size)
+		return -EINVAL;
+
+	if (size != sizeof(data))
+		return -EINVAL;
+
+	if (copy_from_user(&data, user_data, sizeof(data)))
+		return -EFAULT;
+
+	if (check_add_overflow(data.eh_frame_hdr_start, data.eh_frame_hdr_size,
+			       &eh_frame_hdr_end))
+		return -EINVAL;
+
+	if (check_add_overflow(data.text_start, data.text_size, &text_end))
+		return -EINVAL;
+
+	return eh_frame_add_section(data.eh_frame_hdr_start, eh_frame_hdr_end,
+				    data.text_start, text_end);
+}
+
+int eh_frame_unregister(struct eh_frame_setup __user *user_data, __kernel_size_t size)
+{
+	struct eh_frame_setup data;
+
+	if (!user_data || !size)
+		return -EINVAL;
+
+	if (size != sizeof(data))
+		return -EINVAL;
+
+	if (copy_from_user(&data, user_data, sizeof(data)))
+		return -EFAULT;
+
+	/* Unregister only uses eh_frame_hdr_start */
+	if (data.eh_frame_hdr_size || data.text_start || data.text_size)
+		return -EINVAL;
+
+	return eh_frame_remove_section(data.eh_frame_hdr_start);
+}
-- 
2.53.0

