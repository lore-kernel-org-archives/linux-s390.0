Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309399;
	b=yLoGel0mMIZsasCVFnBKKhTppq7ybHsm9BPLGzkOdIRj+fXblq0F7LpkwBIOu7jM3lbX
	 dUBc3mEKIHxcUi0QRUkmY+HmFqm+OyHHqIAJg+kayeKI3msPVEydiPEAxJMjvcr6KS+QG
	 QVpa7Zt/ETaa8lJKoauEtEDJk05wLD/Z6oZI4qj9x4wzldOtWVHMM8YQxpoo/7pO5dbci
	 3AaiDDuUuNYPkrQp7s+2U5l0f4BKkoHAswFQOMelGnuIvL8+TSJxzxsC4ng0+AvlvaPvt
	 mHduJCVw18WnzGnUXaDV7lZTXusuVy3nTZwikK9cCUoJ1/LGMtS7Pdb8lmJjsVdk3YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309399;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Fc9RhK0DBS+LmXhd7bJN9thdyFsHQod2cJzQXhbHKBU=;
	b=Ii7ilP6+bJAHkwjp4lLwWGXFzBlFNH3otYd44doCYkaPYNciEUUXoiOv1gciM3X6Nv2A
	 qULSmkElF385SKwr/W4PYwuqQTSXSPCAOVwtTGAbr/d3Z8KqjSYlk4GfZFnTuqhNPphUJ
	 J1Oxnfpknvl91VM1uwoDCa7Jtn1Hd1Uh8T89yisho1lsXm3WM78pTt7e1TnyzGWH1y6xI
	 f111dyu7PTJlD8ZBqZobeK5Y+ItArXVNqZEiaiBEMuk/GkoLhIR2yTFnW3DamnLDdT7mC
	 WegyLI2f/go1nyAFSBEG+swpp6jvBWcPGXpeyTyXvUL2cAwWpAQHnfWEhTolxLjOtPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KMeg+rzP;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90660A2610;
	Tue, 10 Nov 2026 11:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E90660A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KMeg+rzP
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEZBB2179956;
	Tue, 10 Nov 2026 11:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fc9RhK0DBS+LmXhd7
	bJN9thdyFsHQod2cJzQXhbHKBU=; b=KMeg+rzPW4/Jv8xvl6MKYEfSFUHSQg4JY
	jnD7+WZC4+bzAgAIsxNiTmXKUIYdo+O0tlPR4fYNJCzTxbUU+uIPY8hLJHtPk/x0
	2wk5XS/628fPKHOFLesQ5AaIdk4PR1Ro2oChr7bHZzc8d9jVwrwcwxnZQICSEX0R
	vTbl/Xmkuo0HQOlQpm1XQJ86FPR9ryYg8GOJ4F0jogefeaXbRSGeL0SmlJzUDwc3
	VCjheV12mqQbSAxni69wIwr85KzZEFD58qs1IRFWvMV4fnqb9Mpv4CuJqd4hZvLs
	J+pogoTlbzygToEs2lPN19XA1RXOj+KTn0AKmYakMLkazvbhbWeaw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuuumt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7nuwi331799;
	Tue, 10 Nov 2026 11:16:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg617g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABGYHB31916734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:16:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 159BF58051;
	Tue, 10 Nov 2026 11:16:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F12A5805A;
	Tue, 10 Nov 2026 11:16:33 +0000 (GMT)
Received: from MacBookPro.localdomain (unknown [9.61.241.43])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:16:33 +0000 (GMT)
From: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
Subject: [PATCH 5/6] KVM: s390: selftests: Add ucontrol storage key and immediate exit tests
Date: Tue, 10 Nov 2026 06:16:18 -0500
Message-ID: <20261110111619.61760-6-aaronmbr@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX0Wt9FU8Dk7iq
 qgb09SkbzNreZ7zFtQEnYwGFToYzohVsvCeyYQFLaC3PRwZUpZ4UrkXEkc5Q+KE++0+Y+iL46/a
 9U3pwUD7NoxUQRb2ubQNZhqtEmUFiuk=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af2fd15 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=TRWk677NCLsTFGTt9tsA:9
X-Proofpoint-GUID: PkVjSq8OGNx3cBqd4UCr7N9X_-zcX3Xb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX298dwXxDYONf
 hJOIwDhGBj32gKpGRKEFYKDCGX4+CnOkhcchhP96rDaTTazNjKo1OnSVeK4ebebLyQZ90e+N654
 qIlsq8/HvT/hODhsqpi2Sk0vv4GW+5zQJEMVGlXYVZWJfY2A/aUUtkhraxrbCIzQgiL1GkJzTyK
 M5JNb3xQgaeTmva1iO6cMIrfmW9cI2go4AapQJgIarqWRU6QsbVJcb6eE7IZsDSBX8ci995uM/N
 LbvWzuzup2U/sYRzqNJm4/0dhEC45bUCVopLeaH5mzWkywxpQaR0T01K5405Kr7pFTfTr2vdxpd
 mKhuxChR3tayfB73iEYP5sKeCcxSpyyUl67n0Tq6+QF4e8KVQesV1958TPRucdrm0Su6iLBJCsc
 z/glrE7xFQWzZdIumq/RzhK2VV08j4WUD/xuL74ZHaZp5Z6YxIim0LRwDv8cEZ1J/AxcWG/XiuY
 3Lou0Aj+GtcvHGOZaaw==
X-Proofpoint-ORIG-GUID: PkVjSq8OGNx3cBqd4UCr7N9X_-zcX3Xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

Add two more ucontrol tests:

- Storage key: the guest executes SSKE. Check for ICPT_KSS and the key
  in the guest register. Skip if CPUSTAT_KSS is not set, as the
  intercept is not generated then.
- Immediate exit: set immediate_exit and a marker register before
  KVM_RUN. Check for EINTR, exit_reason KVM_EXIT_UNKNOWN, and that the
  marker is unchanged.

Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390/kvm_exit.c | 107 ++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
index d0a3894daf0d..4b9b30cd4e2a 100644
--- a/tools/testing/selftests/kvm/s390/kvm_exit.c
+++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
@@ -37,6 +37,10 @@ int capget(cap_user_header_t header, cap_user_data_t data);
 #define STSI_IPA 0xb27d
 #define TSCH_IPA 0xb235
 #define STSCH_IPA 0xb234
+#define EXPECTED_STORAGE_KEY 0x20
+#define IPA_SUBOPCODE_MASK_SKEY 0xff
+#define SSKE_SUBOPCODE 0x2b
+#define SSKE_OPCODE 0xb2
 #define PSW_WAIT_BIT_MASK (1ULL << (63 - 14))
 #define PGM_CODE_GPA_ADDRESS 0x8e
 #define PGM_CODE_MASK        0x7f
@@ -121,6 +125,15 @@ static struct kvm_parameters manual_kvm_creation_execution(struct kvm_parameters
 	param.run->s.regs.gprs[15] = CODE_GPA - 160;
 	param.run->kvm_dirty_regs |= KVM_SYNC_GPRS;
 
+	if (param.manual_parameters.immediate_exit_condition) {
+		param.run->immediate_exit = 1;
+		param.run->s.regs.gprs[3] = 0xdead;
+		param.run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+		rc = ioctl(param.manual_parameters.vcpu_fd, KVM_RUN, NULL);
+		TEST_ASSERT(rc == -1 && errno == EINTR, "KVM_RUN failed (%d)", errno);
+		return param;
+	}
+
 	rc = ioctl(param.manual_parameters.vcpu_fd, KVM_RUN, NULL);
 	TEST_ASSERT(rc == 0, "KVM_RUN failed (%d)", errno);
 
@@ -585,6 +598,90 @@ static bool test_io_instruction_code(void)
 	return true;
 }
 
+static void guestcode_storage_key(void)
+{
+	asm volatile(
+		"lghi %%r3, 0\n"
+		"lghi %%r2, %[skey]\n"
+		"sske %%r2, %%r3\n"
+		:
+		: [skey] "i" (EXPECTED_STORAGE_KEY)
+		: "r3", "r2"
+	);
+}
+
+static bool test_storage_key_interrupt(void)
+{
+	struct kvm_parameters parameters = {
+		.guest_code = guestcode_storage_key,
+		.manual_parameters.immediate_exit_condition = false,
+	};
+
+	if (!ucontrol_available())
+		return false;
+
+	ksft_print_msg("Testing Storage Key Interrupt KVM Exit\n");
+	parameters = manual_kvm_creation_execution(parameters);
+
+	/* Skip on hosts where sclp.has_kss is false. */
+	if (!(parameters.manual_parameters.sie_block->cpuflags & CPUSTAT_KSS)) {
+		manual_cleanup(parameters);
+		return false;
+	}
+
+	TEST_ASSERT(parameters.run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Expected KVM_EXIT_S390_SIEIC, got %u\n", parameters.run->exit_reason);
+	TEST_ASSERT(parameters.run->s390_sieic.icptcode == ICPT_KSS,
+		    "Failed with Unexpected Exit Reason of %u and icptcode of 0x%x\n",
+		    parameters.run->exit_reason, parameters.run->s390_sieic.icptcode);
+	TEST_ASSERT((parameters.run->s390_sieic.ipa & IPA_SUBOPCODE_MASK_SKEY) == SSKE_SUBOPCODE,
+		    "Expected SSKE Sub Opcode of 0x2B, Result of 0x%x\n",
+		    parameters.run->s390_sieic.ipa & IPA_SUBOPCODE_MASK_SKEY);
+	TEST_ASSERT((parameters.run->s390_sieic.ipa >> 8) == SSKE_OPCODE,
+		    "Expected SSKE Opcode of 0xb2, Actual of 0x%x\n",
+		    parameters.run->s390_sieic.ipa >> 8);
+	TEST_ASSERT(parameters.run->s.regs.gprs[2] == EXPECTED_STORAGE_KEY,
+		    "Storage Key not stored correctly, got 0x%llx\n",
+		    parameters.run->s.regs.gprs[2]);
+
+	manual_cleanup(parameters);
+	return true;
+}
+
+static void guestcode_immediate_exit(void)
+{
+	asm volatile(
+		"lghi %%r3, 0x3333\n"
+		:
+		:
+		: "r3"
+	);
+}
+
+static bool test_immediate_exit(void)
+{
+	struct kvm_parameters parameters = {
+		.guest_code = guestcode_immediate_exit,
+		.manual_parameters.immediate_exit_condition = true,
+	};
+
+	if (!ucontrol_available())
+		return false;
+
+	ksft_print_msg("Testing KVM Immediate Exit\n");
+	parameters = manual_kvm_creation_execution(parameters);
+
+	TEST_ASSERT(parameters.run->exit_reason == KVM_EXIT_UNKNOWN,
+		    "Expected KVM_EXIT_UNKNOWN (0), got %u\n",
+		    parameters.run->exit_reason);
+	TEST_ASSERT(parameters.run->s.regs.gprs[3] == 0xdead,
+		    "Guest code executed when it should not have: r3=0x%llx\n",
+			parameters.run->s.regs.gprs[3]);
+
+	manual_cleanup(parameters);
+	return true;
+}
+
 static void test(void)
 {
 	int i;
@@ -631,6 +728,16 @@ static void test(void)
 			.test = test_io_instruction_code,
 			.skip_reason = "KVM_CAP_S390_UCONTROL unavailable or insufficient privilege"
 		},
+		{
+			.name = "Testing Storage Key Interrupts",
+			.test = test_storage_key_interrupt,
+			.skip_reason = "KVM_CAP_S390_UCONTROL, privilege or KSS unavailable"
+		},
+		{
+			.name = "Testing Immediate Exit",
+			.test = test_immediate_exit,
+			.skip_reason = "KVM_CAP_S390_UCONTROL unavailable or insufficient privilege"
+		},
 	};
 
 	ksft_print_header();
-- 
2.50.1 (Apple Git-155)

