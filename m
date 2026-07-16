Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4853385D88;
	Thu, 16 Jul 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224370; cv=none; b=XKl3r/sMkPXrwsa1x88wYrzFIQKtTgPLZEOzqJk2kPF/mSXchlb8UgtXzEoKfYkQo47+4lgou12QDc2m0kpFapvo+6yJuDYBZnXmEQnpJ35YQAGq2lMXMHH6EIHtkeYTGBh2TW7FAFuNugZwc9lcFAgTOceg5B+rC3vRJOvrRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224370; c=relaxed/simple;
	bh=JcP9PixSey+zPC7bEDWe+KXuetvt0F7UwdBKq52/3N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdQrRk6BKSRwvPOu05RUIu6sFxpqpQhUfFZi8ij2R7zlTAPGwaDMCQoFgi3+5TKYb3Lr9ljFh0GMAz8d2BNPQ0cEYoCPcNLhT1PJgVnlaaHlcpFej4t+QEcI9hYw/9TnEuUkVq3+yWQcf2mzexlO/YfOQbDVw064kd72XNFpJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tundDbx+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tundDbx+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGflfY3764418;
	Thu, 16 Jul 2026 17:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eyHG4APSlwxaNMQ6I
	3JKLzvWUjUxyohiPkCqHugwBao=; b=tundDbx+fxAKXBxjb9JmgXJM70hy3tgj9
	rtWpL1400ETZDkwfLt/lF/jMhtkevRPrnD4rNmMXvjz7IK+/wXmSeX98HOLCS22e
	0YI8A88dTOYQaxEIkXbCoQ0fzGBiBzavfkqhEa83URVt32HYHofY84ytD+L8Y4uV
	/uzCGhD4e7pyFwa3/AtJEY/+ZN8XS+bpqiFhx42uf8DXZ7IOry3VSvvlU/Tz02XA
	sPWKWG/T7jTpi89/t3DNnMpV3bIFg1WmKfPxcRFrqYP2fkskcKw0R8MCI7kf8uWl
	K4KCf7UoYvpNZmSy7D04yQou1l+I0tHaR3AByKKbjP6uhzrfUO7Kw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtjap9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GHndmi020723;
	Thu, 16 Jul 2026 17:52:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhp2y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GHqiB123331354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 17:52:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ECC358059;
	Thu, 16 Jul 2026 17:52:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B99EB58058;
	Thu, 16 Jul 2026 17:52:43 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.47])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 17:52:43 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v2 1/4] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Thu, 16 Jul 2026 10:52:38 -0700
Message-ID: <20260716175241.1039-2-alifm@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: VIS4naqT6z_nAGpO5FEyrnciMfsAx6JA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfX8O++iRmHzc5m
 qNzzzZE8ve4zmZIA20LVAfna7qWq2RVxj2y2xL1h/Wik+IFgqSSqALd7Sb8kj80vsAInX29DoG8
 v8gpCS/YSEEVAlVFdRa9Y4Oe1UZpfzc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfXzRfQ0I4SL9MH
 onpChLa/ZQKi+J128gvYYKNf8eJWNg9VqrKRfOeFFBuZmOkbxyu6gFsi1mtmGzmo4MhAK1RLzI0
 BO+FJ0qcAbHcH9VcGGfLcnFMEqbYA93DweMcXmkRLLWKAvEK7+udll06scsYllLfMeUy9f6bEHt
 0i1iVw7dN24G0l995VP5eBLMV/qOjuNJiApiNzqMtyhTMQ6m15cbWrF1ilnSvFGESyIQ7JpwRQ7
 qe6Gg0M3znp3KktCohXWbOOJY9JCFJKB7A02DBLwm4iGcUsg+lZPiuVeXkPB1EMKCiACd4/+Fj8
 0Hm6XQa9Yf6Csds+yH50MG4Z8RDwZP0RgUXrcbQHx8uH71pqlsNkIn9CnY1HVfYHYeeghe81BRl
 5NyjO96hpGjtgN6IKIWXFFnd/wYv3YX7FujEZxVHteNyR+E1JCNMxQZrNqsA2Aa9ZT50Nv6bYYo
 oga0lYCbRBsAg3a25eA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a591a6f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=EQJuD_CdQHuXhf-s-5YA:9
X-Proofpoint-GUID: VIS4naqT6z_nAGpO5FEyrnciMfsAx6JA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160181

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

