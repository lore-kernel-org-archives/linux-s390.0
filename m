Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35041BA7F;
	Mon, 27 Jul 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164592; cv=none; b=LKShriT2M+wp3ITmJXINgwOapFA5FUpD/1chQQ8vpLnPungAEiOfv/IpaV6EpbUhygCGmtMTePfbqJHhDPYUcvgNnsz547FVXTdDXPfLC+IjQy144B2rNn4g7YC9sHVL1xf0D7wetj2VZtrOr3o2CQuawFomaKXzPaigZeIvTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164592; c=relaxed/simple;
	bh=1WEX258pDUMckhsuOUIRyEyTsrPowAa4NjbQ00ctvCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQu2yy8B28Ga+eEMt00OJEwSSnZJSPCvmtMA27ezsyOcNwfKMoQ39rK26Yz1k0G11yanS8POerCSXjX8K9et8JEJuALt6aWq7jx3fPiag9Rm7eeHpBz5uLO15XKeEdd5rb6Y9Hye6jgvuUnfGy0tA0zV2uyBePXOs6Bcf4Df/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kyxWaK0u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kyxWaK0u"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDo7dd2293696;
	Mon, 27 Jul 2026 15:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kimcgs3neOQpff10D
	T5tgh3pS+99tpJGSEpbK4mu1lU=; b=kyxWaK0uGkmGFnBo1/qmsx3chRVE50fs+
	qRqjzzdURn86e09YJABKj8dlRLckR8FVdV07QrPWQMQ3tJfBU+Ws6ZdE9EVpf2c6
	nIu7DAG1IigGgwPgIZtFHSJDJ+uVGqnwHDv+EIdFPTDDaMOahSVfILjIJwND/DHm
	DpFhe1psiRH78lLyUgcOMij0spB+2RVbu+Px4u4jm9h+azHYBczZxseplvvoP0Wb
	awIGAhgi8ca6DZvkw8jnamzEhQcFHuSrvlMfT9X0h2Lj0zm5IG3CekcGOpl1oVyL
	n/O+ORSsnHaqJyKvwW/R3/dcz9MDS0/pCLkXvZb6l8gP11mnuz7Vg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ng6ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuGHK015933;
	Mon, 27 Jul 2026 15:03:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg5mjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF30mi47972816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:03:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FDEA200F6;
	Mon, 27 Jul 2026 15:03:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44DAD200F4;
	Mon, 27 Jul 2026 15:02:59 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:02:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 05/10] KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
Date: Mon, 27 Jul 2026 17:02:49 +0200
Message-ID: <20260727150254.236021-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727150254.236021-1-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX+yGo/NJMzeSr
 7m0hMf2xHNzMZfV4cUr2mx+0q/TQzLYbPVkBqE8dKzFFcMJdfCydyYIRDypofiQ48K50Xy68Z4u
 82luVfVRRbW9yD5jAF9nkgnpwtxQ3tc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX/oUf0Ixed63B
 e8PaISGOJFNL90VGnQVlwfpI6uA4uQx8HzL00UgWjGRmDrbpuEwKL0pT/M3GpXlWJD2plNvHR0e
 je4upxckBcGo/e9/exjk0Z13LczyiYfDUJCrwVUZTzdLr3qqBlcLuUdze4fWW6pv/b7biGHKN5e
 4pOpSdCeacfA3M3ziGJxwJrMHxr/jz0E2L03KeNBpOq2MAr9zJwT/9BUM3n+50w/Zvp1VE5Z4eT
 TXBRjQyFQCZR6tb7f8mrmXWROQRpdTZfY1AJWDWiPVZlA1UVUkrMmjUDwNfQr2lm01iXszQ3N9k
 ciJ1qV/Trl6rSy7khmZ00MA0gZUmEzjbrIuISLJDqnZ3f3kJ4+KBQW9al//I6BlCzTXdKxoh/6L
 DgMctiBB185PO6XRaVvd/Hh16tyFG6IT7dlpk/mDDBo8fgnnoVVT0S8xEVuE7Txa8deRFxmovTu
 wFixZsSSbCjs97aFUiA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a67732a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qtdt0r206yBj_IGTItsA:9
X-Proofpoint-GUID: 6xXfmQdXf0AJXSdqcYmLwQCSX2pN9ORj
X-Proofpoint-ORIG-GUID: 6xXfmQdXf0AJXSdqcYmLwQCSX2pN9ORj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270140

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
index 19294d8dff96..9fccba261930 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3869,7 +3869,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
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

