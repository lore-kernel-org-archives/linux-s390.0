Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74833B19C6;
	Mon, 13 Jul 2026 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931437; cv=none; b=s6M3S3dtQvmxfO4BUU3NazKAUUFipJVrmYYzgbvLCUOzi8jj5bPVA4riWCE0kT6zEbDLcNzNzDU8sU/jQjnaB7y/2akoC5qRYTCME0q0C17BNibFQTOEFuYMeB7Fn13n1XmVaXhAnT5wywfXdlJdc+hHV5v3xt+S4xIJZLGXaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931437; c=relaxed/simple;
	bh=Ouk4VKLB9G477C1yRwRfDK1R7Ll6mG8gC4wbvkc+QFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJP84YgsdUc+9SwVyMSfx+hjEEjPssgNVaKciiD8buGH/ClkuZoge5QjT6R+9tEgo4V8zbN/ygt50uHLpRifbG2++dAMdpg4CKyg/+n5V65ThtP0Jx802uXUVDloS6Na3YcdiNDmof+j/Td2pIf9lIOcuH+mVUL7K/7L5IS+h6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NuuyyqAk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NuuyyqAk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fcqm1731404;
	Mon, 13 Jul 2026 08:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lHk+um5yL0iD506UY
	2TSROtTBcmTygErUdgllR5ZCbg=; b=NuuyyqAkrNfnCf6ua43yRyjvqa+BJPoEq
	dOXaeXmpE4Pnk9xPNh2wa6grpQDefqZyYF4q3ocMp86KgczIEFkVzhIEZ4Zq3f5h
	Q9uXDMehDOTE53NNgvX7PBe6Qy+Jr8/9fL2/d93MxGl1BYI42HXSFIOLuT14SF0D
	gsFGnyQnDvYb2xdKx0KmYy/ZVxRBiGDBA0DquAr1zNGb74VG5U0RNnpS9c6Jrl6B
	xE8XeBzlbW04kyL7YBuKiUTT5g9PUDmVQ0iWRtR2eC+a86+9gU5rbmkiN4Mq8O1Y
	T8/bGfGa6ky/XB3FjI7wFqtGQHqTO3YWCuSKVSf196o78rBn2g+hg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbfb7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D8Jbfv021593;
	Mon, 13 Jul 2026 08:30:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvvwh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D8UTG723134746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 08:30:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F27858063;
	Mon, 13 Jul 2026 08:30:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6320358059;
	Mon, 13 Jul 2026 08:30:26 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 08:30:26 +0000 (GMT)
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
        Sven Schnelle <svens@linux.ibm.com>
Subject: [GIT PULL 5/5] KVM: s390: pci: Fix handling of AIF enable without AISB
Date: Mon, 13 Jul 2026 10:30:07 +0200
Message-ID: <20260713083007.65863-6-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713083007.65863-1-borntraeger@de.ibm.com>
References: <20260713083007.65863-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54a227 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=rbFSK_jk36QTBQMObJwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfXyqbCdDYN2Zuw
 YQDx7XJvzDHNRa+djUZRxbjV6Axma2EpAMZtrzhZSA3nXkUad+w/QRbyLD/VdeAKYfgkIkTNQRf
 HGpgsU3MUnjSzl6QLAVYNs8YAM+MuxeROK7SXHU7qOUqZzW4oPL1iSWDVRP3EAu3PoQ6XQZaQB+
 /2nt4ElGwf3FmwxFE52TW2czILbOqM1MV6MULsvYFBnoo4sJUw9xtXvEOIvChPTF4KSeqhnO52v
 5GiHSDdWooEMi1I8nKXLqzRGaDfk774iOpWc4pFTN66aQhneWEXPScKpOkhK4sBZMbIfp496oyR
 nXMd8wNikq5quYMYFXr/eClNy1tX32fr63g0k9VXBm4Qvn5bms+LRP3A6TFv30flSDfMKCJ3HW3
 rs33ZDTqcWZU8jVLw6CaM2akMXCkvlBqKLfPRIrvEtMsf3ZlSLbJ5eRg0F+vzGB8d4++eqHKAs0
 clADBYlBQKVH91HBSvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX/AfmYyd8eUCP
 tmmeraW8Tsf0lk623vztVfhMwduL/hPQSGAe37bSYIBcGBIu6sFHSPRjY9xgK8qEnRkMCMulmtM
 o31Cr36yNRuiAs/a8s+k2LEUupxLonU=
X-Proofpoint-GUID: TIL-Ha_Y0d8h5pHYFpg5DLWrmzbc2rL4
X-Proofpoint-ORIG-GUID: TIL-Ha_Y0d8h5pHYFpg5DLWrmzbc2rL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130084

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

