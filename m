Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A72FBDF0;
	Thu,  4 Dec 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866084; cv=none; b=bGqV9iyoKT6/FQ8FKZXrJlfAIytw+HoZalbi+BTFQyRPSilvh8FXq2rr2e3UG9DO/W4IVy3afzAq/GBNvBvXsixm59pYVN06eY3Hb6t9cAxn2hpCA/cSRREr8W6jsMfLyEoMsl+b60Xu9swdCAv2ZbjCH+WzIsVTTCaCVUFBNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866084; c=relaxed/simple;
	bh=3d2g9b1clJsGDPXN8/R/ZpHdHp5pzq9PRSACZTZfj3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU6/oETaeRF+2DX+a0OT5gzSldXJ2UVGHtcxte2dGvvVzmH4kWIUC9MOaMKsxwVJ9v7fSnu9nrR5OA8lo/7B+Rt9zU98vlOYlKDr5HQsfnxM2dcEENZT3MHeo34cUEDOpMqzFlAkf/uaWbYs6c9CpXTv8jyQmUUc3Ghhymr7ugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KwbXng+h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KwbXng+h"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4CEQvi008307;
	Thu, 4 Dec 2025 16:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qIY0cAGdz6OerCQGw
	i9knfHNyuXTV862qruMFa4nqKo=; b=KwbXng+htnl7U26fjZXbyD9CJ9nnRby0v
	OVPB3A1laVy2jpW37Tc3MrVnY9BbEW1zuB+gCZ+DoTgREQeeO6/A8z/io7stFxMK
	OfVxFADpDRieV/W17oxbla88MlB6H9FCKKy6NYPzzPHbFhTAHrvRWN7abLqGx6pi
	RcEy6MBUVoWXlzRa/Nb9WD+XE1OUlGm/xBQJG15SYGoECo3AoC0BQ7C3l4ioW65E
	t9HAMfZMtx04//3rUl5IgAdDHliJtWzEvOv5QuzAX25xUaH9+TNUiXhC7M5gsJ+7
	/e2nhBXkshDhPFols4i9HDu9U1hp50HmAJIaJPmSdoTyOMxi5R7gg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbghn70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:34:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4Fq2f4029328;
	Thu, 4 Dec 2025 16:34:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1rhc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:34:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4GYYdc50331916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 16:34:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1030E20040;
	Thu,  4 Dec 2025 16:34:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D53C92004B;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/3] scripts/gdb: add lx_cpu convenience function
Date: Thu,  4 Dec 2025 17:34:25 +0100
Message-ID: <20251204163425.370783-4-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204163425.370783-1-jremus@linux.ibm.com>
References: <20251204163425.370783-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hlWi6LeNBoAsvUztviaXrVgkJx0o9I8n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfXxI04e2rrQEZY
 4J86lINBBMZUkAv8aArVTBz3LLfHHQa7MVRPiIDGs/rqGGvXATEaCf21AWV8GH+0NlQPbJ84Wyw
 S5X54kZFU1Z0tXI3n2ccfIk045KbK872SgbveMMRqVU2qopSL+bRJSCc11Pyh6WX+hsBFrIDucd
 g27EMLGB64lOf6Ux4BKkXH91HolLaiaFeer5jpqRrayQ0E91GxqeJUQFdLyl3hpbYqJwAG7EPDM
 kyRFWCkhTZWiEFM/+MKJqPdPtif5rcwOOsaCm40Gta82WZu9K2euQ46/oitbbCcWSWs35HYCTVT
 gfzL2jTeaXxA3YhtDXC1CVgVFnUEFidBstMpcIWISd7ZT7NX5yMqdM+eDrQy+cMgqCdcPb2tfKG
 XSPhrWrQf28obuRcQu5UtYysIa3tGA==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=6931b81e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=iYM5X8Zm5P8KSLW-2RQA:9
X-Proofpoint-GUID: hlWi6LeNBoAsvUztviaXrVgkJx0o9I8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

lx_cpu is a convenience function to retrieve the current CPU number.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 scripts/gdb/linux/cpus.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 3e17550cd577..fa05fc30a090 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -119,6 +119,21 @@ def each_active_cpu():
         yield cpu
 
 
+class LxCpuFunc(gdb.Function):
+    """Return current CPU number.
+
+$lx_cpu(): Return the current CPU number."""
+
+    def __init__(self):
+        super(LxCpuFunc, self).__init__("lx_cpu")
+
+    def invoke(self):
+        return get_current_cpu()
+
+
+LxCpuFunc()
+
+
 class LxCpus(gdb.Command):
     """List CPU status arrays
 
-- 
2.51.0

