Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506441F349;
	Mon, 27 Jul 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164597; cv=none; b=M9OH+TbEbwXayXCP25mDfnUnMhD8eb0cmS/wTEhicvPaAleK/8vfT/b9fhMz2MKVg02Ss70O2+AkXhtiIO9kdLzIrrOd67QvNefFMpxG2bjLp8UZZGMyadJppo7kcrU7q26pbzM+ERIxC8P2CFdbVx4R5q2S6l9n+K1DdezPQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164597; c=relaxed/simple;
	bh=y9i1iEua3IXO98UobwP6pO4CiE+rWZ5eLdBDKUjhzvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hislr0OD7zwC0o71zaL9gNaUFrLMwcHuxHJljqxsZgRfp4ssbgGT1Ap4679OxAudD2LGHHXtqFoxmqgH1v5KoqZzRnyvA89H6Px2i6v89Weoa95ZRVzk/lFdIWPTjafttjLMkbghF6UciEGAFevOdo9OnjzNRFcp6Fj9kWaaZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YwVrZAxR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YwVrZAxR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDo4oW2413991;
	Mon, 27 Jul 2026 15:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ff8/zUoLpjhnuz0Pr
	kYqzveH2635oSmWTJI/B5jNyIg=; b=YwVrZAxRo84nfJmBAclEm471X+WEKWkyz
	bCrEaFC5ONfOsm+0KxRzqhT6uOHt0693xFadirfEBAS1z2FkdxBX/mzSj2VbhVet
	rzK+rS+HMAhozwWbMr5M/b1cskbTpxLlyqLfnmSxT9sjULdvtclOMHH4ThOTadTQ
	dCD6SD6wX8VnsB8mWwHdk8WlzNIrMI2RMV5QRuilyKuC9rGVIPL5HtyWh3qGcelt
	SpIebFFk+Yn5O/MmFxRpRCMzBC74Ck318DJRxK9HjufV/P7vI/jKX1CNQgYYehal
	not7WUZ0cGG74iPvlPSMGiUf7KbeEuQ11uSGXHRHvs167rckYOqUg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcr7hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuHPD006051;
	Mon, 27 Jul 2026 15:03:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvwy2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF34G849217888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:03:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009D4200F7;
	Mon, 27 Jul 2026 15:03:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09776200F4;
	Mon, 27 Jul 2026 15:03:03 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:03:02 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 08/10] KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
Date: Mon, 27 Jul 2026 17:02:52 +0200
Message-ID: <20260727150254.236021-9-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: y6yKVyU_5S9Cjr3TgArRf2BDAGexHsYZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfXxVtPApgRdvdw
 A8miXIX9mYz8CTUW6m8XhqNkuUAA4eTeBllTqL3Q3f7a8ewB/rMlhN4SDEqo5Y3VnCwDM8i1Rfi
 jOCUSUPoDF3XNel5KOHW0t5rFX0Qv1E=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a67732e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=slTk6vZ5Lws0SGuG0WwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX01leMhnhzAVw
 myEzqPiFKJJpcGjfcHRkKik1cv4ECXhqn2qiCeVBYnXdarJ4RCCYPYY5MjeutfhKJPibpjeT+19
 hhJ6c+hr7MOqt5CaSz9xNpdQevrlDP2MFOIvBZ9uKzspq+HrQ5Dy9uhn3GuW4nLgZB+CwIOXK7a
 IHxUR2sCZqLujBrVyJDsHllqVEXSz01MHzJkBzLjpjSYoILX4+PhH+IZU0XDFrC7Y5veCU8TPvH
 uTHy6Z0hI3tjkhZlACHmmN9Bd+w8MCpKcdD9gvpvAKgrdwbph7KQu6JMf9hFC449/D4G0f375ya
 I+zk/GBOtrSvo9G1h4O7lkTd3A7pJih3UIFcpwP7upSCuBZviknKUFkg6oXvVaaAS49yA6BcWKm
 VX7dQmliMNPIth25B7JAzv28ryKcGiKJoAc8RbxRGH1TwSNkT0xZhST1XIuGmKiI64Sd8ty1WaY
 JTOy/gDan51Stk7nQBQ==
X-Proofpoint-GUID: y6yKVyU_5S9Cjr3TgArRf2BDAGexHsYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270140

The mmu cache is the first thing that is allocated in
kvm_arch_vcpu_create(), but in case of failure it was not freed.

Fix by freeing the mmu cache in case of failure.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 69c9027c42bf..8afb88a2b73d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3796,19 +3796,17 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
 	struct sie_page *sie_page;
 	int rc;
 
 	BUILD_BUG_ON(sizeof(struct sie_page) != 4096);
-	vcpu->arch.mc = kvm_s390_new_mmu_cache();
-	if (!vcpu->arch.mc)
+	mc = kvm_s390_new_mmu_cache();
+	if (!mc)
 		return -ENOMEM;
 	sie_page = (struct sie_page *) get_zeroed_page(GFP_KERNEL_ACCOUNT);
-	if (!sie_page) {
-		kvm_s390_free_mmu_cache(vcpu->arch.mc);
-		vcpu->arch.mc = NULL;
+	if (!sie_page)
 		return -ENOMEM;
-	}
 
 	vcpu->arch.sie_block = &sie_page->sie_block;
 	vcpu->arch.sie_block->itdba = virt_to_phys(&sie_page->itdb);
@@ -3864,6 +3862,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (rc)
 		goto out_ucontrol_uninit;
 
+	vcpu->arch.mc = mc;
+	mc = NULL;
 	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
 	return 0;
 
-- 
2.55.0

