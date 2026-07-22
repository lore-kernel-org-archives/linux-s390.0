Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C29421234;
	Wed, 22 Jul 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739993; cv=none; b=LsLjLIvraA4P/CIQxTqLOuzS/k+PAFbEWOp/92MDwQE1qvKEHP+tU34bb91rSGYt6hSHIOSqAUS3QXlLywk1xNgRTFUPR/BoPfq0fRA1WMQ26TaLeuYqcOyoqGnNTrnCAwX/JOCPX3MyQJ+yXxVk1yeQM+0cPYRADXt7KMOd20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739993; c=relaxed/simple;
	bh=O3gQjb7+aEWm9H6Gzv6JD3X68t4Fnyo4j50qgDY1SiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw13OwAk5PoqnLIcSCbnqFfNsgGOAiLJ1SntuB3Ef80cGclKGjv8JZBE0F0GbBPSxXE4Jf9QV34zAOYxZjJDcmjRGDCwVonvJp6nt6OPoxzPvVWeny1gJRvYd7uJFfOAb3WVAuR1k2k/pn5lazO164JDYrmrUFDJFkzZHbodLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C4NQWbS4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C4NQWbS4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFfeBk374375;
	Wed, 22 Jul 2026 17:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XhTcKlgNG+PrRulNA
	PvlZ2Z8GBD/jvEgSiTuKa+fD9Q=; b=C4NQWbS4Vrks6PETJMpH9Kvstj7UklRh/
	zzEtkVsOEqMjhE/Akp3088r3tw8kbjvRJH0eN6i61iC185lBmTC0zwlZPg1RWby2
	clL4/zmMwPj+0KXxgsFFkFBeom7LX4UN6XdEBvZfleaG1l6lZXhYC016ki/OiRfc
	G7C2/sYKWMiwMP3Pvq+clQfCQMFWk0aS1A6idr/IogRrRvZ1jWv5n98XLhWPgRap
	qjWNYq9Btlv3vNd/ZG5exMRr2TjFe/yf6LlVfXe5aAwUUd8Xl8pKvv3R+HK9gib1
	RUPRua8cE05Xh9ZmPNFJEv6RGnRBS3Iaur5/9Z7otVLuLKCW6uYig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abkdwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MH4cSg031818;
	Wed, 22 Jul 2026 17:06:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyg1cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MH6SU327001518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:06:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D662158053;
	Wed, 22 Jul 2026 17:06:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0723E58043;
	Wed, 22 Jul 2026 17:06:28 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.249])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 17:06:27 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v4 5/6] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Wed, 22 Jul 2026 10:06:20 -0700
Message-ID: <20260722170621.1686-6-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722170621.1686-1-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX8cCgU90rMBml
 rPCcTIp845csAyP+PZ4HGiepsW0YDB1npoTlcaUeFtA+9T8YhDVGSjTaeYQt23Oh37BNU7vt3dR
 LUrY9yA/lgKq4Jxc0pa0pGnbT3lCmRI43l6JOOmHUJVlw9FmBa9sd5eTC3UPPz04qYPngWH0ov8
 B0EXkuHXHGeR5JhUXHSZwtQemG8f6t5RS6VbENtY3zgP++saZkr+xENK3mJrn9i1zn/TIPId57y
 OYKwVMDp3JqAP6qEqs+R9JyQOiZPTLDTrWfZDRQdYGLKBWNwcq6V2ano2Zx/UimhtBM8k8ZSN3U
 ch9qA5LYFE+TYsxr/Kv4Ix0OFgB4oQkmaFHxC5UnBhOepirLihqHgtJ+zbqWZI0yIxkKT9DL25e
 gOVVWS1tV3fab8cjvJn2U193qzaaBFnNSCTJ1GZA7loOADOl1i0uUc9itT0Hol5BjQ8yFhSlNtk
 x8JBzUImQNiEO+NQN6w==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a60f897 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jfJf0X725jgLZ45auVgA:9
X-Proofpoint-ORIG-GUID: sLkqwrvI71FE0nxdettbEkYL8JEpXcIB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX8CCcfiKFH6lk
 +lKhZUo1hFhcX0vs2g9oJCyr1b3tJ3WOCaIHcl/uvHKg70k2mYc8z7bVULJwwrN0vV4N8PJywr4
 dZtDcCjdWvYDGzugafl6lC/Yr+WIuNU=
X-Proofpoint-GUID: sLkqwrvI71FE0nxdettbEkYL8JEpXcIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220164

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 231a4236fc3c..d76b2c5484ac 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -341,19 +341,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	aift->kzdev[zdev->aisb] = zdev->kzdev;
 	spin_unlock_irq(&aift->gait_lock);
 
-	/* Update guest FIB for re-issue */
-	fib->fmt0.aisbo = zdev->aisb & 63;
-	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
-	fib->fmt0.isc = gisc;
-
 	/* Save some guest fib values in the host for later use */
-	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
+	zdev->kzdev->fib.fmt0.isc = gisc;
 	zdev->kzdev->fib.fmt0.aibv = fib->fmt0.aibv;
-	mutex_unlock(&aift->aift_lock);
 
 	/* Issue the clp to setup the irq now */
 	rc = kvm_zpci_set_airq(zdev);
-	return rc;
+	if (!rc) {
+		mutex_unlock(&aift->aift_lock);
+		return rc;
+	}
+
+	/* Start cleanup */
+	zdev->kzdev->fib.fmt0.isc = 0;
+	zdev->kzdev->fib.fmt0.aibv = 0;
+
+	spin_lock_irq(&aift->gait_lock);
+	gaite->count--;
+	gaite->aisb = 0;
+	gaite->gisc = 0;
+	gaite->aisbo = 0;
+	gaite->gisa = 0;
+	aift->kzdev[zdev->aisb] = NULL;
+	spin_unlock_irq(&aift->gait_lock);
+
+	airq_iv_release(zdev->aibv);
+	zdev->aibv = NULL;
 
 free_aisb:
 	airq_iv_free_bit(aift->sbv, zdev->aisb);
-- 
2.43.0

