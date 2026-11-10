Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309397;
	b=URmb6bzKlQ1AOQj50/tDkrtIcgBuAGIPNXyQLisVfu0FMToTBeQyj1oAdNt8ng6zdx9f
	 qD3t31xdIL0PBZtJsMMJOSJFRwIGryOI7FPeAToKCqgIstS8zxDNKD8DjR9YenSar5kgo
	 xjuU4K6FqNnx4JZXUbaYythbHq2DhXepLgNlT5HrydC5yjvWvSWtnBH9WxDHRiadnPULQ
	 9ZZFZhRfe9kB28O8XnZ+Gd51zwjDSCpdFxNEI5z3rJ7o2qc7RZkx5R3BNSlBAIuV2b1Lc
	 M13a52YsrT+bv9pFTz6vEYezUXrvAuxq1/+jUvkmtne1KZol3PyrSXAs4BXLqKohIdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309397;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=F5RTTDA/kpTa3FXsON0SDYEc/lnM21uS5G4YDmWr+B4=;
	b=vddondjuk8LJ3ndYCgO44yb9DSuQKwTgMT0Uz4TXLxshHWpN+FpVrJzl+SDVZoddCN/m
	 DpAo5Vy2VlrtNTUfAFWcXxQrHJTl7K76uBVe4hqJWY4fOYirMaVZKEqyRpDd9geY8un+L
	 fk6UiSbakKF/vtl7WgRYSQutYx/c8PA+X/AN6SUMahqXIG9fdXAFl7BSlTsVP7lUS1Y7O
	 5vEdcWnluW6/cGP3aC0+8nJHdRSyjeMUaMhhnPO9yJRN/erXj2knG2btxPqZiMbw1YGnr
	 NhPtVRnf+GichFREEucQ25Bclslg07XwSqOAv/7Yf7Jw9O9iRug3IivLrNCsfExzYMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Oxjz44bD;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855D606A33D;
	Tue, 10 Nov 2026 11:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3855D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Oxjz44bD
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEAia2376534;
	Tue, 10 Nov 2026 11:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F5RTTDA/kpTa3FXsO
	N0SDYEc/lnM21uS5G4YDmWr+B4=; b=Oxjz44bDQ1tg3N+ye3XBJmwsa/yhWxpgT
	gdxfo0qh/+KFoBeP/CDjd0CWkMXFCyzfEBQ8Am7Nmd1s0NCO9qJu1LRe1YycmDgb
	A6GMu6IE214MoEQQUuYNJkkSDMfEkl3G5BGjeO0jR6ny/x6HSObmNyTqh6kcc8ts
	YN/e7BS9hodZ/otvitAM5p/4rPdqZkEFUUxii2bZ/xtshsxswmX/jwKU4ExIhkP6
	Un2hNcWfiHDE2ZXiOvHRTrgBCeRAb+4w6zYKtk/hmUZzaR0ufJfQ1BpAnuGYYyXv
	6RK0+oyATJIZXZV59VaGQEw6amNFXf8wSaduLqBWcfKRSjUrNJ1QQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug64jsp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7o3H11505992;
	Tue, 10 Nov 2026 11:16:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y5yb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABGWPg65405246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:16:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A74005805E;
	Tue, 10 Nov 2026 11:16:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB355805A;
	Tue, 10 Nov 2026 11:16:32 +0000 (GMT)
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
Subject: [PATCH 3/6] KVM: s390: selftests: Add wait state and VM lifecycle tests
Date: Tue, 10 Nov 2026 06:16:16 -0500
Message-ID: <20261110111619.61760-4-aaronmbr@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NfFzM3YRRkPJwC_F466p2Tx0gZDBY-EM
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af2fd14 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=anTWP1fZpf_-wTlijt4A:9
X-Proofpoint-GUID: NfFzM3YRRkPJwC_F466p2Tx0gZDBY-EM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX2ykZifkJsUVb
 H9VhWbmyO2sqtsgtRePi8ntGTwwKUpdHTKRYb3PuZx452PYT6L3/IJPKasNTeeGBoH4K1+wijuX
 ze8r4VSfp07jAv3qfAySTmvQtccEZD3Ona+9Zs60ySJlDHTMeyC67mwURInVCobDrSZVRA7DCN4
 EPzq6Dmv8MG5JZBTA6KCrNidV/uODC8bRjLCgmEU/soW40rAhC67aFcfydi57lZc2x19Aznq0It
 S252Pc2J8acjmsRt52YdKLFvzpnSu68e45t8r4fk4WqRijQxON0frhhuoJi0zv+nEk3MXLCLr0m
 SFMF5+Nd4+/yd+vxEq3JktTxYqQTLw5BOJJ35w57ndAnfrF1z9yGvznbu3r7auOZR9L62u7+Tu/
 A541Y086Xhiglaory/b/OFzgMOQEWY4gb3FQjY6KBm3U6uFPa8BOOLlD6UoejX6ZRk/xoDX6W/H
 B84jSKK2G6o20ayTjBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX4NAO3/aTELTk
 YO7HxRLn9EEKoh1c6Ct/F3yAQzOAhogoqK70ie3f15GXDeBb2zt4EhNKT/eckYnnIwFPXrFrRAu
 i2ZvjOCdP+h2FX1eIv/6EdiPwCEEfrA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

Add two tests:

- Wait state: the guest loads a PSW with the wait bit (bit 14) set and
  the I/O, external and machine-check masks (bits 6, 7, 13) clear.
  Check for ICPT_WAIT and the wait bit in the PSW.
- VM create and destroy: before the first KVM_RUN, check that
  exit_reason is KVM_EXIT_UNKNOWN and immediate_exit is clear.

Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390/kvm_exit.c | 78 +++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
index 4a6f01ff14ca..2f73eae1954a 100644
--- a/tools/testing/selftests/kvm/s390/kvm_exit.c
+++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
@@ -27,6 +27,7 @@
 #define IPA_DIAG 0x83
 #define PSW_MASK_64BIT_DAT_OFF  0x0000000180000000ULL
 #define PGM_CODE_SEGMENT_TRANSLATION 0x10
+#define PSW_WAIT_BIT_MASK (1ULL << (63 - 14))
 #define PGM_CODE_GPA_ADDRESS 0x8e
 #define PGM_CODE_MASK        0x7f
 #define PGM_NEW_PSW_GPA 0x1d0
@@ -308,6 +309,75 @@ static bool test_translation_exceptions(void)
 	return true;
 }
 
+static uint64_t psw_save[2] __aligned(16);
+
+static void guestcode_wait_state(void)
+{
+	register uint64_t *psw_ptr asm("r4") = psw_save;
+
+	asm volatile(
+		"lghi  %%r3, 0x3333\n"
+		"lgrl  %%r7, 1f\n"
+		"stg   %%r7, 0(%%r4)\n"
+		"xgr   %%r5, %%r5\n"
+		"stg   %%r5, 8(%%r4)\n"
+		"lpswe 0(%%r4)\n"
+		".align 8\n"
+		"1: .quad 0x0002000180000000\n"
+		:
+		: "d"(psw_ptr)
+		: "r3", "r5", "r7", "memory"
+	);
+}
+
+static bool test_wait_state(void)
+{
+	struct kvm_parameters param = {};
+	struct kvm_regs regs;
+
+	ksft_print_msg("Testing Wait State Exit\n");
+	param.guest_code = guestcode_wait_state;
+	param = create_vm_kvm_exit(param);
+	vcpu_run(param.vcpu);
+	param.run = param.vcpu->run;
+	TEST_ASSERT(param.run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Expected KVM_EXIT_S390_SIEIC, got %u\n",
+		    param.run->exit_reason);
+	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_WAIT,
+		    "Failed with Unexpected Exit Reason of %u and icptcode of 0x%x\n",
+		    param.run->exit_reason, param.run->s390_sieic.icptcode);
+	vcpu_regs_get(param.vcpu, &regs);
+	TEST_ASSERT(regs.gprs[3] == 0x3333,
+		    "Expected 0x3333 but got 0x%llx\n", regs.gprs[3]);
+	/* Check PSW wait bit (bit 14 from MSB = bit 63-14 from LSB) */
+	TEST_ASSERT((param.run->psw_mask & PSW_WAIT_BIT_MASK) != 0,
+		    "PSW wait bit not set, PSW Mask = 0x%llx\n",
+		    param.run->psw_mask);
+	cleanup_kvm(&param);
+	return true;
+}
+
+static void guestcode_nop(void)
+{
+	GUEST_DONE();
+}
+
+static bool test_vm_create_and_destroy(void)
+{
+	struct kvm_parameters parameters = {.guest_code = guestcode_nop};
+
+	ksft_print_msg("Testing VM Closure without Running vCPU\n");
+	parameters = create_vm_kvm_exit(parameters);
+	TEST_ASSERT(parameters.vcpu->run->exit_reason == KVM_EXIT_UNKNOWN,
+		    "Unexpected Exit Reason Before vCPU Execution: %u\n",
+		    parameters.vcpu->run->exit_reason);
+	TEST_ASSERT(parameters.vcpu->run->immediate_exit == 0,
+		    "Immediate Exit Unexpected Behavior: %d\n",
+		    parameters.vcpu->run->immediate_exit);
+	cleanup_kvm(&parameters);
+	return true;
+}
+
 static void test(void)
 {
 	int i;
@@ -336,6 +406,14 @@ static void test(void)
 			.name = "Testing Translation Exceptions",
 			.test = test_translation_exceptions,
 		},
+		{
+			.name = "Testing Wait State",
+			.test = test_wait_state,
+		},
+		{
+			.name = "Testing VM Create and Destroy",
+			.test = test_vm_create_and_destroy,
+		},
 	};
 
 	ksft_print_header();
-- 
2.50.1 (Apple Git-155)

