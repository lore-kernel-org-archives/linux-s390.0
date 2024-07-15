Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402C18732B;
	Mon, 15 Jul 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042692; cv=none; b=TGQ+CICfjCowwl+Q0ltDI9Uu0QBm3qzafMipXphgFRmr93cp6Nx5HBLhmrVYzdAt0uVLxJdoemQ20WEv+46WsKSMrNd4qIPN7GhBSbq+Nf4lzTRp59W7Cwj8dUh1WzS+5AbC7opW2nsjez1L0BqLusEg4DQQEAfXN3iL70cYQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042692; c=relaxed/simple;
	bh=UQqhqKd5HlElbDPXI5F32cZQ6XAP/HzwJgl38OXew14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PaYt3YOfh6OBnSaT357kgfKD65xI4fzVDd1OmK4tTHFKbFZHalp2vZPAMutkd/NUbvrNyVBhtOivOD8MW8ejk10G1I8qw4RwEfymno/LyyHXZfOBLjLfiRymiuSIccYQm5nnaqq0eAjJxcV5DTNBvb1YFg1/4NyCKJK5s1/bUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BAmsUY9C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BAmsUY9C"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FASLbp002458;
	Mon, 15 Jul 2024 11:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=9xjYYYpqcjJxM
	FaLA0tof+R2D9c1wo71viwpOzCNmd8=; b=BAmsUY9Cy0IqpzoYPWIRumJh/zniu
	JzH4PIGp/F+zXJvVZsTptTYtLUbDxh1xFSHPypQQobAggy6os/X52mxSwNvPTiPH
	FOylBzqW13NMGRmGgH2dN/AF7hW0adMzNa/ewhS3DDW+PHBiuLcsbrag3NSBhjFs
	wyZympqjaIsblOgeAEj7enikhTD3uDHQFLy4bAHper5N/LpfV3Iay2cblC/Zz/7Y
	/g/+bPJXOKShzWZ2/Et3XyVNpE+DzsYosaMS7vn7qre7peu/3YphjoXps7T7zIZM
	eduXxmri7h+BnvsME0YTEW/wouen3xMNdP+WuSGhMpxM5eNTEgK1hysyQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d21x83ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:24:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46F9eaDG022083;
	Mon, 15 Jul 2024 11:24:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c5dnpfp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:24:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46FBOZcf49152354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 11:24:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EA7020067;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C65620075;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id D3B44E0A5C; Mon, 15 Jul 2024 13:24:34 +0200 (CEST)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Carlos Lopez <clopez@suse.de>
Subject: [PATCH 1/2] s390/dasd: add missing MODULE_DESCRIPTION() macros
Date: Mon, 15 Jul 2024 13:24:33 +0200
Message-Id: <20240715112434.2111291-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240715112434.2111291-1-sth@linux.ibm.com>
References: <20240715112434.2111291-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NoSabbdFvCu4_D2F6ZyRYZXKJnyxF8_4
X-Proofpoint-ORIG-GUID: NoSabbdFvCu4_D2F6ZyRYZXKJnyxF8_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150090

From: Jeff Johnson <quic_jjohnson@quicinc.com>

With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_diag_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_eckd_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_fba_mod.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
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
index a76c6af9ea63..9388b5c383ca 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -44,6 +44,7 @@
 /* 64k are 128 x 512 byte sectors  */
 #define DASD_RAW_SECTORS_PER_TRACK 128
 
+MODULE_DESCRIPTION("S/390 DASD ECKD Disks device driver");
 MODULE_LICENSE("GPL");
 
 static struct dasd_discipline dasd_eckd_discipline;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 9f2023a077c2..a2216795591d 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -32,6 +32,7 @@
 #define DASD_FBA_CCW_LOCATE 0x43
 #define DASD_FBA_CCW_DEFINE_EXTENT 0x63
 
+MODULE_DESCRIPTION("S/390 DASD FBA Disks device driver");
 MODULE_LICENSE("GPL");
 
 static struct dasd_discipline dasd_fba_discipline;
-- 
2.40.1

