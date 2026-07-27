Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BB3EF64F;
	Mon, 27 Jul 2026 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146255; cv=none; b=hm8h1dUOaPmEVYdaFyKwOFdZz6uzdVoav7UfhCNSoP0A02UO/xj0eKtlvmLgnJmJ5BLfveqhAAF1P2khjtQHOEZBgBzBY8eapa8+oQmn86KZZ7niV4grCUb+C7WlcwnWgl/yfnueCqRx+R+hR3v6hpFMhyZWncCP9IrxZJzX+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146255; c=relaxed/simple;
	bh=/11wPTde5BbCnkT1aWlPio2uaFte7b/x229bySk1rTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9ZXVWTcxg064049Hjoi65spfpVkiojjFLMgl4xNTo21NrhV7ANTIihMDkDP8XqxxA/g2Uq5vO0BHHs+s+oTe5gnVX2oyhs2VU04yJGoETbogHeMBJBbkUgySLW28640Br+eWJ1dEGBTFYw8xX1J4Wmnqxc0hXn5r59dF4rH7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZvM/XZ6l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZvM/XZ6l"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Ucs14154290;
	Mon, 27 Jul 2026 09:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HjKUfPjc9Kv3Y3sg5
	O3zS3nB3yhjToFiCoTD8L0/0co=; b=ZvM/XZ6l96Mo+pLpZZRXkz3vl0N7mFHYY
	X0cnF/Emu+n04iQwPi4qn/2yEIiCOusM4ZWR2l+kSjlOdTBpmisxmZupI5t1LGDY
	wTMDsLgpo0U4MUgTjyriaQNdPImIUOmR6712Br4glyCGjuKFCshXhPFVUYtgHC/w
	sE9swZZVmyBa+OVU6Bb8TetLoh5ZTJzMQwbjj5IZlv1AdkNbKabtDOxM/2BLDDnK
	E6jFbvfGtDxl9jyeN24XNnfRojIiAm/a9eQMHMCy8dozh3p+jCO5qW9k4KssH8Xe
	JUZp6kcl0peoYblifFJZZoy8LsRuCZcOEfo9Au8uIyDo8idvMBJ1w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc7bh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9uPY1011410;
	Mon, 27 Jul 2026 09:57:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvvyb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9vS3n000894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:57:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D746658051;
	Mon, 27 Jul 2026 09:57:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CDDA5805A;
	Mon, 27 Jul 2026 09:57:26 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:57:26 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [GIT PULL 2/7] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Mon, 27 Jul 2026 11:57:15 +0200
Message-ID: <20260727095720.9150-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727095720.9150-1-borntraeger@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HPMVlcVfiiIU1fRjIWR8fy7SNplh2h9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX2MtGOtcIEEjX
 Rtm8uJvNEdyTTYK6LMuSaICRPVQK1ZSn6P9Wh9sEPj3dq2QdEK6CTaJzTP03BPF0kBFZWVBRytn
 75wLEwhxv8FrWBQib33LoEQSJjj71ltSsVH8CgZGYBjzHXKvKqwHG1H/S0WAKL3v7uL/+OV0K5o
 DpFPMBptUrrEcbMKD48QyM6duXtFJ+UlvQzAsz0j85BALk1ew0FYHOCyUu0otpegvca5koon4t4
 K+tPiX5zRVs9jo/FNy/JR00zRmNElWXYKrPwZw0eSoyvYG6mAHcemTfKRCfeejcL039THm+tzLo
 g64F/liIlZyqgUuna7r3SwjV7CdKMjlQ8RZ+zHpddCXAVFTJf7ndubRIyTKLtoBS+mDCwaFeo2l
 wQIhu/X3LlVIJrBVtmvobB3aiMd/x0v5+MNJhazKJ1JFAy46pl21RCPmERk0Gus9z1oLTflLXxB
 kZ3E59zI2M6DCoc9g7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX8h4JuSgpDXwU
 tOKRFLRVOtGgchECain5fH+J3j+69yxV90VuM59MJHouuf0f3zSdQMf4CTdFetz8vmD30t6pHRT
 dD8jcy+bCC85KZELGZJrivp/Q3Szhmg=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a672b8b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=JEwYuTun2GxKFk6TasMA:9
X-Proofpoint-GUID: HPMVlcVfiiIU1fRjIWR8fy7SNplh2h9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270096

From: Farhan Ali <alifm@linux.ibm.com>

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
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
[borntraeger@linux.ibm.com: Fixed whitespace]
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 43 ++++++++++++++++++++++++++++++++-----------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index d2a11cdf6941..0741aed442bc 100644
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
+			rc = -ENOMEM;
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
2.53.0

