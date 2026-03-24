Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1040B6C0;
	Tue, 24 Mar 2026 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374206; cv=none; b=cpzUuV3Ng85rLvDQQfHcl3JmE8LyZMLHCulUe5eTAIeTjKaeAq/wxr4wlIAFRyVOEizd/Ss3GyxsavOtmKn2Rk/ygEcF8bf8Y2v5XxYYGdLk9m4enAiLkUqDW9eNAfEDxQtY80RVEfxaXDXqZDftr+ybVfO7ohgrfvYZb+r1A0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374206; c=relaxed/simple;
	bh=MF+Zuv+lsaPruI6piauc3ZYmB9fzDQCGBuH85He0KhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snY9gWo/5PKEl33LAUMg/aC+QvYYag15IoQopFIFSjJRdZ9etXsjwy+c3xabYkq72pJawdhlqcrzpDn62fdEuisPjJi6YkKFxWPltZ/WGg06fdycpb3gR5bEjoEGsbQxnTitKAsOQtP0CSs1nBe8Jmh/tNHZOrVPxawmHOvmb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QrSZU7UZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QrSZU7UZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OGjmKt3340564;
	Tue, 24 Mar 2026 17:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nOxwK00xduMxcZUaX
	ts66Eik8r+8wlNhFapP0KVtJco=; b=QrSZU7UZLIkhZj5gMEfaR7bOXbj6bEBwd
	SwZwbiGW/zoO9CZXRsMCPaqOCjY3iuc5rbN05rymMDYKDCscSgHAK2SMXftf6KP4
	hnEUjqY668i+YokWBY7YfqBcsOqdB2Yi1R2rO0zrlwi7S/865D8DTqBWKkhG8UdT
	rFs5JWL6SoHeZxTE1WTaIB8aW1UgDUe/TJw89/+WLKrF7SQ5MVT51v4+fMUOTOVX
	2bO7i2+lLlkP4uxdab4x6jj1cn2Y1+47WiDOO6qLajoI7kapORKh9kaEwMog7IEN
	jQQVCm7M/ShwwhI1V5IYauMaDwzLRIreovi/6G3bQfDxSYeND/BOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky047y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFCnds005969;
	Tue, 24 Mar 2026 17:43:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yk706-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHhFrm36634996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 718CA2004D;
	Tue, 24 Mar 2026 17:43:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3628A20040;
	Tue, 24 Mar 2026 17:43:14 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 9/9] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
Date: Tue, 24 Mar 2026 18:43:01 +0100
Message-ID: <20260324174301.232921-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324174301.232921-1-imbrenda@linux.ibm.com>
References: <20260324174301.232921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfXxX8x8OkN/FAq
 ahJiijR5E1VyKbibd00BX84zaO6dpRqxhqk29939DRJINomceaeAkTFtThHVjezb9whkRuqrjIk
 tMO7aQ/17tRLsHr92QhV1vX47/dmjFpQO2jgNtX5sNRgsB1JHdLclKyy4Xb+BjsvrFnbJo7WGj6
 akrsR4s5viaJPddedNFlELMvvi3geJB7tWkKqNwaFb0rJ63YXof4YPsfqSXEIdYFSoXTi8Ch70r
 kdRrOixFgiSkDPvgTnze7zCkpW1sNzV/CQMj+bk+bcVVLv8RdzC3g2oKOeM6T3kODWUX/NxECUb
 o3+B3+3MuxrWDaBugiWz48hSkGuZfjcDLKv3c+UM1LoOOAcKeYb0lfn/besWWsRpFOnxRDtK4E5
 SSsLRD808u70+ZCZKCO7JQxIuwW3dNwCcxw8qNzmDZl2B+NMtPfLFRLGl/bBMhu7X8j8N/9Ah4b
 P1D9PBAtC1UmvJNptyA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c2cd38 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ikv_JcFPPU8SThzKSe0A:9
X-Proofpoint-ORIG-GUID: wzSVzYxzp_blCfZ8NhEuFTRwc7wNO9Mm
X-Proofpoint-GUID: wzSVzYxzp_blCfZ8NhEuFTRwc7wNO9Mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240134

A previous commit changed the behaviour of the KVM_S390_VCPU_FAULT
ioctl. The current (wrong) implementation will trigger a guest
addressing exception if the requested address lies outside of a
memslot, unless the VM is UCONTROL.

Restore the previous behaviour by open coding the fault-in logic.

Fixes: 3762e905ec2e ("KVM: s390: use __kvm_faultin_pfn()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ebcb0ef8835e..62f04931b54d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5520,9 +5520,21 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 #endif
 	case KVM_S390_VCPU_FAULT: {
-		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = vcpu_dat_fault_handler(vcpu, arg, 0);
-		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+		gpa_t gaddr = arg;
+
+		scoped_guard(srcu, &vcpu->kvm->srcu) {
+			r = vcpu_ucontrol_translate(vcpu, &gaddr);
+			if (r)
+				break;
+
+			r = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(gaddr), false);
+			if (r == PGM_ADDRESSING)
+				r = -EFAULT;
+			if (r <= 0)
+				break;
+			r = -EIO;
+			KVM_BUG_ON(r, vcpu->kvm);
+		}
 		break;
 	}
 	case KVM_ENABLE_CAP:
-- 
2.53.0

