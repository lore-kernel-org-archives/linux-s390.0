Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596903D0917;
	Fri, 20 Mar 2026 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023353; cv=none; b=HFoHFHioJJmRbRAClkQLWgKfogsZiU4g+e7dpfOYfV3eWzfeSjYKmzVtzr0CvP2LJLzFQGVkiXCzT0Cee5k+pHsW+vusi4nwZVAn7YuYLZA5SPxuBc3Ck5S9zmW8dchJe1/72rUXdNd0/Q2+Sq/DVlQwVOc1lBGB1+2y2jAyfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023353; c=relaxed/simple;
	bh=oKevwYpwXMrZRYg4Pdrx3uqixoRKv51pq42iXR6tQSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diMoZs28ATEIHFjueUHRL1TCHY7hC9R+f6i6kKvUxdNWDWGNc+D+uS5Xa3PgUzL5c4BDDOCpJ3f8UNUzo45+gvKf37g6O2/RD1azSUiIW20+3QTCfJA6kEuCJhZcH9/BDbyQ29Ws3zrhDqOEnEbZGSU5hCK84VmkRfIJy6EzhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WX/s5to8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WX/s5to8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K2U3Zx1088018;
	Fri, 20 Mar 2026 16:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IMNzU0+TfITo7bc9Q
	mi5EqrZOSEBfRPTeQQ2TUQBmr8=; b=WX/s5to8iVSOKXsSKtvHTofuHH/Mt3J6k
	QeKp8StPOLFYESgB4vTOOp3+YQqHebEczlrJ9EeNsQ1lljJ+gJl80guxA3udbzQw
	UA4HXsPm768u1i/Mmljk840Mv9N/TZ9M9rOaJ8JRPMS5Pqc9XoxVumBA8chBsJE5
	bfO6AdyaFhBY50gdhdfCfdjjx29N/kd1SsPdqQe+sbhxig6WN6eNmRO8WqKDgdL2
	cTyy63P+elJhNrZ85oCDDf2cQcHCcV4CwTWHbE26PsI4I1S85A+GoZ3du8bR+1Ot
	vMlpuGlTwJ7qimCFtGcyfcQhmr6i5Sh2ttzsGHbUrNXjqh19SxKYg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauuf90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KG5sep005412;
	Fri, 20 Mar 2026 16:15:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sr0dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFhO321889294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE5D420040;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA06A20043;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 8/8] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
Date: Fri, 20 Mar 2026 17:15:42 +0100
Message-ID: <20260320161542.202913-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320161542.202913-1-imbrenda@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfX0Y1j6Ph8qt9Y
 6101hwb+hfUJOj7oTrvJ9y4jVNQvWf/povoD/aXmTC8TrePHV5H4QvxcIMbgYa9ynt+g8URHsUm
 davNAeTAzqvS17yHvop7+MM9vm+uSC3T0UFQgU/yR5e0m+H7jHy8b6Jiwp0bTvKBCBO86XOjkYx
 KVJpYUSUnwJDbKlMr/8wz3EPfOTaDWr/5OyX7EO5iBmiERZ26N/XT4SQ+nb2zzZQJ9j5zfkLvL7
 a3OiIeHvu1nEx/lu5ZBp+ECMsvNUdALaeBWyFtmnf08MJb8H/MPQCDcnHg8lFa3kfQxaxYBUeaG
 mPbfI/h1t0r/ISWSajfJybEFmYc8BVt/Sn4xz0Y9rLX8uGf0g1kSuIQ+C+UH0pUasqWIeot/0Jd
 OsctelBhfwy27jpRMhyy4eEFyHX+702rMfiBb9UOLCvmRcLvaoc23vFOtgsK4j0srJ5gP45t2FR
 egkq118Pl4LlbO4YV2g==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bd72b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ikv_JcFPPU8SThzKSe0A:9
X-Proofpoint-ORIG-GUID: Gy2g5eZ-hBlNROdCOEUo7FLuY66evMHI
X-Proofpoint-GUID: Gy2g5eZ-hBlNROdCOEUo7FLuY66evMHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200130

A previous commit changed the behaviour of the KVM_S390_VCPU_FAULT
ioctl. The current (wrong) implementation will trigger a guest
addressing exception if the requested address lies outside of a
memslot, unless the VM is UCONTROL.

Restore the previous behaviour by open coding the fault-in logic.

Fixes: 3762e905ec2e ("KVM: s390: use __kvm_faultin_pfn()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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

