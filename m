Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2DD298CC4;
	Thu, 11 Jun 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193297; cv=none; b=YjuKgCUKdJ0ULLfsqeeldQjxXDyYxUvQ4DgxX3GqJvNwUC7PFlLSwCeknyiJUlc7hNhg7TBIhwAPIJrq9xMWQpHMQxgv1FecBAMyHDL9nj2C84pxVF54eLFYRQd3VhhTTlSWFvu1h6e0hZCgSNT3izFrUx3+l5GtxezXKAdgckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193297; c=relaxed/simple;
	bh=vBEnx+H6jUEmFFmPbdcgV/l7e+PjPrXJFD0fIFb+REY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k//gdCgWCvBksX7O45JhaCtZLIftt+IGoHvhbn0X5L0gyppn6hHdYtQH/49T5c7IuyQ3/H3UcgpMqRPVf6KBeOqrff6tTpUpgjL+MJWpVLNV8QrVF75eZhHKIISr3EjzWUWSGoa8RoARAuqUaQxNiIreYBSbzh0zPSNx1wpqPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NysiuMOy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NysiuMOy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCLulG722324;
	Thu, 11 Jun 2026 15:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k1vZep
	jOWYsKars/cGVN3OI5NYuPE6kQk0qeVy4rEJw=; b=NysiuMOyIejJ6PRGIrNzVt
	+JOo3DmMXT5FHLWtsK3rMyHOe6x+MJf+tI3YxB/kYe1JuaTdSUcQckGoAcArLi1m
	2mITdOUcMeGB+cwhf8utojLcu7W5S1DiemQe0ZUGIhoqBonakKvN0DZym+0OimmO
	teDGs2MmTeC6wmy25k7i4fICbRIRTRLoGnFwXl7HypgQlZhjM/xnFlqs21ma6DuA
	rH0RXm60yI26aQVadQnZA5hs9tpMlUL0WcRGYy1yXU/xUBnr1o4J5pwKJrF2l02q
	wcxbg/herwZ8dVXl09cr/FUi53uzkUXgnVIHrT3ec5nyw9el4UMw9Ek7pmBwb+Aw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dcps0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BFnjVY018337;
	Thu, 11 Jun 2026 15:54:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09uv8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BFspi149676610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:54:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A3F920043;
	Thu, 11 Jun 2026 15:54:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1735120040;
	Thu, 11 Jun 2026 15:54:51 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.87.150.222])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:54:51 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 11 Jun 2026 17:54:32 +0200
Subject: [PATCH v3 2/4] s390/sclp: Detect ASTFLEIE 2 facility
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-vsie-alter-stfle-fac-v3-2-b1a35efedaba@linux.ibm.com>
References: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
In-Reply-To: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=V36ZurebmPSrSYHqK2pXHIHsgImvYO0q+UdV1uYpKlQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlatzzT0vSv2c+ZsnFNv3yZEmtztpzwxZZw10+fTpp6/
 DuoepCto5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgInkBjD8Fa1S3x1cOj1S7ADb
 5ye8Vy/2LImN7ozbMnmm+qO7Rj9Pb2NkmKZsWMU3y3/yu8cCT+Y4LQpIYvxqpevN2+ka66iyZ7M
 zFwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfXx7mpYwRysHHB
 ematrUS95bwzupJ9MiX6ktqJMpqbXXSqwva2D4my0nqxpcNMwp9G2s6+JAKXWtclof8VB1o4Wxt
 GNas2AiwROIvIX5esOjpoig/ZJG1D2A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfXy8zR63WFkyYq
 Rghv34cjhUlZwBMjRdrJ8hzAHFDP7KtNnhiW+f//wU5s2wYvcimxW3k3xAiRoUMQG2sQRHsBwSx
 3YQINHYFa5MCSR2IyTX1rhEgV3nkXOJDaU98VCQlegfj/DAErQtQLw0dzthXb8yCEn9oTCxMTKF
 qeJQLmYxnr+IIKgPCoXo8bsWuLXlQfBJf1sd3J5IM83Gl6zwvC67/DmDTRbqDArdHuPOesSZ5X3
 00WC7cdNgxYn/GxN6DX2eDrL5kg8KtGul7bsP0OIVMNarZWKpEwP9Ta57M+976hGTrNn1TiZOt6
 VcUEz0fP12dD400Ep6q7Wfzat8qs5GWeUnU8kVlv7FJt5/u4+wFhfq5qs37yPAImPZLUP5vkX9v
 FdSOKQ77ZecvtYfu3szg8pt6xO6UbzmABippgW8eI+Q+MceezMvj150AvYBPaSxMHQB9r/7kg/O
 QCoBjxU+/bsmdwhGB9w==
X-Proofpoint-ORIG-GUID: uoTws-zIEp8IkHiZsP_MAo9Vzt4KuZIr
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2ada50 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=txTkv-xiYvDc7-xnE9QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uoTws-zIEp8IkHiZsP_MAo9Vzt4KuZIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110157

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Detect alternate STFLE interpretive execution facility 2.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 0f184dbdbe5e..0f21501d3e86 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -104,6 +104,7 @@ struct sclp_info {
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
+	unsigned char has_astfleie2 : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 6bf501ad8ff0..22dd797e6229 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -61,8 +61,10 @@ static void __init sclp_early_facilities_detect(void)
 		sclp.has_sipl = !!(sccb->cbl & 0x4000);
 		sclp.has_sipl_eckd = !!(sccb->cbl & 0x2000);
 	}
-	if (sccb->cpuoff > 139)
+	if (sccb->cpuoff > 139) {
 		sclp.has_diag324 = !!(sccb->byte_139 & 0x80);
+		sclp.has_astfleie2 = !!(sccb->byte_139 & 0x40);
+	}
 	sclp.rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
 	sclp.rzm = sccb->rnsize ? sccb->rnsize : sccb->rnsize2;
 	sclp.rzm <<= 20;

-- 
2.54.0

