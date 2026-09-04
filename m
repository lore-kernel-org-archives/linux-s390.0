Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5441D11A;
	Fri,  4 Sep 2026 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502025; cv=none; b=SdiscUZaUBbcilmL+Xs1TIKFivzy2ycwrYXKW4td3uiDCOGoNuLEDjph6TIsTMgso+FrgniMKHwwLlNCYQS5IEwtDLbC37hGa6blKFW5pQBLy5Bk86RDDm3ayYYSN34g5EnSgtWv9Gbu7JX4oCjixmL7ddtAa5ojfheAiM1Az9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502025; c=relaxed/simple;
	bh=AL5eyWo6qlGXo4UQAp0l4pVucA6dKAHxzUJiRwmCq7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXtfN+7Jbf48+omiRXdBX8biGU8LRImtByXpC2W5X7VslgRDAYRBnn1HkBt5JDtg61nCCmuT/JzL2pGDdGqZyDen/Qp0WgBRig3KMovj2gMENVy+hWzoyBtqli2h7mPnFgjeUklq1i07KXhsjgl30kUDOFvYUkQWKooFHx3e/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lVc0Rgpx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lVc0Rgpx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464kKx984379;
	Fri, 4 Sep 2026 06:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cg3PPco2I3kJTCZqw
	P7b+vnAS3dnOXMsZlOdv46ACIU=; b=lVc0RgpxqpofTrKN/5/6x5lFTdHwgp6cT
	zGOkQbffSbvcp+DxRiayDlkxF6j0RRwOwr1ag/0k7atcWY85yLMo4mB0NNCCGnCl
	uCR6b0UlrQqXMBFe8kA/4IUiyHGFUsb3LogGDP4xVQzXuSAnyPsCTH2od+U+cz1C
	jUE8TWogPF4cHrUMv4O6GBXVXckU14vhErL6ts1O9ORXVAB45Jg/lNQt0AFCmJiB
	H6tsCigW44s61zp8BV6LfsOpnta200Vhz0I/wkrYj5vPNSgughJm5JyCFBb1FdD1
	R53dAZem2Q2FbxZ9o88IOZX8ZB8f1FdWgUJkif0vIw2/8ENfpbGkg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2trb9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:07:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uHaB005506;
	Fri, 4 Sep 2026 06:07:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyk9c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466sYk51511786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438FD20049;
	Fri,  4 Sep 2026 06:06:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D17A620040;
	Fri,  4 Sep 2026 06:06:53 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:53 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 11/11] s390/uv: Prevent potential out-of-bounds read
Date: Fri,  4 Sep 2026 08:06:47 +0200
Message-ID: <20260904060647.562443-12-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9a6004 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=25poj8ZeXyvPz4Svze8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXwmTFSTpnjyeM
 nfQBs3Jk985i8Kn2RSqp0mrxE9imCFSgSpGS2pMe1EQPi2YRUuzdEChN+QQG1R37xpWx/PKjTIS
 lyxUB68ccSht0nriDQu72dvqHLEBqfY=
X-Proofpoint-ORIG-GUID: ZBYX6x12s2NnomG2INp65adf8QBep63b
X-Proofpoint-GUID: ZBYX6x12s2NnomG2INp65adf8QBep63b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX8ZCOC2Sh8zEM
 I/CoO1xmeNzIiMrwUPgkKFSJdi1IKoh7VrUVv2pVKPQNb0t31f5Utb2lx0Nezq/6Ahj4dRpJhgF
 vu8pP6rBZ+5o5Prs1Cyt7FpA+U3JBp7Q8WH9sP/PoeJ15fXkw6iyHj0vvOua+nu12ltA4mElmcg
 q+aB6qJzwF4XkNU4qaSMArXnkKHtGwW0k8fXHnPXkMdSpyz3x2YFfHSFtRLSV1JxGJULTC0ZjHl
 4gJ05UrUyQTOhV+onJh4jI+vKL65+4wAMa4QBagKVdFEfBklrFWVAI04NRS5C6+Id6iJroye8QC
 PdjEWM9FuxzevkQd608+MiYPtW6YRcHT1Y9u8ty+WdbB76g15FB2/WYootzAoqkfIQyKTsVP/3+
 N/6tPqSKCFF2c3V1yDbLkvyq/VvFacLZT4l5PNfe1zsU/x11nXDR+CXfo5U+93pJfYGhcttr8LR
 idGzES/4IBYzHmYErjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054

From: Steffen Eiden <seiden@linux.ibm.com>

When the system has more than 85 secrets, the uv_secret_list struct
array only holds up to 85 items per page, resulting in an out of bounds
read in find_secret_in_page if the targeted secret is in the next page
or not stored at all.

Fix this by looping over the number of stored secrets which is the
per sub-list count of stored secrets and not the overall count.

Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260812-uv_secrets_fix-v3-2-a85bd29e0666@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 52003c463fad..8ea9dd7704ff 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -825,7 +825,7 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 {
 	u16 i;
 
-	for (i = 0; i < list->total_num_secrets; i++) {
+	for (i = 0; i < list->num_secr_stored; i++) {
 		if (memcmp(secret_id, list->secrets[i].id, UV_SECRET_ID_LEN) == 0) {
 			*secret = list->secrets[i].hdr;
 			return 0;
-- 
2.55.0

