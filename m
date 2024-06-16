Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F92B9AE;
	Sun, 16 Jun 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718505303; cv=none; b=rY8HoUIWdX/8s3PqHgEEyEgUt5Rn1Ua4JsP/mKluiWxSPkEsPfCITqQ/nvlTycpssxoevIhACX8+WrxqmxowsnBm89li4z3MEQIQpZ9FisUn3KjqFxlxpplwsOITXAsu+rpzI9r1qDfv0dVOXAGb8Oy/zvr9wBCRmTOH1RM3Na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718505303; c=relaxed/simple;
	bh=okBhKRtYZu/XsozCdr595DkZUlyBPurnfjB5fSWy0FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=mJ+XNIf/9cxgcO0CQTzDoSetP45denMmtYMOgbQ4GY00cr4+p8W7h2iwkx8+UIastWDaIdj3q2KTaTsmRdRa60hK2Yx3HSpVRBRRui91b8BkVPSyWIQDHwhJ8Dh0OiC5P8zUSOsUgk/LquE/6APTWhanf6QhaWl99vdiqUYspKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ThRojZyX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ThRojZyX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G2ENwx004550;
	Sun, 16 Jun 2024 02:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DDNNiasvgAEzG48txbi+of
	KnXYEK4uF1YjBksZI5ZJE=; b=ThRojZyXBtnY48tHhSnfmR2mT4O1BiFmZfdQw/
	WCQkLw75otKgu4pWyezB6tonn3ZSW5LzatvFmSsWLq5K0ysQYtk1+v6Qwn2OH3Lg
	kwf3c24DWPRJ09CdHkrcaNqqP3aWowFnF4DgjEawnoFgkmoGwbm7QD4kdMEfqFPA
	RYWRSvwxN9FjKNp4ry8ldUiPMirln5rfPXpiyELiII/ZavOW8OSFS7hCBIxbIyBe
	yN/mR10PwB3qg0HJ/sIzfQKecSDhXzMhb/IBzyop2PxaqwYC+iLmSVdWQh5PgvsE
	wXYH1LUL7Y5NiTs6qkykuOO9yG56/DDeo839JuMUWEiLcvOA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys44js86j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 02:34:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45G2YwAc001631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 02:34:59 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 19:34:58 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 19:34:50 -0700
Subject: [PATCH] s390/dcssblk: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-s390-drivers-s390-block-dcssblk-v1-1-d9d19703abcb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAElPbmYC/yXNTQ6CQAxA4auQrm0ygwwRr2JYzE+VBhhMq4SEc
 HdHXX6b93ZQEiaFa7WD0MrKSy6wpwri4PODkFMx1KZuTGsdzgn13BlMwiuJ/hGmJY6YomqYRrx
 01rlkok9NCyX0FLrz9pvc+uLglTCIz3H4pifO7w1nry8SOI4PI4giiZMAAAA=
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
X-Proofpoint-GUID: 2B_T49uF1NhQsEZrkVSzx9PTB3Y-Ta5p
X-Proofpoint-ORIG-GUID: 2B_T49uF1NhQsEZrkVSzx9PTB3Y-Ta5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_02,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406160018

With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dcssblk.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/s390/block/dcssblk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 6d1689a2717e..995d4c84ed5a 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -1032,4 +1032,5 @@ MODULE_PARM_DESC(segments, "Name of DCSS segment(s) to be loaded, "
 		 "the contiguous segments - \n"
 		 "e.g. segments=\"mydcss1,mydcss2:mydcss3,mydcss4(local)\"");
 
+MODULE_DESCRIPTION("S/390 block driver for DCSS memory");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-s390-drivers-s390-block-dcssblk-89155d0cad46

