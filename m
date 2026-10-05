Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5163F47F2F8;
	Mon,  5 Oct 2026 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201812; cv=none; b=cgYalz56f60nXhYo4xqiDsohQ+caVOiV1/lyla8vK9Inu2bAlXKlC8CfUoQBGSy2WsmgsJBt/raY9f03JJT1RsU7it1JGVmNlqgMNclR1YqO/KC5ouCJv0GeiNU8hKqWYz3AvRDITeaxfRQNvD3fM0clVP+GEKs72Ndwznpb8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201812; c=relaxed/simple;
	bh=b5krF2TPzP/GTVeTkQNMxvpy0xRWYuJKFK7tO766g/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4TPsjvi4iZCeZociFJDLcuG5rnPXna7OKzPHVGM0f0V2MN2eK3jSIskTX2qX/9H57SrZQme+t0TAPF31tEGTE+poqYO0bI26YeIx34R0A4Qnp6yZAFg/rgTAi986B2ecVwJmVXMSvMEMhgPLdwXfyn9UgELu/dhJHHzO80Pbdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j4Nzh02j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j4Nzh02j"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZTaJ378930;
	Mon, 5 Oct 2026 12:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s0kVWo
	i7G02hIXwd0CMzOW4/+dZarR8kc/PPm/iOVGk=; b=j4Nzh02j9EJOjIpE61mqcZ
	GxL9v+BuNVINpZ8ZoH8ye8FDv+2RdJ36bJhiFDKsVtXlFxGZkcATELqloYdVTWsp
	CUefr7/MkIjGehqwpISduEQc4iYKP6ETPm4bZOFAGs2+tdJaYA1KAUkFntsF2TCc
	LhJDnGSOfF02XfLNL4VWftRBS0TUtBhFWDdDAdNz8ZRrg++PMUAieP4qxXq3KFRU
	MAopqe/i0mW2xiyahZtJZ4+zKyO1sIiRI8PMiDCzLrwgZUpwD0MJTQGv/PvhivoC
	zu4E2A1VATXifTtIL11fe3wjf4m1qgPsNDHku/6RejJ1MsDbOMDA7WLRhHM0UDVA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jhpqv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695Blbnd2843499;
	Mon, 5 Oct 2026 12:03:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvne5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695C3PH914418238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 12:03:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36DF32004B;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04EA22005A;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Mon, 05 Oct 2026 14:03:18 +0200
Subject: [PATCH v2 3/7] s390/pci: Fix MSI directed-mode teardown IRQ bit
 count
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s390_irq_domain_fixes-v2-3-d45b824874c0@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: B8a8xxPq7C8UG12GPAp409HR3sFM-7tC
X-Proofpoint-GUID: B8a8xxPq7C8UG12GPAp409HR3sFM-7tC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX4d3oNFMJVpZJ
 ZWslloZtQxapm9aD3aOe0fZLACS8nH6UKH3RK5z2GcdOo9Jx9eLpKXKS25AqPOyqU+eUkuJqM7/
 qdK2gQmvsjz/uCVKYvLB2AueFQpaZno=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX7lBHgOO7fS0M
 r3A89ruarKJk31AIinqwtdSlLW2jiLl3kNK48YEiGE9zuPrxEtJET+5JK7QseeWN2k7B+e9vwCG
 2bED8bEHsjb9DI6pymMu0kMs7FVp8tIaGnQRgDD+9o076fP6QbVZIW1GQt+1tTMT3RcFU4QehHy
 IJtiRqHgfeegr6eci1kWxoAspp7YQvKrzi7L6jX/ZNaIEaHch0fZv/RBtuMoOaVRT12C8U8d7b4
 lxAFbcZOFJzXgVNg8RsH9Q/udoZGeYqpYWOR7Y5PC467zILquZE6LSLxjD9meg55KCIq84Iknm+
 fQF1bT/fVWyAzLcIxFil5hqtdWNoUbrO8rPYT/9QBB88BR5rBSo2N7LwoIc8pcqGi5VYS9BoM2c
 RS+C39JLW1F202wbTJgpUNYLf0XYDD0OBVdbFTsfUkDVfZT0j2rxU+Iy5kxuU6c7xDzuSnYdgzf
 sjbO/YLlnL+2cR77MRw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac39211 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HZfvwOHSaoXKuVtsHEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050045

On s390 with directed interrupts enabled, zpci_msi_teardown_directed()
frees the platform's maximum number of MSI bits (zdev->max_msi) instead
of the actual allocated count (zdev->msi_nr_irqs). This corrupts the
shared IRQ bitmap used by all PCI functions, causing lost interrupts and
heap corruption. Fix zpci_msi_teardown_directed() to only free the
actual allocated IRQ bit count.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 134f8f4a5cfa..d5763c5feb09 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -342,7 +342,7 @@ static struct airq_struct zpci_airq = {
 
 static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
 {
-	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
+	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
 	zdev->msi_first_bit = -1U;
 	zdev->msi_nr_irqs = 0;
 }

-- 
2.53.0

