Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E543AAF63;
	Wed, 29 Jul 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338992; cv=none; b=gkKwptsrK3zfir++Iqzf9vO/DsuFhyIbsspHYuGu0TWFGjWdRNSuqC60J3akHTpcbbzPTQZ/IW8A58tNf3/BEPbBoaTv8GKAal2Gl8FLpLzkTlaCaH0vDbFHcg06WG49gqSEHGD7Tpj3Z0ZkX5x1q5daFYQvixCvYLMLhy6xEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338992; c=relaxed/simple;
	bh=f/8AKxgqDPRjia+Er7CtBcXKukFTVXpBcykKK6b+Yss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI9x7qh4D9kkXN2S7vce2czp3XCw2972oSARYc3PFNrjNkO/Ez6ZTPJiubcEIgMx4fnojWONTLuJQ41pun10gsDmNa/U7CV+gr0u4P6vO8Vfb12w7eVtatfx4svT3k5UdJmwjIRo7nOpdi/v7apbQIjtQqz3sX2eclr9V3F6jZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oT7P7114; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oT7P7114"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHeQS282821;
	Wed, 29 Jul 2026 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UPy0iorx5D+DioWrS
	hnOXmPofwwr16FDUEqyeHrkp1c=; b=oT7P7114qMgG9jqn0wbFA7/KRljpeW1HR
	KZFblpI9hLIpZRIp0cgH6riqhc76nf3zmkEmYEjLPsAC7c5QvWvLWKDlL56qmPM5
	yzk96pQ52oKyECpuIWO29ROP+wcZ8xw6dOEH6GV5ijpAOHSNAcXjyrbRUUJwjbw0
	8r+f8huVfUVigCdMwqmQh7so9diu/Ao19SoaKTiMYVZyZ4pSGe0T+Tn7Ww8VmtoG
	9rDHaCRSZKUUkHprU+09uwotMBkyyk7pyuSYSX75BsaIxBhxZRqqi44QcENz455q
	BuTlQSda+4YFHUnbQJt4G4Rs+fdc98VJgPmpBaNDSOe8fE4zIwYIQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntksy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQGZ4028437;
	Wed, 29 Jul 2026 15:29:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw7dhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTeOp33358276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01D5E20043;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7B362004B;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 08/13] KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
Date: Wed, 29 Jul 2026 17:29:33 +0200
Message-ID: <20260729152938.782383-9-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX1alGHoJaiRY0
 NUuo2aTfRhglyOIyhWoSUHpGdrbSKKCvadd0foaqXMf3nY/HegbCGmc7ZC8/PL+1fxlWe0jh3Og
 CA7vTdATRrIClsdiaaO/+onckUZ5vKQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXziHZJ7beNOlY
 mLCyxIdwxLVk5gHxeCt4dzSgrMDvfdhUoIstwy0RUM+9zrITTbFvFr0Pslt3vjtuEdl4Fnfsb4A
 U1EzbH5U/WXoxHRY5hbqO+BO/YRj3phQ+KCyWqI+COiD7XK36HaJTp3o6Hf3YKURiZaox0J9SFW
 XzGgu3XQjccEPG88Nao2hru1/oLWSXG3c+H4qPU2VuZMylsAqfeFTnDSa9LgnVnYwFfVwoc4TS/
 ZKFX0e9jkGXgjL0sj7ydRJpQOIOX6+R2vhxE9Mwxy6eI/kmd2NaOuVTxnDA0nVaQDTB8aK1vB59
 ZTaypFRlY/MCSgw8bzhW0NjsoNye7cjYlqvQjWI+5//xcY/srvEbbtDFKHRmPzvHGPkl9RWAazy
 /s4qeWv05Yf8m91f3bpjt5Bk1w+1es2nffYG/fn2559GfZ7GcveXcBEBXMYZqXjXc8ms76Cz8hz
 fuYW4NaAM7dJbXN6llQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a1c6a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qtdt0r206yBj_IGTItsA:9
X-Proofpoint-GUID: MnpmmMKlxmsrllXrEqP6_FC0i4J0A7Js
X-Proofpoint-ORIG-GUID: MnpmmMKlxmsrllXrEqP6_FC0i4J0A7Js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

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
index 3e7e5cfea181..a61a2140a60c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3871,7 +3871,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
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

