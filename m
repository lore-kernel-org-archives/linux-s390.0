Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E82D77F7;
	Fri, 18 Sep 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721342; cv=none; b=RY6NjGUtpQaSgOncJyd2Wagm3mdOLUTdPwrpe1ZXpyFqLiLQUFjBxoN+gSgIhzTimwlAm056iStrICIZIQWSxBLV/hcVUbOi69TgAKdH3rq7+2qc3BBZDhkWILJqjaLi1baDKkapkpqBgt/404jCSz9MIzwypm0YCQ0Or0izh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721342; c=relaxed/simple;
	bh=Su7sJp4PolGeOOs8L1MNG5ZVxwB1v+NWwbtvFp2GpUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4uu3sBy2OnxwpXf/SBqfvCfAUNGAb4IiqR7PXWb5/FTP2tnLuprqmDFPYz5VLMRY6v/L8KEhx4iSuowC71JesgUxr/zFrF59L+wX8WFBUr29IECjhbRhfa48S4JZ1mj31oaoM6BkPyXsbx8ITXn4uh5UTAY1olURz5jl7XhsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQAQpoZn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQAQpoZn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61t5u471211;
	Fri, 18 Sep 2026 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O51KxBvtVfbHMzPOo
	XoHcywhUhm2H4kz862QP8ALIJw=; b=qQAQpoZnpNjOhuYP4mAzzPv7L7l2fEkie
	vv43JHjcGj35jzcJ0JJt6Xg84SZ+E3Ll97WKLJPsbnaHBj3bpKA2we4Ez+bo08vC
	pnmWxbHkERWo0UlBS7AUQZE423D2gzjdEe+QjO5t2lnKUoE6Q5S+sF/Kh0Iz+q+s
	VmkkWG1KaMxq35Lv3OmSBjKBQm+gVPXMALPCtXPaevZTChkiQWSeYxYAQRD6w/Z+
	7HpxEkGbFyf1cMF2HxFQLDkFRWpo3XLUQpTKfnEJBdGBF5/gtCJbDdYhB0SzfX8y
	RiChCOWi8DEzHa7cvvHLJf01Ejl5Xg9tNJQevvlg7lAwd694zFQZA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5f5ha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I652Z51154846;
	Fri, 18 Sep 2026 08:48:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gep52x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8mhJe28508606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23FD020040;
	Fri, 18 Sep 2026 08:48:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E217120043;
	Fri, 18 Sep 2026 08:48:42 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:48:42 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 02/12] s390/percpu: Add sanity check to GEN_MVIY macro
Date: Fri, 18 Sep 2026 10:48:32 +0200
Message-ID: <20260918084842.2333237-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918084842.2333237-1-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A8EjY1xm5ZSEqzxZhnI2W4_QAmQGD98A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXxD9Ug3Pa3pCN
 rklIjNRZ2PxdZtCNhXAnWb7LsBQTWNyuhnyPl2q7k527l5gDswzPGqgTnteTiIwDIWyvHEr+WsE
 DaCEbloRXY4DQak84Q6/bPvxmjsoeg0=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aacfaef cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=nXcjTbxpPpxkwf3kCnwA:9
X-Proofpoint-ORIG-GUID: A8EjY1xm5ZSEqzxZhnI2W4_QAmQGD98A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXzhwqCkAH8ZvL
 IwRE9VM5MBHrHyY46AKd+PQGfw11rROLwhyOfFMevUjltT975U3/mPB8+5m0Chjmo2JJsv++aNS
 OEthF80wKRXnZiQp2Lbf7L+4JOr6wkkYVbWb8powOhby+uXQiccIV2disZ3AMMgrQblY8ittMQV
 JuqTX+HFN8GDDwLExVkMoaAzPUEoCmnN/NhShsaqDs8LDvGZpJdTzQaaRVrcswS59iJlJq9O30M
 0VBxt2tk9Dlu9Rj9PzX70h7bDFVEM76ES8KpHklRLhg2Srp8WtLsnSeAlTwyyrMqmtHQzwzrjQz
 /KxxjjZP6jOK7W++bxeqUPfcWaCDsOjSfb5dSVQ4IlC/1ijla8mHKckEicM1XufBJR5sGW7WJob
 +bIfFaQcAK87FxivP2zPqiWS4g0qE0IqqcST7QrkN0rYLEUM1fdRvEc7bdftsmfbb6aVJOrT5QG
 A3Z2IdDN1ko40wbZbQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

Emit an error if the GEN_MVIY macro fails to parse the passed register
string. This will make it more obvious if something similar which was
fixed with [1] happens again.

[1] commit 101782f8945a ("s390/percpu: Fix MVIY_PERCPU() with older binutils")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 31012abe8292..9888b38dedab 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -100,12 +100,17 @@
  */
 
 #define MVIY_PERCPU(disp, dispalt, reg)						\
-	".macro GEN_MVIY disp reg\n"						\
+	".macro GEN_MVIY disp, reg\n"						\
+	".set	.Lreg,255\n"							\
 	".irp	rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n"			\
 	"	.ifc \\reg,%%r\\rs\n"						\
-	"	mviy	\\disp(%%r0),\\rs\n"					\
+	"		.set	.Lreg,\\rs\n"					\
 	"	.endif\n"							\
 	".endr\n"								\
+	".if .Lreg == 255\n"							\
+	"	.error \"Illegal register number\"\n"				\
+	".endif\n"								\
+	"mviy	\\disp(%%r0),.Lreg\n"						\
 	".endm\n"								\
 	ALTERNATIVE("GEN_MVIY " disp    ", " reg "\n",				\
 		    "GEN_MVIY " dispalt ", " reg "\n",				\
-- 
2.53.0

