Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684172;
	b=IiT9aP41IzALVbfttkPe0gsyV9dPltntIvBztcVqdGct/dqW+Io9cuGvolyGAIyZl2ys
	 mAxxxYlIkvePU/UARx9Um20EsRgba1mGXhmjVRcBaB+bTtpDv13Yd2v/r8igurE99727V
	 COKcuQbRXGo0fjky7HMOeB2+GpidgjdjxHnEhSRt5qiA7bULCxmdqeLZU3sHUC3xqINrd
	 mX3J3eZ4oE0o+3OjVrs3sIi5ez/McNM0Kx5x9kQK3E/9cHjsKK6AL5I48xfIw9NWjPDro
	 PTzYJ/97keZkGNO/0b+4i5jkoSFfY/iuojB/Ll9yXyqkCutS+wWcqmt7MB4IsZZ9g9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684172;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7HxB8fKOpvxpPKNbLSmjYh68CfUDm4kka/pn7arhWtk=;
	b=xgY8qqCHg0+I6FEHaPXmBo068bsDSeU8TMAsIK+CEl440jcNgkGCyrLSWPArLBAkC99f
	 zTmH3Y/8DYcnRoz1Mc9+uWYPvVRlAfmgVAksMru9KsfbzIN8u6My2LHRXULA/6s5yO4hH
	 doMVAOPQRU5aYL9usPgt9/OGY+3+7S/YeSGOKUYJCB/cpptWDEclFEI+dxqp1A75lyORK
	 cWmvw9/bUeZDmUA4UpY6+Nos4Ph7idkdZtlne+1NgGSLTxiYIERkSbUfr8E3V3SOCwI0g
	 nuquARhUWlYe+cXc0z3mVR/ztCJqPhU/ENrv/fln3s3D93E4y5A6TMwTlKxTbwExbAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c5H+6YWy;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961F606A320
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9961F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c5H+6YWy
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEuOk058436
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7HxB8f
	KOpvxpPKNbLSmjYh68CfUDm4kka/pn7arhWtk=; b=c5H+6YWy4PgvKeLcQkOpPI
	HvYQRMVJDVJS7YF53wfX13ODCsZ5ytmPLpZSB9YALjODEoSv1LcURp+z80s8L28r
	ySXbfvXFDK0IasFISjNHrBKeHYp94HeXgaTr1QY+wRTnoucnXu1KsOjQjL/B7GAq
	Sj/V/G8xplTLrkJ7u9n9MG+xNBtoNdhi9x0SMeycoMVwKGugzdqrrilvTgfasDKo
	5LdT4bMvmjWdi9gdwv+OAJI9NILRxG1spvmSYqUZSsWOyHwufaTOgEnt87fmgdib
	FKikZmYmedw75jqxWj3c5zNeqb/6aWqYwox4UAjjzTTe0w/MkL/tFm1/wwkqsO9Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5aymqy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJxxk619430
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x0tqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 15:49:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFnQ4p56361452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:49:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE65A2004D;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA21F2004B;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:49:25 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 22 Oct 2026 17:48:57 +0200
Subject: [PATCH v3 3/3] s390/diag: Add diag204 IOCTL to diag misc device
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-diag204ioctl-v3-3-c25e7147736e@linux.ibm.com>
References: <20261022-diag204ioctl-v3-0-c25e7147736e@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v3-0-c25e7147736e@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ada308a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=YdeBdsP-3Lnxc21BVuEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xB5GFW_UEo2YDmC1AXCEJ3tdB1mQ1D7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX1MnhQe4xUmxO
 2396OX5hVUmY8p0n1Dpt9oEb9iCuQoB9Up5b6GgPEuye8j72+CtTHMeO+XAOEh+Fx2YA8ygxZ05
 AzWMkNWKUl0tSfmeiHPCcGL3rVs50HtnM9cKXmHpQGW711YnX4VVcaYS49qLN7HV77nKH7Bb+rZ
 jQaYxItsAh0ROqkhkOqKSvDr22JLkpBrsr4KE7z8Ao5v/l3EOuQOoBjGVHHJPPFtqpiHcO2SV6P
 RiThrF3LS+OWCXr8K6eUjyv+uZGcerE/Chg2140FRJq8log5+Fd8ePHpH9i8PE61nyqcHYz/9Yn
 dgd/rokCaJYPF+vPAFXt/9YIdVteiwphuYJKYFaELWtpbjhOTTEIrCxUgNqsPFJTzAheNtpapiX
 nn6V80+7LVecgMXw76eCTWsu4xrAVlmgZS/27nDlqC2yhS3Pn6fhObYbmBzT3ZFnGfXERAuAxf8
 idFnbPGBOzZz0PXfAXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfXwlS2WOL1Al91
 p62Ze5RC4j4K2+qkSFbihhSc7ovZ4NTRjMpKb6PRD8DjlvetT3arAHmUU+LWOf2WlFcu8bDbsta
 69ASGIYygPYSFXglgwiHXkiI+3DE/j4=
X-Proofpoint-GUID: xB5GFW_UEo2YDmC1AXCEJ3tdB1mQ1D7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220062

Add IOCTL implementation necessary to fetch diag204 data from the new
diag misc device under /dev.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/uapi/asm/diag.h  |  9 +++++++
 arch/s390/kernel/diag/diag204.c    | 50 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/diag/diag_ioctl.h |  4 +++
 arch/s390/kernel/diag/diag_misc.c  |  9 +++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/s390/include/uapi/asm/diag.h b/arch/s390/include/uapi/asm/diag.h
index b7e6ccb4ff6e..e3d09a450a70 100644
--- a/arch/s390/include/uapi/asm/diag.h
+++ b/arch/s390/include/uapi/asm/diag.h
@@ -22,11 +22,20 @@ struct diag310_memtop {
 	__u64 nesting_lvl;
 };
 
+struct diag204_request {
+	__u64 address;
+	__u32 allow_busy;
+	__u32 allow_busy_wait;
+};
+
 /* Diag ioctl definitions */
 #define DIAG324_GET_PIBBUF	_IOWR(DIAG_MAGIC_STR, 0x77, struct diag324_pib)
 #define DIAG324_GET_PIBLEN	_IOR(DIAG_MAGIC_STR, 0x78, size_t)
 #define DIAG310_GET_STRIDE	_IOR(DIAG_MAGIC_STR, 0x79, size_t)
 #define DIAG310_GET_MEMTOPLEN	_IOWR(DIAG_MAGIC_STR, 0x7a, size_t)
 #define DIAG310_GET_MEMTOPBUF	_IOWR(DIAG_MAGIC_STR, 0x7b, struct diag310_memtop)
+#define DIAG204_GET_SUBCODE	_IOR(DIAG_MAGIC_STR, 0x7c, size_t)
+#define DIAG204_GET_LEN		_IOR(DIAG_MAGIC_STR, 0x7d, size_t)
+#define DIAG204_GET_BUF		_IOR(DIAG_MAGIC_STR, 0x7e, struct diag204_request)
 
 #endif /* __S390_UAPI_ASM_DIAG_H */
diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag204.c
index f447bfaf756b..237303aa44d6 100644
--- a/arch/s390/kernel/diag/diag204.c
+++ b/arch/s390/kernel/diag/diag204.c
@@ -14,6 +14,8 @@
 #include <linux/vmalloc.h>
 
 #include <asm/diag.h>
+#include <uapi/asm/diag.h>
+#include "diag_ioctl.h"
 
 struct diag204_info {
 	int pages;			/* number of pages for diag204 data */
@@ -222,6 +224,54 @@ int diag204_store(void *buf, int allow_busy, int allow_busy_wait)
 	return rc;
 }
 
+long diag204_subcode(unsigned long arg)
+{
+	if (!diag204_is_available())
+		return -EOPNOTSUPP;
+	if (put_user(diag204_get_subcode(), (size_t __user *)arg))
+		return -EFAULT;
+	return 0;
+}
+
+long diag204_len(unsigned long arg)
+{
+	if (!diag204_is_available())
+		return -EOPNOTSUPP;
+	if (put_user(diag204_get_buf_size(), (size_t __user *)arg))
+		return -EFAULT;
+	return 0;
+}
+
+long diag204_buf(unsigned long arg)
+{
+	struct diag204_request __user *udata;
+	int rc, allow_busy, allow_busy_wait;
+	u64 address;
+	void *buf;
+
+	if (!diag204_is_available())
+		return -EOPNOTSUPP;
+	udata = (struct diag204_request __user *)arg;
+	if (get_user(address, &udata->address))
+		return -EFAULT;
+	if (get_user(allow_busy, &udata->allow_busy))
+		return -EFAULT;
+	if (get_user(allow_busy_wait, &udata->allow_busy_wait))
+		return -EFAULT;
+	buf = diag204_allocate_buffer();
+	if (!buf)
+		return -ENOMEM;
+	rc = diag204_store(buf, allow_busy, allow_busy_wait);
+	if (rc < 0) {
+		diag204_free_buffer(buf);
+		return rc;
+	}
+	rc = copy_to_user((void __user *)address, buf,
+			  diag204_get_buf_size());
+	diag204_free_buffer(buf);
+	return rc ? -EFAULT : 0;
+}
+
 /*
  * diag204_probe() has to find out, which type of diagnose 204 implementation
  * we have on our machine. Currently there are three possible scanarios:
diff --git a/arch/s390/kernel/diag/diag_ioctl.h b/arch/s390/kernel/diag/diag_ioctl.h
index 7080be946785..68241c67451a 100644
--- a/arch/s390/kernel/diag/diag_ioctl.h
+++ b/arch/s390/kernel/diag/diag_ioctl.h
@@ -11,4 +11,8 @@ long diag310_memtop_stride(unsigned long arg);
 long diag310_memtop_len(unsigned long arg);
 long diag310_memtop_buf(unsigned long arg);
 
+long diag204_subcode(unsigned long arg);
+long diag204_len(unsigned long arg);
+long diag204_buf(unsigned long arg);
+
 #endif /* _DIAG_IOCTL_H */
diff --git a/arch/s390/kernel/diag/diag_misc.c b/arch/s390/kernel/diag/diag_misc.c
index efffe02ea02e..ea7ee9ed805a 100644
--- a/arch/s390/kernel/diag/diag_misc.c
+++ b/arch/s390/kernel/diag/diag_misc.c
@@ -35,6 +35,15 @@ static long diag_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case DIAG310_GET_MEMTOPBUF:
 		rc = diag310_memtop_buf(arg);
 		break;
+	case DIAG204_GET_SUBCODE:
+		rc = diag204_subcode(arg);
+		break;
+	case DIAG204_GET_LEN:
+		rc = diag204_len(arg);
+		break;
+	case DIAG204_GET_BUF:
+		rc = diag204_buf(arg);
+		break;
 	default:
 		rc = -ENOIOCTLCMD;
 		break;

-- 
2.56.0

