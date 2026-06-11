Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C92F8E8F;
	Thu, 11 Jun 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190088; cv=none; b=Vz7XmhxNFqTnW9ysQeIJW+yXTNbyVN2OF8X4/3HKjO7PQElmZX+vGU6WL/yZPqaXTEoynKJKNfUjQmSBISr4jYV7JEa6ei46faK0XDsc1gjo3DQIe2a7Pm7ZTct50PyGuIU7LoAHeLxHnXcbnwdHzxBkZeor5lQeUSiV0TE8MFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190088; c=relaxed/simple;
	bh=7d/+nkuOMvXJyReZuR4dggqy/Bs8nMGNw1y9Fga7PG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRiT3QhlCDfL3EHycStU7NkrayEYprjg5XQaZuMkuGKaATkwbaK2ycDXOwgU6CvNlvid9cSG4PFdmNKVxBGONEJf4ntN6ht+I9v+uzn7pZYG+7hf/jxT5d1klN13ip8Jb887MJy1j7/HSRjt+CF/NF2H8UEsfnTMAGYc3LyIvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FYauWqfj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FYauWqfj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCAHn11742727;
	Thu, 11 Jun 2026 15:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=leWuU8AmaMGKWM4M7
	mVJwxCyHtJLkhYtAYk4B86+Kyc=; b=FYauWqfj+7CANaK3D+GwL2Y8ji6MFteGy
	wFQ+MIlL17YlLcY4ZhVWPadKhV7z8A1vyXzmBs2GoX8qOKM8xvSa5M/gQ119XiWM
	VCU16tFlac0U8Y4KHaSKhYljTT3eoO15lZLWyjHwi7U1ClmL+NyCPFOXc3IfNcwT
	91NHTDlbn9B1dOVmjxG8yZmZTExgzxHP5O1Lpd4RihhKUeDAdnovfY7Z3BasIZ6/
	81fSlWqpR9LVo9L3JKNiD5WMGTOPgRIewbQITOKro6OdvsAaIgHkdOSzfOy8EYot
	5g9dbrUZqK19U+Ug0DPqNLZnOQ+b6J00UHxNrcfbW5LHv782RONDA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bm8ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BEnbUp019800;
	Thu, 11 Jun 2026 15:01:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09knak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BF1HnC36831516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:01:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AECA20040;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 079C32004B;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 3/5] KVM: s390: vsie: Fix allocation of struct vsie_rmap
Date: Thu, 11 Jun 2026 17:01:14 +0200
Message-ID: <20260611150116.218162-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611150116.218162-1-imbrenda@linux.ibm.com>
References: <20260611150116.218162-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2acdc3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hYSCaGdr6WFvCWo5WKQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX8fahzAIbZdU8
 K3ao5bbw9OgMY0yNJ3Ln17TFq84q28mt4RakbTITCPbfwGuahGI7zLHZ+qTRqdYrYhJNdu9HC8Z
 7+ktJXgxUsjZjG9t5YYgcvfJW0Den3FsRWwkNTao3PFL6fmEg3YD9l4EzW0aN50GPZDwpvtQ+yB
 wuDtGkJ/OBye2MOiL4zuUJt3Fiv6YXsq1YoPLj8lhkJJzPkFr1pq0Q4xpJLVlwWCdPNtKlbw3gr
 DwufBed2dNeW4owadCUiC1cIEXjMI5SBIohfxaUww+eFxfPbMHCNfrB7t2MMEDbe4BAvFp4YF1n
 7DZRrfuPqvVXdzDewirRXmWIPeHo1k2U/gPPVQaQLxMBGa32QPMomu3rrkMjVpSR0YQJjirmUQ3
 sTb/wcDQTwwYUlT6BjnzW2aekMhceL5EKReE12cQyky6o3OAenlZS3LYVnICpptvMjrdi6/VWnL
 ZI2RN9rgUcBWP2P5FcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX8lP/xf88FHi2
 lMLN0n6gmrodgokztYvlX13CuODaz0Qn8Jlwc1WenNDkbheeB/GW3xhCQ+EoZK+EatcJYBBIlZb
 n8kQfbdnG127b2+G8tkim4RFyEc/2EM=
X-Proofpoint-ORIG-GUID: Nxz81xU1rNiz9NnKNeoV1Jh2eoFBX5e1
X-Proofpoint-GUID: Nxz81xU1rNiz9NnKNeoV1Jh2eoFBX5e1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110147

The allocation size for struct vsie_rmap in kvm_s390_mmu_cache_topup()
was wrong due to a copy-paste error.

Fix it by using the type name.

Fixes: 12f2f61a9e1a ("KVM: s390: KVM page table management functions: allocation")
CC: stable@vger.kernel.org # 7.1
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260611104850.110313-4-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4a41c0247ffa..a4fe664f65ee 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -45,7 +45,7 @@ int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc)
 		mc->pts[mc->n_pts] = o;
 	}
 	for ( ; mc->n_rmaps < KVM_S390_MMU_CACHE_N_RMAPS; mc->n_rmaps++) {
-		o = kzalloc_obj(*mc->rmaps[0], GFP_KERNEL_ACCOUNT);
+		o = kzalloc_obj(struct vsie_rmap, GFP_KERNEL_ACCOUNT);
 		if (!o)
 			return -ENOMEM;
 		mc->rmaps[mc->n_rmaps] = o;
-- 
2.54.0

