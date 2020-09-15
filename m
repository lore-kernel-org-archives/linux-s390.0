Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727476AbgIOPny (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 11:43:54 -0400
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 3/4] s390/uaccess: implement HAVE_GET_KERNEL_NOFAULT support
Date: Tue, 15 Sep 2020 17:43:39 +0200
Message-Id: <20200915154340.4215-4-hca@linux.ibm.com>
In-Reply-To: <20200915154340.4215-1-hca@linux.ibm.com>
References: <20200915154340.4215-1-hca@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h | 111 ++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index f09444d6aeab..3ef424bca082 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -278,4 +278,115 @@ static inline unsigned long __must_check clear_user(void __user *to, unsigned lo
 int copy_to_user_real(void __user *dest, void *src, unsigned long count);
 void *s390_kernel_write(void *dst, const void *src, size_t size);
 
+#define HAVE_GET_KERNEL_NOFAULT
+
+int __put_kernel_bad(void) __attribute__((noreturn));
+
+#define __put_kernel_asm(val, to, insn)					\
+({									\
+	int __rc;							\
+									\
+	asm volatile(							\
+		"0:   " insn "  %2,%1\n"				\
+		"1:	xr	%0,%0\n"				\
+		"2:\n"							\
+		".pushsection .fixup, \"ax\"\n"				\
+		"3:	lhi	%0,%3\n"				\
+		"	jg	2b\n"					\
+		".popsection\n"						\
+		EX_TABLE(0b,3b) EX_TABLE(1b,3b)				\
+		: "=d" (__rc), "+Q" (*(to))				\
+		: "d" (val), "K" (-EFAULT)				\
+		: "cc");						\
+	__rc;								\
+})
+
+#define __put_kernel_nofault(dst, src, type, err_label)                 \
+do {                                                                    \
+	u64 __x = (u64)(*((type *)(src)));				\
+	int __pk_err;							\
+									\
+	switch (sizeof(type)) {						\
+	case 1:								\
+		__pk_err = __put_kernel_asm(__x, (type *)(dst), "stc"); \
+		break;							\
+	case 2:								\
+		__pk_err = __put_kernel_asm(__x, (type *)(dst), "sth"); \
+		break;							\
+	case 4:								\
+		__pk_err = __put_kernel_asm(__x, (type *)(dst), "st");	\
+		break;							\
+	case 8:								\
+		__pk_err = __put_kernel_asm(__x, (type *)(dst), "stg"); \
+		break;							\
+	default:							\
+		__pk_err = __put_kernel_bad();				\
+		break;							\
+	}								\
+	if (unlikely(__pk_err))						\
+		goto err_label;						\
+} while (0)
+
+int __get_kernel_bad(void) __attribute__((noreturn));
+
+#define __get_kernel_asm(val, from, insn)				\
+({									\
+	int __rc;							\
+									\
+	asm volatile(							\
+		"0:   " insn "  %1,%2\n"				\
+		"1:	xr	%0,%0\n"				\
+		"2:\n"							\
+		".pushsection .fixup, \"ax\"\n"				\
+		"3:	lhi	%0,%3\n"				\
+		"	jg	2b\n"					\
+		".popsection\n"						\
+		EX_TABLE(0b,3b) EX_TABLE(1b,3b)				\
+		: "=d" (__rc), "+d" (val)				\
+		: "Q" (*(from)), "K" (-EFAULT)				\
+		: "cc");						\
+	__rc;								\
+})
+
+#define __get_kernel_nofault(dst, src, type, err_label)                 \
+do {                                                                    \
+	int __gk_err = -EFAULT;						\
+									\
+	switch (sizeof(type)) {						\
+	case 1: {							\
+		u8 __x = 0;						\
+									\
+		__gk_err = __get_kernel_asm(__x, (type *)(src), "ic");	\
+		*((type *)(dst)) = (type)__x;				\
+		break;							\
+	};								\
+	case 2: {							\
+		u16 __x = 0;						\
+									\
+		__gk_err = __get_kernel_asm(__x, (type *)(src), "lh");	\
+		*((type *)(dst)) = (type)__x;				\
+		break;							\
+	};								\
+	case 4: {							\
+		u32 __x = 0;						\
+									\
+		__gk_err = __get_kernel_asm(__x, (type *)(src), "l");	\
+		*((type *)(dst)) = (type)__x;				\
+		break;							\
+	};								\
+	case 8: {							\
+		u64 __x = 0;						\
+									\
+		__gk_err = __get_kernel_asm(__x, (type *)(src), "lg");	\
+		*((type *)(dst)) = (type)__x;				\
+		break;							\
+	};								\
+	default:							\
+		__gk_err = __get_kernel_bad();				\
+		break;							\
+	}								\
+	if (unlikely(__gk_err))						\
+		goto err_label;						\
+} while (0)
+
 #endif /* __S390_UACCESS_H */
-- 
2.17.1
