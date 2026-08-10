Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B15339393;
	Mon, 10 Aug 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377274; cv=none; b=a08fjQIE49QqeVuXBMS5CCLTwdn4KGJXKMpvJqbe3y8+xj42RbWq0w7kn4xPcXfXWPQirlcmCUu7Tz18DUaGm94gV5UZsjbUSTgQE0CLbfsvgZtDltDlb8JAqdwLDz8iUJzrr4IhQaHKTHRBjiXHuvzojmsXiIs/vJL5GykYWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377274; c=relaxed/simple;
	bh=oJqY31bRQ8NUc/6e6fcyxanOZbCqM6HGhLEnLWav/i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpmkTEqkXJuAl639mRb4CPOWPfiC9JBJxXeEtbtW+6peMvzMZlk6oKlmXtwn4YNoBisYur2Qi1wAyhKH8lULi/BasJfZzmngx6/vDW4R1GT4SzgokMt/cx/JcrnIq11PJDEXLWasyAd+kQHmSSlfYtZTd3CivklIm8NSarqMAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JeHQqKCI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JeHQqKCI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWpLM2063320;
	Mon, 10 Aug 2026 15:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2+4xPt
	yROPEW2f/8z22ydguA9GPpXbyhclbetF/WwPg=; b=JeHQqKCI7nYzo+0honb61q
	EvJ4apxgRbYtaYSP6z4DJH18vx+3oknM4OlfbRy5TmAx/yBJiFfDDB8mf4pVIxHP
	qnuoQY8VYU3HRGf6/Bcz8u3YX0wrtSdJQ7D1T/GpVaGE3efipm1HBsMAKSSw2uux
	w3q0W2iEaMnp5pi6y0Sm1mVq8bPrp2Gdq5BzI4ielJf5/kjnhnSCHWv/+j/LMv4T
	DhHL09y1cO9mcZSQ2GV3Rxl7n8JVaiwnR47rDtODShN+7WCXxjdB3ucjdOldj+Io
	XmLgA3q3/g0ilzruPtGTIBDgGNbdypmMCeS6crIqZCkiCPgViCM4p11vN0vlv6FA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw0dj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgSlt024459;
	Mon, 10 Aug 2026 15:54:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespwjkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsO2r39584144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA8FD20040;
	Mon, 10 Aug 2026 15:54:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1769720049;
	Mon, 10 Aug 2026 15:54:24 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:24 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:54:06 +0200
Subject: [PATCH v2 18/20] KVM: s390: vsie: Add VSIE shadow stat counters
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-18-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
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
 bh=oJqY31bRQ8NUc/6e6fcyxanOZbCqM6HGhLEnLWav/i0=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVX5TKf82NeygvlrHy0Ipn2fOKGFrrFYscQpaV6fnmO
 ty/MWNLRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABM5EcXwzzyJS070y88V5+6V
 PF8htrP3RbDDQtNVq349ithXtNebzYiR4fgSromcdT8M8lfnK/pw3Jvv+v3kixT76KeVMSc6nV9
 uZwcA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a79f435 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ZpPwL-J7f7Xe_5oZicQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QZT_iMWeZUZjOftO7srRXHJqb-kTbnyL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX9nq91fqRC+9s
 YHo92wJD45Nx/Gt1d6B/Ts1/RQ3PRgBfv61tuUpnKq3bB4b5+M6oS8WWuyg9pK1S0uRwcg1CEgb
 ao+WGo8eJpk59vk/Fsr886S6LZ9UrF/C0JNd3jJb6a2AOEGOMFuHWt2VyoAtdEUKo1n2wlApD3I
 HY7To1r6sANewjUp9QbzJP5h+dk7S1YfdQkqAKtbXtlFMPXZ6/rJ9kKubKn9cojzqHGvgfbKB1H
 H4tsQ6i54rTtrzeR2GCkPcqmg1Tl+64RKCX3ohiMqUuokZF5y4++eeYt3rz9U52reGvwCiKlGyM
 jK8uNjwMuqLj5LsEK4E62gq1xyu8ZxbWCcXMWp0N2vpSarOWgqbh6/nPoQ9ntZnWLQdW4vnfoHI
 C96ZLcqOD8FppSW9s0X70BvOLVNAE1Z+BXfp1RNOYuPl+9KI1mo2989ZEn5xYC7ZHSNqJkQSYSo
 BNSC9G/As2xgg+qxc0A==
X-Proofpoint-ORIG-GUID: QZT_iMWeZUZjOftO7srRXHJqb-kTbnyL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfXwYRsEV3HJL+N
 +KzbOzqrbIRi6Tf/3y2Ny+ShhBNEfTq9nr2PmwLh59v/mDrXeXgraMNThjUr1hmxHuRlgF0Igsh
 x1EuJNxq4jOzv7cM4f4qhfZHeCIMukQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

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
index 932f0437fce5..171472b8d721 100644
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
index 6f458e7b27e3..95eb1494370a 100644
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

