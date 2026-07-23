Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98947D453;
	Thu, 23 Jul 2026 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831692; cv=none; b=PnYECyJcLifdhLUGzUjFsdfw/TQZCsmnmHnVTBAN81H6B5AL+Nj5uKAJgKTy0NCl4lfFnlaytLXf6jj78I62eTd6ec2ubWF8pytUuDbsaWqP+W8jjQFh0xcjDM8+xaBl3pn1buSQiYbiX1LJat+iRf+7Qo39xqQbP7F95bz6HXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831692; c=relaxed/simple;
	bh=IW1Gni5F3Yk9l9FItdTBHr2nR0rQxqwZ6pRdxOuOvVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbvY4NnNoMSYIqVY0vjw3WrN/u4X8kW6RSAW7cc4IOulEoT/QQb1GgvAdxGDPT6B4kG2BQKCpB9FtQwereyfhVnU6IlP7yUNRicoCAbnUf1t0ceV4ZqpmQjGB9/CkwdKpD5c54e9AqO+K0HaJe6DQ72pFSKhg6V0MYytLjREIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WqRA12Fp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WqRA12Fp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHftV63578992;
	Thu, 23 Jul 2026 18:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8U9/b0+zKyQCz2Cvj
	dULciJQjfyr9Xs5XnEx+6RVNvo=; b=WqRA12FptRjp4bXHEmcrIXcf6ESUcOSJI
	0csV3NpEhXA3dlP3epZfxVEBff+ZbXlFb1hviIIKAXEQMQa5Fe2ilTYTtpyyJg6+
	eNYd2JteCD+UqBme5Xjptu/EiGYx8ZWw4lI9zck+jCZ98uUdGbd3xcBsK7VTGmr3
	bclX4XePSzmjYHnuro7myl9+bnxNVB9L+uNbn1CnSzEJZbYfcKy3C7yspdzawgr4
	NjRUY7Ha7yfCGbyh2Jj4zK657Ns+ocr31PQPlL7UPobg+DlZUffMoikK9Z+pk3sy
	dJRlr/unTKzjJE7V44GWi04moFyhz1GeMgAjRbIE6L/hgA7XUPb0w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gge31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NIYcSE006663;
	Thu, 23 Jul 2026 18:34:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyn8rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NIYhnm28377664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:34:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4625805F;
	Thu, 23 Jul 2026 18:34:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 944FD58050;
	Thu, 23 Jul 2026 18:34:42 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 18:34:42 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v5 2/6] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Thu, 23 Jul 2026 11:34:36 -0700
Message-ID: <20260723183440.3271-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723183440.3271-1-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfXzVoicTgLydT1
 VNNHGWNk4g0DoPLy3arQK3DWEvSGINHtLNYqXap3q3FSPmrZ5trIASFjUQE18VAbOu1I8wfcJhq
 v3jqda1IboQz95eoFj8Oxemy2DBIjrgcWoIs752sCGNgQF8CH4wvLHQKlZDSKfajc1n5Hyi8zlT
 92AGfA41MS6u7pxEIUyL9R0Zs5cTtZK12xt6LcqW+YDmNTVjGSu/+wp1d0MNFpnED1c/glrAHZq
 Tww6L/StuW9eUAg5bjzbx/DWZ0Ghhqrj8EDjbGo1SvlDXftYQc4Z9R6UR7F0dOEFENuO9ltxpUF
 9vvCaCZnNNekvcxdJwfqPPZSVrW8/XDf6vU2ZlacmXUFpaY4lPaKb2to0YO8QvvqHeAiadvEjGN
 IdJz/KcBUIzJDafGgW71BP1lJWAXBnlWYdyKERsOyr9NYeBgCsDGhM5hsOq+/kC4Jo83rdM+JG4
 SkqUb9NI7iTz8LNHJdQ==
X-Proofpoint-GUID: 5cr7kfRm2kNF3R_uv1OnDO59XvEhvl4J
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a625ec5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=JEwYuTun2GxKFk6TasMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfXxPaPO9s6/loW
 NpccnKKuYDoHZllnQ8jjxr0nXeN5Cmx7hReH+MqAvD5tECvxQbAVnSDq3uhq2ZgfX+wHyH1KX8f
 xsiKlO3IcC9Zf1xxUSPnZ3RcLf7E9ss=
X-Proofpoint-ORIG-GUID: 5cr7kfRm2kNF3R_uv1OnDO59XvEhvl4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230178

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

