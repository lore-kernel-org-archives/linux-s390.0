Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309399;
	b=0hbmrcpo8mycBaS7KHK3sVsTyoKbTRXv1k1x9eGdaAASWcwnB5Ss5ZfrKxowYRlzmcMU
	 5yxZzIG4YDD/hKcjH6Mar8z/EHQ4gNdejxVtL4yMsGM0vhdVwq34qa5nbfFyo1OM0CZpR
	 CcdukmLUz+iGnSSPDjAJ1xGs/YQs3fi+mUemy+SQI94ahct4EBoqEkk1nOK8WaA8JVcnY
	 Yw9Y59JquNeTaZUqgP+N0br/C1nIV6GiG9QNjOxzRJ5eLfVxMKCKWLPq01V2pl1thdPmg
	 qqoZTm0bniuuZoebtVx09oC69H6Oo6QwmWUAIWKjETZxgM9Cc4xmYEXUK0GBtqp+BSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309399;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1ebK31odweGtQWhb8awqQiL/qswy9J94/emBFfjDc6k=;
	b=w8upfT42BGTdwgjtUnXCCKzEdSGExe8w9MCnVM8+VoNrW8l/d8w7lo3KTfT2CQ6/BEGp
	 zQ4MfTWocRVUBe8y8J/CAr8OCegLkAt8+ehXxq5foWw0cQYE64KAks4IcgdUGhtJv/Q1z
	 +Eze4HWhmpLi2MlfYb+qt72HDThvQLgS3554w6xpigNQ6BxjW0oQxTygv89mf2l8EoD3z
	 UibMwtdks8QO+GZx8EmZ6SMv6QL2Dx9tWcK/yOSjKxW1PffKct0jMacCjeERUK7Vy03Un
	 z9dCpn8mZrV2qDjCcs8GZtEHGvgjLOTa3MsIsF+nNfwj087h0fdzlvIX5wFfzFjPigw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k8v7v8EC;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186F60A2615;
	Tue, 10 Nov 2026 11:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F186F60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k8v7v8EC
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEKon2179797;
	Tue, 10 Nov 2026 11:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1ebK31odweGtQWhb8
	awqQiL/qswy9J94/emBFfjDc6k=; b=k8v7v8ECyKcsMX7tom4xS7E/e3m1Hdrj1
	K+c+iHukJ82bmy/gney5sxtlJKAVPMrk1lllcaNSXsFyNf5nF+KtV7aLGVMbAtes
	sdB2uXVQs6DUjQvscWRbg1JIKTgz9VJ8ztxw1jlBojgBBkIIdAm56d45pXglMiNj
	0fu86qF9qMhIlwNiPm9LTr9u1qN3JrGfnzDbzslJ0o6Hm1wBa9N11M/4J0QcdgUa
	NEePVRWSNr1Aftoh6SRdU+iy993ZFtrZrpgikbLmhQLjxqqPFO+hY2KFUNKolkb1
	VB92CxdvykVQ+oTAr/4vtSwP+PcIGm9AIhGnbUl9e5ihAhgkmT4Yg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuuumu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7o2JN1505967;
	Tue, 10 Nov 2026 11:16:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y5yba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABGYbr32637586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:16:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7EC25805F;
	Tue, 10 Nov 2026 11:16:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 300125805A;
	Tue, 10 Nov 2026 11:16:34 +0000 (GMT)
Received: from MacBookPro.localdomain (unknown [9.61.241.43])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:16:34 +0000 (GMT)
From: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
Subject: [PATCH 6/6] KVM: s390: selftests: Add clock comparator interrupt test
Date: Tue, 10 Nov 2026 06:16:19 -0500
Message-ID: <20261110111619.61760-7-aaronmbr@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX0pg61968tdca
 RnV0WXQE13g0o4w/fg5KzxuB5b1mmSPPAzfxtQ70Yt7HEPAInGiW4DOimn0M0+azCDDt/EYX+9S
 AhUpVKSeadPDrUS6haqRo4qOaVthuDI=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af2fd15 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-XNLLfuuKHVqFyqJWFcA:9
X-Proofpoint-GUID: YU2EyEg2_2aVPstZxgLXh6EK8HNFnhz9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX3MyrlcV7FXZR
 8t09FAzsxLY5mjI8ZaDMt1NHcTh1TBqRzweqMHNc8yN9A7OymtOoti89VzZtx7Y2Z2H2NQvtV/I
 XbnzWGxrRP0vSap4h+OWgAHrNUBwShtySvwC4LFTqYjuRSBuxAetVcWtBfe2QgwfXKMpWC2U4JG
 wOOHDYFzueegSISvVqWlI4KxziohD4NhbU2qBsCZF7mf0OUQwSNWj2TnkiD5Jx9nX0DlEUmnv+q
 FAyzn8ETSPiLVmfhnxOaaRm3qSGWwi2Kt2sPtrIUB4i07In+K4kJlYBsxw0kJXCjIBSYWwLDEeS
 ClLmjsvyk1wS/3x+462HJpyQGUjZzYSu0pEPNu06p3cR3CJwHUwUYowi+Ng6UQQR2Um8xUKXqZP
 +Jmpv5Sb02QdubPXeB6ftxGo5Q0ILMJl1yMVdM0FIy8LqnTaV51nWB3dTTTw5EXLFqKigzM9Knf
 7c66BAYHkhIgGl8PBFA==
X-Proofpoint-ORIG-GUID: YU2EyEg2_2aVPstZxgLXh6EK8HNFnhz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

Add a test that injects a clock comparator interrupt into a ucontrol
VM. The guest sets the clock comparator far in the future, sets the
subclass mask, and waits with the external mask set.

The first KVM_RUN exits with ICPT_WAIT. Inject KVM_S390_INT_CLOCK_COMP
and run again. Check for ICPT_EXTREQ.

Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390/kvm_exit.c | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
index 4b9b30cd4e2a..0d2fd4f39a9c 100644
--- a/tools/testing/selftests/kvm/s390/kvm_exit.c
+++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
@@ -42,6 +42,8 @@ int capget(cap_user_header_t header, cap_user_data_t data);
 #define SSKE_SUBOPCODE 0x2b
 #define SSKE_OPCODE 0xb2
 #define PSW_WAIT_BIT_MASK (1ULL << (63 - 14))
+#define PSW_CLOCK_WAIT 0x0102000180000000ULL
+#define CLK_COMPARATOR_MASK_BIT (1ULL << 11)
 #define PGM_CODE_GPA_ADDRESS 0x8e
 #define PGM_CODE_MASK        0x7f
 #define PGM_NEW_PSW_GPA 0x1d0
@@ -682,6 +684,73 @@ static bool test_immediate_exit(void)
 	return true;
 }
 
+static void guestcode_clock_comparator(void)
+{
+	asm volatile(
+		/* Set SCKC to the maximum value so it cannot expire on its own */
+		"lghi %%r7, -1\n"
+		"stg  %%r7, 0(%%r15)\n"
+		"sckc 0(%%r15)\n"
+		/* Enable clock comparator interrupt in CR0 (bit 52) */
+		"stctg %%c0, %%c0, 0(%%r15)\n"
+		"oi    6(%%r15), 0x8\n"
+		"lctlg %%c0, %%c0, 0(%%r15)\n"
+		/* Load enabled wait PSW: 64-bit, DAT off, wait bit, external interrupt enabled */
+		"larl  %%r8, 1f\n"
+		"lpswe 0(%%r8)\n"
+		".align 8\n"
+		"1: .quad %[wait_psw], 0\n"
+		:
+		: [wait_psw] "i" (PSW_CLOCK_WAIT)
+		: "r7", "r8", "memory"
+	);
+	GUEST_DONE();
+}
+
+static bool test_clock_comparator_interrupt(void)
+{
+	struct kvm_parameters param = {
+		.guest_code = guestcode_clock_comparator,
+		.manual_parameters.immediate_exit_condition = false,
+	};
+	struct kvm_s390_irq irq = {};
+	int rc;
+
+	if (!ucontrol_available())
+		return false;
+
+	ksft_print_msg("Testing Clock Comparator Interrupt Exit\n");
+	param = manual_kvm_creation_execution(param);
+
+	/* On a ucontrol VM, the guest's enabled wait exits to userspace as ICPT_WAIT. */
+	TEST_ASSERT(param.run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Expected SIEIC, got %u\n", param.run->exit_reason);
+	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_WAIT,
+		    "Expected ICPT_WAIT (0x1c), got 0x%x\n",
+		    param.run->s390_sieic.icptcode);
+	TEST_ASSERT((param.run->s.regs.crs[0] & CLK_COMPARATOR_MASK_BIT) != 0,
+		    "CR0 clock comparator bit not set, cr0=0x%llx\n",
+		    param.run->s.regs.crs[0]);
+
+	/* Inject clock comparator interrupt as a ucontrol VMM would */
+	irq.type = KVM_S390_INT_CLOCK_COMP;
+	rc = ioctl(param.manual_parameters.vcpu_fd, KVM_S390_IRQ, &irq);
+	TEST_ASSERT(rc == 0, "KVM_S390_IRQ (clock comp) failed (%d)", errno);
+
+	/* With the interrupt pending and external interrupts enabled, expect ICPT_EXTREQ. */
+	rc = ioctl(param.manual_parameters.vcpu_fd, KVM_RUN, NULL);
+	TEST_ASSERT(rc == 0, "KVM_RUN (2) failed (%d)", errno);
+	TEST_ASSERT(param.run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Expected SIEIC on second run, got %u\n",
+		    param.run->exit_reason);
+	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_EXTREQ,
+		    "Expected ICPT_EXTREQ (0x10), got 0x%x\n",
+		    param.run->s390_sieic.icptcode);
+
+	manual_cleanup(param);
+	return true;
+}
+
 static void test(void)
 {
 	int i;
@@ -738,6 +807,11 @@ static void test(void)
 			.test = test_immediate_exit,
 			.skip_reason = "KVM_CAP_S390_UCONTROL unavailable or insufficient privilege"
 		},
+		{
+			.name = "Testing Clock Comparator External Interrupts",
+			.test = test_clock_comparator_interrupt,
+			.skip_reason = "KVM_CAP_S390_UCONTROL unavailable or insufficient privilege"
+		},
 	};
 
 	ksft_print_header();
-- 
2.50.1 (Apple Git-155)

