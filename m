Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C83F4DC3;
	Fri, 17 Jul 2026 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287654; cv=none; b=Aq7HTwurXOwFSruFl+i2Wq4l+AUL9r7zKIdyfHmT3BcPS8gSlFw5u7ZPuUXX1Bz917HTeq8YJn98sgn7ezZcf1UfH+SpsgA42/KzqwQJ5bRYjSpwXZXA428EXdSeFL8AjmXIYWZx9uGq50N46/ejLbMltTbof+NlfQ2WMrMO+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287654; c=relaxed/simple;
	bh=bVq33RplP7FCAPhRCPj9xUvLlTXgC/t6pi3c5e1oA4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXWQJRDk8PLtBpZeiWB78pj6yhabSoWhXJJYby6DRJ2dhscul79EDQ0tQa4kImooss6UbmVFJhyg1hKQXkg7LgbqdA1zFcRvE/4sWsou+OP3GU3/udgUNv+l71QlVjjBhct7cEiZfMHC9hzOZ7KLhCwYcPyPiuIMop46zYOyvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gCjaRstv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gCjaRstv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HAfftK4105036;
	Fri, 17 Jul 2026 11:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=J4OmLMYlS+MhthXhr9WGaOjnq6iC709Dbv9BgbURL
	lI=; b=gCjaRstvTtTaHEXJ+hVKo6Byxwl/ww1dXKhQQ8Pcb3WIyefPoAIzNSSfr
	rHKeGwdp8RPiTEvKrF2zxZd3SMItyGasGHdDXigZgAGxbKDkXvHQ+oqsBZx8j9Iy
	JENy1DLE/YQVbgobVJdZqvciHtFg3D/GtRom9VZBMBhPObw7C5JYT1htayqYFsns
	NiHqYACz65WUANek0Um0VGKDwl0q/ZB02yhjEDx/nVVm6J/CaZDM/BxHP/3Jr/8m
	KJzOT/4SIusxPq2o3HbmHd5k8hSiL6A5A0kd+ftx7sfKfYmAqdgtpqAVPDPOIZiK
	BBW34yuRXILXO/EVn5ar8CWQ3Ojug==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33ppa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 11:27:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HBJioC003762;
	Fri, 17 Jul 2026 11:27:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgs7n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 11:27:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HBRHkv1638940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 11:27:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3873658056;
	Fri, 17 Jul 2026 11:27:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F8C258061;
	Fri, 17 Jul 2026 11:27:15 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 11:27:15 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] KVM: s390: pv: ignore ultravisor donated storage for kmemleak
Date: Fri, 17 Jul 2026 13:27:11 +0200
Message-ID: <20260717112711.32089-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExMiBTYWx0ZWRfX5iXZOpzj3hGM
 S9wbcSw0ej1FRXuEQ8fAviR/iL3CDGy0tBg3IA7i1hUJkoD3BB5s1Ta97vb2VvDYz0O715P4gi3
 LLzkKJOak9uhpSzdxBM9CCjbkgHSjVY=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a1196 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=3_QFYANXyXRq7ZT6DTcA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 8NnLlNuR59y3yC6Oi9mk08WBrMw24wlZ
X-Proofpoint-ORIG-GUID: 8NnLlNuR59y3yC6Oi9mk08WBrMw24wlZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExMiBTYWx0ZWRfX2V4RONqt1DhU
 s4SgUzxbx42uJ5Q4szF9ugQ4no5Y2PqqXVG8x2udEZIsQQzb6yfJJU3WBjxBrGrdY338WA2cx3i
 3DKelBT22OCfPqJbeiM92I7pU2l5Pm3QtxylvBXeLa6oxF1HN+TUa6rRE7zhBklDI64/0orE0VK
 fySyKLQjeLp0bwbCLW5KYX9ZQGz4JDarVIL3oWEMULL9FYNAdZylYUGTquX4wFu0LeK5eJN2H5F
 ziA9uqpf8dRY5ni5GBnfZSQGuORKc+/fNf+2ZUzyZE3UprZ1BuD7kJxIAquwMdb2CJKPBfj7NsN
 rM/D72fADdK1U8g0IkF0xNvvxvj9z4W7hEvrCEgV6mfLKAw8q4MHHuLD9VgtnqKLaSscW63EhNA
 FuSShUf530PEr487xbw2VCv+n4M4d59v7OtdBWLLOELfywaMhbPOhH96pEp96StV3cXrOipLhDl
 YUvmIfuCFL960qiV1rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170112

ignore ultravisor donated memory for kmemleak to avoid kernel crashes
when accessing such memory.

Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 98a7f988fc69..e0286f434e25 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -16,6 +16,7 @@
 #include <linux/swap.h>
 #include <linux/pagewalk.h>
 #include <linux/backing-dev.h>
+#include <linux/kmemleak.h>
 #include <linux/vmalloc.h>
 #include <asm/facility.h>
 #include <asm/sections.h>
@@ -71,6 +72,7 @@ void __init setup_uv(void)
 			uv_info.uv_base_stor_len);
 		goto fail;
 	}
+	kmemleak_ignore_phys(__pa(uv_stor_base));
 
 	if (uv_init(__pa(uv_stor_base), uv_info.uv_base_stor_len)) {
 		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
-- 
2.53.0

