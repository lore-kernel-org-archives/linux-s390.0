Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64343ECBF1;
	Tue,  2 Jun 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410249; cv=none; b=pv+4mCINAWd8Z0ZBs+Yih+Pxrri1zsJdQ69exbG9hEX3GzSu67ik6hW8ACi2AmsRiNgvmgWK3Bc/tf6gyl3R5USYMWyjHB/3tVT74qtQEH+TAKZMrXFJNzw5CgarO0PTAX6vqPBTJWuHhVcCwZgJC+ATYIjz7+o2MKrm/8HHR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410249; c=relaxed/simple;
	bh=qluj3bUF8QXR+D6ZflcYNjuSjTryJaNLsOy7TGOlz40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvhQ2Awaecsga0rDv1zp75hy9hAhd767Rb/jn+A82DcyV6RaMWehmlUVHQMEeH8LQLcQHPCL3IzjejR5NPt5opJotHzt3sFD3ShHk3hwiEoBn4PHyuDJ5EsCyALyQXJVczSA8h6FBXoMtTc6Ej6wQL8WqqlaPQgNBeZTSmfydGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hKwrWWUr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hKwrWWUr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6523SL3S1502206;
	Tue, 2 Jun 2026 14:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IE7I1BsQ0hsaDh9I2
	YwFkyN3gn6mJlOwx0AUHKHfLSY=; b=hKwrWWUrQmeYs3LgmVg/vNSLrOjrwrMsa
	VblNOJNazLRREIVuFaWsNYP2bhrluunmuFiRt7StiaEqgkAnazp1VVzcfncMfN0z
	6G7DkKh0Gq6M7KgzmTDBaYaS2CbGv7nX+tW5o5Nl+YTdXVK5i3LnwOBZ4P+ECyn+
	HUYLH5g4iGaKKhTeRhmKRwRRuPX27EknETBO1UIVyXivfHd8Bj6Le9Cr4gL6qi3N
	zna9+L0nT1KlwSd56IVElgW8uvMWRjx2IDFNDueeOGqDajXVrHSHvkTVLDDgFtvJ
	LRoUoYhxAAV0/zNIuitzakjQn+wLuxXMDRZVhbLaKE/lGndmEYXsA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahp4gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652E9DRS026870;
	Tue, 2 Jun 2026 14:24:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvur44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENwK136962782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11FAB20040;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD5C320043;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 06/10] KVM: s390: Fix fault-in code
Date: Tue,  2 Jun 2026 16:23:52 +0200
Message-ID: <20260602142356.169458-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602142356.169458-1-imbrenda@linux.ibm.com>
References: <20260602142356.169458-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfX2YqNUfnaRNzx
 2rVIHiiXKSSTtS6u89CAN2mJNUc6lyIO3hnCjNwD/brJzpSQJNj76fDAAkppJDbMjGVzJ/RyDR7
 v6TGLO3hE66e52/cdBWMG9/AUzeRRzxyMDcMYw15JwyP0jN7GP5fM4VwVnZSDqobnS6ZJyu4M3S
 uumDmuBjr8Qp2Vbs2CSG/ei1/IFSNo4eHBljzRxhn4FOwg7BlE87trNe2Xw5bPhM5EXafFSMhYd
 jVPeZXm2CNwOCzglqvAyCkQdkt0fKnoikSJtjXKkleF9v2qgRytP5jy1OZiwh6TxiEzM9O2kQ/G
 aTGZYAr5ZMtXTiBR1MISXVmUtJOE5scUfsd4eD9IbrNCTfDa7Bh53Yek5/DYQzpoeFPA1MOmOfo
 xo7UtHoXqmq+E10lBBMwagf63h96aXb+5DEsniA+s51eenD6UXsWbfKqKP7Po3Mf2eEGWjTpu8v
 FTJF49S85m2Jw9MbQ2A==
X-Proofpoint-ORIG-GUID: P4CICLaDc6PaQ1QXcOy285jue3-xdZh_
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ee784 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=p5SjDoQbJD9XZwj20uYA:9
X-Proofpoint-GUID: P4CICLaDc6PaQ1QXcOy285jue3-xdZh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136

Fix the fault-in code so that it does not return success if a
concurrent unmap event invalidated the fault-in process between the
best-effort lockless check and the proper check with lock.

The new behaviour is to retry, like the best-effort lockless check
already did.

This prevents the fault-in handler from returning success without
having actually faulted in the requested page.

Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/faultin.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index ddf0ca71f374..cf542b0a7e8e 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -36,7 +36,8 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 	struct kvm_s390_mmu_cache *mc = NULL;
 	struct kvm_memory_slot *slot;
 	unsigned long inv_seq;
-	int foll, rc = 0;
+	int rc = -EAGAIN;
+	int foll;
 
 	foll = f->write_attempt ? FOLL_WRITE : 0;
 	foll |= f->attempt_pfault ? FOLL_NOWAIT : 0;
@@ -53,7 +54,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			return 0;
 	}
 
-	while (1) {
+	while (rc == -EAGAIN) {
 		f->valid = false;
 		inv_seq = kvm->mmu_invalidate_seq;
 		/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
@@ -110,20 +111,19 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			if (!mmu_invalidate_retry_gfn(kvm, inv_seq, f->gfn)) {
 				f->valid = true;
 				rc = gmap_link(mc, kvm->arch.gmap, f, slot);
-				kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
-				f->page = NULL;
 			}
+			kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
 		}
-		kvm_release_faultin_page(kvm, f->page, true, false);
 
 		if (rc == -ENOMEM) {
 			rc = kvm_s390_mmu_cache_topup(mc);
 			if (rc)
 				return rc;
-		} else if (rc != -EAGAIN) {
-			return rc;
+			rc = -EAGAIN;
 		}
 	}
+
+	return rc;
 }
 
 int kvm_s390_get_guest_page(struct kvm *kvm, struct guest_fault *f, gfn_t gfn, bool w)
-- 
2.54.0

