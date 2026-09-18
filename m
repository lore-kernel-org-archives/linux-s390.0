Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144624FE2FA;
	Fri, 18 Sep 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744192; cv=none; b=ltoTzjWVk2yRlCnargIgXB4b8FTlbWT45fdCbGr3cW+yj1k9Djm8tN8h+gLP9E9J6AwLXajeMV+y+0xid6fMSQVj1e4Gk/DWhcdHSuhG+YI5uWIFgVpYKV8+m+4oc3DmSWFxz9FgtMd/1VIXANBl7ilmgECw/D2867qpS3mopec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744192; c=relaxed/simple;
	bh=zMEK1fHDJyr1vQq1N/cOGeWU7tMIzHnmacWuKGxOFl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJVBXWUHR4Jm8zdJpsH9K1tMWfyB1HMTUo1+gVKM/720k12YTnPe+9rqiy/cGd+rUPyP2TknOweTZxGKyeWcf3jujPv5UL+6TtfLNsFu+p9TrInAo2iyFg5he0yJtXuyIn1BuRsRlFa/Q50CtQOtKt83qOpTUIeRFKZ/XMqwB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PsAHFbY+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PsAHFbY+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVP6P1378388;
	Fri, 18 Sep 2026 15:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0We4L1
	IJuA+i33IibAE3X2jEpB7PG7NpJaDPXAt6t28=; b=PsAHFbY+tvpB/1Z8Xm1hSp
	ioLwTx1ssP7PkDTF3qSXLuxXoQSbhBxIGj7Bn6a/GZxmPq3t6RJc8hELqD9O0pYZ
	YRtRmHiPaZaEQtNR62QEi2I9PGhJCINim4UvoCYcOV/9PayYYEc+kcPYwoWbwkNK
	3S30J2NlrYUY3KXOqZOeCWUKqQFcgvxh6knTQQvtezp6tg0Kwn5/YSNbv5tO9bu+
	Iyr/ONEyc9sauyQM01vohqA9nUTPB64UX/it0t1wvsBWl/HMJPRGJG0uWwwp2K4E
	v5ztbYt2lMul0WOQAr6YFsFiwNIgGt/y88FpSm9UD7cHJodztggn2dX0K8y2OQ8g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx848ssc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNtXm722781;
	Fri, 18 Sep 2026 15:09:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjqv83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9WF645285674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE96620040;
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68BBB2004B;
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:34 +0200
Subject: [PATCH v7 17/21] KVM: s390: vsie: Allow guest-3 cpu add and remove
 with ssca
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-17-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4214;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=zMEK1fHDJyr1vQq1N/cOGeWU7tMIzHnmacWuKGxOFl4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQ5Ray++YxG9yecugmuRizchVW8S4MGVj9WKj9t/Xl
 l7Tm1jfUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwETef2b47zRlWvekabcs/i1Z
 1tNQ/zE5QdFmlsSf+f+DznAcruJtucTIcEY/bauE84F1S72qVmT6H2q3OSiWW7JTcp2pZ9syfkU
 3FgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXxPMYX60lcoGm
 Vlw65xi+38zx+CEByvkujotkAX6U8lv05MUWTSug1phsliahPXaXISia/u3eyMoJPc7klGhqqZC
 ZflzWyfPY53ZaVWJ25gXQANa4m5XXxC2kgFWwmkY4ocdUONJWzq2l9/sYoSGq6GMFaKv1nEPUaN
 FXG7vvSgrEoHCaFeGQcLxDku2enQwggTlLCZFxXzEXNKR83sVu789rVUC5EGs8/Cn6BRPXJkNQw
 dPBDPi/tq1rVMvprgQt0liwhGBEXx7q7cr4YdbpH9xX5vN43D2glhKDlOWzPfWRE7K+D/0DvFKA
 cJhTu4P86EIcL7xnhF1tgDpJARSJ4yRgEAzMlDxH3tl9dW2lKcvWV6d/9+YcKVMdV/WasjbJqQb
 6aHpCmGc08DawYxLr73EZv8WYXc+8CuJmT2Acy5nvCImEdaVoJk2AaDUQBEwmJX16jb5mhruM2j
 OasYJptcRf2vQ7ll7tg==
X-Proofpoint-ORIG-GUID: Dy6bpRVc47R2npEfshD3FvrmkKlwZkh9
X-Proofpoint-GUID: NlGH-YKIMUsfPXTp8A8pSc-4RQOB2cO7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX6n9grCg3KoEw
 s/2Dtl+BoE9Hq9XqxHUsPaj7R3ZfPHF8Il1I+3xfcQTT+tSHdN/tY1J3fDP3HqiZ3d2zGZ75eDg
 wqSWZA1c3Lu6UZWRHeqb+j2CZB4ArOM=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad5432 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=PXeH2Pb9wBGPeq1YnyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

As we are shadowing the SCA we need to add and remove the pointers to
the shadowed control blocks and sca entries whenever the mcn /
processors in the configuration changes.

It is not expected that the mcn changes frequently for an already
running guest-3 configuration. So we can simply fully re-init the ssca
whenever the mcn changes.
To detect the mcn change we store the expected mcn in the struct
vsie_sca when running _shadow_sca().

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 66 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index ce053905a9d8..698f17a5f19d 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -2101,6 +2101,43 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca
 	return 0;
 }
 
+/*
+ * Copy the mcn from the osca to the vsie_sca to be able to detect mcn changes later on.
+ *
+ * @vsie_sca: vsie_sca to copy mcn to.
+ * @sca: Pointer to a struct bsca_block or struct esca_block to read from.
+ */
+static void sca_mcn_copy(struct vsie_sca *vsie_sca, void *sca)
+{
+	int offset = offsetof(struct bsca_block, mcn);
+	int size = sizeof(unsigned long);
+
+	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags)) {
+		offset = offsetof(struct esca_block, mcn);
+		size = size * 4;
+	}
+	memcpy(&vsie_sca->mcn, sca + offset, size);
+}
+
+/*
+ * Compare the mcn from the given sca to the vsie_sca to be able to detect mcn changes.
+ *
+ * @vsie_sca: vsie_sca to compare mcn to.
+ * @sca: Pointer to a struct bsca_block or struct esca_block to compare to.
+ */
+static bool sca_mcn_equals(struct vsie_sca *vsie_sca, void *sca)
+{
+	int offset = offsetof(struct bsca_block, mcn);
+	int size = sizeof(unsigned long);
+
+	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags)) {
+		size = size * 4;
+		offset = offsetof(struct esca_block, mcn);
+	}
+
+	return !memcmp(&vsie_sca->mcn, sca + offset, size);
+}
+
 static void update_vsie_sca(struct vsie_sca *vsie_sca, unsigned int cpu_nr,
 			    struct vsie_page *vsie_page_n, hpa_t sca_o_entry_hpa)
 {
@@ -2150,17 +2187,17 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	bool is_esca = sie_uses_esca(vsie_page->scb_o);
 	unsigned int cpu_nr, cpu_slots;
 	hpa_t sca_o_entry_hpa;
-	unsigned long *mcn;
 	int rc;
 
 	if (is_esca)
-		mcn = phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct esca_block, mcn);
+		set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
 	else
-		mcn = phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct bsca_block, mcn);
+		clear_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
+	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
 
 	/* pin and make shadow for ALL scb in the sca */
 	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
-	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);
 		if (rc)
 			break;
@@ -2187,19 +2224,26 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	return rc;
 }
 
+static bool shadow_sca_needed(struct vsie_sca *vsie_sca)
+{
+	if (!vsie_sca->ssca.osca)
+		return true;
+	return !sca_mcn_equals(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
+}
+
 /* Shadow or reshadow the SCA on VSIE enter. */
 static int shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct vsie_sca *vsie_sca)
 {
-	int rc = 0;
+	scoped_guard(rwsem_read, &vcpu->kvm->arch.vsie.vsie_sca_lock) {
+		if (!shadow_sca_needed(vsie_sca))
+			return 0;
+	}
 
 	guard(rwsem_write)(&vcpu->kvm->arch.vsie.vsie_sca_lock);
-	if (!vsie_sca->ssca.osca)
-		rc = _shadow_sca(vcpu, vsie_page, vsie_sca);
-
-	if (!rc)
-		write_scao(&vsie_page->scb_s, virt_to_phys(&vsie_sca->ssca));
+	if (!shadow_sca_needed(vsie_sca))
+		return 0;
 
-	return rc;
+	return _shadow_sca(vcpu, vsie_page, vsie_sca);
 }
 
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)

-- 
2.55.0

