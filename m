Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A7388E49;
	Thu, 16 Jul 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224371; cv=none; b=uhZGRZYTAOcWJ7kEhD5wWYEEdirW1lc8zygvLf9vZMUGsT3WLcE6BsU0QQMa9y+X4qL6ZKroJIvswSu8LTuz7daa9Gk3yC1293Lxk+BIxX0JWA9JENPqFWmonQruzHpg7dpn9BrTOEpNTeSeXtQWDF5qvue0yv+qyZND5I1RxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224371; c=relaxed/simple;
	bh=/FCnwK2bYG5mPZx3iyQYNVlvTbFlLmWpD+OL4/OrUrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH9ObsxIia+ldi4iInPy504HFoQ+ulGrj+mdO2tzOcyfxCdeZqTFcC1oGhm3NaBSm4YlDNB/s5jR7vLR3tIeV8cYQ83gH3S8YHd+hoJGEcCQN4ebOJUYkpixF/iDn0YfZBYjBEVKatt052P/vSd74tcQFa1ImY3t5FcfbRkuAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=asrACzEJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="asrACzEJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGfxWZ3741669;
	Thu, 16 Jul 2026 17:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NpY9tLW+7Lf/n9lqU
	bMid6TKV4aPj2Kx6ri/Ubyi1mY=; b=asrACzEJmXWfZL3rGsEkVtlSBVwkRvEi/
	f9ctR00DsZ8+xEGdogwrOK7lm0y+z3eqn/VShuJcfDS6zF6fOJ32/1syCc/iBxX+
	jaTlc4rOaneG87m4tX0f/y7yeGEjVtpNjH8aVVZDaHaric3IFNx1Y2AIrtci2Jow
	QhqueXnsjx0206y2LsC9Bkr7JnlCVtFgVMAaZvdazmZU/y0yWsOEy1J/f5LKaB4C
	b4+YOQDodFCY+t/7P+NZFZa0DYOekjPI3BCE8gVMWn9d04Lj5lnukUVEuijrj2pa
	/Gvlsjt7+H9w3c2/6ThGFlze/opKhDAAt63cbFOqwQCzhYdG9H4Og==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc1gpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GHnc6P016691;
	Thu, 16 Jul 2026 17:52:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwe995-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GHqjEq30212648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 17:52:45 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8576B58058;
	Thu, 16 Jul 2026 17:52:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B831C5805B;
	Thu, 16 Jul 2026 17:52:44 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.47])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 17:52:44 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v2 2/4] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Thu, 16 Jul 2026 10:52:39 -0700
Message-ID: <20260716175241.1039-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716175241.1039-1-alifm@linux.ibm.com>
References: <20260716175241.1039-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a591a6f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfX4ZyIEIQ6HKNV
 pWkR5hZjpdf6TGzerseC33d24kCzUk8c6/SPpHkTMJT59FP+MKuxNgPSZbvG9QvaEIDZ3HGh26h
 FF2mIsear4th03RzSTWF2ImsiZYjJvGbLI9rCQbZ5uBKZ4rKZMzAumAh2wIQHBIbNdpjmbY6pnY
 69qUXa4R+GrI+qOsqCnw45NnAbdcYsRfqFH2X/Q/BG6F53qKfgjew7ydFvlBcKvblMu6jFBQhUu
 wGmPSfsTdgkhc6GTQJauG+5jDOzKCKf+fwm8z11m+nu50y4H/3I0qQzk/OEcEZsT8JDeni/A6LQ
 uyI6xOtWpRu88Mi5ffcFkY5tHKyMmHPJ9fHj5ZtQFuPMGOe87VjnPaQUDaN92MAVwGoRnpX6P3r
 utlxXqplIIVbD95//FZgL7a0RmimJMX087hRXIwDz2XE35w+GG8J9NRWX90WMhbrTw+vHEGqCIN
 BJM1KlmU6V7lFoa7xOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfXwVGdJwZHoFIu
 5LTSJGmn5I03Ac+Aaxwap9txHIR3DLQ7LMNFfuN48DesTdFmZpkI/44QoZJYqNFfTSgiM0dBzwx
 BV+WmJw4pcIH8vyxyd0PjZk2mmhKWzw=
X-Proofpoint-GUID: bmM21CzXyb53wCuQGsq_W-lJD1wVK4IA
X-Proofpoint-ORIG-GUID: bmM21CzXyb53wCuQGsq_W-lJD1wVK4IA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160181

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

