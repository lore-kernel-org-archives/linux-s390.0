Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15281E6DDE;
	Fri, 18 Oct 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242924; cv=none; b=B1cBN0akRKCD7luYGR3LIv1jhmmdxme+crgUIL1IIMwh1j1vM3oHO0hnx71SzcXEg75/w2bTPe4guUuc9bBo1pvV74YYEOztZkbOtXo7ujdUl+4ppCx++Zjf5XjgfAyxc3ytzav941BZOvc+U0LZRqOxRAtWaaYqpMX2Foaj844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242924; c=relaxed/simple;
	bh=rJYwvQYBiSxFwPdqoxzExDV58GG+tnThnCjc+M2GuE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3ZZXb5iGa3RNqRFeiVnyr0A3Wwjtis7U12dhaEyvoFMsA1vuJYIOmWuV719nJVOFG+K8l8DvQSFM+GLL1WJAueSzTy5nVKn9NYVhK4vEzVlxkVQHe+poOHFB++FzqQP+IGQbgGR8jJCz9sc+2jmQTQvtBxrCzpV+b6iOqv5qUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kLJ4GYLC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kLJ4GYLC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJS9ms013923;
	Fri, 18 Oct 2024 09:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FaPJQ3yGMCmB2/AaG
	NKAyEdAEMsaUgUtuU3RAg7gRvo=; b=kLJ4GYLCJXe9ZKrrwKqn8pMPMgHN8uFLx
	B453ZH7yWF6Tclt+W4Z4ozQSazYyarUFGSq0IJMHms103TM6JgrQONvXm1amCXFD
	khfvqhClFxX7Dm3oUBV/FP8a2WloQS7uOFyCbWh+mMoZPJvPljBmMlZpF7N39X+Y
	6Ju3Rn/FeMb2wcuZXGlKUOo7u8trXfig6xAB/2wo3WuHJsIT6FxokgXWswpVsIBk
	GsJ0nMAictNuSunAjOZsBednlwSj2UviLaU+3OgPqKiblzuSPFt5M3DYSmEzYOUw
	kyf8CrnbJnHahi44ZWSakG31Wtu7YnEFiuoO06W6nml05am2WJKBA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqk2rdmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I7DWHo006694;
	Fri, 18 Oct 2024 09:15:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283esbr6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49I9FHa039780614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:15:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68FF22004F;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AFE32004E;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v4 4/6] s390/uvdevice: Increase indent in IOCTL definitions
Date: Fri, 18 Oct 2024 11:15:14 +0200
Message-ID: <20241018091516.2167885-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018091516.2167885-1-seiden@linux.ibm.com>
References: <20241018091516.2167885-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r0Mp9zehldR-k5h_Rfo53iEsp3Tux5vP
X-Proofpoint-ORIG-GUID: r0Mp9zehldR-k5h_Rfo53iEsp3Tux5vP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=865
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180056

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
index 2ee5bfc61800..4947f26ad9fb 100644
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
2.45.2

