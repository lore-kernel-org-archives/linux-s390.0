Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF48286409;
	Thu, 23 Jul 2026 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844856; cv=none; b=WFyVlnu/BHrFR1zjmgVbDaTLzrd/IZD6n9dP3iRkvP7M6Efwj7yryToSdDYKbGPqRibdo3KZFq10Qa6VaHf/94gnkkv2wLXI6Tbfv8+SjO/GwHDq8onyPrv7hwYESy4M5hXrvmBCBWXwztL5QX4ZYHJRLD1D8MwcloJgyp6Elzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844856; c=relaxed/simple;
	bh=fqaThiPNzIVoMXPHGOntizGg/6n2rla544u3IDRVPlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXOLvaf88ZLLe8mi7WsLX+oPdvSdjKDpjuLli8avnikyQ0StHxDf+ebKUtu1S5o0FIlUzRJ/TbUooGOpB+CtDE9l0cDZo1uqCDDUrYubVX8oVMvo++0qwKJn/kcCk6zOYGQaDXpe5qgb7fsV1H4B1/ABuua6IIYAIPMq5E78d5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gq5elxdE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gq5elxdE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLgEe74186885;
	Thu, 23 Jul 2026 22:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=acBVdoIgc8w1e6aH8
	pRq4ijNnTyeMgJjFmYngVNo/eg=; b=Gq5elxdEC+OxDrZLY1/EkeK7dfPiOWr07
	odS1tC+1CX0XxnvGxPe5nkOoERgxkvsNrzuods1RPm6/2HNbsaFCZq5UPoDDQpdW
	3wIpaSujWT/v0S52ZTfeOADUdFdGYcFPxcsOVCMSnkBP+nlsBPlYB3LvUqMZI7Y/
	h07s2WP3rkCRMuCy2rMND+huycy2rSkkFfErXbIfguSr9WIxSO84PhndIiEznHoU
	KOJuqsIN3siM+ieh2jnjLxELBclbntTZQJecJTXTHa1AqDBINjOkAOlDnCDUFm4Q
	OkLbLXtqh65Uubv7r8VgNoDlY/1WJnFk5obGxgHVAXYWiyvQZvxOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abswx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NM4aQL028626;
	Thu, 23 Jul 2026 22:14:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqeexe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NMEBZp28443220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 22:14:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D1DB5805A;
	Thu, 23 Jul 2026 22:14:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 036E358056;
	Thu, 23 Jul 2026 22:14:11 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.245])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 22:14:10 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v6 2/6] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Thu, 23 Jul 2026 15:14:05 -0700
Message-ID: <20260723221409.5874-3-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX0TJbPCbBWm4J
 HcFU6BqFXwus5j+GIPRShg7Gwposembo8mpSoUY3ZPyZCCbi773eZiYelUP0xzqW+2ImuRDyUdJ
 p84PWRx3kVp/t1GeBmR/2q1OWW8YZfVUu0QmTPfpJZM460FAgMRNgeDVBPJCQn3VrnsWrEXKpxv
 +hVG9BqW06W1ZMD33G7cQjlAfbH+/dG4Of0xp4FvEpyDlmIbSvNDugU8kMuoOqgHl9AmiuJQL82
 vJYLjhRuGUj/NR2+acVjn44ItopJ2aFDbdG7OzFv7ioJYimpMwz1CopVk0fCzMUGCAqMU33J0Gp
 FUiXdKnb508QcTzSM6qW1qoFGvzZzdGOVkXufrUwYtekMqhkb8UXpk0NA0xT2egQa4fab1x7h4m
 m9oTLR80jVSyCwNgHzTKjSyWix8AJjE0yzNkti5kJLSO6U6riZ1JK7ByakHX0lxn1wKQWTQGW+/
 vXJeh078BaZH1+NZM1Q==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a629235 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=JEwYuTun2GxKFk6TasMA:9
X-Proofpoint-ORIG-GUID: YBLRGD2fneZq8owNc6XFc5p52x0pckn2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX/Lfc1bPbZa4+
 LiTyMyzpDgMxqx7iU+FdjRO0jWc3PS1wfiQZvDmnIXqJ3piHy+vMEyXiSIdCXaKn45c80uACPMo
 Nxu9oH9anbtfDN2L0+erX9bszUCwX+U=
X-Proofpoint-GUID: YBLRGD2fneZq8owNc6XFc5p52x0pckn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230215

The account_mem() and unaccount_mem() functions call get_uid() which
increments the reference count of struct user_struct on every invocation.
But we don't decrement the count by calling free_uid(). It also
accounted/unaccounted the pages against the current->mm. But its possible
the unaccount_mem() can be called from a different process context than the
one that originally pinned the pages.

Let's fix this by storing the pinning process user_struct and mm_struct
when accounting for pinned pages, and subsequently free these resources
when the pages are unpinned.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 43 ++++++++++++++++++++++++++++++++-----------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index d2a11cdf6941..44c00e5e32c5 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -190,33 +190,54 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zdev)
 	return cc ? -EIO : 0;
 }
 
-static inline void unaccount_mem(unsigned long nr_pages)
+static inline void unaccount_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
 {
-	struct user_struct *user = get_uid(current_user());
+	struct user_struct *user = kzdev->user_account;
+	struct mm_struct *mm_account = kzdev->mm_account;
 
-	if (user)
+	if (user) {
 		atomic_long_sub(nr_pages, &user->locked_vm);
-	if (current->mm)
-		atomic64_sub(nr_pages, &current->mm->pinned_vm);
+		free_uid(user);
+		kzdev->user_account = NULL;
+	}
+
+	if (mm_account) {
+		atomic64_sub(nr_pages, &mm_account->pinned_vm);
+		mmdrop(mm_account);
+		kzdev->mm_account = NULL;
+	}
 }
 
-static inline int account_mem(unsigned long nr_pages)
+static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
 {
 	struct user_struct *user = get_uid(current_user());
 	unsigned long page_limit, cur_pages, new_pages;
+	int rc = 0;
 
 	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
 	cur_pages = atomic_long_read(&user->locked_vm);
 	do {
 		new_pages = cur_pages + nr_pages;
-		if (new_pages > page_limit)
-			return -ENOMEM;
+		if (new_pages > page_limit) {
+			rc =  -ENOMEM;
+			goto out;
+		}
 	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pages));
 
-	atomic64_add(nr_pages, &current->mm->pinned_vm);
+	if (current->mm) {
+		mmgrab(current->mm);
+		atomic64_add(nr_pages, &current->mm->pinned_vm);
+	}
+
+	kzdev->user_account = user;
+	kzdev->mm_account = current->mm;
 
 	return 0;
+
+out:
+	free_uid(user);
+	return rc;
 }
 
 static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
@@ -279,7 +300,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(pcount))
+	if (account_mem(zdev->kzdev, pcount))
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
@@ -400,7 +421,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
 		pcount++;
 	}
 	if (pcount > 0)
-		unaccount_mem(pcount);
+		unaccount_mem(kzdev, pcount);
 out:
 	mutex_unlock(&aift->aift_lock);
 
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
index ff0972dd5e71..fdf8c7bf4ed0 100644
--- a/arch/s390/kvm/pci.h
+++ b/arch/s390/kvm/pci.h
@@ -22,6 +22,8 @@ struct kvm_zdev {
 	struct kvm *kvm;
 	struct zpci_fib fib;
 	struct list_head entry;
+	struct user_struct *user_account;
+	struct mm_struct *mm_account;
 };
 
 struct zpci_gaite {
-- 
2.43.0

