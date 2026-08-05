Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC7431A55;
	Wed,  5 Aug 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928213; cv=none; b=hdiHNsdeJjMWFIpzGGqjR6hOM+WaGmd+GvDH+wUwzwZyYMKsUMWuJCDEk6OqxEl+nWUEAhy3oiUC9iycPND9tfmAfPtLyqQ9DrEWbogZ3MKG/kXwguY7WSSEc2LnMsPe3pq3WBasSU3HjD6w+1pFINLe3dnfxIquvdHRflZNbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928213; c=relaxed/simple;
	bh=Fsd6pWJXABO6VAiKRB+/D+bbmaxu7PLXBORZzKJcCds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovY5vj0H8R/gCUOsUQ3517Q1yBPZa24R5A2gJVnwse5x8nB+72N3FmKutBFnvhiSVlkBOt9LaCnpkhuMR3U/qV5XTMn4uthOywpjNcpCBzIUTelGUPUUq8AWf8PagOymu32Ff6nZMnwO6lEfPPOt3mZ+0s6bPQYqMECheuLvohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ekz1aRhV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ekz1aRhV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758ln5M3354759;
	Wed, 5 Aug 2026 11:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=37PIucMykZIUAuoBl
	It+eGGnJJfdjthIGvjI5Ob5uD8=; b=ekz1aRhVr8AeQ6FPrnGPHYUQtsJKwfTK1
	BYOIPZmQSDv04in+bVq3OQvR36L/ucmPkalkIp32NYfuVN9teVt/SSUVTqLobMg5
	MpQiCqjEaQpOsjgDz6RvIiTJUSyJnJfAqieJ97S1gF94puBbRilDqDrRAZfi34ea
	2nNUJHEDpfkFxjyvlx1x9mKQ9KB0/zqxVySyl7WDXSNDaS3nqY4hDM5hR163YHHn
	Mb7IuoLYXacBHndAbRzE4sBgyGmX8v3zDEr84gvAqtfBLgP6KKf6GzaU0guXfOd7
	cAhsW0OqZhsakTQO8DLoCsVPStlzZ0rz5MtJHbSFGj1/gj7hLmHFQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42p2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:10:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfU7p006268;
	Wed, 5 Aug 2026 11:10:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k67cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:10:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BA72831785658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:10:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD1C558230;
	Wed,  5 Aug 2026 11:05:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B88455821B;
	Wed,  5 Aug 2026 11:05:09 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:05:09 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH v3 6/8] KVM: s390: Take srcu when importing watchpoint data
Date: Wed,  5 Aug 2026 13:04:53 +0200
Message-ID: <20260805110455.7200-7-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805110455.7200-1-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731a12 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HjbLuaNmiay7o59Kxp4A:9
X-Proofpoint-ORIG-GUID: y2Fo_iu1A8a0qmivnmSHmNHTk5aTiazL
X-Proofpoint-GUID: y2Fo_iu1A8a0qmivnmSHmNHTk5aTiazL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX3o7iqwmoKTK0
 HAgJNY++LMmaVrWo5jocvKFFaFujB5aTbFBQycWm7s1G8uewMm6tMWqiJ3nud1Z1942bxjY8l0G
 bZuQArVwCttaLOHfS/SdOa9rIw+PVgg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX+pwXa6SKl0jE
 n52CMuM8UYrynzOeUx+x8KGhLO8QLKao9Yc71OQMSk6/tTh2e9UwJJzqq3iVdnPlRp8Zw1umnMp
 ngvt17CK8SGg8UPMhhe5R6xj3OhtzObllmwbZjOZRh/IJ/Zbt3yI4PFnOnqfeLC6+KPrdS78Z4z
 d7sMGaSMF/ZGh6ymzTriIbDhzPoiFxnklWY7jeoiP4Mt7j/uBF0v0M39O61yNHl+N3+tGnmCXVx
 8Djm/LStu2dXq/RWBsU6hTdKGtx7pDit9oRlf3ZTHQhxQ4IND2y7m+YG+88lWu+n4vTxlXxdltv
 XxWHLVw8EkVvsjBl2dV21m485m+fhiILPnVn4wTSQnij/vwxyKi/ub8M3fAW5vCRaNbyt84+m+z
 erMwQXd1aPe/roH/NpPWL42oBgxZCR5HmGxrjcAnGVJHi6tch8MbtbunHo4b0lxr2DX7ZWkda+q
 ndbbw9Nf7Zg0rDp79NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

__import_wp_info() backs up the original guest memory contents of a
watchpoint with read_guest_abs(), which is kvm_read_guest() and therefore
resolves the memslot via __kvm_memslots(). That requires kvm->srcu (or
kvm->slots_lock) to be held, otherwise a concurrent memslot update can
free the memslots array under us once its SRCU grace period has elapsed.

As this is not fast path, following lock ordering (mutex first, then
srcu) take the big hammer and hold the srcu for the full import.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c47c3a930db7..e0548926dc49 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4247,8 +4247,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		/* enforce guest PER */
 		kvm_s390_set_cpuflags(vcpu, CPUSTAT_P);
 
-		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
-			rc = kvm_s390_import_bp_data(vcpu, dbg);
+		if (dbg->control & KVM_GUESTDBG_USE_HW_BP) {
+			scoped_guard(srcu, &vcpu->kvm->srcu)
+				rc = kvm_s390_import_bp_data(vcpu, dbg);
+		}
 	} else {
 		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_P);
 		vcpu->arch.guestdbg.last_bp = 0;
-- 
2.53.0

