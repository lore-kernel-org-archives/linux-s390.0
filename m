Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E23F412C;
	Mon, 27 Jul 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146260; cv=none; b=umIaUxUW0TWmBflRHPM/x1pL73DB7GqykwpsWFDNaEwyCkJ+g/oFjYSywlivQl7ZqMh09UgOHz4nINpyaz+uZpTIfYPj5muuGh0oeXOoEXB7dlZMoqEYDx+0LRKOvle4Xm63J7X1cFWO8Z8V5fUCaJyTHtBira2S3EVmAqCiBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146260; c=relaxed/simple;
	bh=hYBrNFe1IIIazb4vgLrMkjVssKP4D16LDNX6N+pLlXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QueeKDhwv/X++zdxtXVGOUHyMsz+lr8KamYdl3CpbfXSwt1gO1xN9JRLzaKBdJnVzPzpPVt7latej/FhguEWrbzoKquEAgaMxLTmrLwPDqWEj5J3u9B9HidsWEV+FElv/c5TNSauJpJp5PbjaJlTXNyJzYF/kD8XBHGc6nYdIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KS1MsJMA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KS1MsJMA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Ud001855335;
	Mon, 27 Jul 2026 09:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tSG2Iiv5nu9setZKs
	nZbBHlR62vjg79ePLVyTM1o1ns=; b=KS1MsJMAc0KimtdpbiXI4zdUhgNPRiMVH
	Y7P6wQzCZ0EsoMd/Bf8lw8f0Nokx0yawCJy4jMuVRT63AF8YMqfopJWSFmTqu66n
	qCqrxfuvg6LOxAr0DJAkKyMDzEpby4QL8QbsyFtJchrp7jJlLb2jW+0MgeqsOPHB
	VSAfVWDZIVrMFu3GyArCL6KYuxu83auONPfRBEyBz00z+yP5bQx03uYgeb+S0mkH
	PXk1tIfo2vwJxk4x5aakiv1KeY2wIzrTVbZJ6kF+c/xxNguYAgAtmHi0rODPPR7d
	TBDfZiMdPRp8UmDdlIG0D6Q+ZsSxp7+XhOL2obuiH0jwPJPc3G4TA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xfc1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9uElQ016957;
	Mon, 27 Jul 2026 09:57:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq50pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9vYxV9634320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:57:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B92F58068;
	Mon, 27 Jul 2026 09:57:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEE5B5805A;
	Mon, 27 Jul 2026 09:57:31 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:57:31 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [GIT PULL 4/7] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Mon, 27 Jul 2026 11:57:17 +0200
Message-ID: <20260727095720.9150-5-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727095720.9150-1-borntraeger@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NxD0EyKp8-EoqnBc6rWYIYkGMoxSY04t
X-Proofpoint-ORIG-GUID: NxD0EyKp8-EoqnBc6rWYIYkGMoxSY04t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX68hQZTu9fr+H
 yUr9VS0OhS0GG5nu2XymoCG7J0ZkJZcx5lvIt7qVx1OFfwfwq1lfY3r6MZmCq64y6UJIv85c+PJ
 ie/EJAJZLkh9q+onxt7mq9VnjHR2luc=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a672b90 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=W0veVcBGhvX6rx8GylQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX1FdikiLm5X0R
 9F0o+jpMvlHKY79RvLwqB0BkwQ70h17fZyCSSGczOaN8zANRhaBz8Ynq70rf6HuX1xkQFncvyRa
 Rd8Sqv+Z/ADMyoba+ezaCmqVljUULDaKgmsIzej3R2EVAGeoToaHsP3it/okEBlno8AIbiA+BV4
 UZQM/kJ0pNTjTvQhSVCYudcOctspqNBcevQTCay9btVFfZ75bdUrfvKOY3ZyMJnThChj091wvcq
 /S5Z6hRk52m877pF4nB6wm7nqx47tOyVAToJEJ3iC/2UKMI0C73UHfJdNY2NotxS3BPyBf9MKBe
 TakqdXWA8doyUfAfAix/i3COH5djasHZWKeUTEvELSDd/UgiUYReFtCX70SagTrPcKf9YEzBt4K
 MKXw14HyMk2klDnDL7ZByXpPcXbZgfskDH3XROn/98J7/8L7Z16UY2cMddWipDjF+dqtzRtrtR1
 363600YFRKn0x+ctCJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270096

From: Farhan Ali <alifm@linux.ibm.com>

The airq_iv_create() can return NULL on failure, but the return value was
never checked. If it fails, zdev->aibv will be NULL and fail when
dereferenced in kvm_zpci_set_airq(). Add a NULL check and free the
previously allocated AISB bit and zdev->aisb on failure.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 36eb30953bb5..1eb127fc9f89 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -317,6 +317,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    AIRQ_IV_GUESTVEC,
 				    phys_to_virt(fib->fmt0.aibv));
 
+	if (!zdev->aibv) {
+		rc = -ENOMEM;
+		goto free_aisb;
+	}
+
 	spin_lock_irq(&aift->gait_lock);
 	gaite = aift->gait + zdev->aisb;
 
@@ -353,6 +358,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	rc = kvm_zpci_set_airq(zdev);
 	return rc;
 
+free_aisb:
+	airq_iv_free_bit(aift->sbv, zdev->aisb);
+	zdev->aisb = 0;
 unlock:
 	if (pcount > 0)
 		unaccount_mem(zdev->kzdev, pcount);
-- 
2.53.0

