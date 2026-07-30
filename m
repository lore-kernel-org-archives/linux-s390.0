Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CC444712;
	Thu, 30 Jul 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428849; cv=none; b=gg7yP+8pCANDl07PxYV08KVtgCOM6OsjYzap6dR8AQ129q8ifuSD+OLEH/jiVULuMFMPn4Dtvy4dJIZZGM/At1RkxhuvEn1DoUXK/RJzR3SkVfVDoOcz2ZV65zBq/BOhaRFPS6dF1wIK5MbmrHhXECOzP1OK/yHkKLVrAGBXPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428849; c=relaxed/simple;
	bh=ZEE0cHbgc+WLOwgumAHGhLEtpAfP0aB6WjEwK0CaM+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYqysbrxb/OIbMhVFAqdFSt1xcLQaEg804NoGW34mmU/7jqKmqZItC/OUsBkVcneLpnCYdAmiQ9OTIxRBxV0kcfZEFY9ky5w6ConsxrreLZcaHLZ0isYYDnECSVwCC3r1C5fXnSrWQdTkR5ziq/hg7vlxPSykzydwrqpkqBzbdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UU9tb6rQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UU9tb6rQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFlsG33353358;
	Thu, 30 Jul 2026 16:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2X7i6CHvSBdmz8pht
	7c0pYzFXUm8zL+65SMhNO0x8jo=; b=UU9tb6rQVAOgX5aNoJggOIdASd7N9bQGf
	9GlCPVpLsXMg1+c5cXC+DjPVK87+6ou1/Z9W9KuuKmdsMgIgDUmxXzBShnc+jiNB
	7gnqnCmGQzq3TnQBTgdTzQmS9Ol+cBmvm8EM//ZrReCJCCC7QnkD0pYGJS8vyVLI
	DeqDfxPflzMjJ4c+kaYLiM1GVbsZtHEugxQWUN6cwekP4convGRxkaTzTYWQmS3N
	Bir42eNm4Jxuf8QInDEwBjNWhXqWm9mZm7GL8VOsMeY3d8d6LPpINwRN1eL3mvME
	/R/oBDqaqj8stBQTr4btHFMaVxqijDFFWuN588Js1asvoH5XastTA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nyvd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQL0P010547;
	Thu, 30 Jul 2026 16:27:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ybv5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRGOK17826096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5888820040;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C2CC2004B;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 08/14] KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
Date: Thu, 30 Jul 2026 18:27:08 +0200
Message-ID: <20260730162714.133327-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX+r7r1lTPSqqi
 PocHsPf/Hrj05UVgVisXdRL0UyEaqrsxIXmx6Fx3llDOCsSnapKHhZ2h9reOJrbTmKjHtEXuPVz
 TFU6x4iDxRh8hJIw9gi2QDgxD0x3O6g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX1j3jai+82gd1
 2XlfQCbuUcbfEPWWVl8YnUguuiVyhvdNN5D9zqLTqkn+aRZ5JMMF8abpu5Mb1+6seDK+lgWpNtX
 CofvX68o/Ai0ZGdHkV2hy1FCHmrAkPFUFD6bI8RH7HbmkmGKXOd3yT09KEeMirY15Kjo1+oUm9f
 zay5um2DZNrqOGrzEugSNKwGn3FSpzGmOBmPR0nRMHw1JQyyJCw39PCupAsK9STHizQA5UjQZjb
 o9VaSFbmiX6obRhe6T+cYVz93G9X5hwlHSJAHf5EE2DjKGcAoZrENOp2vro60zhkW3PWmdsqUDe
 JNhK7cy0ONwlSDYkgQogGg9+EqGqd8NoktgF935EZiWfFtaUtce1Nlq+BhlQr6i4njjDLecl/TZ
 83ka+NCHD8hGLeQSmGvrSWHZxVNSS0p4xMf0DhDuy3YC+kCMlFm0WoSAaO0/lxR8XRy/1KaFVr8
 zUibZXyCBVnuKHqVsWg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b7b6b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qtdt0r206yBj_IGTItsA:9
X-Proofpoint-GUID: YtSUXSE123FP7dPWSL5VIW-p4nU6FLr6
X-Proofpoint-ORIG-GUID: YtSUXSE123FP7dPWSL5VIW-p4nU6FLr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300123

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

Fix by adding the missing lock.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c1984fe2f9a4..a234c2ab5fed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3874,7 +3874,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 out_ucontrol_uninit:
 	if (kvm_is_ucontrol(vcpu->kvm)) {
+		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
 		gmap_remove_child(vcpu->arch.gmap);
+		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
 		vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
 	}
 out_free_sie_block:
-- 
2.55.0

