Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDA417BE2;
	Mon, 20 Jul 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570311; cv=none; b=iKPZZ0r6379pROya6pMeQacIWTl9eigt3qqSSIDLqFLoirRL+goZcrO/DSUD2otV3ZG663Rs2DgWXTDXtDRJTZtzAQLBumu7ZuJu67DTxX3cPIxoH0uZ2fkAvCxcQDUN43ytgT6QzRpR7e15cw4Gbgmswk0Woy3CUmrfalCrWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570311; c=relaxed/simple;
	bh=/FCnwK2bYG5mPZx3iyQYNVlvTbFlLmWpD+OL4/OrUrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAbuL7E28c8ujGx5G74ctUW1y2XfFu3xln1J90diTj3Bk62kHAeYJJNQfLNJTpaa9qvOQzpHqdACwiGaVckZ3ArGbOI3i+DGdKxiDi59H/eKs9jvUdwWxc+k22kcylWh2r4SqGY4xsrlRPqF4MOHx2nqiYwEvOqEe6tbSiy8XFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OlZ5ogJw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OlZ5ogJw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBwxP2731470;
	Mon, 20 Jul 2026 17:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NpY9tLW+7Lf/n9lqU
	bMid6TKV4aPj2Kx6ri/Ubyi1mY=; b=OlZ5ogJwG0vT0LaHsC4hryDDiuF9zaZV5
	+gCsercmpFtwZj04kJg3gorPtpdn8+g9b25F5aL9Q/D642AelYJTI5HoVcA/LRQz
	i+5UTO3BXHLky7WKQv9UdDSpRPVdXH+N38zHJzF3WE6HGzABJMx5knMM+Q0Ii0hX
	bgNR15+AXoVxTzgrrvlRqos8VaqIlr6vT84rJpRipy3VoyXaHg2b0/KrTrYpw0ZN
	/dqv4XtBK+GNpfHQTBu5mTljWIL2ToGku94t/YrDj43lVpXPilUTQjQ6IlnkRcZv
	7K25YmsIh6fTNrUJeVt/7YSUz9MhrzC4MKFQZeA7Nd8HMdL6rq8rw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k0jed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHnnBp000379;
	Mon, 20 Jul 2026 17:58:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjpqus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHwNdT33293042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:58:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F6BD5805A;
	Mon, 20 Jul 2026 17:58:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4DFF5805C;
	Mon, 20 Jul 2026 17:58:22 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.89])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:58:22 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v3 2/4] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Mon, 20 Jul 2026 10:58:17 -0700
Message-ID: <20260720175819.1723-3-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5e61c1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfX0vlJyP9CnRzv
 2M/UJU2c5jTltmwhVSHIdHtRT0mmbk+mNz/PmzA7h3C6iGuslPtZ5NtjnmjdXk7Ibk+CoXgjLbN
 Lkkw4AGy8HSQ4P33KRrXt4QFH9+9T4lxSphJS3y/tg4MS0r+nSofPojwOewUuM1kHOGZtR5emC7
 oNUcNoEJ/qyVNz7XSgfxMqP2di13qaV1++7ozJ+gyCfUgkeYUlbQqrLBSpjv1I/TEoY2qlAej4I
 0pEwYFnBRGH2kOjMQxZ7j2LomUz3rqv0JwVFZdQ5YwlSEBmbMW0pwx9JdJrH64/HTuC7cBxDw4O
 +xWcL1I4yjoJFo83hKQ2Pq669x3CnhJtzmTN0OVQKAYQoT9b2uSwLrbeAbVy+WqOL///rOE8CzL
 mTGh1Ef3XkpSEa4s6fsMkI5EcLg0O9a4Zlzhg0lQrqXIHwHsoP/XZlUDpIZHtg+Z9S8q+2omR4k
 saCihepJua2KJzBCRrw==
X-Proofpoint-ORIG-GUID: 4QTGYx1gwrOdfCGsPwI2APOeO1m8gCwM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfX4uk6VPO5oBTN
 xFXYqVCGnKzldYqlsHfFjJ61GoKq5Qy4rpHTQcFyNHI4hcG6xPTCU91fc1PrEssgNmAdUHeEYTB
 td2ElO41OS+iA4pIBiMv5SJ5lTKzBzA=
X-Proofpoint-GUID: 4QTGYx1gwrOdfCGsPwI2APOeO1m8gCwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200194

In kvm_s390_pci_aif_enable() two error paths failed to set error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating error code on
failure and calling unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index dd17f8a7b473..9fdb6e383b18 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -293,14 +293,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(zdev->kzdev, pcount))
+	rc = account_mem(zdev->kzdev, pcount);
+	if (rc)
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
 	mutex_lock(&aift->aift_lock);
 	bit = airq_iv_alloc_bit(aift->sbv);
-	if (bit == -1UL)
+	if (bit == -1UL) {
+		rc = -ENOMEM;
 		goto unlock;
+	}
 	zdev->aisb = bit; /* store the summary bit number */
 	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA |
 				    AIRQ_IV_BITLOCK |
@@ -344,6 +347,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	return rc;
 
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0

