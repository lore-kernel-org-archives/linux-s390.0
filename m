Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A13364EAB;
	Wed, 19 Aug 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129475; cv=none; b=FzhuGrA+nb4xwbio/fS/NRv+wsLdIKvevXzg97KrRoc9ThJkid/UO3wY2n53mv2Jsn71JEUsQ+K1e2CbaMPk1NULpbkA3ONQjdh87LP5xSH0cphMO4PJPQdRukFVqAMY9n41IdL+pg4xa/vc7wzstaHArzA57qR2TNJFnjh0NSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129475; c=relaxed/simple;
	bh=YF241Iafk6NhMcqEAINFG6wX1J+3sOVRO8wcvi3ARnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNSVy+Kkcw+CM3cTAJhLvVAiy123vp5YwDbJXo3mvQCXRW/tV2EALWA+PA7xwztyM03PmNh+RmRq9JYqnDXKkWRLWMD9jOTcbDsP18n8OBqxUF/xlMWC0nk8wwY8MheJe7bn//RJC77ruXhWtGi1hsVdkjL2O5eilm6p0KLMMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CW9XQ1Rg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CW9XQ1Rg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WHC42700038;
	Wed, 19 Aug 2026 08:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H+qUVP
	v54PjVY8PcBT7IstjPN3xmgNg0sD/7+TA8etA=; b=CW9XQ1RgPIlDQ+lrDHEvHj
	b6az1wbyxzgMWqA06db6zz2HYpyqKT1ExERDleOFcbk15iz5QxmoITTssFEgI6F6
	3W62L4c/t+Udtqr2hjfgUYIVhzrjZLXIdRmZHR0pONwXYXaltGO1wfykDm6mykGH
	uNUcZEGMSWqIayp4o25VF1ePdFlemODOu5f0zfy0ko6jn+QEr5g1q4SEUYkhwjzo
	r7DKsHKzZFAbhllP2ohxuI7aTAy7WubjlMtu7zS6t+CJenH7QcV8xiTKk9qMtoaU
	5Vd3Nf+ljEnzh0CVtLBdh1GejCgafp48oO3tiQIummsAVs5De1W75hYfwoLWqKLQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu42jjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8fOWh007716;
	Wed, 19 Aug 2026 08:51:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq868h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8p85F47448374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:51:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ED532004D;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 592CB2004B;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:50:55 +0200
Subject: [PATCH 2/7] s390/pci: fix use-after-free race in zpci floating
 interrupt cleanup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-s390_irq_domain_fixes-v1-2-826ff27b6e97@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a856e81 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=u7Un7ibZpohKse0PRmsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: trZ20OCLFhIDlnVLASgd964B5cg4G4sB
X-Proofpoint-GUID: trZ20OCLFhIDlnVLASgd964B5cg4G4sB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfXykX0js7xL1tr
 PlkKiNlcjI9VpiMDpRGh370p/DQkzGLnGlTSZHGtLlvRTnne1dAy+opwJCUZ5yubUX2M/9JeKJF
 Qt6zC9E7/bteXi3u5FjmSgKn+CpNG+Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX3JOV13L27HZJ
 Xbjc+fnTSLkTLcMCC8wcuvEaaE8wh6tbOkTnfLgqefimDsHTzsrr+u7Jq7Q9ytbGvKKrixTv+xl
 Mx8oIXpaLhMD38iV0KrMp4rqe29hHFbYYZAn4pvU32aH7f/xVjPRv2wZI59p6l6fYSUy9r3rPp3
 PskVQHFYxfX2Gv9hZzgur8tJ6Z0HkzejgS7n8/zcv2SY3wtOrMBEB8ocJYdhg5I0Tre2R/pfl8V
 Y8UmKL/LiTvfOZ0BpEkaKnJGbS6oFvKr5dE9AC6I87CnTEuA/UjMoHtYu3WjI7ebQnBFNKsvDEG
 eRBbQdTFb1H7VC+5jrP4kmA0XGdgD0q+PXqdvZq1N99SizGxmSrSzt9FEO/hdB+vHkFF93X1kxY
 0G7S3p9ILJVJt+ASzDvgryKBPgGl1APBtfU74sZkgwrZPUPVYH0Ki8y1t5nbsDfOxw9+rtHTeJv
 xeDOhl9ys7BufxSxA5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190063

The interrupt handler reads zpci_ibv[si] without synchronization while
concurrent teardown can release this memory, creating a race:
- handler reads the pointer,
- then teardown frees memory,
- then handler uses the freed pointer.
Fix by protecting array access with RCU synchronization.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index c9520a16ca75..94b03d16006b 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -278,8 +278,14 @@ static void zpci_floating_irq_handler(struct airq_struct *airq,
 			continue;
 		}
 
+		rcu_read_lock();
+
 		/* Scan the adapter interrupt vector for this device. */
-		aibv = zpci_ibv[si];
+		aibv = rcu_dereference(zpci_ibv[si]);
+		if (!aibv) {
+			rcu_read_unlock();
+			continue;
+		}
 		for (ai = 0;;) {
 			ai = airq_iv_scan(aibv, ai, airq_iv_end(aibv));
 			if (ai == -1UL)
@@ -291,6 +297,7 @@ static void zpci_floating_irq_handler(struct airq_struct *airq,
 			generic_handle_domain_irq(msi_domain, hwirq);
 			airq_iv_unlock(aibv, ai);
 		}
+		rcu_read_unlock();
 	}
 }
 
@@ -346,9 +353,12 @@ static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
 
 static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
 {
+	airq_iv_free_bit(zpci_sbv, zdev->aisb);
+	zpci_ibv[zdev->aisb] = NULL;
+	synchronize_rcu();
+
 	airq_iv_release(zdev->aibv);
 	zdev->aibv = NULL;
-	airq_iv_free_bit(zpci_sbv, zdev->aisb);
 	zdev->aisb = -1UL;
 	zdev->msi_first_bit = -1U;
 	zdev->msi_nr_irqs = 0;

-- 
2.53.0

