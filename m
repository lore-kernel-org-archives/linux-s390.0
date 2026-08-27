Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6748665F;
	Thu, 27 Aug 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845997; cv=none; b=ZUy+pUMO0bJ/iP7sHjCwMMl1T14mrhXmftDo1j5Rez3WFnnKDXy3AC5gKyAgUpqNRg7S3h5vLyabzzYhIiJEQG4yly9h6vqG4ZVCgGTUY8h1ds0OqFDHCnVlO7XD+YN1MAko6U+DnERaJ2JO0srx+CwRhAM/Ouc4IV52H4Wc7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845997; c=relaxed/simple;
	bh=ne7m5RFVGu2UVXW//+n9RosiR+N8NVUUxxb5xjK8yJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CR9v2ulxVbaDtVoQldvq0q++63Th3a2964VsMQVw+k1vYIICyGFXaGu+I9NWpr8rIzSw1Mui/QibeZe6ti0NjpC0K9r4SS4CflDznxx0oPoI0MFDb9Ok8f+1kt0fTajLXNaGjvOPEs+3Lc5xAiibzHVUUoQdGyM1aiPO7+l5QP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JqVqAMmF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JqVqAMmF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF585R1478416;
	Thu, 27 Aug 2026 15:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HAQpr4
	qkgPzYapDFz3UunMDBF0QfiLh50TV8UwpcYPM=; b=JqVqAMmFljHkmRCJM+K6KD
	5857PxUbIyk8ZwbBJGCfdHQ3zaYWxYfw0Git8bo5G1eCOlR1Tnf1F2pPPj4NkiK5
	eS8f4Tn83M8EEZGvQHFXCW7WmSYEYqUie1Koee2T97Fl/h73NUMGN3HN054v+mBN
	0QjccJbLIeo5kr9/8Elx7dvAH2wS+G8f1ytqYt8o8tDKQLEsBX94rJKwOr5j9nad
	R2gCn4nnOejxf7js8SSEjGruZ1T5FswqJPx4pCVkxHThbm/cg62WRqHrOVUSDtQD
	ktiAs//heFUEGQwAs0tmdV1h7RURowo/BaxZ9NsgDCHmIgNDSD6jm5cSOKnKnkpw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er6b9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfeFE026712;
	Thu, 27 Aug 2026 15:53:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qh4ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr7WR35520998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A110620043;
	Thu, 27 Aug 2026 15:53:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7E6D2004F;
	Thu, 27 Aug 2026 15:53:06 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:06 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:57 +0200
Subject: [PATCH v6 17/21] KVM: s390: vsie: Allow guest-3 cpu add and remove
 with ssca
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-17-8020bb53be52@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4214;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=ne7m5RFVGu2UVXW//+n9RosiR+N8NVUUxxb5xjK8yJk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoM7VTfoWa5asXhP5PO8//8sXWZ1r53/kvPL5+r2G
 zZWsQpiHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzkcyQjQ28FU568Sfj/7IN3
 H83m/S0zPU9COOHjwwJjnV/7ThkVlTIyHH3l9fY1Z7TZxJs/nr1Pe7VzbebSgONPjT6/krGUZvs
 dxQMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: diIjzz9A9PlmLxLmx16WAwpReK5iRpCH
X-Proofpoint-ORIG-GUID: qsOpG4LgeQbNwrkKFvnRUQxRNs2Id-1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX2rFCRmCyFFNQ
 knYSBXMXznx94bieZeCsRxGeKZms5pIOX9ml1s0xkr8Wgrsi8BSHbfqpVy+TOMiyIgNSOROz/7D
 jhjxnw4Lw4hfyAHV+turAWZBUn8OoHvH7f3LRa/rtKIFEQF2Udl77I1mk60h+SCnrHckaISLzlf
 VYIVN5IR3Ptmrpbi/9cqBotNezhbWYIVmrEUxfjE25ZfDBuoDZhyyUpFlTOsk9hR7j4WmmmRctU
 YiGCW05USgi1xBWDBI8PazDyBY68qdG8/Le6OhmHugea5zVcXMyMPbQxHgwA3m8TJoznXRfe7F6
 fIp6Qfb/hq4xsmsZgJt7n/nFHjPWdKkZMFZi7/A2vUBjxic/OeJvPODMYwE+e9m/eW/bZ5e+een
 +MQ+YaSN74GOboPfolsWYXUTuKjs55T1gDn2jE67PHEpdyxB+6JrwmlSl1Z3UH9vAaGTyWO5PMJ
 YPZDE27I7mj0vzMctEA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a905d68 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=PXeH2Pb9wBGPeq1YnyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX0Rkw+P4zvrQt
 eYzMmYp1+4CaIPq6KrrfALxmCnxwQRScCpcNxPJjvgEQ1ZRzRrVodXD0mUUUj900e4TwLuwCcPg
 eg16Z3pmOXAmMRyg3emVVE3DF38XUa4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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
index 16273cf5cbff..bfd5df1f8b9c 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -2093,6 +2093,43 @@ static int get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca
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
@@ -2142,17 +2179,17 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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
@@ -2179,19 +2216,26 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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

