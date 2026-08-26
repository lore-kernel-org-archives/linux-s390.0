Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535944685D;
	Wed, 26 Aug 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756734; cv=none; b=Wxmb5lUUKmpuBqTaLmylRv0F4YuVoefzJ0CLLomSfPNLGei9rt3sPgK/TnuMGAaFqYF7BTlCi0pDTJueaQNmN2xV1goULIz3zwPrlfRCp6AF7CeoWTZty8aE3q+r6txRDWbeJ46/ueXviLPrsJosnLphZzxccVh/hyDE3A8PRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756734; c=relaxed/simple;
	bh=TSyk5lCgEFv65Y6u0Zff6+kgkPiPzamW+B20crrojUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OIqrIemy7FynT9B/EmGM08zA79KQFxjvrwvG1bUcOtWGuwVLY8ZzyEP3lZ/m5V3Cg2Pqsc3CcZb8vrkeZ1ufweSCqQhdF+KsOPvdydKpoHLOawlyaLjWAkmjrQm3Bz0m6PHgUJJ7QOrI7QeZrkHOoEDHOwheYXB9bEjCVV3ToqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UtEoJ57e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UtEoJ57e"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1dQ13084707;
	Wed, 26 Aug 2026 15:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aQ3gzj
	I1EH20LLS/+d/eTO99I3e2mxEfw5SThftf2jo=; b=UtEoJ57eUFSs4NksZSpuLC
	c5ydjGybR9t2SvaEsh1V64cwL2/n9rF0HH4Z0/KUH/YQPRvlamrTPlt5wU4xrRaE
	QVcKlk7LCvy7t9O3jvlODRqtY28zaR1Qkg4Hfk4yh2EUn4J9wJxDepcJzOi0URww
	u2he0L6gJWjtETyu6QJf0m6F29Xq0YCz0remJySPnqgcM9nVW2qo+k9w5o5BEjaa
	WelnRB20UWNkQ5Q8JFRVSkIv682L2umIdlcwrA/R9qkWOm1xje9KUBYSMM57QBkV
	mE4lK8Nvf47MCTSPgQCrU5zNBsVfGiJyTBSviRmmL4Q9eUAKUfvkxJW9+/H/lYuw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eqbws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuUrj000838;
	Wed, 26 Aug 2026 15:05:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragjee6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5La239321920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA94B20040;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC08C20043;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:21 +0200
Subject: [PATCH v5 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-19-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4371;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=TSyk5lCgEFv65Y6u0Zff6+kgkPiPzamW+B20crrojUg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DGt2FC39FF7O7KwsVMex89PXPSdizzfqirecn/wu5
 cXGwGMyHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAExk8xZGhnXxxjJL57/rOfZ9
 5hWfbLHGqgnROpmnXhRYx+4UtYyudmD4K1e1pUbhTUxY+Dul31NmPZrBuV7XwXv/+m+zz/b+e2o
 cywAA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f00b6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ZpPwL-J7f7Xe_5oZicQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX7dkM8HoMMSSV
 pICMzMQTl5d1330MigJhCrEeh0mL9GaDOzCiwjM0ROcbTame8eSytuDhXI8VVfgWdb2+e/COqwF
 e78jiJyUJGPHKEk8sd7c/GFdYFukkPw=
X-Proofpoint-GUID: 4NqClNs0XClUDwJSKsftvRSSBtsw3JGU
X-Proofpoint-ORIG-GUID: UF0xuW5PY37hoxdR07iZZXazZThrD2KN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX5byL8I//Ez4A
 +C3OoGtjfbrd4YMxJj0qrwSY35dl6Alh1873HuxrMorZ/4oE3NLGIWTMV1A1arzAsKQxrEE8ruy
 m++EGVwLqyRxPngp97OMWiYTo8pz8BeMGUhh+HTgWxxkyJvKf7d7CwEKc4pccSYRuAcuimZSsS8
 CI7ASBEoooQnKZua9S0SBvnAfCJNi8LM8s48zyKRHDmdDiOHBOnOoxPzO1ZsUoZUrJcSYKbQUzb
 Mie/99RotketNJAy0d5MOH6YD0GyO/0m1StI0mTaaDuheOZyMMKu05l8xOvLiz+Z6Ol0RcoMV80
 F2k593IJOVR6aU3CZtWecbwOcbjMK9WFzKUQDdfEMp90Qj9pCat3UOxM7YA6GZsLZrVBJJAWAQD
 Ma2kIYO070dprszec5RfwzafQCLvgQ/Iz8vGqdvoevu5qaN17i74A0AdoyNO/JhBgXtaT1Q1XMG
 x7bkH7iWZCcxM3wMgaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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
index ae0177d74b11..a1ce75be3955 100644
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
index fe94587511b0..335ed1a927aa 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -1133,6 +1133,7 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 		kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] = vsie_sca;
 		kvm->arch.vsie.sca_count++;
 		atomic_set(&vsie_sca->ref_count, 1);
+		kvm->stat.vsie_shadow_sca++;
 	} else {
 		/* reuse previously created vsie_sca allocation for different osca */
 		vsie_sca = get_vsie_sca_unused(kvm);
@@ -1154,6 +1155,7 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 		}
 		unpin_sca(kvm, vsie_sca);
 		clear_vsie_sca(vsie_sca);
+		kvm->stat.vsie_shadow_sca_reuse++;
 	}
 
 	if (sie_uses_esca(scb_o))
@@ -2006,6 +2008,7 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		vsie_page_new = NULL;
 		WRITE_ONCE(kvm->arch.vsie.pages[kvm->arch.vsie.page_count], vsie_page);
 		kvm->arch.vsie.page_count++;
+		kvm->stat.vsie_shadow_scb++;
 	} else {
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
@@ -2018,6 +2021,7 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		}
 
 		unpin_scb(kvm, vsie_page);
+		kvm->stat.vsie_shadow_scb_reuse++;
 	}
 
 	rc = init_vsie_page(vcpu, vsie_page, addr);
@@ -2043,6 +2047,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 					      gpa_t scb_gpa, u16 cpu_nr)
 {
 	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	bool vsie_page_is_new = true;
 	int rc;
 
 	vsie_page = vsie_sca->pages[cpu_nr];
@@ -2063,6 +2068,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 		}
 	}
 	if (vsie_page != vsie_page_new) {
+		vsie_page_is_new = false;
 		if (vsie_page_new)
 			free_vsie_page(vsie_page_new);
 
@@ -2076,6 +2082,10 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 			unpin_scb(vcpu->kvm, vsie_page);
 			rc = init_vsie_page(vcpu, vsie_page, scb_gpa);
 		}
+		if (vsie_page_is_new)
+			vcpu->kvm->stat.vsie_shadow_scb++;
+		else
+			vcpu->kvm->stat.vsie_shadow_scb_reuse++;
 		if (rc) {
 			put_vsie_page(vsie_page);
 			return ERR_PTR(rc);

-- 
2.55.0

