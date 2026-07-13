Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317A33F590;
	Mon, 13 Jul 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955353; cv=none; b=cqpryCbsG3ub4b3UQsKjZSDMLP81sy6IUSqH2wX+EWcs3g5NG7LhzsK4WYzX9zgZlRifHc0TdRSlwMduwHpdDjxpbxAIPr7N9sjfRVnn/cLRpC/5Z9D3QTWfQYtw+4E0YUBrwXQegKYl0zNPVFo80dryPKjvQf1pPIqy2aeqCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955353; c=relaxed/simple;
	bh=65A5PGuki8z2dmhNTLY3DM1uBGLWqw5X8PjSu3Lzu+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAcxrzt51dF+ubPvUwWmQ/SqveR6tFPcnjGfb/e8OSnOt6Lz+NrLPHTtcdTfOK5+Hzt/QxRx38KrEPvNQ/piifaIJ1iG7b4u6CKRitzofyeIJfjfv/CKl+Q+U2nHeORBYDx4+QEar4Pxz8lbMp8tGGVE8ADOdKQiHwuWMyR8FA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N+lZ/ZvH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N+lZ/ZvH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCD8ZZ554991;
	Mon, 13 Jul 2026 15:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KAIEwT30IDabpHLUY
	HkdE7JL5TmpVX+5znlhOoE7lt4=; b=N+lZ/ZvHvrpfpX59lOdGcdy58PgqC0Xqt
	dtAdBsgbBKgvsVy9odPt24P40EsBQNqXIjxfD5fYLDL4XXH0CnaYK0NpfDLUL+Wp
	IXLqh1RvQkapyz4KeYt1GploDYiJ6NKu8BLKcpkCRGw+R/ZCAtBkqjmKSL4h6dVm
	Nu5z+qCk8X4aNV0Psne8r2KPLDAxSbcvXm+aT+Jxe6QBmrRXIcb+eNvLmkcChGq4
	XIoo7pqxRb+7v6TtYXXgDlYRD+m5WHgDzynPr50pgiu7jQWcXRfYSuF+/h7J77Ny
	hClMkj2eYTRsVpGu8gUzOZh8Xh9ADDZPFQATWguzTJVoLOtqQn2XQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv331v00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DF4vES016896;
	Mon, 13 Jul 2026 15:09:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg610w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DF93sq21954938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:09:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8376F20040;
	Mon, 13 Jul 2026 15:09:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9911820043;
	Mon, 13 Jul 2026 15:09:02 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:09:02 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 5/7] KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
Date: Mon, 13 Jul 2026 17:08:55 +0200
Message-ID: <20260713150857.269954-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713150857.269954-1-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfXz01MWZbWZtIG
 jlDchO0b5MK9QWsvkgSL1sQhEwMGA5SM4/jxkg+sOrVFnKQvW3hXA3TBGbdQzNmHZjN8nRVXYUO
 Jo4TNQjgpa/9Yv1Og82Sr9Lqs7f1xsA=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54ff96 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=QmTE1Q1btZTQ1f_0pJkA:9
X-Proofpoint-GUID: Eu8vq2TaDOAXgGAP-S6g_sZAGKdbkzIS
X-Proofpoint-ORIG-GUID: Eu8vq2TaDOAXgGAP-S6g_sZAGKdbkzIS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX1NSAX94dDNiX
 Qd21miLO+n6kagsRP6tBJubOEoD/1vQOKMPBY+kOpwE3gH+CnygbCaYo/stRclq3SR61IoJSCxi
 YQ9ICKOifTvg4OCegByjW+EpJVYUtbOPRSabSGFlfliADWMX3YU3K4x+crtdTBs1JfDzrwV66mt
 Qtbo9QxI70P8WfR55p/fjE7Pe4hgi4LXHRiLBVrvIDKFC0go/C6V/i3FDTHSyjPkIOIMnK2c8or
 QM5qHkTupis6ZL/nVGcqWdEoaZNbon5Y+mJ+YS4uUHPcGPw/sep3bL0dKJb98wsnIgwfC63fzYy
 HP4ZQ0hHyw7Mmhx0TL5mRRosbrjSFpLqA5lx3YP5UzUaF+/iJzeusiRz5v7EKjPAeQhz6fKCYjh
 dYBVG36YwVMDgKRgMeVQVqopo8L30SlXWw+hicKjpwryGu39PLwAZz5YbAEqHZovm9jr71zQgr2
 SBJonVw6ivPX8X6KZRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

Fix by adding the missing lock.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5c2408fc5a8c..fc0a884d7f54 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3866,7 +3866,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 out_ucontrol_uninit:
 	if (kvm_is_ucontrol(vcpu->kvm)) {
-		gmap_remove_child(vcpu->arch.gmap);
+		scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock)
+			gmap_remove_child(vcpu->arch.gmap);
 		vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
 	}
 out_free_sie_block:
-- 
2.55.0

