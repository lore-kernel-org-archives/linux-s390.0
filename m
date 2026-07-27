Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C03EEAD3;
	Mon, 27 Jul 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146071; cv=none; b=B4hjxTFNYRGV6/s6BzwRe/Fi+ktQKdygQaVb/J+zUUo+2uYsun1OGeXPVWoEWEWhXGYOm3WsrYSLICeUVXbEGpNcJVeEaHhKZlK8Uj8Svr2EHwPWD4i4ZATMR9WuKtKH4A4ODiyXgj92S20mpIFer0aRwHsjdxykOUdGITaIjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146071; c=relaxed/simple;
	bh=9DaKLi+WvEV6W0A0YCzDqe0wLvHX6tuvgyPzA6jrZMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUSgkWxT/rIaZp55vvy9fT4fmih4taCgrwgKOpAlwFQuy+omWkds8O5XN47W9dhexPzV12xE++VfYmyfmxXjtGxPxeIxVcQHfM9mX76h6IQrBrVZSGq8onxQ82rGrO+Tvrwy7UPRkF5+nP4GfPTdYYH3M9Fa1LFDaLhIMFwG5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OaVvV9+J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OaVvV9+J"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9UpJR1860187;
	Mon, 27 Jul 2026 09:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FIVQ7IrtufYrmgJ7M
	LxRbiA9DWCoa4n91v+DQVm/0+s=; b=OaVvV9+J2e9ubWS03WMVVzLh5Z8Ue6xr7
	flbtvX+meto7k+tO1VrvdCaIsed3ati9mJAtTZ6j1zqjBgnPtho6ebLhhL5xWcfY
	oUXdljokGK8c9u7ZoKvY07ZO97vYI0cOwg5ZmqTM0U9xx8BpCfN04mB3S7BlbM7l
	oJfCumLpVdqX6VoReqgtdzwK7kSXM0m/+JkiPy/DnBsOxEMfKQfLa+tAs6IY6rMF
	sUsrlKBKiQ9nHNjvf5+zPbSsy9GePBTwqSpgXXNPM5KpejkuqU7wcDvz84mWs3gk
	E2wxXz/D0ixFVsuqlR7lDCAYGleSL0X6f+JvDZ994QHNXez2umvjQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcpymt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9fEkT032300;
	Mon, 27 Jul 2026 09:54:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq50c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9sEsi29754040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:54:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAA865805A;
	Mon, 27 Jul 2026 09:54:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8DF858051;
	Mon, 27 Jul 2026 09:54:10 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:54:10 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [GIT PULL 3/5] KVM: s390: Fix dat_crste_walk_range() early return
Date: Mon, 27 Jul 2026 11:53:57 +0200
Message-ID: <20260727095359.107671-4-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727095359.107671-1-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OaZ880_iD1ajAHKeB9EflcGF3Js8Cmru
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX566q3+ehtgwj
 IUnSNY7pyDvRkfcKUF2jUmM7s37g5jSUsFFAfUZS0TmCZ47FYPc1Khg87f1t/wdqSyH0uZubXhb
 zTg+SlKDuyl7cLmVnTQYxXGgkkPsTr0=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a672ac7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=rMBDsGxj1jqsR9YKdtkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX6gkggeYz6GSj
 5zuz7I29YJl/JmcwdV8yGos+nSK5upY5jEkPpU+4fvStAHm8iduiHMu8tcbDgYCbDG2SSX4AQJX
 8tPj04cfK8AawFlggKGpl1iliTAmqI5nG5jiDGVaQ3uxbnBcGfH0beeiTFJGWr9uOsEhZ5GS632
 2TOOw/tN1p1pJYfImgjt09wU9WcDZj4+NxbxACqtanpWexjAfd5/+u8v/MlSDpqodE7DoxJOMmQ
 ekHdyd1rvfgrLaWuswcYyERhyvzFJxaVjfaB+rn4afl2J4i3do9EMS+8RKa6hsFMwjijt5BC+Oz
 x1/7CjCiAKtXX7Ycxz4iKx3bpCWGClWKVO6CuGjRmaJDIdHqXN2e2/SEcHq0CHDRcjEL2WmPsLy
 RSyfEkcJHeWRCCBCLMYbZvTCGbUHGjHUCjfOOlyzn8BB4KWCPVLTPvzB0dJyaD+rjCQZf+ADCGb
 es0EH9CBDcJff9wFVdA==
X-Proofpoint-GUID: OaZ880_iD1ajAHKeB9EflcGF3Js8Cmru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270096

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

If a walk entry handler for a lower level returns a value,
dat_crste_walk_range() will not return immediately, but instead loop
again and move to the next entry.

This means that some entries are potentially skipped, and early return
is ignored. Skipped entries might lead to all kinds of issues, given
that the caller expects them to not be skipped. Early return is often
used to interrupt a walk when a rescheduling is needed; if it is
ignored it can lead to stalls.

Fix by breaking from the loop immediately if the walk to a lower level
returned non-zero.

Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 5f1960ec982d0..ed4259d176295 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -570,6 +570,8 @@ static long dat_crste_walk_range(gfn_t start, gfn_t end, struct crst_table *tabl
 			else if (walk->ops->pte_entry)
 				rc = dat_pte_walk_range(max(start, cur), min(end, next),
 							dereference_pmd(crste.pmd), walk);
+			if (rc)
+				break;
 		}
 	}
 	return rc;
-- 
2.55.0

