Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8B4FDA53;
	Fri, 18 Sep 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744193; cv=none; b=lftHc279YdeeCPXTkjYkkhysUX6Qf7IFDSRH9uVJZP2yTEcDG2Mnf9YwmFDt2YUHq9FmsoNA0L+Zxj2KRfZA8LuZYWsNhbvdQx/j27e9WLnM5AY6PXmkztC10qshhPRkBGmKRXG6urF40RhNXnivNZz3riBn/AnQ+47f+aOePWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744193; c=relaxed/simple;
	bh=T8volyvm0iI7mohU6R+YscpGgRvRRMfcZPvdkjYbGuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m51BwYaQRt5iQTPB5Bc/+GRg17JEDVMdKY3wpIvaZ8oOK4VCdx/nA9rglL1pilsPVKTdalqY5dpQu70lV/DUJsiJmIjuqRn+a41M3DfhlK9e08N/IRCXRARbJD8Xr14UkkDduvR8WO3JOOInppKJ0aSkZ+K5chLfgK1pJ27RkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=arPeCYuO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="arPeCYuO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVbMS217140;
	Fri, 18 Sep 2026 15:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gPzH5K
	6Ps2rvFRhdZaj/s7WhRF7LqysmWozVq4+siC4=; b=arPeCYuOgLZ/ox9NCC2fhw
	fOH+4CYlQpVgQfB08K1koEDhap1Lp5u2z1tKJGNRfPEiehy7F5iTka7VS8FPxqDp
	u0lS1a0mj1ObDaf0J0vn18ZZYiPD8CVbbACn0eOKw5Xs4xwejnpIqLIGNkxN6gcQ
	umz5j84kEXBMOKw/pH7mFJyJ+RxpqVMI7f0c2Airfwatsz957XhQ43WMSBs3dF1D
	hdkNehocF5/ozRCVkhoXbIhh/ySZAAAEPL4b0TUrARacf+f5Mx6Ih76mJ8+fSJVs
	/7J95TxK4aYVk6JePfrsAMItBh9PFYLBfWOcO+5NLl35lvEea7KjGQvgN/v+qGSg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ega1q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNuXj777393;
	Fri, 18 Sep 2026 15:09:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yxxrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9Y7S43909504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3CFC20040;
	Fri, 18 Sep 2026 15:09:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 802BB2004B;
	Fri, 18 Sep 2026 15:09:33 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:36 +0200
Subject: [PATCH v7 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-19-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4434;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=T8volyvm0iI7mohU6R+YscpGgRvRRMfcZPvdkjYbGuQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQ5SOvpz0q6qB7RBP2z9+R6XV/7WjDsbm+niq9fhf/
 6HL2KrfUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwERWGjIytK/zPfkq5knDKw+n
 bU2fzL8yS877deDm7UuuMeut7nntWcrI8O+NiWF0sXxJkd3lObKhQtrfVEpPdjXsFXB9VFXkq1T
 NDgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX2HJDdtngAooO
 RfiMfo07Oy7Xcx2Y++LHyG+GiRsQLVdFQA/lcmnNRkq1P5ifly4vFfMr9OO6c/kPg5mhzkAxwM+
 vmjHgSZMH/9dTXQvud2yeIpYsZ+XSYjEUIt1MUMt0vh/9U9HQlKHRMnlO0TPqu3F4KTF1hUjXzz
 BKLDOsFbcx2z7ddWgA+WDP33fdlDY4y/xuTm34m5TXbAiLLTc92l6Ie83m3sQnQTaayC16txbrB
 XRgZcKGA7M8T+Mnnf6LLh1gSHhjrAC7hc/wENVKRXiCqjWpY8L9KhHySrDBpzTaVmlvkoBbuEqx
 WAqXysIO7KdMEuh95lvKOQ423G0Xgh7Tj0fHxnacFo/1CwP1eltFo5Nt1gXwpl5OOWke7X+NJk8
 FVwgGRUMtdIOa2y0iBc6t8ZKjr3N8n0qIBKVxktEYiSKASdHyVCArwDHXlrK2Eyv/eSYaXMFjku
 5+KcY+xTtkNPOL8q7qg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad5432 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ZpPwL-J7f7Xe_5oZicQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Iy6NAPG6VlLKqsVmfQv0nucO3MTrHkfb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX0nBULgLGCWqO
 7ABw3qJH0LXXIyVuH7jK3bk64gC3L7/nfCsr17FDa8/lte7XCUtJIW3exGcZVF5eof8Cp6SYOh0
 EJTmJIoFwUUQ/Oeyki2GS8NPH+9lY70=
X-Proofpoint-GUID: OfFyKUJCo8mXEkAswEraBU3Dvw1LmRBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

Add new stat counters to VSIE shadowing to be able to verify and monitor
the functionality.

* vsie_shadow_scb shows the number of allocated SIE control block
  shadows. Should count upwards between 0 and the max number of active
  CPUs or configured value.
* vsie_shadow_sca shows the number of allocated system control area
  shadows. Should count upwards between 0 and the max number of active
  CPUs or configured value.
* vsie_shadow_scb_reuse shows the number of reused SIE control block
  shadows.
* vsie_shadow_sca_reuse shows the number of reused system control area
  shadows.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h |  4 ++++
 arch/s390/kvm/s390/s390.c             |  4 ++++
 arch/s390/kvm/s390/vsie.c             | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 9768c9dca27c..a19d3a5f550c 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -412,6 +412,10 @@ struct kvm_vm_stat {
 	u64 gmap_shadow_r3_entry;
 	u64 gmap_shadow_sg_entry;
 	u64 gmap_shadow_pg_entry;
+	u64 vsie_shadow_scb;
+	u64 vsie_shadow_scb_reuse;
+	u64 vsie_shadow_sca;
+	u64 vsie_shadow_sca_reuse;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index a58c330b9e7c..1ed962520ced 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -87,6 +87,10 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, gmap_shadow_r3_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_sg_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_pg_entry),
+	STATS_DESC_COUNTER(VM, vsie_shadow_scb),
+	STATS_DESC_COUNTER(VM, vsie_shadow_scb_reuse),
+	STATS_DESC_COUNTER(VM, vsie_shadow_sca),
+	STATS_DESC_COUNTER(VM, vsie_shadow_sca_reuse),
 };
 
 const struct kvm_stats_header kvm_vm_stats_header = {
diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 30e24b9b3eaa..59037964efc9 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -1134,6 +1134,7 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb_o,
 		kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] = vsie_sca;
 		kvm->arch.vsie.sca_count++;
 		atomic_set(&vsie_sca->ref_count, 1);
+		kvm->stat.vsie_shadow_sca++;
 	} else {
 		/* reuse previously created vsie_sca allocation for different osca */
 		vsie_sca = get_vsie_sca_unused(kvm);
@@ -1158,6 +1159,7 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb_o,
 		}
 		unpin_sca(kvm, vsie_sca);
 		clear_vsie_sca(vsie_sca);
+		kvm->stat.vsie_shadow_sca_reuse++;
 	}
 
 	if (sie_uses_esca(scb_o))
@@ -2021,6 +2023,7 @@ static int get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr,
 		vsie_page_new = NULL;
 		WRITE_ONCE(kvm->arch.vsie.pages[kvm->arch.vsie.page_count], vsie_page);
 		kvm->arch.vsie.page_count++;
+		kvm->stat.vsie_shadow_scb++;
 	} else {
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
@@ -2038,6 +2041,7 @@ static int get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr,
 		unpin_scb(kvm, vsie_page);
 		/* Mark it as invalid until it resides in the tree. */
 		vsie_page->scb_gpa = ULONG_MAX;
+		kvm->stat.vsie_shadow_scb_reuse++;
 	}
 
 	rc = init_vsie_page(vcpu, vsie_page, addr);
@@ -2068,6 +2072,7 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca
 				u16 cpu_nr, struct vsie_page **vsie_page_out)
 {
 	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	bool vsie_page_is_new = true;
 	int rc;
 
 	vsie_page = vsie_sca->pages[cpu_nr];
@@ -2088,6 +2093,7 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca
 		}
 	}
 	if (vsie_page != vsie_page_new) {
+		vsie_page_is_new = false;
 		if (vsie_page_new)
 			free_vsie_page(vsie_page_new);
 
@@ -2101,6 +2107,10 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca
 			unpin_scb(vcpu->kvm, vsie_page);
 			rc = init_vsie_page(vcpu, vsie_page, scb_gpa);
 		}
+		if (vsie_page_is_new)
+			vcpu->kvm->stat.vsie_shadow_scb++;
+		else
+			vcpu->kvm->stat.vsie_shadow_scb_reuse++;
 		if (rc) {
 			put_vsie_page(vsie_page);
 			return rc;

-- 
2.55.0

