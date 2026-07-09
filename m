Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D9331EDC;
	Thu,  9 Jul 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605253; cv=none; b=n6Yk2jrj2rXLhDSx8p40yNivEWaXcXLu2AU87OahevkhvFtIV2j9Uj7Xddcc9uPOC3zSaSNUzrvEFwp0w9ksuguaEDQ4McEPVQzkKq+9U3Xu+cWUbTrcvUSRqcS5v6s4qe5z+6nTWK110YrAzb8e9Mfgw2YLlqx7X8pnqgE89DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605253; c=relaxed/simple;
	bh=N/FVJoLGchO37FNS19p+JzA0T8fcwmsQE/YKK1R72tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbp809YamQrtrI8ian/7u70VnU5HqA1VMh+nut+6XLp3adC8jC3PovnbSQqyxuTkoLPPRueLxlSVYjykoPDKGItRZ+QyQj8J78Vu/jfvpXe/hwP/kbH7DW7Au0wZJuwzyuSS+DYXUUqvulCWtHjdtwrWgUcVtIvsg6LMZdilFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rmbmNdu3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmbmNdu3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BmnhH2227120;
	Thu, 9 Jul 2026 13:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rGOOVeLA20x0QPPK3WXVNgBbJLjJxEmrpOrL3YTRh
	zs=; b=rmbmNdu3zZjhOsUB1fci3+/jwEvdrPEjtgWpY0ZCnMlHgtymHEMczGQye
	++ONjy6r0Eh3YsoyQNxhjo9YxgDNyKz+Nkexjqdbt7WonJm331ybFBPpyqIDnHFT
	P5ASwMeFurEiCJ9jz5tOXRZQl9+jFcMnle7e6rqdkgi6sbkK+M30PjKrGbE++0Y4
	gF0wGc+TdbP5oXWACpcyyT0NA7RGtfjyjS2/ew0466cXYljQFQFuFvfPz8qjVfqy
	Sz9xUotQygBzc8U7cWgSAyEkyvEOfiJLpjuxCXYw6affEAgFzUbeM1maZuKnIap5
	frdwjh199FL9jwSN3ZjsCHBwxJTXA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknsejg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:54:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669DnbtR009769;
	Thu, 9 Jul 2026 13:54:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hn9f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 13:54:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669Ds69l18547344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 13:54:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C454058045;
	Thu,  9 Jul 2026 13:54:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A9925805F;
	Thu,  9 Jul 2026 13:54:05 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.74.132])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 13:54:05 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, schnelle@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] KVM: s390: pci: Fix handling of AIF enable without AISB
Date: Thu,  9 Jul 2026 09:54:04 -0400
Message-ID: <20260709135404.2255136-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4fa800 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rbFSK_jk36QTBQMObJwA:9
X-Proofpoint-GUID: NhFBMyCD1wyjfu55y7Ayc5Z7iAQwlMmM
X-Proofpoint-ORIG-GUID: NhFBMyCD1wyjfu55y7Ayc5Z7iAQwlMmM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzNiBTYWx0ZWRfX2ByoNDUUmO7J
 aBD8MdU+BxMWMuYdI6yLdhcjuWWwJXc7mDuhgqYGGe92XOQwXxeFX3+P1C+b7MPAbMbS223RKnT
 hi0r6TTqEesjuq7lAKEalDGdyEoJ3/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzNiBTYWx0ZWRfX3i7GFpHGf/OM
 iDSng6t2vsr+obnfjamI0C2ANIwvbPfOWuA75DJ/fFPRaIDPSjrH7fREKpOgbrpsZReCLjCyrEF
 uxjJuRZWDvFMjhJZId2CMlAgRackoutVVSF6n6nYW226e2CVbehO/bEBpTmpRw3HYDqbzWaZ1Y7
 L3PvMBCzurLPN+sd0cA86QArH4Ju7mulNMqXNYM7ix9n3/HU8Y9ao+JSLmSR61EeFvi19n/eN8T
 T2tqtdz7j+DSc/9/AiTzg7MnCxYIHvgJqhxTcISUaudl64+ombI+0O/n//HrRNsjFZI+N5HAwJH
 Xbyrm0igzpEFD+r+cYnmnqdKwNc5zru0q9i7/frDER+ndT31yAbc2udhNDC91nVbeBQsh1WyO0/
 4PYLV5/HH2JIJz4dpaC+rB/Fp+/XT5nFPZ8Ns1+cGBlMU9OC8kWrhqkL390FCrsYd9+8l5i+vhw
 RlgiBCHDY2hP2Y617dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090136

When a guest seeks to register IRQs without a summary bit specified,
ensure that the associated GAITE then stores 0 for the guest AISB
location instead of virt_to_phys(page_address(NULL)).

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 5b075c38998e..dc748cde4703 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -300,9 +300,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 
 	gaite->gisc = fib->fmt0.isc;
 	gaite->count++;
-	gaite->aisbo = fib->fmt0.aisbo;
-	gaite->aisb = virt_to_phys(page_address(aisb_page) + (fib->fmt0.aisb &
-							      ~PAGE_MASK));
+	if (fib->fmt0.sum == 1) {
+		gaite->aisbo = fib->fmt0.aisbo;
+		gaite->aisb = virt_to_phys(page_address(aisb_page) +
+					   (fib->fmt0.aisb & ~PAGE_MASK));
+	} else {
+		gaite->aisbo = 0;
+		gaite->aisb = 0;
+	}
 	aift->kzdev[zdev->aisb] = zdev->kzdev;
 	spin_unlock_irq(&aift->gait_lock);
 
-- 
2.54.0

