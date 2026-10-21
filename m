Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578504;
	b=PeuDyjVRsLswzmo3x7SiL2O5QRuMybrvEPozGlqXllKgjAmNha3V3/svkXYfCLTbZstJ
	 OCxI4wIwTKmkZCL5PDFAflV8F3hnwMmmWlS0ko/OAk4AIf+CWRLb0/znVYiudvI5GKpQH
	 WPVX8o54W5R2ZINDjbg8QAa2HEbxNQ2gOzQbGnysVSsah94eeuih5NJTVS16/Ha5+0qsn
	 DsiJRH+Thl7d7ZB6uSjAFnaAzGhcQXXRhULY4JNOd17bzPm5RWX8PTFxQSutBH7OS1yhm
	 tpLhjXBqkdXMv+bT4AHMhfDRiy0VM8iaelOpFoL/dDo3BdBRS5EGKHhpLKEmgM+2IsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578504;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=whH4Ho9RDgdEAt3m/yH3J7rGC7S072+HiRhQICWQBTI=;
	b=ihdhg63DAl98BZNCSy1kdCvE0cACJdGVwGQRmwveoSz2rI9A5b6plGAGkbV92RdP8ARA
	 20hfCupBbyeDgtQnx2K+gilDvKfSNWJg/MAOPFcD3Q+YQ0JIwH+HZLkl5sLKV5421v9Da
	 2M3IKUhyfEAr6su5o8cBoRoYctxUOQ5PEPxGcVgzwgY1YXWk50S2baV0OSjRZFJ2DsaZf
	 HOMEUbgbIs4uVzl0WRKy2+qobSH2szdRaw28RsPQDrvF48mLNojHY7fPf+gVn8l4g4c59
	 PfoEPv5Fl9hYJDd9YOX+ViejfWAFkfMmNCa986NQw1/aFuuJTWOHZF/wqJLUkTMZ9AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gZg2vdg5;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CC606A31A
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gZg2vdg5
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LAEA8g897608
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=whH4Ho
	9RDgdEAt3m/yH3J7rGC7S072+HiRhQICWQBTI=; b=gZg2vdg5XEsTRiEp/UMn8B
	tNd2+wN/gP1wPlq98pNDLpw1tAB1c9TqhIYcdqmusNMwtrNxrYp3eJ7AUiUKLVGE
	gPD0tg2LsbWBzvywEC6wr91uamhzMmy+lCPLfpiR6eRjKLQUpwj0BS4HgF1oMTmX
	rc4VJFvra57wGF+wR5biCZMskFiMAJQ3ReaOKqD0myK5q/EeQvRygWE22mDhp+d5
	2DCLb7Xg7AJmaueMqyWicm0U6pNIJaFswVquZsI0PY7l1EYvc77Nwjt6+F7IFfCL
	R/9U8GZrkFbCc2rGfDOUVVkKlH6w8S6bkD7gZXYVMca3SgHs9wFyivtyJ5wgffSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a8bpb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA50PW2967790
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he8vhvb2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:28:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LASI5848431406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 10:28:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAAE12004B;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB402004E;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 10:28:18 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Wed, 21 Oct 2026 12:28:10 +0200
Subject: [PATCH 3/3] s390/diag: Add diag204 IOCTL to diag misc device
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
Message-Id: <20261021-diag204ioctl-v1-3-25645b97bf4e@linux.ibm.com>
References: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
In-Reply-To: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX3a8VxcTXoJRA
 FgKQsOMWj48oRZ4FbcLhKJRAVHQtRdOrylHoL9WtAelYpGGS4owGOttlcEjB9iJRhZdM69om8M5
 g9x37yZaVNwBrbNu3LdrSRzbVXEc4gs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX7flNa6wqLfUE
 WWfiyoSVY84JfxQe+efkP++j2S67aBYrMlLlTOI4bK6ZSQXwFkq/JLXaUNoTKN8OJvsqKJpUQpb
 VhkFv9KEvOLk/WnHjr7kbKxPZjNWyHaac7ieDIM5fEqTCm5/IDjspSQLDWEwle4GYDKpKAn7frX
 4+9Lrm2m8n5zknyyCHzRuBOo3XKoZCVnJM7E+Z/D1NoNr2nxFFbk7p79lYtNokvslLez+RJGbt/
 YOmUnfa/42abHpQ7up6e8Pu+K1e6QuVJGjPpTSF/7+HHkUGWtgHEFudgmCPrup+tGm/fL/Ya58u
 WX7sMN2+vmfunZRyWMB4Oq/xJjcpVknyo5qxwfDhc31TqlTkZRNKCgAjuYwYsB4UpN8/YUeOa4k
 oGe4h6q06PGnH4hxLmWdTPyPhLj9EuvNIGMECQoK9QVcu06ReOFPmi48oVwXFUeTWmaXtDv6YpL
 l9PQgdQesLA1nnAko9Q==
X-Proofpoint-GUID: Tv1E7h5lx3H4GOS1y7XnoHMPpJlE5DcL
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad893c7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=YdeBdsP-3Lnxc21BVuEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Tv1E7h5lx3H4GOS1y7XnoHMPpJlE5DcL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210040

Add IOCTL implementation necessary to fetch diag204 data from the new
diag misc device under /dev.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/uapi/asm/diag.h  |  8 +++++++
 arch/s390/kernel/diag/diag204.c    | 43 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/diag/diag_ioctl.h |  3 +++
 arch/s390/kernel/diag/diag_misc.c  | 10 +++++++++
 4 files changed, 64 insertions(+)

diff --git a/arch/s390/include/uapi/asm/diag.h b/arch/s390/include/uapi/asm/diag.h
index b7e6ccb4ff6e..985667b2917a 100644
--- a/arch/s390/include/uapi/asm/diag.h
+++ b/arch/s390/include/uapi/asm/diag.h
@@ -22,11 +22,19 @@ struct diag310_memtop {
 	__u64 nesting_lvl;
 };
 
+struct diag204_request {
+	__u64 address;
+	int allow_busy;
+	int allow_busy_wait;
+};
+
 /* Diag ioctl definitions */
 #define DIAG324_GET_PIBBUF	_IOWR(DIAG_MAGIC_STR, 0x77, struct diag324_pib)
 #define DIAG324_GET_PIBLEN	_IOR(DIAG_MAGIC_STR, 0x78, size_t)
 #define DIAG310_GET_STRIDE	_IOR(DIAG_MAGIC_STR, 0x79, size_t)
 #define DIAG310_GET_MEMTOPLEN	_IOWR(DIAG_MAGIC_STR, 0x7a, size_t)
 #define DIAG310_GET_MEMTOPBUF	_IOWR(DIAG_MAGIC_STR, 0x7b, struct diag310_memtop)
+#define DIAG204_GET_LEN		_IOR(DIAG_MAGIC_STR, 0x7c, size_t)
+#define DIAG204_GET_BUF		_IOWR(DIAG_MAGIC_STR, 0x7d, struct diag204_request)
 
 #endif /* __S390_UAPI_ASM_DIAG_H */
diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag204.c
index 8e1909e6caf9..967b6e0bc667 100644
--- a/arch/s390/kernel/diag/diag204.c
+++ b/arch/s390/kernel/diag/diag204.c
@@ -14,6 +14,8 @@
 #include <linux/vmalloc.h>
 
 #include <asm/diag.h>
+#include <uapi/asm/diag.h>
+#include "diag_ioctl.h"
 
 struct diag204_info {
 	int pages;			/* number of pages for diag204 data */
@@ -268,6 +270,47 @@ int diag204_store(void *buf, int allow_busy, int allow_busy_wait)
 	return rc;
 }
 
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
+	if (rc < 0)
+		rc = -EFAULT;
+	diag204_free_buffer(buf);
+	return rc;
+}
+
 /*
  * diag204_probe() has to find out, which type of diagnose 204 implementation
  * we have on our machine. Currently there are three possible scanarios:
diff --git a/arch/s390/kernel/diag/diag_ioctl.h b/arch/s390/kernel/diag/diag_ioctl.h
index 7080be946785..7718b57ffe3e 100644
--- a/arch/s390/kernel/diag/diag_ioctl.h
+++ b/arch/s390/kernel/diag/diag_ioctl.h
@@ -4,6 +4,9 @@
 
 #include <linux/types.h>
 
+long diag204_len(unsigned long arg);
+long diag204_buf(unsigned long arg);
+
 long diag324_pibbuf(unsigned long arg);
 long diag324_piblen(unsigned long arg);
 
diff --git a/arch/s390/kernel/diag/diag_misc.c b/arch/s390/kernel/diag/diag_misc.c
index efffe02ea02e..ac263baf8d08 100644
--- a/arch/s390/kernel/diag/diag_misc.c
+++ b/arch/s390/kernel/diag/diag_misc.c
@@ -35,6 +35,16 @@ static long diag_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case DIAG310_GET_MEMTOPBUF:
 		rc = diag310_memtop_buf(arg);
 		break;
+	case DIAG204_GET_LEN:
+		rc = -EPERM;
+		if (capable(CAP_SYS_ADMIN))
+			rc = diag204_len(arg);
+		break;
+	case DIAG204_GET_BUF:
+		rc = -EPERM;
+		if (capable(CAP_SYS_ADMIN))
+			rc = diag204_buf(arg);
+		break;
 	default:
 		rc = -ENOIOCTLCMD;
 		break;

-- 
2.56.0

