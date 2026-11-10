Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309396;
	b=Q2KEdaxCvXOxVNgPWA5Q5GqnS+2HAJf3GsYteI56ETdCxU+bXnme58PVDiq2zKZA945j
	 aF+Wr7YbM+99MwXisko/fEBQUSZrARWt2Jyl7PHAgjti/Or+a7h671qgQ7qUqQ6LkUZn5
	 sDq4YjamYSOLv3kM1EV0gL8KIPThqNlpMd2QIeDJihKfzSpcnh1SCHll58MppmhdKROE2
	 L0OY/dVD6+InnJ8UQ9VktJlySlSn5kKgJAJmImJvUP/YZyGUQ48egBdIXCVTJrcZ70ln7
	 9gpi7Fheq3QIKq8p8gf558nbcml2dNDOdghehjXJr3HB5Iui8H006KY7OjXGt4GuZhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309396;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NIHNGigbmY8fXdxfriNqFEjgJ3awRng2OAoihebEAD0=;
	b=zaE3O31BjTn6ajj1UbZW6kOdQ2NQTYTSR3TyE0F6OiO88LbZkbDTq3Hlpd+SzG6U1rOP
	 K727s7k1HlWj2vDY329xPkIcZuQmDFoRvjn10dUbetrCTJ8POrDY2nxjuIyAB98rOO5qE
	 zb1+sB7je3UMGcshsS7vOxWmzSv1UzoYvqc3O98if9L+xeHbgZEwFmLvE8qYnF+3qovfK
	 iD3A83RtVAz6GmiA/iJToVgQb5apXF1v3BnYesguwRTu4RfHEkD5cERjzEcI05EMDZVFK
	 ZOsXFF/0evMxS0D4NabLPx57dwVPvOxbXkmf10khmkTVrxo1RNLUWtKZbWvg0jSBxjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mwA4KEfy;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312C606A325;
	Tue, 10 Nov 2026 11:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F312C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mwA4KEfy
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEw7O537023;
	Tue, 10 Nov 2026 11:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NIHNGigbmY8fXdxfr
	iNqFEjgJ3awRng2OAoihebEAD0=; b=mwA4KEfyXB/KHgrI6E0NUyLB1SHYAYNOw
	D9v06NOdAGx2RxzobtHAFz70Yqhhw/jFOK+VMr0mX283GdoaxTW5z5eBZ1Pzb7bT
	NPMZTCBZfC67iwCehgK1dzKSV4tFp8HEDkLbYYetveBczeG3yAD2H9LDY01rXbLR
	LF1eeI0f4oqcItKT1Wpxar7t4S64eBn1zsOK3GzLJDOygE5cMeb5SEkPpRW6njIv
	MCnq4jF2PRfdJCmDMDtt8AtxrTqq9vOQEbxWKvX4LMmxqrUjT+pLbgq7d4yqVtRq
	iXMSYU7MA5HLHtZKhxTsTEz/FmUaqIgLLZWBRxvMcGlqSxtpIKgwA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt4k30-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7nuDi1541650;
	Tue, 10 Nov 2026 11:16:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthp6g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABGWad63504754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:16:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E77CD5805F;
	Tue, 10 Nov 2026 11:16:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62A855805A;
	Tue, 10 Nov 2026 11:16:31 +0000 (GMT)
Received: from MacBookPro.localdomain (unknown [9.61.241.43])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:16:31 +0000 (GMT)
From: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
Subject: [PATCH 2/6] KVM: s390: selftests: Add SIGP and program exception tests
Date: Tue, 10 Nov 2026 06:16:15 -0500
Message-ID: <20261110111619.61760-3-aaronmbr@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX7j5y+JSNsXDc
 rQkMovjDzkxvkw99OBjbVw5Zw48POqTKDM5PVjlOW2l8xSu7y9L6qXKT0VHUq5f3Mo54Hp5iRLL
 6cLwPREprYqfjui9wQo8iBaF1hlKF1BLVSZzFkZogJfvduajJRFUdXbH1gsb/YrXEPprH+Iu2A1
 23JyIVHtbYf19FV+P5EJVoJfDGXSE9rD7rrw4VjPUJts4AAhK1eLcLzn9/uyMGpU0M3bhBz+P7b
 yIm2jnic14pPRvduwhfcGW8tZW5L3N2Fe4D9jIqtTYmPOyEUH4sJ0BgXres4IAEBivouR6Tu+kh
 r6vPzBQlylfjO77Ln+eo78gRsHX3D4BnmX4n9xqxDCip/c33hCgZ6ioI53VMEZUCZjdG4beEkoO
 4PLNB3NvNkLfuxAmOf8HkELvCQ2pgkfOgU8bJmUKaV1fqsgXtrYVBdi2CcUSxXGCU4U2Ei+s4cW
 hUhWrZoyAV7XntYV8NQ==
X-Proofpoint-ORIG-GUID: E1mdn1afR568bPjrLGTcl62BZzVk4q2V
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX0jB5O+NZl+A4
 Y/nMROcAAbnorNoboX71+sIvmC3nzLuRmsmKiGj978Kj6U0dvL39FaX8fS4kEYp0dJp0B6aC6jv
 Xxiy/331OoKhF+tg5yfLs8eMdSFztP0=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af2fd13 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=KxAmmVnd5jFDCmTr5awA:9
X-Proofpoint-GUID: E1mdn1afR568bPjrLGTcl62BZzVk4q2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

Add tests for:

- SIGP: a second vCPU stops vCPU 0. Both vCPUs are set to operating
  first, as KVM ignores a stop order sent to a stopped vCPU. Check for
  ICPT_STOP.
- Addressing exception (DAT off): check for program code 0x05.
- Segment translation exception (DAT on): check for program code 0x10.

The program new PSW is set to a disabled wait so the guest exits
deterministically.

Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390/kvm_exit.c | 146 ++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
index 140358357c67..4a6f01ff14ca 100644
--- a/tools/testing/selftests/kvm/s390/kvm_exit.c
+++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
@@ -25,6 +25,12 @@
 #define NUM_GPRS 16
 #define DIAG_ASSEMBLY_CODE 0x501
 #define IPA_DIAG 0x83
+#define PSW_MASK_64BIT_DAT_OFF  0x0000000180000000ULL
+#define PGM_CODE_SEGMENT_TRANSLATION 0x10
+#define PGM_CODE_GPA_ADDRESS 0x8e
+#define PGM_CODE_MASK        0x7f
+#define PGM_NEW_PSW_GPA 0x1d0
+#define PSW_DISABLED_WAIT 0x0002000180000000ULL
 
 static struct kvm_parameters create_vm_kvm_exit(struct kvm_parameters parameters)
 {
@@ -174,6 +180,134 @@ static bool test_diagnose_conditional_code(void)
 	return true;
 }
 
+/*
+ * Make a program interrupt end in a disabled wait, which KVM reports to
+ * userspace as ICPT_WAIT. This does not depend on how KVM handles
+ * repeated operation exceptions.
+ */
+static void set_pgm_new_psw_disabled_wait(struct kvm_vm *vm)
+{
+	uint64_t *new_psw = addr_gpa2hva(vm, PGM_NEW_PSW_GPA);
+
+	new_psw[0] = PSW_DISABLED_WAIT;
+	new_psw[1] = 0;
+}
+
+static void guestcode_sigp(void)
+{
+	asm volatile(
+		"lghi %%r3, 0\n"
+		"sigp %%r1, %%r3, 0x05\n"
+		:
+		:
+		: "r1", "r3"
+	);
+	GUEST_DONE();
+}
+
+static bool test_sigp_signals(void)
+{
+	struct kvm_parameters param = {
+		.guest_code = guestcode_sigp,
+		.manual_parameters.immediate_exit_condition = false,
+	};
+	struct kvm_mp_state mp_state = { .mp_state = KVM_MP_STATE_OPERATING };
+	struct kvm_vcpu *vcpu1;
+	struct kvm_regs regs;
+
+	ksft_print_msg("Testing SIGP KVM Exit\n");
+	param = create_vm_kvm_exit(param);
+	vcpu1 = vm_vcpu_add(param.vm, 1, guestcode_sigp);
+	/* New vCPUs are stopped, and KVM ignores a SIGP STOP sent to one */
+	vcpu_mp_state_set(param.vcpu, &mp_state);
+	vcpu_mp_state_set(vcpu1, &mp_state);
+	vcpu_regs_get(param.vcpu, &regs);
+	regs.gprs[3] = 0x3333;
+	vcpu_regs_set(param.vcpu, &regs);
+	vcpu_run(vcpu1);
+	/* vcpu1 exits after GUEST_DONE() ucall */
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu1, KVM_EXIT_S390_SIEIC);
+	vcpu_run(param.vcpu);
+	param.run = param.vcpu->run;
+	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT_EQ(param.run->s390_sieic.icptcode, ICPT_STOP);
+	/*
+	 * The pending SIGP STOP stops vcpu0 before it runs any guest code
+	 * (the guest would clear r3), so r3 keeps the marker value.
+	 */
+	TEST_ASSERT_EQ(param.run->s.regs.gprs[3], 0x3333);
+	cleanup_kvm(&param);
+	return true;
+}
+
+static void guestcode_address_exception(void)
+{
+	asm volatile(
+		"lghi %%r1, 0x1\n"
+		"sllg %%r1, %%r1, 0x28\n"
+		"lg %%r2, 0(%%r1)\n"
+		:
+		:
+		: "r1", "r2"
+	);
+}
+
+static bool test_address_exceptions(void)
+{
+	struct kvm_parameters param = {};
+	uint16_t pgm_code;
+
+	ksft_print_msg("Testing Address Exception Exit\n");
+	param.guest_code = guestcode_address_exception;
+	param = create_vm_kvm_exit(param);
+	set_pgm_new_psw_disabled_wait(param.vm);
+	param.vcpu->run->psw_mask &= PSW_MASK_64BIT_DAT_OFF;
+	/* The guest runs with DAT off, so the entry point must be a GPA */
+	param.vcpu->run->psw_addr = addr_gva2gpa(param.vm, param.vcpu->run->psw_addr);
+	param.vcpu->run->kvm_dirty_regs |= KVM_SYNC_ARCH0;
+	vcpu_run(param.vcpu);
+	param.run = param.vcpu->run;
+	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT_EQ(param.run->s390_sieic.icptcode, ICPT_WAIT);
+	pgm_code = *(uint16_t *)addr_gpa2hva(param.vm, PGM_CODE_GPA_ADDRESS);
+	TEST_ASSERT((pgm_code & PGM_CODE_MASK) == 0x05,
+		    "Expected PGM code 0x05 (addressing), got 0x%x\n", pgm_code);
+	cleanup_kvm(&param);
+	return true;
+}
+
+static void guestcode_translation_exception(void)
+{
+	asm volatile(
+		"lghi %%r1, 0x1\n"
+		"sllg %%r1, %%r1, 0x14\n"
+		"lg %%r2, 0(%%r1)\n"
+		:
+		:
+		: "r1", "r2"
+	);
+}
+
+static bool test_translation_exceptions(void)
+{
+	struct kvm_parameters param = {};
+	uint16_t pgm_code;
+
+	ksft_print_msg("Testing Translation Exception KVM Exit\n");
+	param.guest_code = guestcode_translation_exception;
+	param = create_vm_kvm_exit(param);
+	set_pgm_new_psw_disabled_wait(param.vm);
+	vcpu_run(param.vcpu);
+	param.run = param.vcpu->run;
+	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT_EQ(param.run->s390_sieic.icptcode, ICPT_WAIT);
+	pgm_code = *(uint16_t *)addr_gpa2hva(param.vm, PGM_CODE_GPA_ADDRESS);
+	TEST_ASSERT((pgm_code & PGM_CODE_MASK) == PGM_CODE_SEGMENT_TRANSLATION,
+		    "Expected PGM code 0x10 (segment translation), got 0x%x\n", pgm_code);
+	cleanup_kvm(&param);
+	return true;
+}
+
 static void test(void)
 {
 	int i;
@@ -190,6 +324,18 @@ static void test(void)
 			.name = "Testing Conditional DIAG Code",
 			.test = test_diagnose_conditional_code,
 		},
+		{
+			.name = "Testing SIGP Exits",
+			.test = test_sigp_signals,
+		},
+		{
+			.name = "Testing Address Exceptions",
+			.test = test_address_exceptions,
+		},
+		{
+			.name = "Testing Translation Exceptions",
+			.test = test_translation_exceptions,
+		},
 	};
 
 	ksft_print_header();
-- 
2.50.1 (Apple Git-155)

