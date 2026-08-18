Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699E18A6CF;
	Tue, 18 Aug 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064629; cv=none; b=sfOVsvmlkiGTIWYvzv27G4ZK2B8JIlabLCVyO6+Kf1FbfqUtlkWiIgDNblVhW6WRfaj95kV4q7VuJtNDA7NKWxGag9NKatP1n9rL5Lijv+hKGhNFM6UxUvO2gJ/C5DPh+yk9CbqqaoFvnbmjCdNC34WcyfTg0NOZnfbtZsP1vTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064629; c=relaxed/simple;
	bh=ryN6HnGgUODfo2mkcg4yfPMF8eu56ctIAsET4LUnJQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNjuO6ILhY8VxuW6qeyikrbMshdnRkOqGjGJvdktHpfSMsebjiCKdtxOe91aw+jVbaegTA57arpfxROPtKJf0CchF0xjxteILpV5SOtpQJ2EqD1TWeXojWuwH4L8vnrlbr6G3PyB8F0RjUn/0WjUAc9A4LJxB2qC+0LqLbJrueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nQv+dwXg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nQv+dwXg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3bZb3582467;
	Tue, 18 Aug 2026 14:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5yHdQpnMEHW0fRNxr
	xSFOGMVWC51H5fYvAkW31goDsw=; b=nQv+dwXg8JfwEtXMaFkTlWkjjzK07/42q
	gUNW2QNTWaWmQQfFcW05LLgv45oRaJcGS1kVG99munw9DXdiHuQWyo3kQ3HokJaA
	nZOlatGVfXiSxze2u+KspW6tZyi/XusiVvW1TubH5NjeMmqILao9JSh+iGNTx59u
	B7PZQlunMnF/Qv2WzBQ3Qk+ZULOmctWfE9qPG+jXX4IYgnvA/DEcQNsGCNY4TF/B
	0wQZoaxPMcrxhTlG83zv4USWRENNvHYUtB+Llv3CO+MllsbmZyYXGXGzbunobPuF
	UvoCvfN5oUmzBkQ5Tief3PCKyUjYR4OLjgR1Mi5UnmX3o+SRgtnwg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe8h1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfQpw029654;
	Tue, 18 Aug 2026 14:50:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngbhh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo5Tj45154704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F4F120043;
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B6BD2004D;
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
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
Subject: [RFC PATCH v1 25/25] unwind_user/eh_frame: Add prctl() interface for (un)registering .eh_frame_hdr sections
Date: Tue, 18 Aug 2026 16:49:54 +0200
Message-ID: <20260818144954.2320378-26-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX2OBKpR2bYxD+
 OW9bmZ7wnqLgPuavr4I4saTZGXCP5j5mrvshJuc3tf5rVI+nXfTPnJSgAA/ZMGFvDE62j0izU05
 ewwdqAubJ67R8T1cnNO3EpS4zLE00fjkTUZfHEre+amNMDifsTg/JUd0Y3Jb7BzdWaukI6WDQYP
 /I29lTd+8/WlQ05SgyKuJamMEt8EvqohQZXDFZ1G2UwuAoZ5NW6tKRhHmMk0geePfj23tTOWLsQ
 m5l0YwVQq/cmdsQWSXabjOA26el1kkguHoDOBWrjxu1/N2vBdfbBGP0erxOm2Tr/VvI/JyqE+Z8
 /kjFfVeIDe3kdoFAs8sF8Qj9DkQwHtn41WRDxMDf88nfYSkCrdNuYkJg60TZI5kVa0Zd5FivMUZ
 2sS+Ds94eqcLaso/iVA92LJjQcs9llKIWcvoW6ZZJ/r1kgLWCREyLXnfNEZ6UgLanbDNzEWAAc7
 Lwn8DGJl0gu7hIMzfJA==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a847122 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PpU6TSaerSOHJBOlBi4A:9
X-Proofpoint-ORIG-GUID: sA1KAGVjdsh62MYRpLS8y9zWQ5oTrGOh
X-Proofpoint-GUID: BHYhF3RH_AEPxDiqnC0BXWMCOYuZpnR1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXx8hwRDwFS+so
 fRjGyI4opnptunebSKCv1W41eoCXb3cm880vLzT1TMcL2pEUM5Aw+9REKFB3Ax8X6qjicOMZ074
 u/mwofvxuZy8WOlmmgWIbuvUetq3Fco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

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
 include/linux/eh_frame.h      | 20 +++++++++++++++
 include/uapi/linux/eh_frame.h | 14 +++++++++++
 include/uapi/linux/prctl.h    |  4 +++
 kernel/sys.c                  | 11 +++++++++
 kernel/unwind/eh_frame.c      | 46 +++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+)
 create mode 100644 include/uapi/linux/eh_frame.h

diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
index de68f21e1050..540beab5bf61 100644
--- a/include/linux/eh_frame.h
+++ b/include/linux/eh_frame.h
@@ -6,6 +6,8 @@
 #include <linux/srcu.h>
 #include <linux/unwind_user_types.h>
 
+struct eh_frame_setup;
+
 #ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
 
 struct eh_frame_section {
@@ -39,6 +41,12 @@ extern int eh_frame_add_section(unsigned long eh_frame_hdr_start,
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
@@ -77,6 +85,18 @@ static inline int eh_frame_find(unsigned long ip, struct unwind_user_frame *fram
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
index 49e8a3e8d794..12279f02381d 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/unwind_user_types.h>
 #include <linux/unwind_user_eh_frame_types.h>
+#include <uapi/linux/eh_frame.h>
 
 #include "eh_frame.h"
 #include "eh_frame_debug.h"
@@ -1723,3 +1724,48 @@ void eh_frame_free_mm(struct mm_struct *mm)
 
 	mtree_destroy(&mm->eh_frame_mt);
 }
+
+int eh_frame_register(struct eh_frame_setup __user *user_data, __kernel_size_t size)
+{
+	struct eh_frame_setup data;
+	unsigned long eh_frame_hdr_end, text_end;
+
+	if (!user_data && !size)
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
+	if (!user_data && !size)
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

