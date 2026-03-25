Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B525A2B5;
	Wed, 25 Mar 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458801; cv=none; b=cq3iCpaB1tb9YLj69RNyvgkuFs/unGu0QPnZVXC4s6pCb6T/QdSS3tN28J6PelBSddAH4pMi6kN8zCSsFAo8Xi2RBzCRi/Vqye0vE1R0klAKwBDFk5lqSkF/8PDKQhoY3JT/3Z3T+zovD31cmE6Z0Y8X6+gEudvob5CXgjdyJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458801; c=relaxed/simple;
	bh=OJ0YppEpXxWljpnDo2C4R25lit9Ina1zpzH2IgqgCAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV59gauLrYzofCJEq+UwZCJS2LwpOlxn1NhWnejcyU2q1x4eZae7SGPRE9/ptqKVGWX/HzbBJ7EqFPFQmQqgbJYu+dFiL0FttfANuceAVqvGJ2D0fTBgSanelwAlJk0P93vCozd4Qh9xQ6OTuzXeil97aKabKTx//jwuiWJDP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S0QKFJ3x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S0QKFJ3x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PEip8W2664877;
	Wed, 25 Mar 2026 17:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oDSu/bQDxMYWLBwio
	nStkeQoi6NLCfGdNBrHSiGUtoI=; b=S0QKFJ3xJKBdqudQMNTGvQQrqPYBIpZtt
	pcVfAcLKJM+zWwQqf6hBVbS9/ZIYHDES+9/34D78LSnxnPTn1ln3rteSALo4oUPD
	j/luUEoKpAdE+vr5QMyaaBamUCpSqxm3b1ktrsRe4zC5J5Fy9wepAFO6R/6Tg17r
	SCkCPEcIstSfug+ditxI9lssFx/zgm3POXaucgQw8Zs5ta7ACvf46jh8cakw+lIw
	2Bu7IgWeEdepaTsqd6snjBBJ+oJ4muAAkCvZiHanHu1S78/DFDa/hdjEqCaJhUbh
	skKbOto2/sE9EC++pU6vG4FjOYlr00RdWXAj8oPgURzqN2J/lDh+g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv0qx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PGPgW3004375;
	Wed, 25 Mar 2026 17:13:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c277ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDCko31195430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78ED620040;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AFB92004B;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 01/10] KVM: s390: vsie: Fix dat_split_ste()
Date: Wed, 25 Mar 2026 18:13:02 +0100
Message-ID: <20260325171311.182210-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yNHng_GbjatIV3mG8XYevlJnCAe6UiOE
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c417ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LsQdvuOhCgcXfIND9tsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfX08BF/hbvPkzY
 hhhZ3418TJb/W1LZsQU/gHV6S5mQA85AkzguC7rz9uF8FWv/PgEaqhuPda0etU6HgxMRion89gj
 V6QCHXubyKiLHsyRsq/nTieGFucHKXSH02vIUDMd3bzIXZqu8Y49Y3PKoBC1pzBClWK5pj6KuXD
 WTXCBgQRJkecADMEghkDrIB5kZc0lvfXtVUrovlHC/Wc2o1dmvhgN5I2MyKtlKLAIMrtgg3y2UC
 OFBf2YLRUINVLQBgZDLA2aySOgmQkzyZTdEXS8AO99pZS6ZMGYarGpiy8Wne6UH3mGAiqOlhOEX
 b98rqNsBDtafAd/eRsb5JZAHqBXSNAKZBWWgiGmyKfRAjg6HJa+KfRMlBek9yNDfucvQ2r6Hula
 y6G6hGoIfbSTJ9UcJLL7lCQC5fDxUqnuromRV8M5SFS62tcS6KhpWbeYqzmkaA6BGUSKBQOq0V8
 2bPJjs2/pLpewKsHYCQ==
X-Proofpoint-GUID: yNHng_GbjatIV3mG8XYevlJnCAe6UiOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

If the guest misbehaves and puts the page tables for its nested guest
inside the memory of the nested guest itself, and the guest and nested
guest are being mapped with large pages, the shadow mapping will
lose synchronization with the actual mapping, since this will cause the
large page with the vsie notification bit to be split, but the
vsie notification bit will not be propagated to the resulting small
pages.

Fix this by propagating the vsie_notif bit from large pages to normal
pages when splitting a large page.

Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 670404d4fa44..48b5f2bcf172 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -292,6 +292,7 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
 				pt->ptes[i].val = init.val | i * PAGE_SIZE;
 			/* No need to take locks as the page table is not installed yet. */
 			pgste_init.prefix_notif = old.s.fc1.prefix_notif;
+			pgste_init.vsie_notif = old.s.fc1.vsie_notif;
 			pgste_init.pcl = uses_skeys && init.h.i;
 			dat_init_pgstes(pt, pgste_init.val);
 		} else {
-- 
2.53.0

