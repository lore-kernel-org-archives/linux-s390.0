Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F03803DB;
	Thu,  9 Jul 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610142; cv=none; b=FGQSN5YALTPLTVbEaTd8B5Yt9ohJ5kTG8g6WfDLQg3yDyIzelAJOFrX2gBQLuiMRDJ5TSXpgLN5XYFjC/1sElg4weC5zfcy+KZxe80gucSo1kbjYL5Zov/RFXBauiQ3hrlSlmj3DrEvS20+Hyvwvc/VjCLv9bq3FGrRmBSPUHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610142; c=relaxed/simple;
	bh=0N1jfxc6iRUaeGmBnC3ZmB3zJ0OW8JgBU0Axjp2Qnkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaQbDbM8qy834C5wyRirbxwzwnYHiq/ji04g6UsLRvJu6sIxAlR/F2sS4dp29tOj9fowLFT4IrdJ1YmAiB8HOoDnNq7ked1MgJ77YfJpgltNmjSB8nG+ieeDXP659Ps/nfhy417/UpKN+8AwyGHkYejj9YaMBj+q5nta8Tyjfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fo6o5xt4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fo6o5xt4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIQAE1769923;
	Thu, 9 Jul 2026 15:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+rSo68
	Vwc7B5bdKwKZHzTiZrlLy4vW7/eM1fylxSxI0=; b=Fo6o5xt4COjlqynticg+hb
	QvAnq1GkA/Hp11UPWQfAN9rre+LPm5D+cbHAG/3p0Rz7Knty16lwj8UW1PCsDqtt
	lEJ4T+/bXWZU/wof/k4Z2fb7QUS5xJOr/LrrOGptS8v33OkoaXFdesYyVbvCx/Dq
	tpkOZooTZw+3P90MN1cBu/yf5dEyewCJggy5LCIQ1f+PHyD4ideD7QhsWHEObGi7
	wr1ZkAKKULnYAiyNZn0r2FWaVzov9MglZ+hEB80IJgr0VUzVkY+5VTb2j4dZff6y
	NLDTEtGL9aZ5loWi1cWh0/lfnvLiSGPQct+VUMsj4bVFwdKBR4xEnFfJl9dcHHiA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke2pq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4dhA025112;
	Thu, 9 Jul 2026 15:15:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hnk61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFW5437355938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3224520040;
	Thu,  9 Jul 2026 15:15:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E80120043;
	Thu,  9 Jul 2026 15:15:31 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:31 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:19 +0200
Subject: [PATCH 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-19-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=0N1jfxc6iRUaeGmBnC3ZmB3zJ0OW8JgBU0Axjp2Qnkg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1mVDfLX6O88Omej/94Fd+c+/BcrMeXTnVNi50xvp
 Do8vsuQ0lHKwiDGxSArpshSLW6dV9XXunTOQctrMHNYmUCGMHBxCsBEXvszMrTKKxpea8zif22k
 L9iyt3rx8i1CjP6vZG7Yz8v9eFJVdRLDP7uX1ovjn1Y07be70TNhbuKBngOiO3pKwkP/BrBwfre
 IZwUA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4fbb18 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ACqrv-Omp4_yNseKlhkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX8KZ/WJtziCja
 +IF6la1haTtJ15jZICfCLTgCTEp3J1nXlMH5GcY5D7p93k5pi1oZpi6sa+P0HxXu3ekckDfsR8u
 cC7iMQD+5Qx9lCWDWvKtfYo+TrAIZVOMDo/m7nA2ZJOWauNI3Kc8BMChcQx5aoFtKbtLa0hsgW1
 ssjJ9P3ZnyPJcWyD8Fy3gQSpCiL1hpKc2BOPGQLddX7UcGmJL0HwHDxpSbGs1+cU3yIsOcjDKnm
 /LVVDvqaPNBXcu686rh4CsjXwSQko0/OitNauRB925tlBpmfQDJLjmB78QSwkDVEiWlhZ226V5t
 Y28d4fFf5u7PjJO9a31Vm0KodTstV7ojnW5HAPE+RwekUwxdJ/KRYnYmX2V3LsGdxFLnLqv/us/
 u3ZizrIhZ/XU+ZTvNjSLbikSoYHLoRxQ2je0Aac5WjeKNXgDPckB2n5pG/aKFB38EAewsS85Fja
 P0x7frfrab6oFpVtH8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX+vy63QbXj7uX
 LG+mqsgnUGeab8YMS5+5Q5g00v1wu52Qhz1g7KtEYAqlsgjUVTkkGVTlysqWlZTYob/5MwJgeZm
 OOXRUcTohLnu2sQpYgJ0FiJVu1toakw=
X-Proofpoint-GUID: Ru2XtuevwoftYmHbn1OsQRhLSiBQJCVM
X-Proofpoint-ORIG-GUID: Ru2XtuevwoftYmHbn1OsQRhLSiBQJCVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

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
 arch/s390/include/asm/kvm_host.h | 4 ++++
 arch/s390/kvm/kvm-s390.c         | 4 ++++
 arch/s390/kvm/vsie.c             | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c0e5caf0eb16..575fd67941f7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -466,6 +466,10 @@ struct kvm_vm_stat {
 	u64 gmap_shadow_r3_entry;
 	u64 gmap_shadow_sg_entry;
 	u64 gmap_shadow_pg_entry;
+	u64 vsie_shadow_scb;
+	u64 vsie_shadow_scb_reuse;
+	u64 vsie_shadow_sca;
+	u64 vsie_shadow_sca_reuse;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6749198bac3f..481e566fe228 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -86,6 +86,10 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, gmap_shadow_r3_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_sg_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_pg_entry),
+	STATS_DESC_COUNTER(VM, vsie_shadow_scb),
+	STATS_DESC_COUNTER(VM, vsie_shadow_scb_reuse),
+	STATS_DESC_COUNTER(VM, vsie_shadow_sca),
+	STATS_DESC_COUNTER(VM, vsie_shadow_sca_reuse),
 };
 
 const struct kvm_stats_header kvm_vm_stats_header = {
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c392f7afe130..80050376eaab 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1080,6 +1080,7 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 		kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] = vsie_sca;
 		kvm->arch.vsie.sca_count++;
 		atomic_set(&vsie_sca->ref_count, 1);
+		kvm->stat.vsie_shadow_sca++;
 	} else {
 		/* reuse previously created vsie_sca allocation for different osca */
 		vsie_sca = get_reuseable_vsie_sca(kvm);
@@ -1102,6 +1103,7 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 		}
 		unpin_sca(kvm, vsie_sca);
 		clear_vsie_sca(vsie_sca);
+		kvm->stat.vsie_shadow_sca_reuse++;
 	}
 
 	if (sie_uses_esca(scb_o))
@@ -1946,6 +1948,7 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		vsie_page_new = NULL;
 		WRITE_ONCE(kvm->arch.vsie.pages[kvm->arch.vsie.page_count], vsie_page);
 		kvm->arch.vsie.page_count++;
+		kvm->stat.vsie_shadow_scb++;
 	} else {
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
@@ -1958,6 +1961,7 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		}
 
 		unpin_scb(kvm, vsie_page);
+		kvm->stat.vsie_shadow_scb_reuse++;
 	}
 
 	rc = vsie_page_init(vcpu, vsie_page, addr);
@@ -2002,6 +2006,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 				vsie_page = vsie_page_new;
 			}
 		}
+		vcpu->kvm->stat.vsie_shadow_scb++;
 	}
 	if (vsie_page != vsie_page_new) {
 		if (vsie_page_new)
@@ -2011,6 +2016,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 		if (!try_get_vsie_page(vsie_page))
 			return ERR_PTR(-EAGAIN);
 		vsie_page->vsie_sca = vsie_sca;
+		vcpu->kvm->stat.vsie_shadow_scb_reuse++;
 	}
 	if (vsie_page->scb_gpa != scb_gpa || vsie_page->sca_gpa != vsie_sca->sca_gpa) {
 		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {

-- 
2.55.0

