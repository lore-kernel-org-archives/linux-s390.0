Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DA367F21;
	Tue, 11 Aug 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455423; cv=none; b=InEFN3doVXe1ZadFdrnA3b0HnbrJvURpeB6X6x8na8A2apPuV20nlNNmb5eqOY9NqDbvTeN4m6xoLKVJP8eF1xRnK0vmuL30NWok1Wv69gKW1ALvoYDFNBv5rNA5oDiESyXW+sOxjGTDtyRaRHjR/VZFjoygPdy5oABepwTNvcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455423; c=relaxed/simple;
	bh=0kcnX4l8F7OvXl1EdAt0A3DwPK1wJKgRjjb7jiXPiA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRPBVzuDLjgzJUe7z7zGKUV5lvjF8Acv/QaugmwT+XecDm9BQG7iBxcD073rXb8NLQtfaUzvm8Be5WhDdXjIIDqTtlKLYIFW3Nigl1EB0c2qgOgeSwe/iZ48dVtRnk4Z/jgBeJV0xEKK9glVU1uKqE5chvqC6Q+RjPPWRC58oPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XJ/7MsLe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XJ/7MsLe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX9TT451227;
	Tue, 11 Aug 2026 13:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q9OKvA
	A+qn/GEi/wFieR0zousz1s1F2g1B9AeGTSC9U=; b=XJ/7MsLeZ4piFUzApSlBE9
	PSb+bL6M+JL4D/a2o7oyl+0NxOGV3qVz8lh/hOTZ2/Vz8m6qljAD054E1nL224rE
	3sgT3Pzv+1mQZWGJMrxU6yj3OREazVFPhV0DGykxfPJSBacpc2cCAnOZopbfy7KR
	NwLF3x+LFguPsJDuIzWdDQ9fecl9PjQiqJxWE4kqQIPt2RteldzyOuQ+0PuRrlGG
	2fSClC572ToG0EXo2s70wpPYyaU0qYu3+UU+OfyFQixt5OWztSFacMzlO7uh2OzV
	25zFRAMWVcT5Z5pI9MLD0gX0u7i8Ty+w6GCrwG+A7cGwTxB28TzUYrVMmsACiafA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2vgkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQHS7008687;
	Tue, 11 Aug 2026 13:36:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g8xst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDae0b49283516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0C5B20040;
	Tue, 11 Aug 2026 13:36:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C87E2004B;
	Tue, 11 Aug 2026 13:36:40 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:40 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:33 +0200
Subject: [PATCH v3 18/20] KVM: s390: vsie: Add VSIE shadow stat counters
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-18-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4244;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=0kcnX4l8F7OvXl1EdAt0A3DwPK1wJKgRjjb7jiXPiA8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqtESb1V+pndeM5ZryD6seKblWMn/Rcs+JN/t3bNxp
 ujcCK6wjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACaSvZGR4dB56+qruoUrnVbo
 7WaxjtuakP1I4uHhd+X3U6Vm3C2PZGD4n9Swhun/tjkpsS2zJQsbzxeEHnp0RWraEWlj79/RjY5
 1LAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b256d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZpPwL-J7f7Xe_5oZicQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wr6FGAQCQvD0IHvIG9AWAGxgNII9DSBA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX3P7DzOLIPLW5
 mW0Bt+STrm+70+Zf16uChgrC9PUWIPdoG27fG5fV4oNs2WpL7GQU/XgDDSlOhraqd3nfMDzd+Da
 su4pBx8VGORAmjN4jEbzry7tVyLnKyZfzvOiTSasb/2yLyvikalgtgnwH+xKQguqZMt1FUh5Yo7
 9xbiyYNaRyxujTkhdzqLscPmuAHpc6tjEuBZlfdbg5sNKutY2Dz676cSGH9TYamaz5rbljPEbU3
 iJB0tJdM1rhwJqXUURxjSKvvKQ2csF02ao9dUbZ4luGeNThgUkyrCJuNtMQfyu2OzfguKUOqMKX
 Gt84LBLfakUb9nVFWoCGpxmMcQZIc8BPknlbndxawq6HXs3c2E8zmFa6Dmoy+GBBnQPCPH4JEA+
 9Uk6sqVTrlBPdMAVaDVWGwGLN+tElKwfdfGWkcPVZ5S+Kn3n+9B7VKhtXFCJARPq0oMK7qMXKWh
 AxWED/muhPQkh0OrF6g==
X-Proofpoint-ORIG-GUID: wr6FGAQCQvD0IHvIG9AWAGxgNII9DSBA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX1oMsy8L3JW7V
 PM4g1XaqIjeFxz+6KXVzDcw5hi8vMA7Flt6JkrCBWEQSTuFVGBTBFORAvOprsghnjNozwfjdtUE
 QPTxWZKKjhrKvhzqQ2XqsTflO/lsjwc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110113

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
 arch/s390/include/asm/kvm_host.h |  4 ++++
 arch/s390/kvm/kvm-s390.c         |  4 ++++
 arch/s390/kvm/vsie.c             | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 9939bdbecaa0..00498c89467f 100644
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
index 908823dd36cd..08c14bbd4aeb 100644
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
index 892023dc92d4..8640435c9d5f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1104,6 +1104,7 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 		kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] = vsie_sca;
 		kvm->arch.vsie.sca_count++;
 		atomic_set(&vsie_sca->ref_count, 1);
+		kvm->stat.vsie_shadow_sca++;
 	} else {
 		/* reuse previously created vsie_sca allocation for different osca */
 		vsie_sca = get_reuseable_vsie_sca(kvm);
@@ -1126,6 +1127,7 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_
 		}
 		unpin_sca(kvm, vsie_sca);
 		clear_vsie_sca(vsie_sca);
+		kvm->stat.vsie_shadow_sca_reuse++;
 	}
 
 	if (sie_uses_esca(scb_o))
@@ -1983,6 +1985,7 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		vsie_page_new = NULL;
 		WRITE_ONCE(kvm->arch.vsie.pages[kvm->arch.vsie.page_count], vsie_page);
 		kvm->arch.vsie.page_count++;
+		kvm->stat.vsie_shadow_scb++;
 	} else {
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
@@ -1995,6 +1998,7 @@ static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr
 		}
 
 		unpin_scb(kvm, vsie_page);
+		kvm->stat.vsie_shadow_scb_reuse++;
 	}
 
 	rc = vsie_page_init(vcpu, vsie_page, addr);
@@ -2021,6 +2025,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 					      gpa_t scb_gpa, u16 cpu_nr)
 {
 	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	bool vsie_page_is_new = true;
 	int rc;
 
 	vsie_page = vsie_sca->pages[cpu_nr];
@@ -2041,6 +2046,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 		}
 	}
 	if (vsie_page != vsie_page_new) {
+		vsie_page_is_new = false;
 		if (vsie_page_new)
 			free_vsie_page(vsie_page_new);
 
@@ -2058,6 +2064,11 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 			put_vsie_page(vsie_page);
 			return ERR_PTR(rc);
 		}
+
+		if (vsie_page_is_new)
+			vcpu->kvm->stat.vsie_shadow_scb++;
+		else
+			vcpu->kvm->stat.vsie_shadow_scb_reuse++;
 	}
 
 	return vsie_page;

-- 
2.55.0

