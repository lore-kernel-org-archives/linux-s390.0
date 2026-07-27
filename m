Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A63F23C9;
	Mon, 27 Jul 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146075; cv=none; b=rmZ7ZQLILuNMDDtmN8MOdkl9wd2legqKK4/cbjXYboSyXa3cvtF3nf7NOM/6zfUSZtvGaIVMMojyxde9bWEoa4V1hrVZ8Ocz9BNJvsK3tiksnqlqDb78Jogm6TTvQ/SIouJErbOCzDUiqhB8u+fSe5KK8v/Am9Vw8WQifSy12TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146075; c=relaxed/simple;
	bh=Ouk4VKLB9G477C1yRwRfDK1R7Ll6mG8gC4wbvkc+QFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfM675Dt0Yb2hV/5+vVcHRAmBVmcOOaIXFCeEi+wmLwPzXPYtOG61SXYa4OGNrRgmQxHBkxbNZn8prkA0YwTiumbdOMP6AkVp6HqP3R17bX0bkAOJmujCPPMeTOcKSC7LqIOGilen5JnmDzKa4cCQCpoOf7avs4h33RmFDqv+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J2SZe4u5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J2SZe4u5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Uhom1855418;
	Mon, 27 Jul 2026 09:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lHk+um5yL0iD506UY
	2TSROtTBcmTygErUdgllR5ZCbg=; b=J2SZe4u5jCS+F/GHCrqNZuWEyYng7ahhr
	eH6+9tyG4dh482oS7To+zofgPu33ASTObsx3KQN6rny2ya+rRbeLkjLkVJviLRy+
	GyiLkaFGF0tTb/97JlOyihxg1TuCwxAbdC4Ev/Lw4HeRNz/kvhvgxUumNTq8ylmf
	nx48MTNmqmsCF4+8xBfc5B9rxJk7l8XYt2VVD6aa/HSqP/0Wn7VdhmjycduawKtu
	qzRe6T51uMKB9MZiCoc1UHqrr8Cc3yKKtYR0B733WV0d1bx6S8YI3jRIXLMHsXGA
	Ty/Lcz4hYUSKX8JNd8O/hapTnT8lr5lr7h9uMpIfTwCQK59yyTpyw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xfbkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9s6W2008498;
	Mon, 27 Jul 2026 09:54:22 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh4s4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9sKj424183520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:54:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9527D58051;
	Mon, 27 Jul 2026 09:54:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D7D45805A;
	Mon, 27 Jul 2026 09:54:17 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:54:17 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [GIT PULL 5/5] KVM: s390: pci: Fix handling of AIF enable without AISB
Date: Mon, 27 Jul 2026 11:53:59 +0200
Message-ID: <20260727095359.107671-6-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727095359.107671-1-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WPg46IE4POPpyrZSXbjXaXS24czTwg-X
X-Proofpoint-ORIG-GUID: WPg46IE4POPpyrZSXbjXaXS24czTwg-X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfXzH5LZ8Pt7WCw
 9EaO9DB8GUeF04Yt5GvuHPAcWRLBu4aQB49bxq66x5dMEsMTX1/JnC3aUVxJtqnfioBqrHEYPmP
 Otcs4X12YihQvDs0jm0vARONzdZOm/E=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a672acf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=rbFSK_jk36QTBQMObJwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfXw8AdvhE5bSbD
 e/FT5jerl7HoQ1ArWa5EKdpWEsWRoN/PvVM2Jezz0RxswKaEvhyY9gFmAKdiSffqIuYJaVD9HYY
 1/SLJEf+zCPi+TsNeAWCMjiAYmSXbqD2kqClEQkKVECcAfaFYP5jLrXbTmI8KOMYUBiWNQKWP7y
 CneHWVYCjdfSacop2dto3e27BC5ynSJFMaPZwthqkFOsomxa0dfZL28bPLvrioxGwCJ+WyR9cof
 YyK2ItjTGfCt7e83ebwlk0IX0cwIej9UJ50lwg81ISYm782dh2t9+lmP0RyZ2jfr2QMWJNm8zzG
 Ev4mG94LxYKl4Yn3JPclljBHhNVQGXSTh5ht5p+a9KiJX3FXDpoALq/BRJJ2mrFOvIbgUIScJ+Q
 o4hA26PuH8FilkYe2GfHSa1UIraNS/fQS9I5vNfKqGG1pGzHvaiNUzmx58sg0/ddiyv6GEHVHkU
 axJLTFW7TITA5yo8PuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270096

From: Matthew Rosato <mjrosato@linux.ibm.com>

When a guest seeks to register IRQs without a summary bit specified,
ensure that the associated GAITE then stores 0 for the guest AISB
location instead of virt_to_phys(page_address(NULL)).

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 686113be05309..720bb58cabe2e 100644
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
2.55.0

