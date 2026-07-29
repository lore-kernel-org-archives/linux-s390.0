Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEF3AAF6C;
	Wed, 29 Jul 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338992; cv=none; b=nkFiluYyJmtl12lsUe7ES6hEInlk7I1g0W5OVJOtailJQ8Za/F7GKgIdcB//yZoqbTLx/q1jF0goQwy8GlIyyxufSMl5+rZj8rSppm40Wyg5yNHU5v4dM0D01u0/uU5NVwINI8T8CJ+abqZqt3Cfizw1x3e2fIQGqO69aYg2fG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338992; c=relaxed/simple;
	bh=lrLXFoXGkCQqajiFzpvyyVTqja9Wibw9Q7qbE7OIzeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWxv3D1g8VEaHbTjJD0C7QKHXVQvTf6dpNR9qFhFJxTH/LG88V1Czi/L+9I8p4xUoDhhXNK4upFK8yu43BfU63zIWPBTkhGZUOVKtmtJ2CD4Y0tSTkbsPHeRbYxLCg9JIfiTp/FQXlr3pahtzP6xcOWhBpsBj7gJIyT8U/iVEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jw8Jyc6/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jw8Jyc6/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHa2G2684339;
	Wed, 29 Jul 2026 15:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J5ryilsnnfEEjhv+w
	mZlP5DZ1N22K6iGMAkWi7r5uEo=; b=Jw8Jyc6/iC9P9Bza7aYDmjrJK4/lww4JJ
	5txaDxTNuY0ugJTnP4HVt3bc0MBZWuhI9aQwUpBiCKH9eUtIV7oL7tt2SmOB+7+P
	BrtHw0Fy1609/UBhDdnC50BTF7AO9cAKeg6W1MsckXGuTip/P2TMx4fFd43mZxBo
	6ID0cqaOsAQZf8bjhhBZ9IJQ1gMESe5huVJA643EQhOTGPIoTdhahjwQXDHHpDVK
	yLNCugZo1YW+WJITHyQTK3+RvjtQcowIRfriVewC3SHEfDIJM7b/qXNHOJdeyXDM
	TIbifWHA0Rm3OI5PRLUtx1kMA3wyyTCZJF28d+6hrjxqn5K+ZAigw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyckbs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQGIL002188;
	Wed, 29 Jul 2026 15:29:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqff4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTedR30277932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56C5320043;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 332982004B;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 10/13] KVM: s390: Return -EINTR if a signal was pending while faulting-in
Date: Wed, 29 Jul 2026 17:29:35 +0200
Message-ID: <20260729152938.782383-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729152938.782383-1-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NKq6jbSLxqctZNUgvti2CfF44K8vruNT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX0JKFPubkl2oT
 3ZtZlFrzPXcTNbuFS18Mydv6SgvjQMavCl745co7DTQGdQt/sKF0ItijquX/hpAmIw9h2Z7axoO
 1+oDNMD3FP8A3CQTu/rKgO6dwxf3k3sTBYE3nNZK5w44lkQ8uvRBQTVZXUsHGPygA6V10SUoKJf
 o0IPxFLNaEVfx/v2ki2qi7aHyROI2Niqfop2k4I/dw6GcE+B+eUYfkTvtQ7O1WPCM2IHX6l/Y+H
 dWOKdkjcde3RheVNhVbyNvHN/l6ZQC24tgaLi/EMN+4IPzlyJ1VLsi//9ehpDkM4EqreIH6yiDf
 arGeNAhKrhLNNQUAGbGp2BApE34lPCWKhZQBV8f9OfWG0mvYyc4Gthm2yaBszG2rdYMRhCjLw8G
 64J3iB1OJpNsLhSRY6HT57WjnLRi4HvoLDquUxOeMeB8Yn9EWoHFJGXOuZeIM6mdXRycDC21dqo
 2yYJjM4LjOLZrSzVEJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX5RQsKeUTUkdk
 ssXWPMcYPFDSdcbDkKdOA6Sjf5cbULK3LH8TVkAZ8M+3Yalwm3GhD/MaIFEsuUJcv5gFVLCKYbv
 aPZGjGBa1GAWhUNEqsHs07S/Vcu8sTU=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a1c6b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4yawSYOjwzvXb9KGJXwA:9
X-Proofpoint-GUID: NKq6jbSLxqctZNUgvti2CfF44K8vruNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

If a fatal signal is pending while trying to fault-in a page, return
-EINTR instead of -EAGAIN.

Also fix unpack_one() to handle -EINTR properly.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
---
 arch/s390/kvm/faultin.c | 6 +++---
 arch/s390/kvm/pv.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..3cc45f7f5b2d 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -91,9 +91,9 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		/* Access outside memory, addressing exception. */
 		if (is_noslot_pfn(f->pfn))
 			return PGM_ADDRESSING;
-		/* Signal pending: try again. */
-		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
-			return -EAGAIN;
+		/* Fatal signal pending: bail out. */
+		if (is_sigpending_pfn(f->pfn))
+			return -EINTR;
 		/* Check if it's read-only memory; don't try to actually handle that case. */
 		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
 			return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..dc204b521052 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -809,7 +809,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
 			return -EAGAIN;
 	}
 
-	if (ret && ret != -EAGAIN)
+	if (ret && ret != -EAGAIN && ret != -EINTR)
 		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
 			     uvcb.gaddr, *rc, *rrc);
 	return ret;
-- 
2.55.0

