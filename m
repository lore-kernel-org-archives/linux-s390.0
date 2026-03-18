Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76036B07D;
	Wed, 18 Mar 2026 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821190; cv=none; b=Zy8SJsrOtB4KVxa9od/FljoAT5jxI+zfhLBlNPhugb6iCUc33hbW+v1N91XwhC7YxPK5UAXrK1j2Ygj5pyLvOB9TOOWje+DMCG6nMFW9hORJZXQ8kadK/LF6B0bIBxiQ75XH4MSW2WG/Xn0Jut6GxUWOpJ/ui77p00hL8LBeGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821190; c=relaxed/simple;
	bh=Mvmjc7e12P1BvR34uE/Sf8busuYAppWbrZubKfk1/e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pt6EZhuWNZ9jFIf975XlbR3ifNJhZTSXvo5Tqu/G7EOLf6ZkoooixMlxmKzSQNQ5DydSdE2yQHN9hBzuqCDIxD/viLQdYToaZUmvvpTuajRv/ou1/ZUbRbgm978rMdFkbVYVsObwusGVwdwysbcmFdy6CIgYcM3YGPVHczSgBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nwy1IPvT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nwy1IPvT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HK5JhK1189532;
	Wed, 18 Mar 2026 08:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VQC78xVxiVxSvPC63
	c+yJKO/B/6voVykdITU7DfHR1s=; b=Nwy1IPvTGiOEPqHlZiOxqi9wxS0PUuJdS
	LQlzFxXtCy2mlI0HJlpIaiwDGkDVzTlsXvi6KbsvblthwXnPCPdKZDP2uiHBr/cU
	hfaWIWf3QHrjQglKvjG/0IJD1DLYJlSl+f9fcFzedO0bTKKXpRpiqdTuVgj1DDKd
	x9N5nnrK2xdhW6c9WpoSBNKn6mwWcSJS9QVNuRe/50sIpgSJud1isOvRLP5dgvU9
	zug/kPAlc3USvEpr1S+bkXLsHy/1mMgBY7M/66/h7M5XHbGfGzA7nQ0v7tN+VQvu
	ZVDn+FtFtbAmDVLXDsw72iHfS7pmxNmlK5Ng8KGBw+c0Oq1GaKJ6g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfk4dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I6Msim028501;
	Wed, 18 Mar 2026 08:06:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1ctx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I86LV628181130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:06:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2BCE58064;
	Wed, 18 Mar 2026 08:06:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C884058058;
	Wed, 18 Mar 2026 08:06:19 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ibm.com.com (unknown [9.111.93.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:06:19 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [GIT PULL 5/6] KVM: s390: log machine checks more aggressively
Date: Wed, 18 Mar 2026 09:06:05 +0100
Message-ID: <20260318080606.2450514-6-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318080606.2450514-1-borntraeger@de.ibm.com>
References: <20260318080606.2450514-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: koskq15mrnZr-n7KOeuGZ1aVF19Bjzq5
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69ba5d00 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=AY7VfyBuPtHfJwy2xJcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfXwi8NecfRXMnA
 9yuAZRGCl+tVHQSKA93Cl5H2ZP7lks8C+R7jGKQ0KjJ2Dmvr7sEA/DKowgGtTkO/p4RDq5EgmYR
 besSt+NNJ+J/vBOYGYEWwEu5QO9ZN0WPiL1E1wL9rY+1xMDzWmZ2cxELMUDLYfjAtwjkW22J0el
 o4QCFm2NrMxpUTbWk6eh0QG7JGXOjS+ptvgG5JftIcCUIsxykytr8C1f+NraAwsY68Kre7NWIgQ
 6TUN8MiQ8OtV6Xprx+46hUd/RD6DdQQqhhHAsd03HGnKTGXShYcP0/dGXKu4gRGBO5KYF6rJqJ5
 zbJvAwAip3Z8loc3H+aQVSQ6VSXwGqpSEQ2Bxxpo/4kh0jPmgaBLe/5jh1Mx3rsOuq/a/wW1scR
 UmB/iyV8T42AHE/axC6Gly66klrg1xG+u8hk7QbozQlltKc+CWkG69y4vA+XQLZTyh7EBIV5fAA
 XD9bvSJF1S32xjiYv0A==
X-Proofpoint-GUID: koskq15mrnZr-n7KOeuGZ1aVF19Bjzq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180064

From: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM will reinject machine checks that happen during guest activity.
From a host perspective this machine check is no longer visible
and even for the guest, the guest might decide to only kill a
userspace program or even ignore the machine check.
As this can be a disruptive event nevertheless, we should log this
not only in the VM debug event (that gets lost after guest shutdown)
but also on the global KVM event as well as syslog.
Consolidate the logging and log with loglevel 2 and higher.

Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 6 ++++++
 arch/s390/kvm/kvm-s390.c  | 1 -
 arch/s390/kvm/vsie.c      | 1 -
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1a702e8ef574c..7cb8ce833b625 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2827,6 +2827,12 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 	int rc;
 
 	mci.val = mcck_info->mcic;
+
+	/* log machine checks being reinjected on all debugs */
+	VCPU_EVENT(vcpu, 2, "guest machine check %lx", mci.val);
+	KVM_EVENT(2, "guest machine check %lx", mci.val);
+	pr_info("guest machine check pid %d: %lx", current->pid, mci.val);
+
 	if (mci.sr)
 		cr14 |= CR14_RECOVERY_SUBMASK;
 	if (mci.dg)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bc7d6fa66eafd..1668580008c6d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4634,7 +4634,6 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	vcpu->run->s.regs.gprs[15] = vcpu->arch.sie_block->gg15;
 
 	if (exit_reason == -EINTR) {
-		VCPU_EVENT(vcpu, 3, "%s", "machine check");
 		sie_page = container_of(vcpu->arch.sie_block,
 					struct sie_page, sie_block);
 		mcck_info = &sie_page->mcck_info;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d249b10044eb7..c0d36afd4023f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1179,7 +1179,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
 	kvm_vcpu_srcu_read_lock(vcpu);
 
 	if (rc == -EINTR) {
-		VCPU_EVENT(vcpu, 3, "%s", "machine check");
 		kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
 		return 0;
 	}
-- 
2.53.0

