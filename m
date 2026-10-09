Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EF43C069;
	Fri,  9 Oct 2026 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526661; cv=none; b=uJsikXmoeI7Qnx/cGBULt3MWdt/6We2xBakwxbGtQHh8Yod6M0aYtQ45iWtnyYDBbElghdxEHN+/1UvLKW0Gm1D8HRabKStDWkaCxHRQ5ESPMaCo2hCZZ75J77Ub1A/gyOwWi2+NIDgAztCGXmBqShhwkFIAYCBv6+gQdywKiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526661; c=relaxed/simple;
	bh=BJBNFBS9lvcusXLnec9W26QY/BdJxGtMfrAEfzULX4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3fDcM1mCRaCbFrTU84rG3hnRanlzsxGw7M6IGQQHnQT1XcNZvRLEokdSXdNECxOz5DB3u0w/XPiQcOGaKr1rUJlh7X/g4q6H09Gq4L+CvBi3M1Qquwd9HqYDN0hnbBoF6lsmcTJJunV2Uq1Fl3P3LFt3R8+AxjM9qwaK2FHgjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JvJHOeLO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JvJHOeLO"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZXDP1403074;
	Fri, 9 Oct 2026 06:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YZX2ly
	13Iob3AvZ5ATG4eV6AAbFHC+BgcUxaV8Ij7FI=; b=JvJHOeLO/IIIoGmrg3kLkS
	vNOi7X4JesSqrLLR6okwGvePuTHQC5pnEFc9YGat8vfT3ph0OyvWN33dGlZIT59b
	T34MRMQAI05OUj8vcNk3Bumvlt95LkzaaalZqRe0Epe628bTP6WBy8jIsZFkRPKN
	1YSCPk542lf6SgVgMBJkVdCfveEZuv9a/2taWHJHpBXC4kBqvoSdVDj2jfQPOMtz
	n0AcQ5xZmrgEKowaT9tRerImwxugbtnLqrrDhcdBUvibYtdlvDC5G8twwEX8uLTJ
	iHoEc9UJVepWHetYu6wolUvA3Z8InhV1RtHBNYmb3LVsYY2BRBLSHwLd03DrXDKQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw8uta-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HeTe290551;
	Fri, 9 Oct 2026 06:17:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dtn3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HYqB50004308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40F4B20040;
	Fri,  9 Oct 2026 06:17:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DED1A20049;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 09 Oct 2026 08:15:51 +0200
Subject: [PATCH v3 4/8] s390/pci: Fix use-after-free race in zpci floating
 interrupt cleanup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s390_irq_domain_fixes-v3-4-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DK4tMNF_Cvo2aAlfPYqz-5oPTCOozKpT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX5Asf1o56obIr
 K1xo3qG3SFte/zoig5ZNoTKFBP+Qg7HakdIzB0CVMVC0GPnoP7BMnVh4mmLLaB/EOGaaDS3907w
 BC3WqaxY4nBYPdzGYpj606TMrN8mfU1kSPm3y8A0kB1lwlYaeE8S8LZWj3cNeYfEfJ010103Mhs
 k3svYfrQrXie/PdZwDlFHyEcQbaBK5TXeZbVg3t5V5tL0qxZ++tF1Ifsm0fawvNyjiNU1n+0EJH
 fJg87VgPzUPTfK2fuAm03VRRQGUG4X2928wOwiHQ/hOIP8ChUD7ut3ot1AYWOdPD6ozaVp5F4De
 WcXxwGohtn8Wp4SGZwTQionxLG+Y2v42WTbsUXVx5NeafPE/TkSOjCxPCfiglMcUumXG4f6jUn9
 MDIRNoenzGTz4cy/d49T/LvaRz1aXBSqbr/JgorBrRDg9HbHrrMlKg7MdL1OeOBZtVfCbDjGX5x
 WTOIWnYDPh3AP6RISiA==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac88702 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=APtM44dArK3XA30jmSkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX60+8QK8o7GCT
 vu1e8pLXkMhloY61bUMbdU/3fkj43r27reiSnFKN37AJnZm4TTO0yCcQf57RGihFu8yElwXQXC4
 TduBn80X/OMaNEln1W89DTxKZ+cO5eA=
X-Proofpoint-ORIG-GUID: DK4tMNF_Cvo2aAlfPYqz-5oPTCOozKpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024

zpci_clear_irq() stops the adapter from raising new interrupts for the
function, but a zpci_floating_irq_handler() already running on another CPU
can still be scanning zdev->aibv when zpci_msi_teardown_floating() releases
it.

Clear the zpci_ibv[] entry so no further handler picks the vector up, then
wait for a grace period before releasing it. The handler runs inside the
rcu_read_lock() section that do_airq_interrupt() holds across
airq->handler(), so synchronize_rcu() drains any handler still in flight.
Release the vector and free the summary bit only after the grace period, so
neither can be reused while a reader still holds the old pointer.

zpci_ibv served both delivery modes, indexed by function under
FLOATING and by cpu under DIRECTED. Only the floating vectors are
published to and torn down under the interrupt handler, so split the
directed vectors out into zpci_dibv and annotate zpci_ibv __rcu, which
lets sparse check the accessors above.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 58 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index d5763c5feb09..c5fabad38139 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -22,12 +22,11 @@ static enum {FLOATING, DIRECTED} irq_delivery;
  */
 static struct airq_iv *zpci_sbv;
 
-/*
- * interrupt bit vectors
- * FLOATING - interrupt bit vector per function
- * DIRECTED - interrupt bit vector per cpu
- */
-static struct airq_iv **zpci_ibv;
+/* FLOATING - interrupt bit vector per function */
+static struct airq_iv __rcu **zpci_ibv;
+
+/* DIRECTED - interrupt bit vector per cpu */
+static struct airq_iv **zpci_dibv;
 
 /* Modify PCI: Register floating adapter interruptions */
 static int zpci_set_airq(struct zpci_dev *zdev)
@@ -169,7 +168,7 @@ static struct irq_chip zpci_irq_chip = {
 
 static void zpci_handle_cpu_local_irq(bool rescan)
 {
-	struct airq_iv *dibv = zpci_ibv[smp_processor_id()];
+	struct airq_iv *dibv = zpci_dibv[smp_processor_id()];
 	union zpci_sic_iib iib = {{0}};
 	struct irq_domain *msi_domain;
 	irq_hw_number_t hwirq;
@@ -279,7 +278,9 @@ static void zpci_floating_irq_handler(struct airq_struct *airq,
 		}
 
 		/* Scan the adapter interrupt vector for this device. */
-		aibv = zpci_ibv[si];
+		aibv = rcu_dereference(zpci_ibv[si]);
+		if (!aibv)
+			continue;
 		for (ai = 0;;) {
 			ai = airq_iv_scan(aibv, ai, airq_iv_end(aibv));
 			if (ai == -1UL)
@@ -299,7 +300,7 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
 {
 	if (irq_delivery == DIRECTED) {
 		/* Allocate cpu vector bits */
-		*bit = airq_iv_alloc(zpci_ibv[0], msi_vecs);
+		*bit = airq_iv_alloc(zpci_dibv[0], msi_vecs);
 		if (*bit == -1UL)
 			return -EIO;
 	} else {
@@ -320,7 +321,7 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
 		}
 
 		/* Wire up shortcut pointer */
-		zpci_ibv[*bit] = zdev->aibv;
+		rcu_assign_pointer(zpci_ibv[*bit], zdev->aibv);
 		/* Each function has its own interrupt vector */
 		*bit = 0;
 	}
@@ -342,13 +343,16 @@ static struct airq_struct zpci_airq = {
 
 static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
 {
-	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
+	airq_iv_free(zpci_dibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
 	zdev->msi_first_bit = -1U;
 	zdev->msi_nr_irqs = 0;
 }
 
 static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
 {
+	rcu_assign_pointer(zpci_ibv[zdev->aisb], NULL);
+	synchronize_rcu();
+
 	airq_iv_release(zdev->aibv);
 	zdev->aibv = NULL;
 	airq_iv_free_bit(zpci_sbv, zdev->aisb);
@@ -428,9 +432,9 @@ static int zpci_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 		if (irq_delivery == DIRECTED) {
 			for_each_possible_cpu(cpu) {
-				airq_iv_set_ptr(zpci_ibv[cpu], bit + i,
+				airq_iv_set_ptr(zpci_dibv[cpu], bit + i,
 						(unsigned long)zbus->msi_parent_domain);
-				airq_iv_set_data(zpci_ibv[cpu], bit + i, hwirq + i);
+				airq_iv_set_data(zpci_dibv[cpu], bit + i, hwirq + i);
 			}
 		} else {
 			airq_iv_set_ptr(zdev->aibv, bit + i,
@@ -455,8 +459,8 @@ static void zpci_msi_clear_airq(struct irq_data *d, int i)
 
 	if (irq_delivery == DIRECTED) {
 		for_each_possible_cpu(cpu) {
-			airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
-			airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
+			airq_iv_set_ptr(zpci_dibv[cpu], bit + i, 0);
+			airq_iv_set_data(zpci_dibv[cpu], bit + i, 0);
 		}
 	} else {
 		airq_iv_set_ptr(zdev->aibv, bit + i, 0);
@@ -550,7 +554,7 @@ static void __init cpu_enable_directed_irq(void *unused)
 	union zpci_sic_iib iib = {{0}};
 	union zpci_sic_iib ziib = {{0}};
 
-	iib.cdiib.dibv_addr = virt_to_phys(zpci_ibv[smp_processor_id()]->vector);
+	iib.cdiib.dibv_addr = virt_to_phys(zpci_dibv[smp_processor_id()]->vector);
 
 	zpci_set_irq_ctrl(SIC_IRQ_MODE_SET_CPU, 0, &iib);
 	zpci_set_irq_ctrl(SIC_IRQ_MODE_D_SINGLE, PCI_ISC, &ziib);
@@ -570,8 +574,8 @@ static int __init zpci_directed_irq_init(void)
 	iib.diib.disb_addr = virt_to_phys(zpci_sbv->vector);
 	zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
 
-	zpci_ibv = kzalloc_objs(*zpci_ibv, num_possible_cpus());
-	if (!zpci_ibv)
+	zpci_dibv = kzalloc_objs(*zpci_dibv, num_possible_cpus());
+	if (!zpci_dibv)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
@@ -579,12 +583,12 @@ static int __init zpci_directed_irq_init(void)
 		 * Per CPU IRQ vectors look the same but bit-allocation
 		 * is only done on the first vector.
 		 */
-		zpci_ibv[cpu] = airq_iv_create(cache_line_size() * BITS_PER_BYTE,
-					       AIRQ_IV_PTR |
-					       AIRQ_IV_DATA |
-					       AIRQ_IV_CACHELINE |
-					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
-		if (!zpci_ibv[cpu])
+		zpci_dibv[cpu] = airq_iv_create(cache_line_size() * BITS_PER_BYTE,
+						AIRQ_IV_PTR |
+						AIRQ_IV_DATA |
+						AIRQ_IV_CACHELINE |
+						(!cpu ? AIRQ_IV_ALLOC : 0), NULL);
+		if (!zpci_dibv[cpu])
 			return -ENOMEM;
 	}
 	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
@@ -660,10 +664,12 @@ void __init zpci_irq_exit(void)
 
 	if (irq_delivery == DIRECTED) {
 		for_each_possible_cpu(cpu) {
-			airq_iv_release(zpci_ibv[cpu]);
+			airq_iv_release(zpci_dibv[cpu]);
 		}
+		kfree(zpci_dibv);
+	} else {
+		kfree(zpci_ibv);
 	}
-	kfree(zpci_ibv);
 	if (zpci_sbv)
 		airq_iv_release(zpci_sbv);
 	unregister_adapter_interrupt(&zpci_airq);

-- 
2.53.0

