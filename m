Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFB3DEFE0;
	Wed,  1 Apr 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065213; cv=none; b=PKir4GNckm7m8pUJ44cvJ+Bm71/rWNrP41gx06SisgrBbH/5X7rPWBEMwzQjbNSJYsUw3oS+Kp4ciGtaBJEXastEsHLGVFrCXYc94KFsx//z6IKjAdsxD+zwRkImCg62le7KUPoA08NXLvOPgi+kCU9N4MUR9/njktza5Ckcwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065213; c=relaxed/simple;
	bh=4bzpiikrqEOg5U6fMhqOPLN+lShirOVWBeTxH4aYvbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojthHFxMny3Z8dko9FmSOlfIV0nclZOYV6g029dzVtgn+tJ4w3JTN8i6YCrviF4OpcDVdm7ONOGvxPrv5gMe5xXlXnnesSi8Y+9mMA3BllpRpBjNNk9FWoU9vbfI652aNiPzzaYdWH2kom0XKnHoe9zjiry8WWrwZnmtUI9GzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D49UhPzp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D49UhPzp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AFS3Q3843131;
	Wed, 1 Apr 2026 17:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ANiYZVSOka3t8+Rdk
	JZAMw4WgJDb2c6+W0sQ9f+lOr0=; b=D49UhPzpsnON2nbEpAjuwBfALXPnDutbR
	SqaAsw7QupcRhJiO8V4bTVcaovR5a+xRa2BEnAmR1xvf54gVGzu40Yvwjy7lipIT
	KxEzESw71ul/jz4OvvgRGggVzpB3t2V06CIEhW8ko8S/lpgHfT7kdHR+QntN66dB
	x5oXph7L90gPEYyEsmGHVJz98TnSHrUDvPlIt/j7S8SgCYYupBdEFG+QVs46aFkP
	G/9xImOTrKDihUZCn3Vy7U2d0bhqKbpvRgn9M7BtuB5qleNq9cmQrMmy1jq3vLh5
	SEJFv70A9ECnwj+Cow1n2HTRK0RmSefBy3q6XVnd2u1kfflQSAn8g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms8my0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631G18VI030995;
	Wed, 1 Apr 2026 17:40:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjxk7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631HdxoF29885090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:39:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4780420040;
	Wed,  1 Apr 2026 17:39:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D9820043;
	Wed,  1 Apr 2026 17:39:58 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.24.224])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 17:39:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 3/5] KVM: s390: Allow 4k granularity for memslots
Date: Wed,  1 Apr 2026 19:39:53 +0200
Message-ID: <20260401173955.314821-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401173955.314821-1-imbrenda@linux.ibm.com>
References: <20260401173955.314821-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd5875 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=oKVxSbr36kwotj49NyIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MiBTYWx0ZWRfX0KgegOcupgtQ
 FoLWFL3WZBi28lgR13dHzyzAVgUHJ8eZ0Y+vIFaCCtb9p8bmG5bAtNETZKd8Hbf5f9fcliCvZgZ
 88NofQ/VZce6Qdph7sHdfOhI6L2iXM6/cfBOBlcWugyuYzK180UQtbhfQiGsYXLuzTj8S9jmCvM
 kOmKZsBDJLlxL452b46XbBLsCZeNxr7bJqpiko6yi30Bm8o510/Wa1Dz+xGzzWYTGhhCRUnxJP1
 iRUgL2sI3o3+BWThJ2t7jjr8HFv2DEW+h2yTnNfdlQR03R3jYiycMcoeeiwqD1DWKX11GP0p0ln
 rUp8hIsII0TTU3YPZ6gG6zPHc3SOT4FmXJJwPhzQ1lc4/fhyslhhUCsX6jzDdY/FO3cLfkAevdW
 Chxt2kTuRfZzL3rCz+1Y1X36TOuHFtnzmCAq/caA7kpcLq4YwK+gUXCXlJoKmtNRPS7jakm7dsy
 58Djeien5YXlZaGniDg==
X-Proofpoint-GUID: H33jeiz8H-5H4ryQX7UshpCFIzusDHHP
X-Proofpoint-ORIG-GUID: H33jeiz8H-5H4ryQX7UshpCFIzusDHHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010162

Until now memslots on s390 needed to have 1M granularity and be 1M
aligned. Since the new gmap code can handle memslots with 4k
granularity and alignment, remove the restrictions.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bc7d6fa66eaf..be2a721e2574 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5636,8 +5636,6 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	gpa_t size;
-
 	if (kvm_is_ucontrol(kvm) && new->id < KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
@@ -5647,20 +5645,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 
 	if (change != KVM_MR_DELETE && change != KVM_MR_FLAGS_ONLY) {
 		/*
-		 * A few sanity checks. We can have memory slots which have to be
-		 * located/ended at a segment boundary (1MB). The memory in userland is
-		 * ok to be fragmented into various different vmas. It is okay to mmap()
-		 * and munmap() stuff in this slot after doing this call at any time
+		 * A few sanity checks. The memory in userland is ok to be
+		 * fragmented into various different vmas. It is okay to mmap()
+		 * and munmap() stuff in this slot after doing this call at any
+		 * time.
 		 */
-
-		if (new->userspace_addr & 0xffffful)
+		if (new->userspace_addr & ~PAGE_MASK)
 			return -EINVAL;
-
-		size = new->npages * PAGE_SIZE;
-		if (size & 0xffffful)
-			return -EINVAL;
-
-		if ((new->base_gfn * PAGE_SIZE) + size > kvm->arch.mem_limit)
+		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
 			return -EINVAL;
 	}
 
-- 
2.53.0

