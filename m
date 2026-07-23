Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E53F5BE3;
	Thu, 23 Jul 2026 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844857; cv=none; b=sKtAAMRnoaQqUKU+czUzWElHxU76ZpFt4Jj4V+eJx91yLushG/xbmRoY6tQeiXmTEjlYDziuESqxvlBFObddW0FGeHjHzx70fsxsEDbHWh7pe4L0Jobx7YK+tkv5yIwbbhFkdeNJKPWl36sXwXRKp4BnWJ7jLrxz1pF/mk4Ffhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844857; c=relaxed/simple;
	bh=cACEiM6Nq+6I4fyIVQbBsqHVLzW5fcBPUsr1jB3xDMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XI8qTphARy+OZZTEUBkOpnJzuolikkarK1arZxmPbyGYzSESGGMikaHZZPRsMGt6X5LKeI0MsdpAwDXjxyApnxS65julxeoK7hK6bqmVxbW7Xi4WtWRaxauCRQFjw2ja0nw79hOUuUEkQWKi2Y3pQHzhT4U83Lh9jnI4AsC4Mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ANOTZSuS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ANOTZSuS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLfkpd4185855;
	Thu, 23 Jul 2026 22:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UHxpgyzoTI4Km5fw2
	6DQzeQjQssmfWgLtDByRdwuZu8=; b=ANOTZSuSg8jWyHVgO1G5hbReY4Uho8BlE
	7yJZtvegP1bE1s93mBjvfrvmi70hJL2toNc0poVUZfjrXe/Xx+o7pE2Sm/vlxdus
	S6mZmpWjY5Ou73zPGNNO3GRdRpK2nnF1EoZZti/YBdvYqUrxlbsaG6JxGewdVgwI
	jCvsxKe3acuZVHsyjszwBJmwV9wKcwvi+pFQM8uXyC7ppcM4FdNbGc7Tp2dDENdo
	1xUFs4DfPYi3qPO6bQyV0DU/O5+iXW2OpYuXoW+zfTAfe3nUtKkgxZN0Zu7ZYqg0
	bnS6tnBMs96wqMTyNsOUwENO2M9v1nPhIZCdR3HkVxOwi+ajXt2FA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abswx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NM4e25028647;
	Thu, 23 Jul 2026 22:14:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqeexh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NMECEw28705418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 22:14:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A71658052;
	Thu, 23 Jul 2026 22:14:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABFE558056;
	Thu, 23 Jul 2026 22:14:11 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.245])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 22:14:11 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v6 3/6] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Thu, 23 Jul 2026 15:14:06 -0700
Message-ID: <20260723221409.5874-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723221409.5874-1-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX7Lrgt7ffezon
 fE3YYHhaDGrQi2CWlRXB5ONEEFzdlbRGKnmhZYwz1iwRFKO1+48izDYhPYiW/sML/a2dSlX9A0n
 DoZx1V8lfTGgke5Nlvn3zWz6EmKdoYF4LSZExTf95zt9fyjpSdsThJ+Nfg9g4sTjwG9rSeJo0EF
 JE4EKJUoGXwrtPl8Pa2W0wRBXDDeg5AmzMvOyHNwQ/PbMGuSP5QqFWRxqJBT4KO6tU02Vtkd/Al
 4vMoGY/HXxZOVZRGeZrhVgzovvkYXMDf+UD6H5+kql8CWgziz+sMQhE/zplIi/3cbePOo8AcNF/
 4Wyp5hlMhxGm4yeVaWhyyxNFZXhe9BEr6380+0vx2AiJ0EJWupiEAVWpPWu+LkLCyLzAIn84d2q
 pJYkdC0XyfPccLfEBTDVf2Xo2nmWXTkfp10G2KNYaSkD3jX9TZXI4W3WNLglEb5G7KO0m9k+gu3
 LD2ijQag1Zqm2hsz1yg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a629237 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-ORIG-GUID: Aq9t9OFX62_oFt4uez8WgnZULdibkYH5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX4nake/5ANs8w
 0n+U+Y8p9LAJbpy5nmDmPrn2E8qZu3UaOziJWf0pzzV1UjLGWZ43FOljfoDVJ5oNLC4Gfyc+Q2+
 varbZL6mMPi79ewuV+X0O7wLeGCmaAM=
X-Proofpoint-GUID: Aq9t9OFX62_oFt4uez8WgnZULdibkYH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230215

In kvm_s390_pci_aif_enable() two error paths failed to set an error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating an error code on
failure and calling unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 44c00e5e32c5..f58d7ec0bc7e 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -300,14 +300,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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
@@ -351,6 +354,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	return rc;
 
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0

