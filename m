Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E83FE66C;
	Wed, 25 Mar 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458803; cv=none; b=pqhk6XwyTTkJM+Zau6uVcy7jj4+QlY6BhBnRi400bIsV5FHlh9aQk3+nZVIw9K70M6y6EUMARm86UdrgkfCZy74lVIcQsRur088lXYnqSV64In8aGlHVM56ZZzjzyw+HjS6hj/bSqSv06rfS+B5KY0xWYMcicdpCavUb1lXXnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458803; c=relaxed/simple;
	bh=MF+Zuv+lsaPruI6piauc3ZYmB9fzDQCGBuH85He0KhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B//lNJ9kxDJ/MqQ06Xjoj5aHlG9iXvJYZNZURXS76MZwZy1BmEKvDpc5p2P/GE37p6FVGg6sYcIg1tDis0gCvsZtrAAI7Ry7uyYwCxuv93hhMZYBlC/WDyPgqIN37a4VgHZRL063HZsQLbx4rntZCqXljbhxElydvjVGItAo2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CXkoC4a+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CXkoC4a+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P8vMWq3893308;
	Wed, 25 Mar 2026 17:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nOxwK00xduMxcZUaX
	ts66Eik8r+8wlNhFapP0KVtJco=; b=CXkoC4a+PBSMGfJ6DQamqEGckxDv63e7v
	a3EXiAZhQelsP81dGoMzEfQx9gzIkVWpwsnnVwm+oHpdGv5FceEDm7VWZfmLdxNl
	OC8tdy37Ac/ltU6u9l+qSbRe+ERtk10Ixl9cu9BjnU/MvG27j4IRm/I1kc2al0zQ
	t8+7qIHpoFfpo+yUdp2cNYjW5flGytsOxa3CjSWbBHx/MZ+DXKf0+sw+ibzxTJk5
	4+tdufn+iKQ/wJKX/OE+CxVQc4FpdmhoZila3MpM657TR/S7wiR7WYa7YbkMJyG9
	9wNtf2lIysH1ip04RuecK2wd00H/znO89q9C1Xfp+7Ex5VZBRvR9A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv0qx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PEnsT9006009;
	Wed, 25 Mar 2026 17:13:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yqjwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDEcv50987416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7188C20040;
	Wed, 25 Mar 2026 17:13:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45FE32004B;
	Wed, 25 Mar 2026 17:13:14 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 10/10] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
Date: Wed, 25 Mar 2026 18:13:11 +0100
Message-ID: <20260325171311.182210-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n7gPk_wM1g3C1dSv6_0oIdlSsr7f7Iqg
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c417af cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ikv_JcFPPU8SThzKSe0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfX92XLFJKhxc82
 EQv9xTta2i2aTRFr96/Nzee94jGC3Nv1zq25Bc4fmzdfyVs9RTs/VxwgxjwZOchPAsN+RnXSRsC
 8QRuYR+cmAfpjUt84zoa/OiF+LV4ppSNKX4DTrlXYdVi87Q0atm3YwjpzdrFo7Vx2+xnK0Xyqlc
 xE2q0ISnwGFZTeyvRBORYkODLOnn0Hipi3eKioAR35ED4wvzRrXre/mU/TynhsHOEOwxaxcSVjF
 Rqr8UMDQ1Y77w3eiqT3UUdNL6zZvRT+ag/HpEWGMxGfHn1PsEp1xIppx8/fzQFuj71vsVVLbHXp
 XQsV5huTqJRLs7/2xOmpuZaGYxRRjNP9ccy6CCt0FGMvfblW6ad+FgmlqKFb4Rel2Rn1bEweDYu
 IXT/P39Zqejt396r8e+u8/G5GvYFphKzOYPEAqh9jVbqas8CeVyJ9giTlxZgcn1xJo5cIcVUyJ9
 B4atdJE5J0+kHmgvQsg==
X-Proofpoint-GUID: n7gPk_wM1g3C1dSv6_0oIdlSsr7f7Iqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

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

