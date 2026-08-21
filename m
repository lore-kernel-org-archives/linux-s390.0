Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA342BC3A;
	Fri, 21 Aug 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342032; cv=none; b=qVcgrdmNKPmj7EiA242vtYvWRyNtSYpebwHRt7IgVCyAx/b2B3yuVGL3uJUbCJ7yJgfCVJYf7kXOcnYzElRRgOUBVmVtU2IPL7P5ttpjBkIUu6wOemPyFtZXrUBFb/79lo/LFI04wrVeXHwQEb9zGP7azLThWH+cbar5WOt5yOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342032; c=relaxed/simple;
	bh=jyKcTd/kpV54h9Hy59OQuFjCYkzCdrb9oBE70SGGnQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIy6v/VouqjXk5AkIaDC87MdP4WFbA95QRcJHVyH+Fbo207Ng56CMQ50PVtG5l/z49EaOsoERctBjkHT8hfI3ppS3YyQx2XcC5XMP9nE67UPB7oDj+buuO9OBOtU+mkXsh7RiIMhlcTmJ8H8t7VTM6z6Ojo1L6M/zcMXAVhrU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CobCQ6sm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CobCQ6sm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVeYx2363796;
	Fri, 21 Aug 2026 19:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=j+wEbXZq/n+IhPUNd
	E1WSrq7I0dPA9QUfGyBzZcW9pY=; b=CobCQ6smd3zC4mBkFKcVi0kwZoWHDM0hS
	SGMA5DKTJ9sSBndUvhMS4eYwIE23AVnwGqrLSOI05GYnvezY7lgk5V8bGst1kq/D
	sBUzwJmpE+crZlVPBc33WafcNDilssGb0XKk5p9bGPN8CoA0JJVp+DXfyMDNrzEJ
	vq1QAKjG1Ddno1nNzsLvA8mZlzTFX5NQkUu1pRJRPdlvSnlFM7KDcbsRrQERMJo1
	0zKytnMNTUF6J7NxumU4gIUav7TkXRT+1OsrUrPngci0BltIZaANqLV1SlFjeN9W
	lJ3tCSf+S8Es21jOXfVtJnXbpgjVQ52vrn/e/8o/yHIE/WVV+lJUw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0uxkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfKU9008731;
	Fri, 21 Aug 2026 19:53:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yxdwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr7at45154634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21CE52004B;
	Fri, 21 Aug 2026 19:53:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF4792004E;
	Fri, 21 Aug 2026 19:53:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:06 +0000 (GMT)
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
Subject: [RFC PATCH v2 07/24] unwind_user/eh_frame: Add support for reading .eh_frame_hdr section
Date: Fri, 21 Aug 2026 21:52:42 +0200
Message-ID: <20260821195259.2688377-8-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88aca8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=meVymXHHAAAA:8
 a=SzVkBJ_cOz4MhcCxlBAA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: jEoAe7cfRj1X6HO5mqUaDfdo1LbQOC4q
X-Proofpoint-GUID: DBRTnkmGeT5zVgu34pKHiGG6Wtlh34og
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX/TvzHU1t0u/i
 AxKIrUWHhsQHcUWwVeb9de5WE2/bg1G4ptzcowqVMNpbFb1KYXRGgjNPwMVY/3LwDcc/Yv23don
 znvGymzU5p92DC80AWhxN15qPPADGKY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX9W/cQxxRPyPD
 G9kx8KaKXJ7U9QZsFd9aqqcCQ9hlt4/ShojZH08nz6+1prZbGwsnFfprGsRJmzQcUgW2jQF252C
 hYNUySJGbv+pj1R9FkzPookpKswHXB+oIoh+ZYDZ/l+AJyYo6EeyQL27KO7WjuBtcFU6CcFNqr6
 nm/6P9Mbn7ycNgz/T1CT0N1VINfnxeFRTkqO99e0Ukk45MQOkNxTBx8vmmI98sxAGF8QMJwoyVk
 an8vrAXezWLYU06Dj27RRQv9c5NgH4I4cjdzM970clfjQzWAfpBsh2s/x8FG3F31xbbd5M5XRjz
 14Jooe/mRvVS2sHE+aclqppWZk13g79yhYiXgZyh0KW9v7El6Fgbp8BDBFKXR+g8w8WHUhLSa5C
 BE61TOuaCIb+EIB+FRGsAn+dzF/1kQirarDD8k+VlbwgogYTP9PHiLPDhShFnNGxoGtYVCbrsLc
 +GjJYbh6zO9ex7ndSQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

In preparation for unwinding user space stacks with .eh_frame, add
basic unwind user eh_frame infrastructure and support for reading the
.eh_frame_hdr section.

The .eh_frame_hdr section provides a binary search table for efficient
lookup of Frame Description Entries (FDEs) in the .eh_frame section
based on instruction pointer (IP).

eh_frame_add_section() reads the .eh_frame_hdr section and
unconditionally returns an error, so it is not very useful yet.  A
subsequent patch will improve that.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - read_encoded_pointer(): Enable DW_EH_PE_absptr in combination with
      relative application flags (e.g. DW_EH_PE_pcrel). (Sashiko AI)
    - eh_frame_read_header(): Fix binary search table bounds check.
      (Sashiko AI)
    - UNSAFE_GET_USER_INC(): Improve overflow check.

 MAINTAINERS              |   1 +
 arch/Kconfig             |   3 +
 include/linux/eh_frame.h |  45 +++++
 kernel/unwind/Makefile   |   3 +-
 kernel/unwind/eh_frame.c | 366 +++++++++++++++++++++++++++++++++++++++
 kernel/unwind/eh_frame.h |  30 ++++
 6 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/eh_frame.h
 create mode 100644 kernel/unwind/eh_frame.c
 create mode 100644 kernel/unwind/eh_frame.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e5738a250d63..f19f5bb87f00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28203,6 +28203,7 @@ M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
 F:	arch/*/include/asm/unwind_user.h
 F:	include/asm-generic/unwind_user.h
+F:	include/linux/eh_frame.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..60542d5e5731 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -486,6 +486,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 config UNWIND_USER
 	bool
 
+config HAVE_UNWIND_USER_EH_FRAME
+	bool
+
 config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
new file mode 100644
index 000000000000..aaac2dd663d5
--- /dev/null
+++ b/include/linux/eh_frame.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_EH_FRAME_H
+#define _LINUX_EH_FRAME_H
+
+#ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
+
+struct eh_frame_section {
+	unsigned long	eh_frame_hdr_start;
+	unsigned long	eh_frame_hdr_end;
+	unsigned long	text_start;
+	unsigned long	text_end;
+
+	/* .eh_frame_hdr information */
+	unsigned long	eh_frame_start;
+	unsigned long	eh_frame_vma_end;
+	unsigned long	binary_search_table_start;
+	unsigned long	binary_search_table_end;
+	unsigned long	fde_count;
+	u8		binary_search_table_enc;
+};
+
+extern int eh_frame_add_section(unsigned long eh_frame_hdr_start,
+				unsigned long eh_frame_hdr_end,
+				unsigned long text_start,
+				unsigned long text_end);
+extern int eh_frame_remove_section(unsigned long eh_frame_hdr_start);
+
+#else /* !CONFIG_HAVE_UNWIND_USER_EH_FRAME */
+
+static inline int eh_frame_add_section(unsigned long eh_frame_hdr_start,
+				       unsigned long eh_frame_hdr_end,
+				       unsigned long text_start,
+				       unsigned long text_end)
+{
+	return -ENOSYS;
+}
+
+static inline int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_HAVE_UNWIND_USER_EH_FRAME */
+
+#endif /* _LINUX_EH_FRAME_H */
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index eae37bea54fd..2d97e2625d8a 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1,2 @@
- obj-$(CONFIG_UNWIND_USER)	+= user.o deferred.o
+ obj-$(CONFIG_UNWIND_USER)			+= user.o deferred.o
+ obj-$(CONFIG_HAVE_UNWIND_USER_EH_FRAME)	+= eh_frame.o
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
new file mode 100644
index 000000000000..f25a0923e315
--- /dev/null
+++ b/kernel/unwind/eh_frame.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace eh_frame access functions
+ */
+
+#define pr_fmt(fmt)	"eh_frame: " fmt
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <linux/string_helpers.h>
+#include <linux/eh_frame.h>
+#include <linux/unwind_user_types.h>
+
+#include "eh_frame.h"
+
+#define dbg(fmt, ...)							\
+	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+
+#define UNSAFE_GET_USER_INC(to, from, end, label)			\
+({									\
+	typeof(to) __to;						\
+	if (sizeof(__to) > end - from)					\
+		return -EINVAL;						\
+	unsafe_get_user(__to, (typeof(to) __user *)from, label);	\
+	from += sizeof(__to);						\
+	to = __to;							\
+})
+
+static __always_inline int read_uleb128(unsigned long *addr, unsigned long end,
+					unsigned long *value)
+{
+	unsigned long cur = *addr;
+	unsigned long result = 0;
+	int shift = 0;
+	u8 byte;
+
+	do {
+		if (shift >= BITS_PER_LONG)
+			return -EINVAL;
+
+		UNSAFE_GET_USER_INC(byte, cur, end, Efault);
+		result |= (unsigned long)(byte & 0x7f) << shift;
+		shift += 7;
+	} while (byte & 0x80);
+
+	*value = result;
+	*addr = cur;
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int read_sleb128(unsigned long *addr, unsigned long end,
+					long *value)
+{
+	unsigned long cur = *addr;
+	long result = 0;
+	int shift = 0;
+	u8 byte;
+
+	do {
+		if (shift >= BITS_PER_LONG)
+			return -EINVAL;
+
+		UNSAFE_GET_USER_INC(byte, cur, end, Efault);
+		result |= (long)(byte & 0x7f) << shift;
+		shift += 7;
+	} while (byte & 0x80);
+
+	/* Sign extend if necessary */
+	if (shift < BITS_PER_LONG && (byte & 0x40))
+		result |= -(1L << shift);
+
+	*value = result;
+	*addr = cur;
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int encoded_pointer_size(u8 encoding)
+{
+	u8 format = DW_EH_PE_format(encoding);
+
+	switch (format) {
+	case DW_EH_PE_absptr:
+		return sizeof(unsigned long);
+	case DW_EH_PE_udata2:
+	case DW_EH_PE_sdata2:
+		return 2;
+	case DW_EH_PE_udata4:
+	case DW_EH_PE_sdata4:
+		return 4;
+	case DW_EH_PE_udata8:
+	case DW_EH_PE_sdata8:
+		return 8;
+	case DW_EH_PE_uleb128:
+	case DW_EH_PE_sleb128:
+		/* Variable length */
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static __always_inline int read_encoded_pointer(struct eh_frame_section *sec,
+						unsigned long *addr,
+						unsigned long end,
+						u8 encoding,
+						unsigned long *value)
+{
+	unsigned long cur = *addr;
+	u8 format = DW_EH_PE_format(encoding);
+	u8 application = DW_EH_PE_application(encoding);
+	unsigned long result;
+	int ret;
+
+	if (encoding == DW_EH_PE_omit)
+		return -EINVAL;
+
+	/* Determine base address based on application */
+	switch (application) {
+	case 0:
+		/* Absolute */
+		result = 0;
+		break;
+	case DW_EH_PE_pcrel:
+		result = *addr;
+		break;
+	case DW_EH_PE_datarel:
+		result = sec->eh_frame_hdr_start;
+		break;
+	case DW_EH_PE_textrel:
+		result = sec->text_start;
+		break;
+	case DW_EH_PE_funcrel:
+	case DW_EH_PE_aligned:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+
+	/* Read value based on format */
+	switch (format) {
+	case DW_EH_PE_absptr: {
+		unsigned long tmp;
+		UNSAFE_GET_USER_INC(tmp, cur, end, Efault);
+		result += tmp;
+		break;
+	}
+	case DW_EH_PE_uleb128: {
+		unsigned long tmp;
+		ret = read_uleb128(&cur, end, &tmp);
+		if (ret)
+			return ret;
+		result += tmp;
+		break;
+	}
+	case DW_EH_PE_udata2: {
+		u16 tmp16;
+		UNSAFE_GET_USER_INC(tmp16, cur, end, Efault);
+		result += tmp16;
+		break;
+	}
+	case DW_EH_PE_udata4: {
+		u32 tmp32;
+		UNSAFE_GET_USER_INC(tmp32, cur, end, Efault);
+		result += tmp32;
+		break;
+	}
+	case DW_EH_PE_udata8: {
+		u64 tmp64;
+		UNSAFE_GET_USER_INC(tmp64, cur, end, Efault);
+		result += tmp64;
+		break;
+	}
+	case DW_EH_PE_sleb128: {
+		long stmp;
+		ret = read_sleb128(&cur, end, &stmp);
+		if (ret)
+			return ret;
+		result += stmp;
+		break;
+	}
+	case DW_EH_PE_sdata2: {
+		s16 stmp16;
+		UNSAFE_GET_USER_INC(stmp16, cur, end, Efault);
+		result += stmp16;
+		break;
+	}
+	case DW_EH_PE_sdata4: {
+		s32 stmp32;
+		UNSAFE_GET_USER_INC(stmp32, cur, end, Efault);
+		result += stmp32;
+		break;
+	}
+	case DW_EH_PE_sdata8: {
+		s64 stmp64;
+		UNSAFE_GET_USER_INC(stmp64, cur, end, Efault);
+		result += stmp64;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	/* Indirect (dereference) - should not occur */
+	if (encoding & DW_EH_PE_indirect)
+		return -EOPNOTSUPP;
+
+	*value = result;
+	*addr = cur;
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static void free_section(struct eh_frame_section *sec)
+{
+	kfree(sec);
+}
+
+static int eh_frame_read_header(struct eh_frame_section *sec)
+{
+	struct mm_struct *mm = current->mm;
+	void __user *eh_frame_hdr = (void __user *)sec->eh_frame_hdr_start;
+	unsigned long cur = sec->eh_frame_hdr_start, end = sec->eh_frame_hdr_end;
+	unsigned long eh_frame_start, eh_frame_vma_end, table_start, table_end;
+	u8 version, eh_frame_ptr_enc, fde_count_enc, table_enc;
+	unsigned long fde_count;
+	int entry_size;
+	int ret;
+
+	/*
+	 * Unaligned access to .eh_frame[_hdr] fields using
+	 * unsafe_get_user() via UNSAFE_GET_USER_INC()
+	 */
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS));
+
+	scoped_user_read_access_size(eh_frame_hdr, end - sec->eh_frame_hdr_start,
+				     Efault) {
+		/* Read version */
+		UNSAFE_GET_USER_INC(version, cur, end, Efault);
+		if (version != 1)
+			return -EINVAL;
+
+		/* Read encoding information */
+		UNSAFE_GET_USER_INC(eh_frame_ptr_enc, cur, end, Efault);
+		UNSAFE_GET_USER_INC(fde_count_enc, cur, end, Efault);
+		UNSAFE_GET_USER_INC(table_enc, cur, end, Efault);
+
+		/* .eh_frame_hdr without binary search table is not supported */
+		if (fde_count_enc == DW_EH_PE_omit || table_enc == DW_EH_PE_omit)
+			return -EINVAL;
+
+		/* Read pointer to .eh_frame */
+		ret = read_encoded_pointer(sec, &cur, end,
+					   eh_frame_ptr_enc, &eh_frame_start);
+		if (ret)
+			return ret;
+
+		/* Read FDE count */
+		ret = read_encoded_pointer(sec, &cur, end,
+					   fde_count_enc, &fde_count);
+		if (ret)
+			return ret;
+
+		/* Determine binary search table start and end */
+		table_start = cur;
+		entry_size = 2 * encoded_pointer_size(table_enc);
+		if (!entry_size)
+			return -EINVAL;
+		if (fde_count > (end - table_start) / entry_size)
+			return -EINVAL;
+		table_end = table_start + fde_count * entry_size;
+	}
+
+	scoped_guard(mmap_read_lock, mm) {
+		struct vm_area_struct *eh_frame_vma;
+
+		eh_frame_vma = vma_lookup(mm, eh_frame_start);
+		if (!eh_frame_vma) {
+			dbg("bad eh_frame address (0x%lx)\n", eh_frame_start);
+			return -EINVAL;
+		}
+		eh_frame_vma_end = eh_frame_vma->vm_end;
+	}
+
+	sec->eh_frame_start		= eh_frame_start;
+	sec->eh_frame_vma_end		= eh_frame_vma_end;
+	sec->binary_search_table_start	= table_start;
+	sec->binary_search_table_end	= table_end;
+	sec->binary_search_table_enc	= table_enc;
+	sec->fde_count			= fde_count;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+int eh_frame_add_section(unsigned long eh_frame_hdr_start,
+			 unsigned long eh_frame_hdr_end,
+			 unsigned long text_start,
+			 unsigned long text_end)
+{
+	struct mm_struct *mm = current->mm;
+	struct eh_frame_section *sec;
+	int ret;
+
+	if (eh_frame_hdr_start >= eh_frame_hdr_end || text_start >= text_end) {
+		dbg("invalid eh_frame/text address\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mmap_read_lock, mm) {
+		struct vm_area_struct *eh_frame_hdr_vma, *text_vma;
+
+		eh_frame_hdr_vma = vma_lookup(mm, eh_frame_hdr_start);
+		if (!eh_frame_hdr_vma || eh_frame_hdr_end > eh_frame_hdr_vma->vm_end) {
+			dbg("bad eh_frame_hdr address (0x%lx - 0x%lx)\n",
+			    eh_frame_hdr_start, eh_frame_hdr_end);
+			return -EINVAL;
+		}
+
+		text_vma = vma_lookup(mm, text_start);
+		if (!text_vma ||
+		    !(text_vma->vm_flags & VM_EXEC) ||
+		    text_end > text_vma->vm_end) {
+			dbg("bad text address (0x%lx - 0x%lx)\n",
+			    text_start, text_end);
+			return -EINVAL;
+		}
+	}
+
+	sec = kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
+	if (!sec)
+		return -ENOMEM;
+
+	sec->eh_frame_hdr_start	= eh_frame_hdr_start;
+	sec->eh_frame_hdr_end	= eh_frame_hdr_end;
+	sec->text_start		= text_start;
+	sec->text_end		= text_end;
+
+	ret = eh_frame_read_header(sec);
+	if (ret)
+		goto err_free;
+
+	/* TODO nowhere to store it yet - just free it and return an error */
+	ret = -ENOSYS;
+
+err_free:
+	free_section(sec);
+	return ret;
+}
+
+int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
+{
+	return -ENOSYS;
+}
diff --git a/kernel/unwind/eh_frame.h b/kernel/unwind/eh_frame.h
new file mode 100644
index 000000000000..77eda5376dfb
--- /dev/null
+++ b/kernel/unwind/eh_frame.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _EH_FRAME_H
+#define _EH_FRAME_H
+
+/* DWARF exception header pointer encodings */
+#define DW_EH_PE_omit			0xff
+/* Formats */
+#define DW_EH_PE_absptr			0x00
+#define DW_EH_PE_uleb128		0x01
+#define DW_EH_PE_udata2			0x02
+#define DW_EH_PE_udata4			0x03
+#define DW_EH_PE_udata8			0x04
+#define DW_EH_PE_sleb128		0x09
+#define DW_EH_PE_sdata2			0x0a
+#define DW_EH_PE_sdata4			0x0b
+#define DW_EH_PE_sdata8			0x0c
+/* Applications */
+#define DW_EH_PE_pcrel			0x10
+#define DW_EH_PE_textrel		0x20
+#define DW_EH_PE_datarel		0x30
+#define DW_EH_PE_funcrel		0x40
+#define DW_EH_PE_aligned		0x50
+/* Flags */
+#define DW_EH_PE_indirect		0x80
+
+/* Helpers for DWARF exception header pointer encodings */
+#define DW_EH_PE_format(encoding)	((encoding) & 0x0f)
+#define DW_EH_PE_application(encoding)	((encoding) & 0x70)
+
+#endif /* _EH_FRAME_H */
-- 
2.53.0

