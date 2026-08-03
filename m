Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893630BF67;
	Mon,  3 Aug 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767356; cv=none; b=JyI9C3c9hZLIotWIVOy0SaUktVX7bYVQrlRP93RmmRNqjfSf3s/YwH2Nzdr5soCwZ3OsA/ZajIGCZpORHdrTnKF7fhw9g8Zs34uWijCNxY4wxw3DR0J4sP7XUkB/4ZooRNxioXr0Cawx/uLU7WnC+p5U7tOK2a+9SMBE1/eNbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767356; c=relaxed/simple;
	bh=mclsNwZP6adbRjVRyGhr3KqNodbTA1Ic/YqMpeR3I6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxVmdx2XYrmTI0ixYXNYjSmZPBAd+3wiBrPe8pCU7y2uf+Ea5oV74Iy6Ghr9ozAU1Fiq0N5PCb9waZquczaIBxllBiYpuS14vVDVJE7bLW4h/qJn/t/27q2ywV/9fvjwk6m2Of+uP8X9uIFSD/LIr3JyLY5nX3+/wlYKdYgxQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RIO1y2KC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RIO1y2KC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHYY7413703;
	Mon, 3 Aug 2026 14:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=37EJygpbD7lUmddly
	IOgIJgMzApXhhDgvbSyl7VQjHg=; b=RIO1y2KCxrVVydi3O7FZyCelHCfYcTpKX
	T83hCc5Px676o01xXNlw4L2UMq7S/4CBBPBoBHy2kxITa5QIMnzWKGCBnb0RpzRU
	TA6hpQJ/DmTVc07f9Xu5gd0IbwuAcuml0HvT+bqTfXi2VEW1+7FTqJGK/QwerE80
	/0JDup6YwBwYNNpmBczyTAam1iD7UV9r8+clEiac5JF9qIIL/6OEQt54NHaGm80i
	M4Nez9glrwaW8yoWsG/V9Twm0cHu8aeGnEQgunAz0Z537MDCPRyzW56iUhhjDslt
	i+aH8PWEg6KHjQEn9GRljpxj+j5wiAo2EELZHivWHW62iclvJweAg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqh7xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:29:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EQMpM019962;
	Mon, 3 Aug 2026 14:29:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwvba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:29:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673ET8c820120164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:29:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D126E20043;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1B3C20040;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 14:29:08 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] s390/pci: Enable CONTEXT_ANALYSIS
Date: Mon,  3 Aug 2026 16:29:07 +0200
Message-ID: <20260803142907.1771509-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803142907.1771509-1-hca@linux.ibm.com>
References: <20260803142907.1771509-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GkozQfUg8lWKibHwLATRa3sP-4ACOOGE
X-Proofpoint-ORIG-GUID: GkozQfUg8lWKibHwLATRa3sP-4ACOOGE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfXwvU06kuIyPNl
 w3+xwC2IG7Dx/PnIgOWz0qH1O6gsBdQy5bp+z0MXzcMIOHO7qQDDmoR9JcOM5wgdFbkiTosxkKU
 0zO+51IkKYtRLbpwCe1ffU8EPZxqZl0=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a70a5ba cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=BVUoiYlOf69TRVgg-NoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfX2lv2Q0W+QZwh
 2JjUj8geLLUj5Oy0FMtxmGmqs7FuC8anyx4VIBbGFFH5QF/P6K7zZ55n8trxTjU53EWfZHujpML
 /TJrkiBzwAwSHYGZv+pGVnfw6DAUf+khoWpmO/r1N7B0W8r+wQ/vuPuALUb/XewopnxezWhxBnr
 tYCmBm9eDcNYGMNOHzpR/QG34W7NZVPwV3Y+zoM545GsSti9yBeZjBnzCQqXQqgI52vqc2W8WMR
 vSThdf8i1MgYnE836rr9RbAgig5CSN6oEfarVWMy3RalFWQKseKom8HTXh6E6ZWzGeWF8C/Voec
 bZ8NPXCXxGLemf4VBMNPfPkYwZFZJKU4T0w9n56UAHZfP0MiTNFmUJJ/moSPoVYq8Q/jIfp6AqE
 mXssVSd0x/u2JrTQWAHDKraBFyhzQQzddvEHH9oiaohn137gl4mm4hXYDQimHympVAjSNYcmDWD
 0Q4ojIbJ4W9XijJjTlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030128

Enable CONTEXT_ANALYSIS since s390's pci code compiles now without
warnings.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index 1810e0944a4e..b8be1316491b 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the s390 PCI subsystem.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o \
 			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
 			   pci_bus.o pci_kvm_hook.o pci_report.o pci_fixup.o
-- 
2.53.0

