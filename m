Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C01446060;
	Mon, 20 Jul 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570310; cv=none; b=lrkOh1pmh5V44xOKyzn5uXCLBYcimKz/VLJEDcDRY23fWmInrE9sHFV7E3AhYESy7iinMSrt7au72qEVPusrazofPMkhSr80T10lILABzzJDeJTMotD8vMoEONsZyV2BY7YKCIcinfBRtfoDN6icmgyBOIPzZ33Lr3NwUsvgPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570310; c=relaxed/simple;
	bh=JcP9PixSey+zPC7bEDWe+KXuetvt0F7UwdBKq52/3N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8shieIy3xTtrClDxrkVDbn+BIsiYcJxQQgCEXS8j9Kp4zlngv20FGUVqLtP5RSmu1JMfO1wqYmox/QtURYKxQdmWLawGWyvHeWp0QeEfsh9e5Bx1rIQzAvHovuwi8FzjsmS8NNEz8tBGukWqnvWycueUrWgjBBWTK12uA75Oak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K1fMW5Ws; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K1fMW5Ws"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHCPv72812963;
	Mon, 20 Jul 2026 17:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eyHG4APSlwxaNMQ6I
	3JKLzvWUjUxyohiPkCqHugwBao=; b=K1fMW5WsSDDAYqhf87HrZnhWZSjHZ7R1J
	r00WeEWPwrYWXNE+mVC8+tJRuO9T14/FAmG+SqQDTFjDapWXC5Wshe49RLocNzHD
	99lJn9l51CDKasMYeTUS1+Vrfem+M7KtWDxrXZCyT14vyuTYzwzE5s7fTywPyFNc
	jcExnZ30nGgEN6orqjO0ZhrobjM1mUzfs/h4T31Lpt/Ob0o/PanfEshD9I6Nazfn
	D1BQ9LXsqtFtiZpD55EU2y4twqzKvZgUFqmkwhcy6JuKYXL6QQ9rPsK01aaczI/H
	rZV1XEziIG9C7azah9aA7hFjvumA9nGUN66GFuacM69rQuv8pwlMw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah0hec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHnafv001686;
	Mon, 20 Jul 2026 17:58:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagxpm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHvlgq30540528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:57:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 776335805C;
	Mon, 20 Jul 2026 17:58:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 744DB58054;
	Mon, 20 Jul 2026 17:58:21 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.89])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:58:21 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v3 1/4] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Mon, 20 Jul 2026 10:58:16 -0700
Message-ID: <20260720175819.1723-2-alifm@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Ojz22dkCorOtTf6Yze-AspE1W9yKyDkg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfX04xFo5u2Kfo2
 f5Xj3rVXAqTs8CjwgMqrEATrT6el9ub++aJTC2n/v9lkzuyygrCgAQ9ERNWKkrhVn/Oq1+VKWs/
 l76aMAvRNH6DhZlnJTpmvXeXQUE9YPCF2FtqVCl+7v+Ryba8ORFfD4W2SxNHNCfxF6pfriwO9ap
 8KQ8l3ZOXmal+q+pq1MlSx/j+shjQyp1MMgRXZVjJLiBD4rZ/SO5/TRKJ90i1SYvruMo/a7f1qU
 JHA1trwgnaDho+zwx5mf1F3DTIGjvwYGfFiKmY1hQSRBdoxZfjdTlc4svhnUVIRRjxeXPvmivgn
 kiSz5mqmtGJS33Ajg+NLyONnlWj3k65ThJoUwXg4BetrGstgK9co65zLtEFW0QzlRil2riY4QgS
 JdhQcQgcyllCmHWVEPTdoolR10js/zurMUjJt+4XY3Gx2Mooh8s9saD33PPSpPf8mMdVHS2N1SD
 I+A6cWOH0xVI5oEfvhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfXy3Yde5FWnFyX
 97E1dKPKxcyF9SmwWsINTG5ha0ccwcrmvy6ahi0HAcBhS7UdYMPsUUPpYrkV7RuwG/zdOEGlZxx
 z3sT11Ui4m4vw5h+FFcdeDt1YbmcrEc=
X-Proofpoint-GUID: Ojz22dkCorOtTf6Yze-AspE1W9yKyDkg
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5e61c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EQJuD_CdQHuXhf-s-5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200194

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
index 720bb58cabe2..dd17f8a7b473 100644
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
@@ -275,7 +293,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(pcount))
+	if (account_mem(zdev->kzdev, pcount))
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
@@ -396,7 +414,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
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

