Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FD4749F5;
	Tue,  4 Aug 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860703; cv=none; b=B7A9eytJMXwKcHdtPi2sGl1iN5Pj7fFxlLU8u+pXGemfHMF4AobhD/HgcXVKYg67gSj7HKCiilE4E+C6GyGCegt85bUN0UJctM0R6pvfvlH8rVP9UPCmKsE1xTxUZG5WWEHsoilN8S4ezXdxKthIqdX3RQRvvZSt1cUT3wbD2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860703; c=relaxed/simple;
	bh=AtBaY1l3zkB1C+GK3FFBxpFxscFH0k+1+qnixDYfNM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oK5M908hMeLW5M12wc9M/6USL+KkVfFmvBc32kRZsYgwKgoy+Cj9ztoO637HCuvz5pnmj8GmKzhB0GqkbqCjG2eL6Rh9ROIUdzQoJxC19Ol5ln621lxTnG1+QCBzlvGjG15RLweOLzi/stgFwPE3BtkSzIcGR9ohEzGpiEqaUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JFNbSRBp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JFNbSRBp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Flxp01341042;
	Tue, 4 Aug 2026 16:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ugi7gyUJOirIDtK2r
	4gU9u4w8jmpqJ4kMD7n4Mu2s/w=; b=JFNbSRBp3IMbCHGt1DadYOmjfVg1d5MGN
	Z3vduqs/c23VD1TsOIG/XHnHX+CxDQr9oPaHXqjzvx3QCHdDeo5s07ASPYOnj2cC
	vQ8MgbzwnZa+oZuXE2wa3g3aTShKlbEKS/HSRPyq5p8Wzi8psIgcdDh9tkAD5ia1
	cEi9k1/GnjK95vanzznFQ8bCEHlB+AhU0f61CxtJVnzXGdvBQNJwR7JHmEMsqfCT
	oh9cwVVtD12bEz1K0nIlIo37Ny5iw2sx/n9sSS3ea85prJ85QMbamWeHthH75FxY
	q3bteUf1X7jCub1FqhemcxOfNJkox5euiXb48MS7SuiCt2HxmPscw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eupb9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GBTQK007712;
	Tue, 4 Aug 2026 16:24:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qjv68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674GOvR715467046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:24:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F17ED5805C;
	Tue,  4 Aug 2026 16:24:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B56185805B;
	Tue,  4 Aug 2026 16:24:54 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:24:54 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH v2 7/7] KVM: s390: Free guest debug data on vcpu destroy
Date: Tue,  4 Aug 2026 18:24:35 +0200
Message-ID: <20260804162435.28617-8-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804162435.28617-1-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MBjyLTqYc3EDzladuekXvXUwveVU6gg8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfXxEoztewAQUiJ
 K3jGZEzQ4RWtS7LMvammuJtcG3CQ8ztnf0FlTTjfkA24krLPO3zC/kBNjp5MgV76PflJlOFJD61
 9cGxdeYpGRqcpZK0EphDMCV63Iu/DKo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfX2MR6IfsBoGd5
 nX7ylD4sd1zcsNysgemIiAZPwGtpBR3V+xP+4cO4LHz4SdwR/zujkTdBidJ9KG0Mjxpyh/fI+Hk
 no9URAlTRolSw9l2G7MVFQVciGBaPhJfZd6F7+pBUqQx/H8WOEPMlqbDhLR2Hbyyi5feouYgNRS
 yMUjUUniNiyAshCiTlOm0Gcp4UPNcgNXxXMuXEU1IFWQ5oyskgKuI476bZEGBBEQQgH87/g6nXv
 se5zjurWYA/DMiOX5qlNTCDgEvaC5r84eyO+RpkV2a7kq/ziZB6Y4ACsVa/KfijwQrgGGhZoTWq
 a8trHiZce1Iezu55eIvFm2oBN+1JXSQzOfymPV6z0DN+cuShJ8qHrHOAmAP17l1QrGOYXEq/m5s
 VWucQvys7oPJX9am8zKsW5Yw/RxFsfFZQA06BYnYjdSI3LWieLpodk6u64iSFWpqEmcebZVPt3F
 ruV516kOfWh/8vZHCyQ==
X-Proofpoint-GUID: MBjyLTqYc3EDzladuekXvXUwveVU6gg8
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a72125b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FN5RJEE1uaSDo9arrcAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040131

kvm_s390_clear_bp_data() is only called from
kvm_arch_vcpu_ioctl_set_guest_debug(), i.e. when user space changes or
disables debugging. A vCPU that is destroyed while hardware breakpoints
are still armed - the normal case when the VMM just exits or crashes -
leaks hw_bp_info, hw_wp_info and all old_data buffers, since generic KVM
frees the vCPU right after kvm_arch_vcpu_destroy().

That is bounded by MAX_BP_COUNT entries, so roughly 8 KiB per vCPU, but
it is unbounded over VM lifetimes. The allocations are
GFP_KERNEL_ACCOUNT, so the charge also outlives the exiting process and
pins dying memcgs.

Fix by clearing the debug data on vCPU destruction. Calling it
unconditionally is fine: struct kvm_vcpu is zero allocated, so for a vCPU
that never enabled debugging the counters are 0 and the pointers NULL.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e0548926dc49..ccbdb109e22c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3409,6 +3409,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
 	kvm_s390_clear_local_irqs(vcpu);
 	kvm_clear_async_pf_completion_queue(vcpu);
+	kvm_s390_clear_bp_data(vcpu);
 	if (!kvm_is_ucontrol(vcpu->kvm))
 		sca_del_vcpu(vcpu);
 	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
-- 
2.53.0

