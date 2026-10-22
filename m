Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669800;
	b=PFzzNbD8H6qG/gMg9UeO74WfhMzQijm5VBk19b/uowcVKnbV9pC9v7ZMab9Iyw3ro14c
	 XVqarWTAjEhNepc5KbSolInr2SflFieboQ2YDWXmR+dSKqH5VUMCD64laOSsfvkr/1WYk
	 rj8yUPTlYXzL8f4SdZvPzTapvhnfFyIneI/iW1rBXJJHabZj4Pb6RhQeIuHqXiFhyVg7Q
	 RRRtik0O0wpTqJtLOK2R6gRlkWwFzavy/DW+Gb6DAhIbCSxEkSIB+fLp0TlA7BTkphL7H
	 2SgvcNp9zZQ1Mz8gMypwC9F2ZKhR+cUjh7Em+GOUeojYCRDjWEojMn2b8j4b+CUlZeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669800;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=09/9ponEPWu2kForAbfayCKzH0rBRd7xBlyrgQaTrUE=;
	b=SvfhF+n6qUrH098u7J8i5/OChhHQYrRdP3l9XTgOHypeC2ksJZ7qbFT91G/AaFJguZGK
	 roj6rRp9kVkaq+ALA/pxTyTAJppK23A4RoiPnYrVGnTqRgF1rdIuA7hooYkSSPtluQylB
	 a8WMUHuu5zwC0N9Fpbh+er9GTIUddt3s9SXfG+vjsfG0OkXbe+nrrRiaCs4P0tFJq0Gqw
	 uDW3GHaTOy94UeAcuBDVmrMxIuppOS4oCXL7bywo+3xHoSyWrFSilTvBVmWzPT5LPcRWW
	 s//AS0Wk6DMvx373ZCBN4kb4strRviIuoOEt253OrRj1+G/uQxpDlvhRBMAA/oFtQ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dtbhbn5W;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64745606A319
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64745606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dtbhbn5W
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MAEPH63926601
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=09/9po
	nEPWu2kForAbfayCKzH0rBRd7xBlyrgQaTrUE=; b=dtbhbn5WTIhRZ8pZJ30OIs
	qNHpr769SLAZcOsB1W2jJnLJca9XL6awMy+5iKinXGYEAAIPN+NTgDQ2Da4Hn53R
	FiKa2pKfVxmCxbvkR1smNiXwG4JTlXVrFdJKTH1WXkseed1kQd5IlrewV/FbUw71
	9BZAIimRAvT/P+U7euIhHhNRXfffxB0uxRKxJD4pAermM+pG+EX32I8XsiETxtBo
	J5KILjJX44mIMlXnLzId9U+TqQnCeyjQ+kVdnmYRgJ19MZyZhAYTxR9Xi4OXqZZ3
	dcMF2EfXTf7hDwL/YjjOzE3c/RRoeZCBjCvXofYtSmGz+G39QBnX5DlIyZc1Gn3A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58xst9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA4riO376903
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he8vj1ed3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MBntiM27066688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 11:49:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FD272004B;
	Thu, 22 Oct 2026 11:49:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBACF20049;
	Thu, 22 Oct 2026 11:49:54 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 11:49:54 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 22 Oct 2026 13:49:47 +0200
Subject: [PATCH v2 3/3] s390/diag: Add diag204 IOCTL to diag misc device
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
Message-Id: <20261022-diag204ioctl-v2-3-7e5a9d1cd21a@linux.ibm.com>
References: <20261022-diag204ioctl-v2-0-7e5a9d1cd21a@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v2-0-7e5a9d1cd21a@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RW_UUsFgiWH599IEkXrjynq-GUvN5tQB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NiBTYWx0ZWRfXzT8WIBkbACHG
 VUnupJbCBK5svUIYL1xdDVIdQuxnhcMuKPOsiujWVnualUFyHSYesgdFo+mf11cgiec31NPmJd5
 6p/kwWvUUf0nVb9UfxfXZANiASq2O70=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NiBTYWx0ZWRfX03dyHLtOG0wF
 44eGgCyvesS6I53ng+ABL7hBWih5y8pO4nyMRP2KhdW+uSmU5y2SS4MivswPM0W+GlqjDuAmROo
 L6w7dAEO6jcH/JaJpx1J106caJNeiUABF0MabQQz8TxUAm4wjW6Z+D6tqzyPaWgve6O1MKu5vQr
 VUpiqbaQ9esSgA5cZ/9cYzetWUrsm1Q6my+rCtaqoQZUNyphUY7Thrhoep3bNOeXeMgS2Q+6zks
 E5y7UGuqqPzL4qbrOnpStx7LG0GOKw8DEdnfOsDyL8kV0mxGnzDqxTNiqxa9x7hTj6V1VrNRC5N
 QBhPoN34EPHPp5Okq2NjFuhEhbmOAog7ht9SfcQSkt9yIgtTKkXapIIxmvcYI7zZjp/byXvMEqv
 49aKTY9Y759MMG59XnEJ8l3UQjo/X6nW1srHfMDbd1QwFTXgSMhJ1MHwWtzI1Q8B1vedQFwnxFW
 m4w5T4uQD6C0+PL5odw==
X-Proofpoint-ORIG-GUID: RW_UUsFgiWH599IEkXrjynq-GUvN5tQB
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad9f867 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=tzlaJ-29ccyXqqbTioAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220046

Add IOCTL implementation necessary to fetch diag204 data from the new
diag misc device under /dev.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/uapi/asm/diag.h  |  8 ++++++++
 arch/s390/kernel/diag/diag204.c    | 41 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/diag/diag_ioctl.h |  3 +++
 arch/s390/kernel/diag/diag_misc.c  |  6 ++++++
 4 files changed, 58 insertions(+)

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
index 7f366ea12a67..3450a013258f 100644
--- a/arch/s390/kernel/diag/diag204.c
+++ b/arch/s390/kernel/diag/diag204.c
@@ -14,6 +14,8 @@
 #include <linux/vmalloc.h>
 
 #include <asm/diag.h>
+#include <uapi/asm/diag.h>
+#include "diag_ioctl.h"
 
 struct diag204_info {
 	int pages;			/* number of pages for diag204 data */
@@ -220,6 +222,45 @@ int diag204_store(void *buf, int allow_busy, int allow_busy_wait)
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
+	diag204_free_buffer(buf);
+	return rc ? -EFAULT : 0;
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
index efffe02ea02e..68742f49a3e6 100644
--- a/arch/s390/kernel/diag/diag_misc.c
+++ b/arch/s390/kernel/diag/diag_misc.c
@@ -35,6 +35,12 @@ static long diag_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case DIAG310_GET_MEMTOPBUF:
 		rc = diag310_memtop_buf(arg);
 		break;
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

