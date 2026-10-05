Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588447F3A6;
	Mon,  5 Oct 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201813; cv=none; b=M97PW8kI08Scd337eEBFaDGZ3Q5EYGjyUQ0s5irLMXRiZjGDBD/UhOgPp1sHFogUqqIPfJ562TvkaI5wPZ+hAtsIGX6JONtG85jGtBmDcG2rAWaguW6M73HHCQG9PpFgfTzmIGRWM4ZgOf041r2ErEDa/Q8pSa1+NFahGVXuH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201813; c=relaxed/simple;
	bh=s0Yxf5+QCdnQGX/YhOhEZ5nUHW4IZBfeDjFEIkcjEFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHIRA7fbs0wFSer0J+8QoDe9lLUig8gkiEUv18eBc7SOvY55EPf5TL/vWivI2Qgo3JdlTftHhtTiPJXbm4CkrcKzoy+FAfPey8bs7U/Xlwtpeaq2pz9uy/pfoExbm8GmCn+HZYdNOyVwSVBLJtvf0fIIQ4Mg/ZTB/wwKU9Ob+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HJI3H4gs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HJI3H4gs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZZJr526490;
	Mon, 5 Oct 2026 12:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Du8RtI
	IM+GfJLh2EPhwyjjfUiTRL9VkU/fYYdZTJLOI=; b=HJI3H4gsgadgnzyZQbFOjq
	rfvDAc2Oeh6xtzHUbzvT8rNuuQnEygONBnR7gARimzR8qTfXV4APcFXo+WLEBEd3
	oWbfgpDW/soI33FyDVDoSFFtb6Hyb/sG44J1OwGs+KhGeYxohIvix+SxSFl9/xUc
	tp4S4pFxl3Vi2QJOv7po5XzxNeTUjQc/eU2rP3nNW9bmTqdea2wGhV/ST/73xuAo
	1ores35PeGUV8WdttNPt81cCgOEU8kLos/yjwoyhqRpZOZmJgVi3fL4jcf92Q3B1
	Uf1yhdk1DwcXfxNrLQ8Tx8h7tDoy/WX9Sr1Kxt95+gTSR3/y7z9aQsK9ghl1CTzA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv196h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWbQl2862890;
	Mon, 5 Oct 2026 12:03:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy53fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695C3PfT17236424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 12:03:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B6BB2004B;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B55120063;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Mon, 05 Oct 2026 14:03:19 +0200
Subject: [PATCH v2 4/7] s390/pci: Fix use-after-free race in zpci floating
 interrupt cleanup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s390_irq_domain_fixes-v2-4-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lwfH0E7BE0CCg_7xa-gX2US_I_Jy3INy
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac39212 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=APtM44dArK3XA30jmSkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lwfH0E7BE0CCg_7xa-gX2US_I_Jy3INy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX7yNlSZ4f+id9
 f59avckD0y1wnjpTzxXAeqhp+Cw4SYSux0G5Qq1TbZFzanVmSWpQHotrFhEsIQySpPopPehfCm6
 Kicq2iod1iZmcQ2tEUQP0SVt7nmwZHMC9n75pzB759yJG5wxEoXnWeDGR6P2I8tfeLVMfd4mlDK
 SMegAVAADDQiVN9I3ugUXUdRlH1yZ5gS2JzZdBhRNMLzdI8seez1cG/QisiSUac0MbtOPvH8jCb
 sXa8iqnFQdrelENdFDnvSf4bDhX+xthZD8IrqvJebtqEc/b4LgdJALoGBxBi34Niq7l5llgbtU8
 6wa7mdW7ml5KfQ1JeGdN/3fabvEBigRoezoRYAGE1gAP2VBOBvHaC0LNAjblyo45/C6rMAAjNwX
 K1XOBVNKpY3FJs+hfX22npreYN44Kfq1KkAFK2DDYIt5TNRw4Uc6SReqdws/ziw5+F9tYCiz+g2
 tfbETnqhyMkqCc3d3og==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX5v9QrqD2+sfi
 TnQRgnnGkY9B2kMCGcrQCQ/sQlSWXL5VSIIgaCfBqeH4C7zRdwkJLotbk47y6CMFGE3kRhrHtP5
 AyoTzUaS/M37Fh7TS+rW5kR/lyyH3CI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050045

zpci_clear_irq() stops the adapter from raising new interrupts for the
function, but a zpci_floating_irq_handler() already running on another CPU
can still be scanning zdev->aibv when zpci_msi_teardown_floating() releases
it.

Clear the zpci_ibv[] entry so no further handler picks the vector up, then
wait for a grace period before releasing it. The handler runs inside the
rcu_read_lock() section that do_airq_interrupt() holds across
airq->handler(), so synchronize_rcu() drains any handler still in flight.
Free the summary bit only after the grace period, so it cannot be handed to
another device while a reader still holds the old pointer.

zpci_ibv served both delivery modes, indexed by summary bit under
FLOATING and by cpu under DIRECTED. Only the floating vectors are
published to and torn down under the interrupt handler, so split the
directed vectors out into zpci_dibv and annotate zpci_ibv __rcu, which
lets sparse check the accessors above.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 60 +++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index d5763c5feb09..81a27bf756a3 100644
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
@@ -342,16 +343,19 @@ static struct airq_struct zpci_airq = {
 
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
+	airq_iv_free_bit(zpci_sbv, zdev->aisb);
+
 	airq_iv_release(zdev->aibv);
 	zdev->aibv = NULL;
-	airq_iv_free_bit(zpci_sbv, zdev->aisb);
 	zdev->aisb = -1UL;
 	zdev->msi_first_bit = -1U;
 	zdev->msi_nr_irqs = 0;
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

