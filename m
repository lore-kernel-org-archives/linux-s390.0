Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42627386C1E;
	Mon,  6 Jul 2026 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351163; cv=none; b=B4igIaP/P6nmoK0l7TXSL9dZmXZayVJMAW3kiJteDCJ0q4IZRqD6rET0y+NP35fkjtrSty4laB9XB+uJJW46/pWglXon99hxAuD9kNqRkbwjaI4BIpmCFhJchj1hKZJOYVsCMPCdEubYs46OWxSK++KGIs4Ah2HwRDwR2l7fEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351163; c=relaxed/simple;
	bh=ChljosxfRSwiZXe85VeO6rWspKW445ScOoBhxyxt/3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INDjYwAIZv8PVAar6+xOWWcszZ7kzs6bnUnOpwiwHhTj9j7CGk2N7XsGWJnaceVYo3ylTKql0p3P/4Y/1RivBmGvIamzFGn0ntNoGTN2eews9SyR1o7/tSFmT4Ol9JwCeGyeG/7zim1VovgNbqHkt10sfZKdUclxQeptIQbFnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E6fhSKp9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E6fhSKp9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FICZt611138;
	Mon, 6 Jul 2026 15:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FGvC5i46VdgFL8irG
	XVgxlcN3w3ujkyUONZx/vOvPnE=; b=E6fhSKp9vKjjFFBYeJFqyVZs0HIgJsitb
	UqmksmdvgXRQnhf+/YkOW7OoqFbLnGcLLBoKbMFAFV6JFvF8HfaKavh8WbtCZ/kV
	BpTL3niVDomXMTHwDueLGEeTyCVeJZRxN2PTJqYJBp7jinqet/mJFYIurzMtJRz6
	opBQ27mzlZYJy148Nh/WmwUpfVSPYshDxEmX+jZcaTD+hzetdYxexFSOn6e6/LNt
	NKsUyl77dB+BqV27kmCSRDrXKEC7EkhCwRfpq/m8ujwF74LXP2j4BxLuWrgIAH6h
	k+QdMlHGaY1j53UL0vYgBpDLiZoQ4LFaPLedBe5zwV3tqwibf4CwQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3j4q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:19:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666F4sTX028938;
	Mon, 6 Jul 2026 15:19:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h610n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:19:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666FJB5Z11862286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 15:19:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A63D20040;
	Mon,  6 Jul 2026 15:19:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD04F20043;
	Mon,  6 Jul 2026 15:19:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 15:19:10 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] s390/vdso: Use symbolic constants for the PHDR permission flags
Date: Mon,  6 Jul 2026 17:19:09 +0200
Message-ID: <20260706151909.103539-3-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706151909.103539-1-jremus@linux.ibm.com>
References: <20260706151909.103539-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bc774 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Mk8Ik3_Xw2e2UI5hhpgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX+j8V3ZpecvzI
 tBSFi0KUnQJF2YAndylSa0SILOVPNOjob4k8yBfaYYMmumFfQdXw62FUi2+LTeXuC4CyvKLse0z
 SQlZs6ij2f22MVxddyR0RdAt+EqcMGs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX0Hrh3DkgvOqo
 iyVRFP8vzqMMIOw0UL4NlVcxt8OZOK3wUmVAPlE+Fwkvq8rdN3umIFB59M3h9Ee8ei4jkwD9/Wq
 gRdhQ+PbZkfFyeEEOIk4rDo5JI294yyVDL8yGiqY20WlWIHInJ+jiVaEyNwcQ3atMWUAeYItK8y
 f/ew1Gr0T1sE7T/PRldBGyN/cdl0GX8s2MUBZ5T2X4Ok33VEarD+Bz3HrHBke35umVEMdbjinN5
 eT0wO1wQSZiZIRnDiT3V1IbaFwBLBT0CaY8nD7v6sMmXfenKvktNLMfkWF1j90cNLV+5xLageTo
 0RnjMriFt8mvrYJdfr45/KWLjA+F4Pf7kRytn/XEZTh8nb+ra8XUDTfFajLdkrdBfJlPZ5zBCJ0
 CwJ4LTBQP/zoGWUp+JET8AXajwkq99/8u5zkYieo+AiAZJkc9g9m4wGMY1WKsHtbtB+Zz+AIT9c
 Wg96+xV4yRdFAJWzHPQ==
X-Proofpoint-ORIG-GUID: eiA2AlY-MQ0dU8FoWNJAxOrpKKxhmEuC
X-Proofpoint-GUID: eiA2AlY-MQ0dU8FoWNJAxOrpKKxhmEuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060156

While at it explicitly specify GNU_EH_FRAME PHDR to be read-only.

Inspired by x86 commit 8717b02b8c03 ("x86/entry/vdso: Include
GNU_PROPERTY and GNU_STACK PHDRs").

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/kernel/vdso/vdso.lds.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
index 7bec4de0e8e0..35ea7ede06c0 100644
--- a/arch/s390/kernel/vdso/vdso.lds.S
+++ b/arch/s390/kernel/vdso/vdso.lds.S
@@ -82,12 +82,16 @@ SECTIONS
  * We must supply the ELF program headers explicitly to get just one
  * PT_LOAD segment, and set the flags explicitly to make segments read-only.
  */
+#define PF_R	FLAGS(4)
+#define PF_RW	FLAGS(6)
+#define PF_RX	FLAGS(5)
+
 PHDRS
 {
-	text		PT_LOAD FILEHDR PHDRS FLAGS(5);	/* PF_R|PF_X */
-	dynamic		PT_DYNAMIC FLAGS(4);		/* PF_R */
-	note		PT_NOTE FLAGS(4);		/* PF_R */
-	eh_frame_hdr	PT_GNU_EH_FRAME;
+	text		PT_LOAD		PF_RX FILEHDR PHDRS;
+	dynamic		PT_DYNAMIC	PF_R;
+	note		PT_NOTE		PF_R;
+	eh_frame_hdr	PT_GNU_EH_FRAME	PF_R;
 }
 
 /*
-- 
2.53.0

