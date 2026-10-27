Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111439;
	b=Ay1fnUlwqUJrEbFb9yvu8+fghWGACCYpbmUP6UinMLt7fvptDchiqNw2J3lyWGnVg3DY
	 EdUSo1e8VqQarUIJdqHFCN+68oGGUidTN/Kh17tVWwBsIm1lqE72NH+ACCFixeJ90zjUI
	 Q+c3BkCfF2X8gevEpBX++Eqdaepdm8rJYndMTcN8/rhK0jbi8B+jnNCyTznM8ChOJkvZM
	 hdbcD6qA2Fuo2CEPS+s0NA8859ef5OyM8G4L/koZNbON5ttmd6JG+F5+3tSnb3qzW9YrQ
	 aEney7ClPpRuus2hFVsPy1hry+5BQE8bf9U73VCak1OceCNhjN4Y/5P3JQojtouyAPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111439;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0tmTKeSbF5dRArzIrGP2iG4uo2NGAOsdbmXF3AzBOjI=;
	b=x+p5TAL2WilBg8oJTc9Hki3R+XEXNtqyUoJi65Sr90VDtwHHiy9Y8eYrcLH7FjKqSe9h
	 vaBLkMDe850bocStux1k2WlpsACV7Z8BIdEVGkAcs6BLr6cTXe2XBnz05CDSpFHXge5u1
	 Q6cVISd+d63JVKQSBM0y0TX1oDOBbnJ32cBeYv0OYZ9eCKc3Fydv5UuDRCTCZhShwbtR/
	 A1ufaqSQYOrhfdgOtZv95MABSpmdYaWjIX9wc9KPFLbp1b5kW2iiUhMZrmy9TUP01kS8z
	 0UDhNg0F1vljl9uy2MMWt43nR97UY8HBOT2wQmkUm2BiRU5NaqSCpBc5mhWhPKZ7cIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IhstAVeS;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7C60A260F;
	Tue, 27 Oct 2026 14:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B7C60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IhstAVeS
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REELid1518855;
	Tue, 27 Oct 2026 14:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0tmTKeSbF5dRArzIr
	GP2iG4uo2NGAOsdbmXF3AzBOjI=; b=IhstAVeSPfil5lZnCfY9/PnhmqN12xgZa
	Z+mJKJMefvyAlVNL6k/Hvk6w2/16FN0xUlOiRjtYmfgBPYAsG59wXAAsjwKGZDhl
	Iy5hqdiBtn6WsPrj+ncc2AlmwDjQ2FuCSHczFvn97UnTQGqNTyJZGMo+Ii70Cf4X
	NtdovAMrnefTaHm/JUg07eCkD6ng5QcBLefU1Mt/l39nQTT/N/e/Dju5WVL7JhwJ
	2AkCCCvfKhcdc29gWwNlobQaVjPzdGqZs5R+w7CVLpAcbZgQjj0o4z1YyNuafo3q
	ruTcJ6yHkt2blQny2uqDGp+theufJrsroYP5dbBnggHJqBj62fqDQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3fysgm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDobdF097357;
	Tue, 27 Oct 2026 14:30:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh33at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUWTL43712846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B69D320040;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94CF820043;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 09/10] s390/uaccess: Move s390_kernel_write() to asm/text-patching.h
Date: Tue, 27 Oct 2026 15:30:29 +0100
Message-ID: <20261027143030.3154657-10-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0b58d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=sZFfZANlLT8gPewTKxcA:9
X-Proofpoint-ORIG-GUID: jOxQF5ssHB1w3F4EuUMa32bAhFTJg9LB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX5eJY4Y5ZrXvU
 BHIz8i8YzRZ5sXKqiw2+k2Ba8dSmW/0wJpWLeCu0H6oKB1vKJu3tWeIBnm/diqtApQBWC9wlpxY
 LrRQEDXvY532K3wLA9LwF1XUZPMVCDJkCKD0cozXNcpVBmCTNYhl8Ag0NMh0hwT8gzrsVJGVIJa
 pFludA6QSTE3CYCkUMzN8blbB5I1472UL1kR1DRUe3TnxYcnIC6Jgudf9PP177h9Qpu9BBiMvmB
 fFlsEUDmZBtgY5uP5bkx3O7lFj0OtBJ/JVzmn1loIAELvwO4w0TMFWH1kaZhPpVpp4w3T/7im/E
 1c+bt+RF9EazkFVoUnnQaebU0cFw3vEZMEfwAJc/qO+uv5QEzV2Co5VQp43kOONm34xoaXwBcj3
 fJAHkWbaJSeal5OoGm4gJAeKD55FUBVSBVIVE3lvWbvYbDWTkrrmu6Q5vpRkFKgOj9f6pjk8VLF
 i1vM8LARTddie4613Gw==
X-Proofpoint-GUID: jOxQF5ssHB1w3F4EuUMa32bAhFTJg9LB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX1QNsq4uU7/lr
 pr7nrGnmks9ZJXTCuuLiocrwBIVGQkH62N8kyiNUTYs23Md7wLkNHnDrflq/IdwAtE8BCpTrgWl
 h+8PhscIpD5F+7vOV+0jAG+LMDisaUk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056

s390_kernel_write() is a text-patching primitive, not a user access
function. Move its declaration and the inline wrapper from uaccess.h
to text-patching.h.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/runtime-const.h |  2 +-
 arch/s390/include/asm/text-patching.h | 11 +++++++++++
 arch/s390/include/asm/uaccess.h       |  9 ---------
 arch/s390/kernel/alternative.c        |  2 +-
 arch/s390/kernel/jump_label.c         |  1 -
 arch/s390/kernel/module.c             |  1 +
 arch/s390/kernel/nospec-branch.c      |  2 ++
 arch/s390/kernel/stackprotector.c     |  2 +-
 arch/s390/mm/maccess.c                |  1 +
 9 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index 0e2402717e8b..4d73a198f63f 100644
--- a/arch/s390/include/asm/runtime-const.h
+++ b/arch/s390/include/asm/runtime-const.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_S390_RUNTIME_CONST_H
 #define _ASM_S390_RUNTIME_CONST_H
 
-#include <linux/uaccess.h>
+#include <linux/text-patching.h>
 #include <linux/memory.h>
 
 #define runtime_const_ptr(sym)					\
diff --git a/arch/s390/include/asm/text-patching.h b/arch/s390/include/asm/text-patching.h
index b219056a8817..c2f87f20ff97 100644
--- a/arch/s390/include/asm/text-patching.h
+++ b/arch/s390/include/asm/text-patching.h
@@ -3,6 +3,8 @@
 #ifndef _ASM_S390_TEXT_PATCHING_H
 #define _ASM_S390_TEXT_PATCHING_H
 
+#include <linux/string.h>
+#include <linux/memory.h>
 #include <asm/barrier.h>
 
 static __always_inline void sync_core(void)
@@ -13,4 +15,13 @@ static __always_inline void sync_core(void)
 void text_poke_sync(void);
 void text_poke_sync_lock(void);
 
+void *__s390_kernel_write(void *dst, const void *src, size_t size);
+
+static inline void *s390_kernel_write(void *dst, const void *src, size_t size)
+{
+	if (__is_defined(__DECOMPRESSOR))
+		return memcpy(dst, src, size);
+	return __s390_kernel_write(dst, src, size);
+}
+
 #endif /* _ASM_S390_TEXT_PATCHING_H */
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index ac99b32c6ceb..db6acea9e7b8 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -384,15 +384,6 @@ static __always_inline unsigned long __must_check clear_user(void __user *to, un
 	return __clear_user(to, n);
 }
 
-void *__s390_kernel_write(void *dst, const void *src, size_t size);
-
-static inline void *s390_kernel_write(void *dst, const void *src, size_t size)
-{
-	if (__is_defined(__DECOMPRESSOR))
-		return memcpy(dst, src, size);
-	return __s390_kernel_write(dst, src, size);
-}
-
 void __noreturn __mvc_kernel_nofault_bad(void);
 
 #if defined(CONFIG_CC_HAS_ASM_GOTO_OUTPUT) && defined(CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS)
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index 6013a75f5241..8efd2165692b 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -4,9 +4,9 @@
 #define pr_fmt(fmt)	"alt: " fmt
 #endif
 
+#include <linux/text-patching.h>
 #include <linux/hex.h>
 #include <linux/memory.h>
-#include <linux/uaccess.h>
 #include <linux/printk.h>
 #include <asm/nospec-branch.h>
 #include <asm/abs_lowcore.h>
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 548141eaa20b..5c3083c917bb 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -6,7 +6,6 @@
  * Author(s): Jan Glauber <jang@linux.vnet.ibm.com>
  */
 #include <linux/memory.h>
-#include <linux/uaccess.h>
 #include <linux/jump_label.h>
 #include <linux/module.h>
 #include <asm/text-patching.h>
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 79bc80d7bd02..4e03f40d2b2e 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -10,6 +10,7 @@
  *  based on i386 version
  *    Copyright (C) 2001 Rusty Russell.
  */
+#include <linux/text-patching.h>
 #include <linux/module.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index 26cd5b278e8a..1d9d05e1def4 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <linux/text-patching.h>
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/device.h>
diff --git a/arch/s390/kernel/stackprotector.c b/arch/s390/kernel/stackprotector.c
index d72aef57a40a..5da113c2c7f6 100644
--- a/arch/s390/kernel/stackprotector.c
+++ b/arch/s390/kernel/stackprotector.c
@@ -4,10 +4,10 @@
 #define pr_fmt(fmt)	"stackprot: " fmt
 #endif
 
+#include <linux/text-patching.h>
 #include <linux/export.h>
 #include <linux/hex.h>
 #include <linux/memory.h>
-#include <linux/uaccess.h>
 #include <linux/printk.h>
 #include <asm/abs_lowcore.h>
 #include <asm/sections.h>
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index f39968dd8063..6b25203fb05c 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/text-patching.h>
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-- 
2.53.0

