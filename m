Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103E3F4117
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001231; cv=none; b=T8bLnysfPYZUoWuALt+Y6pLYBylyJWKa1HMqOwX1ENzeswUfGq3TaCQrLjXcGydbgYkKU1gqk+P2+eMDpMRdCw026pm+nSOWec9JzbN553dJC6LJyVZRWZ3Q/g8LUk0/e6ag5jZI8V+A5oiDZSt/empl+6w5R5JPwySzDh3e+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001231; c=relaxed/simple;
	bh=OMhNTzVwxgQ6vqrqX52G+JJrMh8JaMtfH33fsDHTxys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7gTkiE1x85NXXSpO2sisYr9fAMFYz1hidrBdma/rTw/fMT3yZSyB/7hCyj1e39R0iMg4YgSy5GrB6OLFZC4yq9u4zmpiot66MeeJ5jyuqnBSPAxWR3AYpS1p5IaQNIDgBC2WTCH8S71ocZvs0xoRZMnh5lIMmtqWg9BAm7tDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r6k2rvhW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r6k2rvhW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658KJxQc2465898
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7Xdy0YbZEeXKj2bks
	HtfF8j2l6XHni8t/+UTE2UgxCM=; b=r6k2rvhW9JO1ar6lbDf38pto2E6eD8yf0
	TRuDtUYAu88VCXpEmUVLiZUhz7W3+Pti0g34eJo4SArnDoxi723P6MXD0UXmLpUQ
	GhTYaU8fU//9t4R6SpyLkVpJ87qLSmH6y1naZUsKRR54bPJkyTqP+ux9a03qEq1t
	oHb2czRLJ/mNL9YOhfZimhCvSBB+YhjzhP0Vq5eKUJbo0+4U7hp6dLKOnov08BC4
	3W4sPko3Ks8X4nCQ+3h9JkinZXEy900g7jQ5+PMHZaoxs1TFjYkD/zT3bstJHg+1
	lm5N/hI9fsvmjl2TC/yAdI2OLDtPYhrjSsC8DD9kbphfIzryigauw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sucmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJecY003736
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy99n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXir040698296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE25E2004E;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90C362004B;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 3/9] s390/string: Add -ffreestanding compile option to string.o
Date: Tue,  9 Jun 2026 12:33:37 +0200
Message-ID: <20260609103343.107325-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609103343.107325-1-hca@linux.ibm.com>
References: <20260609103343.107325-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hXEq92HRUlp-RAhsB4hocZ75_GwBw1fA
X-Proofpoint-GUID: hXEq92HRUlp-RAhsB4hocZ75_GwBw1fA
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a27ec0d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pYktNFmJ8AmhxwwasfgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfX50VMFvlT1tk/
 Qm7ud3Gorvbcjh94oKfAirjg40JkVEc0ApL1uz73Q7KjPcuktMeqLuIueX5+jnXtVnIA3Tc4DuQ
 2nHhYufMTCuFomtEMQulG1yGbGAV9HInsLRMjdxodcTKFYmYdUj5gewoArXZWiTwX71VSxf3p5P
 P2XbKo/VUaU1YbOU1zyUyFkv/wuDo3gAWtTDtAGMLNq1TQuhfapSiZe3k21rd767ClR+YOvJ3Zd
 WlVXFTRVa8R+m3C948ZCe7sD3KeQOuveqBoFl1+zcbmePyQQqqq3c+1v00IiLTyJdrNY5I1heN6
 0h0DBUGNObfW0a9hcECHxDl8QjFDs9pwFbRUmn6pj3OK8EBRonkW48Ua6QafOroQrXQ6YFIU+ZK
 45dbW+d1dQ73V+jxXRFWgUEMn3BwIoDbcfKIyFbxWthAGnDmRyZ+Jot+NdzNDORnyD42rGL3DxA
 diq5Y4kVGxCN/qR0RLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090094

Use -ffreestanding for string.o to avoid that the compiler generates
calls into themselves for standard library functions like memset().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/Makefile | 5 +++++
 arch/s390/lib/Makefile  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index a1e719a79d38..e1f82d118bc9 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -25,6 +25,11 @@ KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 
 CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 
+# string.o implements standard library functions like memset/memcpy etc.
+# Use -ffreestanding to ensure that the compiler does not try to "optimize"
+# them into calls to themselves.
+CFLAGS_string.o = -ffreestanding
+
 obj-y	:= head.o als.o startup.o physmem_info.o ipl_parm.o ipl_report.o vmem.o
 obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
 obj-y	+= version.o pgm_check.o ctype.o ipl_data.o relocs.o alternative.o
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index 2bf47204f6ab..c82aedef0272 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -3,6 +3,11 @@
 # Makefile for s390-specific library files..
 #
 
+# string.o implements standard library functions like memset/memcpy etc.
+# Use -ffreestanding to ensure that the compiler does not try to "optimize"
+# them into calls to themselves.
+CFLAGS_string.o = -ffreestanding
+
 lib-y += delay.o string.o uaccess.o find.o spinlock.o tishift.o
 lib-y += csum-partial.o
 obj-y += mem.o
-- 
2.53.0

