Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFF18FDA3;
	Mon, 30 Sep 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702359; cv=none; b=Day1GpgGfcjDag+QRvaM1za+/leYLRAcIYkLJ7nbXuYPX3JJv+daYbF5qY7ENXIjbqvD5qGcO8j2TDw07mvIuC268+KWv9KWKdr0kqf0UETi5kBMaEYGh+tQFhj7Lh/gQtbVBo0LAg/zEZ1QiSUcWKzfrkic2ML3xkfvPOkVkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702359; c=relaxed/simple;
	bh=l5u9Ae6fpRtxlVLGHJo5C8D9qTMJrkkRkUp5yNSXD8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfUfFyqBRY8/8UamSofb1R2e1EBD3J6go0XTOIvdZKK6wfsvSBWDlc74YazwJb2HCzYle15HGX6pYBIOteXudq+N7oh/Ch/FmU4hk9rPcG4JsNqwXJjnCIIrT4oabDbqmJADeKJ9opXNTPmdK2haiaXVblp3kD30L6AlcxR2Q2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tU+2LhRr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tU+2LhRr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U8iAIJ005910;
	Mon, 30 Sep 2024 13:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=TOEfP3oBitGV4
	g2BcQpqynQT6m6MJccErdWVQRXkhCg=; b=tU+2LhRrYf2n4ZAAslGM0Dchv69Q1
	TjLEVUZTSNtbcn0Zk8noA0PxYYYrz+R9+ppa+2TvDUs49b+apjufX/50WHzYrH4R
	kfNam4vRAOK5h9bzvGKxK3fYOgks8+Z+lVQdKOnW5KUN3J8wEVWOn1Ztpxx9FS6w
	/Q5rrVj9IhWA4NKX6AOTw9jN2/uku86ikpvTmn0EGYSat4pK1aV6l1JAIO8fuGQY
	P8g+/4PrmTCTeecIPNxByjYwet86H3zgAWgFy/RCOjGrqvpieezQ0mG+q4+hEwWt
	GbTPM0Rg3fXVrybwa4nER2AKKUcSSldclOAJEBHTyuep50tdl/LnQE4Kw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt0b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC1atf013058;
	Mon, 30 Sep 2024 13:19:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj6epx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDJBXv54264256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:19:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E59720049;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 341742004B;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 4/6] s390/uvdevice: Increase indent in IOCTL definitions
Date: Mon, 30 Sep 2024 15:19:07 +0200
Message-ID: <20240930131909.2079965-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930131909.2079965-1-seiden@linux.ibm.com>
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hg6yBh4tCat9SRdibS8f98hGK5CXUD5t
X-Proofpoint-GUID: Hg6yBh4tCat9SRdibS8f98hGK5CXUD5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=848 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

Increase the indentations in the IOCTL defines so that we will not have
problems with upcoming, longer constant names.
While at it, fix a minor typo.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/uapi/asm/uvdevice.h | 30 +++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
index 70657e87d130..72c188f7819f 100644
--- a/arch/s390/include/uapi/asm/uvdevice.h
+++ b/arch/s390/include/uapi/asm/uvdevice.h
@@ -52,7 +52,7 @@ struct uvio_uvdev_info {
 	__u64 supp_uvio_cmds;
 	/*
 	 * If bit `n` is set, the Ultravisor(UV) supports the UV-call
-	 * corresponding to the IOCTL with nr `n` in the calling contextx (host
+	 * corresponding to the IOCTL with nr `n` in the calling context (host
 	 * or guest).  The value is only valid if the corresponding bit in
 	 * @supp_uvio_cmds is set as well.
 	 */
@@ -87,20 +87,20 @@ enum UVIO_IOCTL_NR {
 	UVIO_IOCTL_NUM_IOCTLS
 };
 
-#define UVIO_IOCTL(nr)		_IOWR(UVIO_TYPE_UVC, nr, struct uvio_ioctl_cb)
-#define UVIO_IOCTL_UVDEV_INFO	UVIO_IOCTL(UVIO_IOCTL_UVDEV_INFO_NR)
-#define UVIO_IOCTL_ATT		UVIO_IOCTL(UVIO_IOCTL_ATT_NR)
-#define UVIO_IOCTL_ADD_SECRET	UVIO_IOCTL(UVIO_IOCTL_ADD_SECRET_NR)
-#define UVIO_IOCTL_LIST_SECRETS	UVIO_IOCTL(UVIO_IOCTL_LIST_SECRETS_NR)
-#define UVIO_IOCTL_LOCK_SECRETS	UVIO_IOCTL(UVIO_IOCTL_LOCK_SECRETS_NR)
-#define UVIO_IOCTL_RETR_SECRET	UVIO_IOCTL(UVIO_IOCTL_RETR_SECRET_NR)
+#define UVIO_IOCTL(nr)			_IOWR(UVIO_TYPE_UVC, nr, struct uvio_ioctl_cb)
+#define UVIO_IOCTL_UVDEV_INFO		UVIO_IOCTL(UVIO_IOCTL_UVDEV_INFO_NR)
+#define UVIO_IOCTL_ATT			UVIO_IOCTL(UVIO_IOCTL_ATT_NR)
+#define UVIO_IOCTL_ADD_SECRET		UVIO_IOCTL(UVIO_IOCTL_ADD_SECRET_NR)
+#define UVIO_IOCTL_LIST_SECRETS		UVIO_IOCTL(UVIO_IOCTL_LIST_SECRETS_NR)
+#define UVIO_IOCTL_LOCK_SECRETS		UVIO_IOCTL(UVIO_IOCTL_LOCK_SECRETS_NR)
+#define UVIO_IOCTL_RETR_SECRET		UVIO_IOCTL(UVIO_IOCTL_RETR_SECRET_NR)
 
-#define UVIO_SUPP_CALL(nr)	(1ULL << (nr))
-#define UVIO_SUPP_UDEV_INFO	UVIO_SUPP_CALL(UVIO_IOCTL_UDEV_INFO_NR)
-#define UVIO_SUPP_ATT		UVIO_SUPP_CALL(UVIO_IOCTL_ATT_NR)
-#define UVIO_SUPP_ADD_SECRET	UVIO_SUPP_CALL(UVIO_IOCTL_ADD_SECRET_NR)
-#define UVIO_SUPP_LIST_SECRETS	UVIO_SUPP_CALL(UVIO_IOCTL_LIST_SECRETS_NR)
-#define UVIO_SUPP_LOCK_SECRETS	UVIO_SUPP_CALL(UVIO_IOCTL_LOCK_SECRETS_NR)
-#define UVIO_SUPP_RETR_SECRET	UVIO_SUPP_CALL(UVIO_IOCTL_RETR_SECRET_NR)
+#define UVIO_SUPP_CALL(nr)		(1ULL << (nr))
+#define UVIO_SUPP_UDEV_INFO		UVIO_SUPP_CALL(UVIO_IOCTL_UDEV_INFO_NR)
+#define UVIO_SUPP_ATT			UVIO_SUPP_CALL(UVIO_IOCTL_ATT_NR)
+#define UVIO_SUPP_ADD_SECRET		UVIO_SUPP_CALL(UVIO_IOCTL_ADD_SECRET_NR)
+#define UVIO_SUPP_LIST_SECRETS		UVIO_SUPP_CALL(UVIO_IOCTL_LIST_SECRETS_NR)
+#define UVIO_SUPP_LOCK_SECRETS		UVIO_SUPP_CALL(UVIO_IOCTL_LOCK_SECRETS_NR)
+#define UVIO_SUPP_RETR_SECRET		UVIO_SUPP_CALL(UVIO_IOCTL_RETR_SECRET_NR)
 
 #endif /* __S390_ASM_UVDEVICE_H */
-- 
2.43.0

