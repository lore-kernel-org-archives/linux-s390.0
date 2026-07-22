Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C33515DF;
	Wed, 22 Jul 2026 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739990; cv=none; b=ssQr+h/YjJ1t6WOlFE1v3AORnhUm/MsTq+KfhsBdLNl6yFsUYJrfBRzRleHiuB2VmD6jBh0xVPEeMNcGcGmxM5zPs2oF2usGN+SEEqTvsCgwDSUXmMdGgJ+dwsmiYKMBQzkk2Q7RF02dAgl71SJ/OosArE3AVBj9KmvoP6FUxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739990; c=relaxed/simple;
	bh=7+1FYKJHGcD/MypKEHc5lg9sR+DKko4ykPkUeC4Ahnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6Cyx5WQWrtQMEQDePeLOyXOFmOkhZAqu70591v2bqJi/BhrQ/SDh7bOW0ZGzBPvSPSsVEnWxfBDGwNcjTmwrzCcqOZKfHmdAWJM3mBSUxEk3qDsWnmJzYBrNmb7z27mN1e2h8Y2tt/Zeyv1vUyc7BAt1nASSNM/AMA/F7QhoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fy1PdtaF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fy1PdtaF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFfexQ275840;
	Wed, 22 Jul 2026 17:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SmrxrqArObQSWOOsc
	/rFYmYq6uAVUy6w97H5mDDXGNk=; b=Fy1PdtaF4jY+3OF/MwqrwaIEWDAOA6KMx
	MDcRjvK7+lEbZOjp2lMZ4Eulstfgv4OuxfrMb6LmFb2FM7h2SHycicDjVI9pJzXA
	eUysA+tF1IP2n/S6sG0cDRbZvN8I1+N3YAJhU+WkA0CzqQ/G+Px7Fz3uYTpSDiDR
	fmnUGuIidL9Zf1M9lxghYQtb3V3SuW84B2oPoaPQIvKq1nL8tZeSgl25vQtLVAJi
	KO/9wAeYLNS118pvWXuQs4STY0lT9oTSxxE2Zjuby1ovIv4qW+9DZI2GSpMOqdqR
	qmh27s/M+CUAW892+gcNjuPHu2fHkuaZwos8OWry6rCRyMVpf2cmw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gav2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MGndJG012118;
	Wed, 22 Jul 2026 17:06:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq8g4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MH6PMX8979198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:06:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3EDE58059;
	Wed, 22 Jul 2026 17:06:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D419358043;
	Wed, 22 Jul 2026 17:06:24 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.249])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 17:06:24 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v4 2/6] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Wed, 22 Jul 2026 10:06:17 -0700
Message-ID: <20260722170621.1686-3-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX0IqjqaNOqwCR
 l909dxNIsyefqCqrg/2+AQybJBoF5y4mT487v82ZdkD4rUfBb/EctMc5BAfRTW2peUgCFXcXlmt
 y7yKQ8BcudjjaWb0IP7+krKUSc9AaTRJR/ozOeK3hjvcuHeicT/SpHvTo8uLg/hO672j73JEAYy
 ipwvZ/p7z7YLAseRblnme2aUesDkgridK9v5Jhip00soRXEFCQ9UKATVqMZrs39BAh7YX/ocViM
 miYJB9qWgsvhaFcIUAua5BHPQomsPjrzKeWgcNuLAmjC9grJiF9fUEBYJjaOUng0ByvK0Zo9xzh
 Q8AgBHWTl1BVLAXq8SQumj1i6lzF5u4fVik1zoC3vSE8GubeObCwbmuZDuAga/A8rn0/MahRMDC
 22JA9TXozUXkwzNS/dLgx89uwO84L+Y2eNSaGIXDDRDacw9707yA1+pPzUMCFaRu3D1nL4qH4Ni
 nUSULgPpYvUEEwmdgFA==
X-Proofpoint-GUID: aVjV73MfRRw9BttxKkDzx7CfcvS3lxqB
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a60f893 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=EQJuD_CdQHuXhf-s-5YA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX7sZQd7STQOy9
 kPg+8RQdSqpWGEtiTxd14Wluns6LNIq7rfQHxKYBCGrVv79gxD+Yu3Zdi1tkB09M8aZAgQt111m
 KwJQ9sVltfsfNsMTQYb+kZ+oRTLF7vg=
X-Proofpoint-ORIG-GUID: aVjV73MfRRw9BttxKkDzx7CfcvS3lxqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220164

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
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 38 ++++++++++++++++++++++++++++----------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index d2a11cdf6941..1b3114c7cfbb 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -190,33 +190,51 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zdev)
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
 
+	mmgrab(current->mm);
 	atomic64_add(nr_pages, &current->mm->pinned_vm);
+	kzdev->user_account = user;
+	kzdev->mm_account = current->mm;
 
 	return 0;
+
+out:
+	free_uid(user);
+	return rc;
 }
 
 static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
@@ -279,7 +297,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(pcount))
+	if (account_mem(zdev->kzdev, pcount))
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
@@ -400,7 +418,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
 		pcount++;
 	}
 	if (pcount > 0)
-		unaccount_mem(pcount);
+		unaccount_mem(kzdev, pcount);
 out:
 	mutex_unlock(&aift->aift_lock);
 
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
index ff0972dd5e71..544e6aa75e38 100644
--- a/arch/s390/kvm/pci.h
+++ b/arch/s390/kvm/pci.h
@@ -21,6 +21,8 @@ struct kvm_zdev {
 	struct zpci_dev *zdev;
 	struct kvm *kvm;
 	struct zpci_fib fib;
+	struct user_struct *user_account;
+	struct mm_struct *mm_account;
 	struct list_head entry;
 };
 
-- 
2.43.0

