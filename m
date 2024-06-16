Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7B16A390;
	Sun, 16 Jun 2024 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718504349; cv=none; b=VXZl41Ukq+8c/CgtoUNmVh5CorC18YOwZfq4P6t6Y1mUqzgoYReJKRjKqHVVqaor9tkpURX2egFIuNi7ltiw1KLW5k2/RRR6YJYdAKYJX3lmgwx+jEcxBKP+CQaU1nHGqwDflFJdM4faA5STT8ZwuZi40iveSf3dDqR+oLYHbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718504349; c=relaxed/simple;
	bh=WdCqbRuw9QrBMMbPdkZSVCnZq+2Ido/fc4soz80tya4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=M2lLjGf/NzLWCCn9svmrjWr5da5PrwsxVciRZIrk8S67RpkTmnDy5hyUlcgm+oAjgwoVgs5BarLmlb/LUanrDqx7Ce4+5O36XMbN11jWLoTl/QfN6hxXxPMq/Ezs4zSCZrvXIrA/q9eQuqpcXL0YIcodl+2zqL7KOL9+D9Ti/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C35jbu7F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C35jbu7F"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G1tekg022866;
	Sun, 16 Jun 2024 02:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V/5Shy/1cvKlOwLzU1pHg8
	r46t2nwW1p0r4KzazLDQs=; b=C35jbu7F0N/3KrmHtqkm5FEBHk4Tb4qVvtRXcB
	AKgZA5m5+xG4/ipu6kWXQ7ghMYEP62itiN6JEqqQcO9xsKRTdwFT+ORmCbL5NgPs
	83Zl+0Jt6YRB9x5uXNrKCxTji877AYNSv9Thcs85rvlWCPoJSssPhasfhcSxqGZX
	t4prmfoXgPH+Ou0/QNaJVklo6LWECHXvLMXyNXAQ5nPQ0n8YA7rRsko8SiLmDOcs
	BJJ8oYs4QMxjPMxwR1vBorSyma8GE/VmaH88T7HKJs2LGAwzUHLXFAYH2pXOQx8k
	f88tZ6ljS8zUTWEqTdyQS6PBn/tNt61bEjEYVz06T81Con1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1wr1dvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 02:19:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45G2J4GF004706
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 02:19:04 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 19:19:03 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 19:19:02 -0700
Subject: [PATCH] s390/dasd: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-s390-drivers-s390-block-dasd-v1-1-36b200f14344@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJVLbmYC/yXNwQ6CMAyA4VchPdtkY0iCr2I8lK1KIwzTIiEhv
 LtTj9/l/3cwVmGDS7WD8iomcy7wpwriQPnBKKkYalc3rvVnnBJa6BwmlZXV/ujHOT4xkSXsyDc
 htpFcF6BUXsp32X6H6624J2PslXIcvt1R8nvDiWxhheP4AFo2sP+QAAAA
To: Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner
	<hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC: <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NiW6SyUhI8bZA7LAr1syksIDWf90XS5j
X-Proofpoint-ORIG-GUID: NiW6SyUhI8bZA7LAr1syksIDWf90XS5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_01,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406160016

With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_diag_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_eckd_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_fba_mod.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Corrections to these descriptions are welcomed. I'm not an expert in
this code so in most cases I've taken these descriptions directly from
code comments, Kconfig descriptions, or git logs.  History has shown
that in some cases these are originally wrong due to cut-n-paste
errors, and in other cases the drivers have evolved such that the
original information is no longer accurate.
---
 drivers/s390/block/dasd_diag.c | 1 +
 drivers/s390/block/dasd_eckd.c | 1 +
 drivers/s390/block/dasd_fba.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index ea4b1d01bb76..8245b742e4a2 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -29,6 +29,7 @@
 #include "dasd_int.h"
 #include "dasd_diag.h"
 
+MODULE_DESCRIPTION("S/390 Support for DIAG access to DASD Disks");
 MODULE_LICENSE("GPL");
 
 /* The maximum number of blocks per request (max_blocks) is dependent on the
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 2f16f543079b..f8113974cfba 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -44,6 +44,7 @@
 /* 64k are 128 x 512 byte sectors  */
 #define DASD_RAW_SECTORS_PER_TRACK 128
 
+MODULE_DESCRIPTION("S/390 DASD ECKD Disks device driver");
 MODULE_LICENSE("GPL");
 
 static struct dasd_discipline dasd_eckd_discipline;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 361e9bd75257..9ef7b168aba8 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -32,6 +32,7 @@
 #define DASD_FBA_CCW_LOCATE 0x43
 #define DASD_FBA_CCW_DEFINE_EXTENT 0x63
 
+MODULE_DESCRIPTION("S/390 DASD FBA Disks device driver");
 MODULE_LICENSE("GPL");
 
 static struct dasd_discipline dasd_fba_discipline;

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-s390-drivers-s390-block-dasd-9a143c6ca093

