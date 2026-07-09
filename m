Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CA383316;
	Thu,  9 Jul 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610140; cv=none; b=HBoQFROl2ixQyqoZOskCw91h0zYSPl1GG7hMqvsP9giMuaVVNDk1vEAwm/27njFkoE8l2gf46Za30HfPc5zaLB6ZhBYXsrsA/BFiV6twaEBkQsbxzB+Gbrr6Gx4fWO8e00chYzDjbyF8vMz+f5m9fuE6wtYB8LDCnv+ya5OaN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610140; c=relaxed/simple;
	bh=yVXsG475EOxvnZK5feZO1BGPTHWAi+ZSnYIme2XDylE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rr3WxRrvgduM/IeT1zerEAb3WMyRQ5NhusCldFhQutlGY8/hPKN62fdozSQQjY5Ik15t5RJzi6Cirw363VGvHUxxXptR/6RezGdKwnD4AHcQald5M0G8NG7PqrDhV5bUQB/RvMcMDci9wDYiZ9CV1izuggIpvd+O2AbfNLDX11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TqreRQDr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TqreRQDr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIn691497508;
	Thu, 9 Jul 2026 15:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MW6p+R
	utD+7J7kp902Wy9XSnDOr9sP5gbaZa/KRMpOE=; b=TqreRQDrbvq8qBM+p8bOQE
	9nrWLV2zvvtIjh75Fe5B7rqE0i44dnehbjb+z727x8PsP1tqNVIi5PYt0WksQvy1
	TPOlvWtmuTiTo+ffff+3e71FJANS7UwcCy/XxtmIYNYgyoE8iMkOMgzkfLLqRuyQ
	kKXKE2tBGo/iwPsJ6Adr78W1Bp7JlznFrx7DuY6BzJRupXFvJVJKY3ie5Wi6768J
	sTNCY63wToGUW54BB/at6PFHiPB8GYCJ1IN8f0/yxMtfFpRPVktq3hau+l+zZjLb
	trwUBWc8ApWi5r1Cq52IJ9Ih7zsQ8233aNUluXWd8djmZafrlRxBbn9VgiQXXlyw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt2m0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4jw5026950;
	Thu, 9 Jul 2026 15:15:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwdvdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFUuR46661962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D097420040;
	Thu,  9 Jul 2026 15:15:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4111B2004E;
	Thu,  9 Jul 2026 15:15:30 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:30 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:17 +0200
Subject: [PATCH 17/21] KVM: s390: vsie: Allow guest-3 cpu add and remove
 with vsie sigpif
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-17-ea9f12066408@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4505;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=yVXsG475EOxvnZK5feZO1BGPTHWAi+ZSnYIme2XDylE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1nPeJ4MW6FRntRSlfspb3+3++b+RXPuHatrqJi3e
 vMJMyu9jlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACZS/Z2Roees+QRF7h/NFYKq
 /6VrohlYJrre5V6U2Php2rXYwzEyNYwMvxIE1j+716dftLsi66rV+tdqlYZZ/RyRxrVvjkydeLG
 ZDQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K5TPTjRBuET_iQWafeIPPW0OEXc2R5qQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXwsQUSUiA5zy7
 SAntvF2bDsblnbQlIvdmY/Ug99hmxM03uyVxRlrksyozzK4aIYJefB/IcWh5fX1xdoVBk4pcdiF
 /IPFjaX5axo688LTB7M/i0cBUV3ME1U=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4fbb17 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=NGxpWG_ktdww3nycDa4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: K5TPTjRBuET_iQWafeIPPW0OEXc2R5qQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX9qQMPo4fWlc2
 bQeUyQQcq4ZcKxcbonWRx5xcPbU9VxXZKX8LwuPAjAZjq3/MSGZhg4CJ6TJItfmqPiR5iHI2RIn
 zjhMS5Nv2jQ9kluriBd5t4sVEtNYM3iXUw6DkKnvmPMKqHSqpMC9OqhiK5qGxdETtpPQvvnzezM
 5lSh9r8sS5gfdm4WM47E1SpfjUSLpXDcaqk1ekz8hhsKomObkqC/tKASoe14PHT1qZJxmrRxYaC
 6e5KD5DeeYgf+p/2RWYvW26SoG55vuujGzLV57aEhgdtUolX08RRiI2lqbJu81u9t5OQXk/1tP7
 8nEEQzpPIxZ8yIIt029Akj7S9HWBasvTuHYrndEM+jxjakeN57TlDjm3Gb71PVwlYkniln/a169
 1c9TlrfKJgT9c6aBRhI+JAprLo1+MACpL77sGrWvVv2gFTNKvKY0w/JoQMDUO10/SSTWD5sdpi0
 c2Fp3cMqHuwEWDE+ATg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090146

As we are shadowing the SCA we need to add and remove the pointers to
the shadowed control blocks and sca entries whenever the mcn /
processors in the configuration changes.

It is not expected that the mcn changes frequently for a already running
guest-3 configuration. So we can simply fully re-init the ssca whenever
the mcn changes.
To detect the mcn change we store the expected mcn in the struct
vsie_sca when running init_ssca().

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 68 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 74455c689c51..de8931e714ca 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -2014,6 +2014,43 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 	return vsie_page;
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
+	int size = BYTES_PER_LONG;
+
+	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags)) {
+		offset = offsetof(struct esca_block, mcn);
+		size = BYTES_PER_LONG * 4;
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
+	int size = BYTES_PER_LONG;
+
+	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags)) {
+		size = BYTES_PER_LONG * 4;
+		offset = offsetof(struct esca_block, mcn);
+	}
+
+	return !memcmp(&vsie_sca->mcn, sca + offset, size);
+}
+
 static void vsie_sca_update(struct vsie_sca *vsie_sca, unsigned int cpu_nr,
 			    struct vsie_page *vsie_page_n, hpa_t sca_o_entry_hpa)
 {
@@ -2031,18 +2068,14 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	unsigned int cpu_nr, cpu_slots;
 	struct vsie_page *vsie_page_n;
 	hva_t sca_o_entry_hva;
-	unsigned long *mcn;
 	gpa_t scb_o_gpa;
 	int rc;
 
-	if (is_esca)
-		mcn = phys_to_virt(sca_o_hpa) + offsetof(struct esca_block, mcn);
-	else
-		mcn = phys_to_virt(sca_o_hpa) + offsetof(struct bsca_block, mcn);
+	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa));
 
 	/* pin and make shadow for ALL scb in the sca */
 	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
-	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);
 		if (rc)
 			goto err;
@@ -2074,7 +2107,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	return 0;
 
 err:
-	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		vsie_sca->ssca.cpu[cpu_nr].ssda = 0;
 		vsie_sca->ssca.cpu[cpu_nr].ossea = 0;
 	}
@@ -2084,13 +2117,24 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 /* Shadow or reshadow the SCA on VSIE enter. */
 static int shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct vsie_sca *vsie_sca)
 {
-	int rc = 0;
+	struct kvm_s390_sie_block *sca_o = phys_to_virt(vsie_sca->sca_o_pages[0].hpa);
+	bool do_init_ssca;
 
-	guard(rwsem_write)(&vcpu->kvm->arch.vsie.vsie_sca_lock);
-	if (!vsie_sca->ssca.osca)
-		rc = _shadow_sca(vcpu, vsie_page, vsie_sca);
+	scoped_guard(rwsem_read, &vcpu->kvm->arch.vsie.vsie_sca_lock) {
+		do_init_ssca = !vsie_sca->ssca.osca;
+		do_init_ssca = do_init_ssca || !sca_mcn_equals(vsie_sca, sca_o);
+		if (!do_init_ssca)
+			return 0;
+	}
 
-	return rc;
+	scoped_guard(rwsem_write, &vcpu->kvm->arch.vsie.vsie_sca_lock) {
+		do_init_ssca = !vsie_sca->ssca.osca;
+		do_init_ssca = do_init_ssca || !sca_mcn_equals(vsie_sca, sca_o);
+		if (do_init_ssca)
+			return _shadow_sca(vcpu, vsie_page, vsie_sca);
+	}
+
+	return 0;
 }
 
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)

-- 
2.55.0

