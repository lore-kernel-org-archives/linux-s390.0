Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CC346E40;
	Mon, 13 Jul 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963567; cv=none; b=HDyzZGb5yuX7EGGrmc5cJaw8KtnOX/eOZkv+bLZheJrOP69Lc/BBkAm0C/ACl1cJFJaiaH0G2WwrIS/+dgfYsJ0gp4aGF4aBhPv99kumSrzGBtsQqYA6QWsH3iZzrPO7ak8VDC5km8IfQSh3IT3G3h04iCJy734ivyKjUu+WMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963567; c=relaxed/simple;
	bh=Exaf+DLstzGfAYuQAFhmIjaX+0FNKdzp14kRsZmoOQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQgzCH7QnuvhiBvI5+apbBwSgYwZIgF6QSAno6n+xImQgMusEZBMGFYWRoqJPnkE9UXKRU9O2Gu2pBuYlvwZ6LJ98gMY7FoFMddZ/o2ba0Z3VpugeAiuuK8TLSyfujXNIckShd4psYtoSEyF3IWi5zFnw0agncG/F53u7ML5aDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s/Wu0KlD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s/Wu0KlD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEP5q2770694;
	Mon, 13 Jul 2026 17:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xMT1MgcTxHsL0ar8P
	ZF+6cC+u8S4ve3Eyg5SGRElG38=; b=s/Wu0KlDGR8HEu+Zlz3xL25uU2bnbWF9J
	VRdUkXrXkIWMRgEuUtSUJmjr14sqb+Sq6cEe9eFcPyNXviKxfGOub11wFTrNvKvU
	ukOClt7Tio6mLTaZIqvNBIVT2cWxZysMCHV8Q4LFR9LJeQXm7KhDjTLOqObIdkp5
	ZsMYkLAFm3w2K2eljRQNY5VfWdRJro8hEThkzRSZF43OyBwSq3+JPr83pTqWqZg2
	NkZy4rdyXfwQqXTT98EWrqNAQQ2civfv3YsqUcF91tIT348g/H4gQH17g5Tg52S5
	qIJECDflU6Wq2jShLTmHHnnHE1h7TWSAqvue86EOcD2IKtRrxWi/A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwhjgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DHJcNh016539;
	Mon, 13 Jul 2026 17:26:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxxhth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DHQ3WF21168648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 17:26:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E60245805E;
	Mon, 13 Jul 2026 17:26:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D45A5805F;
	Mon, 13 Jul 2026 17:26:02 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.24])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 17:26:02 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com
Subject: [PATCH v1 1/5] KVM: s390: pci: Fix refcount leak in memory accounting functions
Date: Mon, 13 Jul 2026 10:25:56 -0700
Message-ID: <20260713172600.1284-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713172600.1284-1-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0oXW_xZKOV05omybnikgWhZYYzwtgjXX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfXx/eAsNckJtow
 oFLzhxZRACNYnnMrCt+XmL0KFjf5MSEd/lfqzJNJB6PsDGpjIakiySJtYyqvT8A/xXDmEBtcbPr
 /wwMWUDaigqL9ieVyNKqzzloFsBk6A5Ra5p44N5jgb4RhKS8srv5SZFyJRIogrZpvYU++g//2Qs
 /Bri5GO8xzhn0hqd9oWka3htLD6r/R5bMT9dwHtWdGyZ4Q2Ko/k5ltJr/vKJEHGfOjM6GsJ+0fD
 kCvwPuMcrlN5hTtpPSzPUUgmYxV+zzXrtd+WHyO8oJsr+C6NYuyD5/1tA9wKnwuPVhQuKcVBNrL
 QcDMzoBY3HZ3VSFO0t4atODPtpRA+6R7OKyIBrs4w8MJ65vrymwe/KffZNlhWSAjuPQ48oyweEq
 hXPoJuaNCXx/NZnTvUw9/WuNzEwtU8HsyxdfqPFZJSRaKzBbe6mZTF5cRIqdEG8GdB3y3VbkeIJ
 bNoR65Yql98/sg6340g==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a551fac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=D-MSj2RqzxEEtpeRmKsA:9
X-Proofpoint-ORIG-GUID: 0oXW_xZKOV05omybnikgWhZYYzwtgjXX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfX97JHaF4DJ5A2
 UFfRzIFXK4k3/vdFUFBuXPm9nTna6ZOtMSBUE5fLPqC4dhfhauOsnU7rJ7ybQR4OpS1koJhunzT
 tiaIzJiIm8L/WU2MzgPum0zziseQ2EI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130178

The account_mem() and unaccount_mem() functions call get_uid() which
increments the reference count of struct user_struct on every invocation.
But we don't decrement the count by calling free_uid().
Fix this by calling the free_uid() appropriately.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 720bb58cabe2..5bbbb1de4b5a 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -198,25 +198,32 @@ static inline void unaccount_mem(unsigned long nr_pages)
 		atomic_long_sub(nr_pages, &user->locked_vm);
 	if (current->mm)
 		atomic64_sub(nr_pages, &current->mm->pinned_vm);
+
+	free_uid(user);
 }
 
 static inline int account_mem(unsigned long nr_pages)
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
 
 	atomic64_add(nr_pages, &current->mm->pinned_vm);
 
-	return 0;
+out:
+	free_uid(user);
+	return rc;
 }
 
 static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
-- 
2.43.0

