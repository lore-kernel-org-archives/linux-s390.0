Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71382486E62;
	Thu, 27 Aug 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846001; cv=none; b=rIeQfbBBek7v5H+JB7o7KiFRt5tPXF2LpP3LBrQ4YkcbcTIuxzkTu3uC8gNHG4Q2sb8l+TLTEAtnLBoWUDYbC1fVYbAbWmw+x8L6PKCPttDW5HDpPHCrWVFsPWpIfl+6ydnQGhiOdM9OL6ENGiLHMeuh9QGFd35mMi9So4rcayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846001; c=relaxed/simple;
	bh=4pM62i9RAbsG1zrbxcp0qb3kaCH4uxaLSQd8wtgJzhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3PYGZ2FaKPi5JkjiDj7OZA5stRNNbYcSpxhw/irT3aTKxX1+eHaLAPm0DjwHyqHtjDE44/gjJpXJmEVxktJn3j7vWZdsxEVKI+t1K/+VVp4GcoOBpHwNA4CeyhBjKzrMtEXhdXcbRax6hpGDXKV60C/JUEY3N0yQVyUU5FVpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JHrRft1u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JHrRft1u"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5Arc3328988;
	Thu, 27 Aug 2026 15:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IJywk2
	/q3SexWirHs+plO0VZZBt/Zky43VRBZGzC4lE=; b=JHrRft1u7NeNx6S1rxHuEI
	UcKppvOCmBWaDA+/JKRHX6rUC37GcR6BYDc2/mct+VGVwnpgUnha4w/iGF+At7pw
	HRfSsJbyHkitaRxAAOWQRkhCJAUIxNtAPOqKD9bxU8wL8sb3PiSp8olArF/f1GYE
	5LWGq2d+wcrH1ONrElO1lo5CgQKNi/3imaMt5PMRNDxk9RJzzELtDstY2AFSdrIy
	kh6tB5tpuDbUq+sRYztx7i6gNjAHZXcQdyIAVh4HoCL7gktTm1o2RvcqEajNazq4
	0QhBd0MeC+dTvGoVNCXCkTWNNG94M82FttTt8WdFXpvqTtIaIFTEzWXrYfjDGgHA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394eefw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFg1S2005813;
	Thu, 27 Aug 2026 15:53:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k8vbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr9fQ46661890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 326FD2004E;
	Thu, 27 Aug 2026 15:53:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 796822004B;
	Thu, 27 Aug 2026 15:53:08 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:08 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:59 +0200
Subject: [PATCH v6 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-19-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4378;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=4pM62i9RAbsG1zrbxcp0qb3kaCH4uxaLSQd8wtgJzhk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYkNcwiwuFD15cUZv6oS8CLbVy1w4zPfEzF3z3tByY
 +wyoSDFjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACZyegMjw4OCezb3T+7J6z+r
 rfNynq7a1qdXfIV9K4UcT7MGfV+olMrIcNzERPXMtrquP0fY2nWXbrN48KDwYDzTMfZNGyUXCbm
 XMQAA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: JJxmSWT0dbiMCx7QfT73dWpuJ_QNV5IZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfXxsmgYVGv4qBe
 Rrly+1JddMVwFSztty67jia+47AT5K1Imh/1/irKKlOL3hucA3HE4JIstguYnNIHLLUZlBGqZ3F
 PIJcTNoWJ2w0DqWVg/bMp0AIDrYQzO8EUrq7hj4JEQ0vcdFAKmJIIhKP3AIWEyeGVm0MGQQsg4Q
 bA1GhN3oIm/FV2c+wvPhaQewOqF4eBFHKpBjQeZBA/h1hoUFUmBJIJAKkg5a91B+5KgTZwJ9Rse
 QKtHicGqKQhMY3htKcRqmr8SiuUf+KTts82gLe2Rhn5Nd7Ge+E+V4oUNoV5bD9pO0OdCXYRDz3s
 Ha6bDtrD/UPRXq3Klotx+yMDKU1vWeX5dB1fO8KyIOAp4o+xC7avv8GPx1+T4IJkGo0bEzTC+9g
 3SFC0HQ1TUf4LKWvERbh/dz7AaoOa2LAlNCc73cSIDKuNiruAbXr4k0qn0jpqy8wYZkUnLU30En
 GU8tOqmxGBlNpOLxWAw==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a905d6a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ZpPwL-J7f7Xe_5oZicQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfXzo81HdZ1iQGq
 EL2Xq/i9OGhNgrDZoifmZXEtunQJJRMqwiFJgXXOi7xostLcP4+2Dlx/vPmdYV38NBR8iwDtwGn
 JqkBuvISfgqSqy1XAWNRFltESpSiPPM=
X-Proofpoint-ORIG-GUID: szmzZGikBie2ufCwzspacHtuC9srLpYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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
index 3a839154fdfe..f8dff6846fb3 100644
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
@@ -1156,6 +1157,7 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb_o,
 		}
 		unpin_sca(kvm, vsie_sca);
 		clear_vsie_sca(vsie_sca);
+		kvm->stat.vsie_shadow_sca_reuse++;
 	}
 
 	if (sie_uses_esca(scb_o))
@@ -2014,6 +2016,7 @@ static int get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr,
 		vsie_page_new = NULL;
 		WRITE_ONCE(kvm->arch.vsie.pages[kvm->arch.vsie.page_count], vsie_page);
 		kvm->arch.vsie.page_count++;
+		kvm->stat.vsie_shadow_scb++;
 	} else {
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
@@ -2031,6 +2034,7 @@ static int get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr,
 		vsie_page->scb_gpa = ULONG_MAX;
 
 		unpin_scb(kvm, vsie_page);
+		kvm->stat.vsie_shadow_scb_reuse++;
 	}
 
 	rc = init_vsie_page(vcpu, vsie_page, addr);
@@ -2060,6 +2064,7 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca
 				u16 cpu_nr, struct vsie_page **vsie_page_out)
 {
 	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	bool vsie_page_is_new = true;
 	int rc;
 
 	vsie_page = vsie_sca->pages[cpu_nr];
@@ -2080,6 +2085,7 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca
 		}
 	}
 	if (vsie_page != vsie_page_new) {
+		vsie_page_is_new = false;
 		if (vsie_page_new)
 			free_vsie_page(vsie_page_new);
 
@@ -2093,6 +2099,10 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca
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

