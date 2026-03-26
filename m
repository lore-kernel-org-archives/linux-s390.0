Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F143F8DF1;
	Thu, 26 Mar 2026 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531064; cv=none; b=eJYrd2QZfPweSaDlZXfgKHECmv00NLMO3Qp3CbSsOzVRgdMH6Q5m5grw08Pd7Eg9LcMOCv7ZP1e0qj4mRUQjLgu8P42+jaAoLYPKQSNej2Z+1H2gXZfmBxGhqK5QHKur/BQ0Olokv+uo4CsoH5eQ82damsiiXJAEQBFU+5LmA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531064; c=relaxed/simple;
	bh=MF+Zuv+lsaPruI6piauc3ZYmB9fzDQCGBuH85He0KhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaqshMxTc7A3AP6jcUDw3moe+EuqN2bcfUh7kebzZCT7tyhY7PuOHn+NSLYQsBx0Q540RMlOHeZ38gfwQnqAEBmRodEDeYeMx60zYWsgFoSiaeFyAGRp1h3L1tXvjbVEslI4jZ6J9DPfElNSvu5/qcyDk8Qw+3YV9xWCzM/VRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKBY/8F2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKBY/8F2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q2NF9b826235;
	Thu, 26 Mar 2026 13:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nOxwK00xduMxcZUaX
	ts66Eik8r+8wlNhFapP0KVtJco=; b=rKBY/8F2fb3PFJqjoAhgItyEAyXFSlzZ+
	wQ2FRgOTVKj+MBh80aeVWB0XmknJyqJPUsa8STAlo3PJXVZw9xubZfMqwhlEU3Sp
	DBYcf6NCbNEzZeWE3zzZxu+ct07x8j2m1KLUAF9UwEaRF6MW0dBZubF529a78Bd/
	Au0g5I7lJZVec+zWg6WAcW0Nqw71lyMl81fBvu5XnQDAgLMkq935a1gc45D5CF7k
	GDxbUG62rz1Y9LK34stJkWXXB5VI1Tx5+HAwmNNd5I9Is+dxT6DkLHyoVAO6iSYa
	EWQsPhTLz4YkH+tt7tpVmcE+mcSux4SQs7+y0YC4i1vyusjHr1QEA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqnd2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QBWYDt026695;
	Thu, 26 Mar 2026 13:17:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m2yx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHZif34341128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BFB020040;
	Thu, 26 Mar 2026 13:17:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E8A2004B;
	Thu, 26 Mar 2026 13:17:34 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:34 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 10/10] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
Date: Thu, 26 Mar 2026 14:17:19 +0100
Message-ID: <20260326131719.98229-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MTp9iHB-EkkrVc2nig7eGgnQuKvOj1lL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfX0hJ3Ge+/mbi/
 epqx5D8RSv0rgNPinleCfzPBH97UGsiF6MJbKyUVhzh6YsytQgBkBLhQgtIFaKVz5qi4DvLBK8D
 EjMVsVP1oiQGbtLmnrc56qGmxjw0N2URzlDtLGeSxyR5Ub2TxLFVI5vgHeqT4CBRGr3MewXtfmm
 qA5HAQIqaOKs7XRWOk706U/bXLSYimal7UjGgoNyOLHXBUy95cYn39j/kZ1ulP3ynU/PbEpVNeY
 9WVPR2iTtlIt68Ay4T1MjfDw90hJGgzwnXH/WoA33jOrZ9VT5fjhnH+CBaBxsT3py8qNaV8UPXM
 ilYOXrcWnTx8LYygMav3GDTdBOIyFBmHORsjvFja8nbqSwUOigOzCedFwmi54gcDYaZqQZWvGhw
 AxkOxBvms5SwEIJ89SUHLGTbnYEen9zz3UdcnfKyRMxYSPLYWNKQc0j2bwXDdEXB3DmJ1hBUBdn
 X8qj18dMCJENOERXN2Q==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c531f4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ikv_JcFPPU8SThzKSe0A:9
X-Proofpoint-GUID: MTp9iHB-EkkrVc2nig7eGgnQuKvOj1lL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260093

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

