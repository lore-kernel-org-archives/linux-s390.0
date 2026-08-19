Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B33F1AD3;
	Wed, 19 Aug 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129475; cv=none; b=QyRaglQ6qcFaAbHBQuhvXkc6iIhvZUG4q0/RUf+vXqkMuzYaFp0kGfD46OKp/XLeeoD8siuP0qhZhxDZDL/OzEVZ0evvy+Dks0Oz1StHeVGmR3LXR0fe33fCXMRL54GiEbq4xqLgUFr/wRzUh5qjRH82rt36Io1j124kvP1niqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129475; c=relaxed/simple;
	bh=iiGSw3MAEDhhYKpP3QXTIIkI70MydeBZkCvYSd6fNBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCqTV0l6Ph/fF0rd+Pojf66Jdd3girGqKFKv8AvMtwjJRSArM3u4K2JFVKRc4+5XyOcX6kN+QX/zPYihAFgFnI5/atQDxbU+Yg9RSbok/TOSxSXhAAW3lMvWTPW0WJXmWntQwtmSDwZzzK0EcmK+WiaF/pKmHlDYSxsUbwoxH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p4Xw30LW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p4Xw30LW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6Wupq799764;
	Wed, 19 Aug 2026 08:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iYxY3F
	wJ0N+w/bPo/HDIS3Nx0fLFnUy3i0c1+BKecvg=; b=p4Xw30LWjGM62zdmHpaQ6T
	XYsTuc3vwzAa5KmBalynxqyNYU93pGQldn7NJLYzDjTwSoRqa0Xsz3PAzYPqR4yK
	7c7DlgNzdL29mTndg9Iaf1g1dvu9U4dM2D9/UnxRAksLUn1sRVeN06HA5kAgcunf
	8wMwdRaN8fe5GRoSTw/Glw6oXZRPm1zS/WlEa26itYp9KLj7Rir5dNe85pBIlzVi
	3VE6X2qlYA211o6FGOEIBwvvB2gGjP+7pYfpGeI9fe6qgdDNt4qf23C5UEv1eXNc
	qT/o/DLDDR3A0vjf/r3ZC5zxS6QNQJ+MyAWId0msDeNi7H8GxV6Tryur7dlgY7Tg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu02mcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8fH6Y028348;
	Wed, 19 Aug 2026 08:51:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yfrud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8p9hK49676760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:51:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3633D20040;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 060D32004B;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:50:58 +0200
Subject: [PATCH 5/7] s390/pci: add NULL check in zpci_msi_clear_airq()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-s390_irq_domain_fixes-v1-5-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kso1fGyYDa3arVyF_osRN5QMLioZu8SB
X-Proofpoint-GUID: Kso1fGyYDa3arVyF_osRN5QMLioZu8SB
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a856e81 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZfaGzbHgtsswHcod-aMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfXzxp59iM3tS2z
 0jSo6IqLeq9j2W/tLODMiJvLI7D0gUS//EHfeDQe41KmLVftjJVQcOjDndkVMlHTPv5mSfeNQPZ
 e2SfQ2eUr67xh+jSAewdYXZZ2WZdINw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfXzZRHS2OVgzud
 92JsLFqNqUoFZadhK3no+5SaHn/QdfqGVP+93/D7qV62osg6dZCu6P4uPCyZRALeQxsiSpRnU8s
 JrG3qGXU/5bNpuzhvg3p1u/CGmhHLwC7l7kkeAMGzDDvW6S/FjNmDzrQJUmes20nQj5kTh5yOQX
 kNGnFxMDf3ZuGcRx6/1Dcm+TJCocHs1mbI0+vtfGIvHB2d5PCyA7po7AAnwMhtEzT2oqPU5m0gv
 FKuP8EX3lOL9X/jI/T8By4paiCZ80uBHDs3WBosaxF6IKCNYiOVmR5prKpVYPqc2/HaQDK0ZU/K
 7twS77XM54QB7zK7mA54T5tf95orsJxsPAAhhadpRq+2egNah66DdzwT1z5uwVP6t+M/7OE1nZz
 hRLOGfGZH86P5qhdrwsHNqbxkoxPJKsMJPy5uuVdX4/7y7ioNn/pMyyoBwXHP2FfGpLr3tKVdmk
 TrCMRV21Sn2nBq+en6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190063

zpci_msi_clear_airq() clears IRQ data in both DIRECTED and FLOATING
modes but does not check if the interrupt vector pointers are NULL
before dereferencing them.

In DIRECTED mode, zpci_ibv[cpu] can be NULL if:
- zpci_directed_irq_init() fails during boot after allocating some
  but not all per-CPU vectors, and cleanup is attempted
- The system is shutting down and zpci_irq_exit() has already
  released some vectors

In FLOATING mode, zdev->aibv can be NULL if:
- zpci_msi_prepare() fails after __alloc_airq() but before setting
  up the device's AIBV, and zpci_msi_domain_free() is called during
  error cleanup
- The device is being torn down and zpci_msi_teardown_floating()
  has already released the AIBV

Add NULL checks for zpci_ibv[cpu] in DIRECTED mode and zdev->aibv in
FLOATING mode to prevent crashes during these error and shutdown paths.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index e9eda846cb2d..1515d8d7460e 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -465,12 +465,16 @@ static void zpci_msi_clear_airq(struct irq_data *d, int i)
 
 	if (irq_delivery == DIRECTED) {
 		for_each_possible_cpu(cpu) {
-			airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
-			airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
+			if (zpci_ibv[cpu]) {
+				airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
+				airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
+			}
 		}
 	} else {
-		airq_iv_set_ptr(zdev->aibv, bit + i, 0);
-		airq_iv_set_data(zdev->aibv, bit + i, 0);
+		if (zdev->aibv) {
+			airq_iv_set_ptr(zdev->aibv, bit + i, 0);
+			airq_iv_set_data(zdev->aibv, bit + i, 0);
+		}
 	}
 }
 

-- 
2.53.0

