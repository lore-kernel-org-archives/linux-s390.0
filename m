Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D4125BA;
	Sun, 16 Jun 2024 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718507980; cv=none; b=NBq7b9Ti17K5gHupfhlTssbWEy3HJ+kOwJUQPkVGTzbnPpmdbazyrxd3U7yZd1zHX4ol9VubVzDAL2c/nuSocpIwFMMdYnO9WDGbpa8YWsC7WqoKpx2oc/I+m9r5278AhJHiGexfT4PptZgzB16ORGSU5vsCTFgDzsilCNk2RPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718507980; c=relaxed/simple;
	bh=t6JCg73Ma4iasdLN6dUbkyfNUgxcXqmx3ME9scYzNwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lA4NGd5nc3Qr/1UhQ/yIVNFeAr6sRwI/CWQlG2EOLcZNMGkndgzMbiHYCmQezGpZvYuuj9teP4NQe5AS/KEXN+GRekUBlgPAL6Q6S4rxkhLxR+3tUtWZ/AFwDqaSVPsq8aO2r2Ydq8XyKJYAGQzzvN+Vm0Nj/qgygvk1g4WDudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K1eTLbqc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K1eTLbqc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G1WxU8007756;
	Sun, 16 Jun 2024 03:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2rIvePCrIM+n6KRtljr1wo
	eNLErP9bPWy4SwHhqQg1s=; b=K1eTLbqcICyt9tb6vDce6TQqO34sCaSgzZ3Rb0
	IOSscUQVIIjVXtEsVnvbdoAJ5LbM7+d5SP88PEVu8S8EU4bSk722wtzfp1XOjmjB
	/26Z1NeMXMZ61i0szTVnYb/EJJ9UHR6wUSRMUHPKbap89XZcxog+/fG7gDHq9Ll6
	yankqS6xhCEqk2EZOLb3FqiTFkk69qRbBQe90dh/bNNemrLt8CwjLkrP4VCiEQrP
	o2g9oWAGGNQm/eRtVsrVQUdQVgN9WLNQDNB1vOAwj2fwOcOcmcjSTNWGsWtEEIuO
	FokLLwLfe+S3NlAhNY/B6zqnvg3wnNFr8JVTP2IYlV2oPftw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys44js9ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 03:19:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45G3J6ku004317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 03:19:06 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 20:19:05 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 20:01:17 -0700
Subject: [PATCH] s390/3270: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-s390-drivers-s390-char-v1-1-d1cd23ff6476@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAH1VbmYC/yXMQQrCQAyF4auUrA1Mx1qpVxEXM01qA3aUpJZC6
 d2NuvzgvX8DYxU2uFQbKC9i8iyO+lBBP6ZyZxRyQwyxCW19wonQjl1AUllY7Q+fKnbNkOicI3F
 L4P+X8iDrr329uXMyxqyp9OO3+JDyXnFKNrPCvn8AaJ4X14oAAAA=
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
	<borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC: <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f7V7FtA_TPcD-ogkZ3KqjZcu8M2obbLo
X-Proofpoint-ORIG-GUID: f7V7FtA_TPcD-ogkZ3KqjZcu8M2obbLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_02,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=903 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406160024

With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/raw3270.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/con3270.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/fs3270.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/s390/char/con3270.c | 1 +
 drivers/s390/char/fs3270.c  | 1 +
 drivers/s390/char/raw3270.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index 251d2a1c3eef..053102d0fcd2 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -2185,6 +2185,7 @@ con3270_init(void)
 console_initcall(con3270_init);
 #endif
 
+MODULE_DESCRIPTION("IBM/3270 Driver - tty functions");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(IBM_TTY3270_MAJOR);
 
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 4d824f86bbbb..61515781c5dd 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -559,6 +559,7 @@ static void __exit fs3270_exit(void)
 	__unregister_chrdev(IBM_FS3270_MAJOR, 0, 1, "fs3270");
 }
 
+MODULE_DESCRIPTION("IBM/3270 Driver - fullscreen driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(IBM_FS3270_MAJOR);
 
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index c57694be9bd3..ba3d7114b34f 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1341,6 +1341,7 @@ static void raw3270_exit(void)
 	class_unregister(&class3270);
 }
 
+MODULE_DESCRIPTION("IBM/3270 Driver - core functions");
 MODULE_LICENSE("GPL");
 
 module_init(raw3270_init);

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-s390-drivers-s390-char-94fad7b2de6d

