Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA43DF000;
	Mon,  4 May 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908047; cv=none; b=Y/wXtd/q9EOCfjMcLuE/GlibUstbU56OqifDKMwliIGQyV7rhnDzJhgiR9FIlP43c39RWgsranyogPqzkLEAn1F1+YlpX41y6WzDRUKhD51tuJCBWNN8auKcs55OnlSLBRXeyXWUe4DNZqudZ43G/z10y9qYIZi6puG/yZ4cqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908047; c=relaxed/simple;
	bh=OaLyzt0z4MYJcFRiuWkVyFRYEcwIkrIgKDXxgA02pXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTs/a6mIdL01J72IwpdbdhZxk5VAYmVu4tVsiOml2YP9G9kUJNJJXsTVoRFJlCC3ITqWj2PKKh8ypDIYBUN8Oi4GfV365aLveS2k2f8DgFx6aW+YTx8mJdAkA/alCmubNDVfbgLPzuVOxOy5COfQrZbrVbooXtGtC30x/P5YtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gm0cRher; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gm0cRher"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644Eb0lx3486157;
	Mon, 4 May 2026 15:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kBlv2jEN0snGKD/0O
	IcQrr2UZosnUrR0vfRzwGLrI5M=; b=Gm0cRheromYOxgeE3hYH0DUOeFKPJA9y+
	uRccU8gQT/fxGppY+kfeATRclWh6zkmTquUDlezI15UhTm3P/Ka4RomzbXcRB+U1
	gJCj5pJ92JIO+eHgVsYmGO1V5Qgkd6RAZtVI0JbsAnyTsyYDwNRSP9n2HM0F0B5S
	ae9aJUCFOP7Y4wgFKDkHqvNoFbBCy1iRHHFvVGCM+nATiTbvQsVNX7WvciG4fj7P
	5KQYT14EnfSvkllDF1M82+KkeKQGhd3+e1TtX1wk5lGLB+QO0TLzm37eyYXHhrKH
	MR7bl4UzgYSPMcE4Oc0JJANpR2qHec0n3HhPDVUFMAeDuuaxGyq7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxfej4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:20:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EsSJA016769;
	Mon, 4 May 2026 15:20:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjnnyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:20:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644FKfKs15663664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 15:20:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3823D58068;
	Mon,  4 May 2026 15:20:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB6D58054;
	Mon,  4 May 2026 15:20:38 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 15:20:38 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
        Junrui Luo <moonafterrain@outlook.com>,
        Yuhao Jiang <danisjiang@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: pci: Fix aisb calculation
Date: Mon,  4 May 2026 17:20:26 +0200
Message-ID: <20260504152026.587578-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504152026.587578-1-borntraeger@linux.ibm.com>
References: <20260504152026.587578-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NCBTYWx0ZWRfX+wtXD5odKvNS
 bq6Kn1AiOJLOKis2WoLsbud1S3rr5BUAdXvATJGisEFPEqrTwu4NfMPpHQGTvVvyKKARZYwpgca
 cVp9EnTjB6ttVpdu99Sl5FL90XP3F7lR9gBezQl+q+f1cmSvQ9o8yg6cEhCA+XWe2trdw7xD/53
 mBZGwkpCtP8PoEI6Ks3BpOf1MN8M5sM974D2De7aEEHH5UbynxnDA4ENsrH7yNFa3OZQocqGnyO
 LPJY6R8a1g1hS7FodFhBqwWBe/Mq38kd8XlZAjCWK/7JU78AA0mPBcDrd5w7acSW821Hyg+gL3E
 LLCVe4d24RrlkKbHvAcg8haCvY6FYxCXzd2Uqqe1vymjArhDisRRI9fi6dihBf5oByQkMA7VpBB
 xmCVuJh9nWwPQSkT9CuY4ugqevHbmmHTGzZzSQmZ4CzWUQTWsNBo1UTgEcxkgM0UdQas84nUQKQ
 Cf0GREPdbfSJK0LZaYQ==
X-Proofpoint-ORIG-GUID: LnpbDyedSsPr830P0zWcf7vr0N2B4tDR
X-Proofpoint-GUID: vcESICMrTqZiIRbcoVuVp7L06DphX59Q
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f8b94c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=D0XiIlwIJVH3yKn5C8sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040154

From: Matthew Rosato <mjrosato@linux.ibm.com>

The current implementation of aisb calculation will erroneously index
via an unsigned long * as well as multiply by 8B for every 64-bits in
the offset; only one or the other is required.  This throws off aisb
calculations once the number of devices exceeds 64, and can result
in out-of-bounds access as well as failure to indicate summary bits
associated with those devices in guests.

Fix this by converting to a physical address before applying the
offset, as is already done in arch/s390/pci/pci_irq.c.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index eed45af1a92d..5b075c38998e 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -166,7 +166,7 @@ static int kvm_zpci_set_airq(struct zpci_dev *zdev)
 	fib.fmt0.noi = airq_iv_end(zdev->aibv);
 	fib.fmt0.aibv = virt_to_phys(zdev->aibv->vector);
 	fib.fmt0.aibvo = 0;
-	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
+	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
 	fib.fmt0.aisbo = zdev->aisb & 63;
 	fib.gd = zdev->gisa;
 
@@ -308,7 +308,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 
 	/* Update guest FIB for re-issue */
 	fib->fmt0.aisbo = zdev->aisb & 63;
-	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
+	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
 	fib->fmt0.isc = gisc;
 
 	/* Save some guest fib values in the host for later use */
-- 
2.53.0

