Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C335676A;
	Wed, 12 Aug 2026 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531486; cv=none; b=BuOX7eFHxVXL//wlST/BmVHacVwPLkajisffelUz51lrrCYPbXrG/Croh3+VLowI5ZTct2t19+MUJ1P0UJNQw/OnjiAVf/j4BdLiTGTaBfHltA8LGYwnD5B0S5bBCjHXE2NKBHyN4/hVvlfGvXBo56alllsb/joJX5FN3juYOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531486; c=relaxed/simple;
	bh=RPFC84bG+VxmF/L8qPqo5w6M/ZoHjgplkZrHserCyFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqegMDe7/BeFqY3K8HnmJfRLXBYy9GH9DSGLBg/insBWQDKpg8Khp2oo/wKy/7hRnmYBrwce/MJciHxqNoRpXm/ynDzKmG+zzlLMw1uFzqmO1GvL9ejOU9OluoP30jamjKgm/EMMzgbGuVTFzPJfjqb2kGEiQ2VDYfPoS8Qws0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EeQwjIms; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EeQwjIms"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1Ujp3130342;
	Wed, 12 Aug 2026 10:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bA+snetHaHH1XLlLP
	Kh3fuogEd/JEhmICO2md5+GNpo=; b=EeQwjImshYY8SuYChzbt28p3GA94kHezo
	I4Ik+5ZSnVbF5yvxL72o5W6KWej5gfcVsLv5c2eU8/+UdqTtsSe+h4111mCDme3v
	vUKrWqQXQ5ZqIf9QLqHdqPnv5cpQ+EMj1B49RUvOBl2IPUsVlaYoa6YrpNnwdgGc
	k+BnVgJVq1TX7t2RBShLcJtFgdb82PGA2BJxtOgYNH+gajfFFqlTg7MJ0Ugxp7BX
	TGrasW8hGcGYS3JTtsDYcYTWjY39bJn+E3JZ1vaeiL+JFvfluVFJ35RwarauDj8u
	4gRZR4c5YqpzFOOOkSZsNlBlmtW36RRUonZ0JwdfNcm+OXSFvdcCw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9hy6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfUAx004265;
	Wed, 12 Aug 2026 10:44:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjwkx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAibAq25494192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71D462004B;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E4652004D;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 2/9] KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()
Date: Wed, 12 Aug 2026 12:44:29 +0200
Message-ID: <20260812104436.109741-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104436.109741-1-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uit1xB1UHZ9Hnn6MdZHzbFieEK_9b6St
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c4e9b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HjbLuaNmiay7o59Kxp4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfXyqx4jtYI45Vt
 rR9fsvUmRBpdmjKW2lEqOQumxSLat553e9hfoIoTVSivCUSSyrglHX3s/LH43A53Eh9Up6/7hNV
 7m0lLJNvUKF6SukCBAJ/xc7aFQoGyKl3Dhq2x42vwabvNJlF0C2z9QtBkpHqwKj4xAhDbGo8rTO
 cK4HxDvc192F9ixvXRl+RHKa4SFoNGX1Zn6x4StmqCRpbhQR2YX6ymc6DavElSxrINkYBkQV4M4
 hESXX55ek9R7WO8uZ7kdlScJPvUd39EPqVHFK+f3aOZAYaJjjsWMPmGZOlJKnaz3BGdyRvpYfiL
 1hmfm7VLkKmTWU/E7rfBhEOYFw5u5VqfF4LOuOGOg+6p7kI2oDYc8U5V8bUbVRvNCQ4pR+jqSak
 gkPZnXSMk3oxjpWzoKuIyBSJ5Fo5ByIYQ51Bx1W44HNa6k/cmVgamPiMGPH1KrQ83V/dM+MdZrE
 H+S56e/Yon4eLFgHcog==
X-Proofpoint-ORIG-GUID: uit1xB1UHZ9Hnn6MdZHzbFieEK_9b6St
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX+uBqXkDJcxTD
 AffnHCzVi9xSMrem3IU2AWJXv8DOg3dKp1OpyZXy+/GLL0+wp1MaRRfERh7SnFLBWvut0Z8Cx9h
 6dU0H3Zlxsjm4vwLZI53qYZLFXE5hjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

kvm_arch_vcpu_unlocked_ioctl() is called without further locks held, but
kvm_s390_inject_vcpu(), which is called from there, needs either the
kvm->srcu or the slots lock.

Fix by taking the kvm->srcu in kvm_arch_vcpu_unlocked_ioctl().

Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 518a69c55e85..b35340642c3e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5450,7 +5450,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 
 		if (copy_from_user(&s390irq, argp, sizeof(s390irq)))
 			return -EFAULT;
-		rc = kvm_s390_inject_vcpu(vcpu, &s390irq);
+		scoped_guard(srcu, &vcpu->kvm->srcu)
+			rc = kvm_s390_inject_vcpu(vcpu, &s390irq);
 		break;
 	}
 	case KVM_S390_INTERRUPT: {
@@ -5463,7 +5464,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 			return -EFAULT;
 		if (s390int_to_s390irq(&s390int, &s390irq))
 			return -EINVAL;
-		rc = kvm_s390_inject_vcpu(vcpu, &s390irq);
+		scoped_guard(srcu, &vcpu->kvm->srcu)
+			rc = kvm_s390_inject_vcpu(vcpu, &s390irq);
 		break;
 	}
 	default:
-- 
2.55.0

