Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14755442FD8;
	Mon, 20 Jul 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570312; cv=none; b=b43aZnjj4AwgPSjxt07ASrEBwFTwKxuQ3eU6CS4u+UUdSW5j9RuOf5qFS0D1f3/lf5PNp4FAqW/8nIJhNWhJmTDUCztS7XqeaMJ1F0MKiPaUNVt6PTF5YANex3uSgKgJ3IuK3xagIPJpesycaVvBXr9xkZXGDwP4l/t//wOWxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570312; c=relaxed/simple;
	bh=CcqKWYY7ZsYS5qGMWh/UlpC4JOWFday01Sj2aFj3F7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOKgq+Ki7mLPsgOqJ8rdBZGT1012HCaz0PYLxzqrka15uAQ9GYwYLi3wpoQ+4r+Mdi70UuN1tJAvwbUPJG5tOcfL0QbdmuyHS6gDtI5aoSQDaDzZd2jlTkVZRsd/q2pXLgI80Jhxw8AzTcyWtlVd8xQtA00wpEjSpRVLGC1rrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mDDbDgWw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mDDbDgWw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBjhn2730700;
	Mon, 20 Jul 2026 17:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+h3hHDJBubYDrmeM2
	+O+lmqQ0VlmK2E3XRocYf/CfIg=; b=mDDbDgWw09WDmZR0wqZNL7/+UFZuPERw3
	zFo7kmrCxIPzFWDnJPwAgji5jqr6TF4KkZZ/jXz/TwRwWaBTbB98mhy+BEUlr7C1
	rhhL95JGwFkYdtNQmMPdQGhAZqWKlqDByRufh+VP5YDOs683mu/yA8dVTzhC6lMv
	wrHeMx1a7GcdKXkA9Fd8hP9d5TdGc8rVGutYgiBlC5Ykg3Ie6OtnhGl1gbZ2gvln
	szRrpVRHGFD015m4ELhGZEdU/NkLm+zTxxgKUo8evS3bpo0LeYYkevRD5RSj5Zis
	RKqBnyx/O3+EeXYCYJUpdVTkf6f0CBwynI7fnStstlSK5vibvY1rA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k0jee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHnZtR022754;
	Mon, 20 Jul 2026 17:58:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vxuw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHwO0X28115614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:58:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CC5158062;
	Mon, 20 Jul 2026 17:58:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADCDA58054;
	Mon, 20 Jul 2026 17:58:23 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.89])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:58:23 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v3 3/4] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Mon, 20 Jul 2026 10:58:18 -0700
Message-ID: <20260720175819.1723-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720175819.1723-1-alifm@linux.ibm.com>
References: <20260720175819.1723-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5e61c2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VpFnpj6RERqEfYQjrFkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfXyGmy0gqw/Hcl
 9CXBfmeqIdjRpRmmSyS3F1YjYX+TRAxd0XSrKSnDjDMN/vETAN6s887kOBejuj3Oj/i5Fjw2TNn
 VlO8ZYjCzvkj/osAp/abKNrbj4yfPM1FhJgI+uMfdqjvprbNZThSITL5q0N3N994tzw635vXAkE
 yJLO5Pc0ziaAuEooVhbRauQFbY4xvi01qguGPuV8VMN9F7GgGkv5ovfvqH1dNO1cG5AOWegly2K
 OuYzbajGd7ftKZxmZxeAB4FonbFK7IFTKmHEFTXU246PkeKF+gpburmAthxOUHc+RLQgbbXT7IA
 /w7fbxPgk/p72csmm4wnXKSVe2eA/2xrtVU7oPiqFHvKcvVZwns2Ol88adNKAdWgTDQyRK5BAkW
 5dDxm6MD8sVSaF77rIyQQBft8MBHreda+bydmH63ZmSOljcvLoLcX8NqfsQutQRJGD4EG2uVdGv
 R7vKBPEiw3DloEbmUrw==
X-Proofpoint-ORIG-GUID: tY15_weEHjhuGitt1WrIdB25arv6NknL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfX94/hi7uTj36l
 Ftk8FQcS4E+SUWYDCVK6Jk3F+WaD05l8OGMc9QxW1Weukg6oGYCycorWz0wN9r4PSoetocbFxyF
 a3gu+9XXC48qRClZy54MhaaojVUvZ/g=
X-Proofpoint-GUID: tY15_weEHjhuGitt1WrIdB25arv6NknL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200194

The airq_iv_create() can return NULL on failure, but the return value was
never checked. If it fails, zdev->aibv will be NULL and fail when
derefenced in kvm_zpci_set_airq(). Add a NULL check and free the previously
allocated AISB bit and zdev->aisb on failure.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 9fdb6e383b18..85f4fb5d36b3 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -310,6 +310,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    AIRQ_IV_GUESTVEC,
 				    phys_to_virt(fib->fmt0.aibv));
 
+	if (!zdev->aibv) {
+		rc = -ENOMEM;
+		goto free_aisb;
+	}
+
 	spin_lock_irq(&aift->gait_lock);
 	gaite = aift->gait + zdev->aisb;
 
@@ -346,6 +351,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	rc = kvm_zpci_set_airq(zdev);
 	return rc;
 
+free_aisb:
+	airq_iv_free_bit(aift->sbv, zdev->aisb);
+	zdev->aisb = 0;
 unlock:
 	if (pcount > 0)
 		unaccount_mem(zdev->kzdev, pcount);
-- 
2.43.0

