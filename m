Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491121;
	b=O57VvR+ICE8TiOuaiEFc1eUYCaYaCmOSz/rezfStmK6p48W3Pld+SREo/D7UKOhOlQ8+
	 FRPeVt+YQiQTHXlt8WS9zl+8g1CwroDV+JgWhwfC3ZDWxluSsTPuNB/IUV6JKiOrzCtYp
	 ufypHKOv1+K2ocT2zaGICr60FzhtHSLBtFdxQ4dWQmgIlWc6l23UHfJrdMzsdI2+WA+23
	 eLUpnJf32aWeTAS0vHDqrRaRcuk4/oUGZmBu7iXXP7YHOAj08+TiV/4Ut45gvoyaMyLuC
	 6A8DoQso3uD3sXdKlD7m8opOjsxDeP26Jdd6E+Jc6e2gIbrBl+lAD0MOrpmO1nq+IlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491121;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FaT8gH18DUw5Fot23FFeVAxKZv7oyJmprKLRp8kvO4c=;
	b=QS/d/sTchcTiUZAShz+q9TAP2nn7lIIyCJRuw2jM3AU/JC15ua941I2NjTWef7QSd7j0
	 OZe9ae4P+IkXjdP1t71PI1M1jPgDH1jsOLVgaceTF3kTHyJYzFUw8uMFrcYmX0U25H/Ad
	 5xFDoDQ8xCTm5vNgHHPaSX4GvYOLk6u74Sf9SpMQIJfxZHLv/BGrSSvWiC3kTSIP0BZHG
	 rediGXCe88lkm5FojdzqwGClMqnxITYM5k4hNJ6ie/yNSLlmU9WunkaZoyAnKfEO0SkBb
	 o8LwLOhd8qYhZBUeGguWPRMoARgYfkOg8kwFU2Ni6GjirQiNRQH2rj4NeFeJiHwMbsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cK7TV0x2;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926A606A32D;
	Thu, 12 Nov 2026 13:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2926A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cK7TV0x2
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iPSq2796254;
	Thu, 12 Nov 2026 13:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FaT8gH
	18DUw5Fot23FFeVAxKZv7oyJmprKLRp8kvO4c=; b=cK7TV0x21OveeS08j3090c
	2YARV1zDACVbht13lxTgU6ywzPPZxdDcmSOfwY1URPt5itcVAlgG4JbWMGUektaj
	50lTBPEbUQstKaDwV1t8H/w6rew1w81OMOF76F/Z0g1pB5EgfxA/GWZ8RU6zs/Z2
	RZ/K6qvDoD2cx2J9d2d0h2mIrnKoEy08tGozqXsgonZVR5M5X8VLvBNrGfI6mI57
	admjXeAkYgiAZiwIfPEZd7aIpr1VzHpPaetnog8WslRQP9tK2S/xUHXiKWZJyinw
	VR3+HApDHP/3F6HZQvG7rsgAP1p3mRMjMdRJQZtgAN6hXNEY9z2IB0XUqzrV9mQA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdky8bp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:45:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACDb4AQ729199;
	Thu, 12 Nov 2026 13:45:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegf80s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:45:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACDjDxb35193296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 13:45:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE0F2004B;
	Thu, 12 Nov 2026 13:45:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8116720040;
	Thu, 12 Nov 2026 13:45:13 +0000 (GMT)
Received: from [9.111.70.171] (unknown [9.111.70.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 13:45:13 +0000 (GMT)
Message-ID: <90cf2229-af79-4f08-b001-753dc7a86aa2@linux.ibm.com>
Date: Thu, 12 Nov 2026 14:45:13 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] KVM: s390: selftests: Add kvm_exit test for
 instruction intercepts
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>, kvm@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-2-aaronmbr@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261110111619.61760-2-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af5c2f0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=dzDuJC72ndYMTPXVUbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfXyWDb3Qh/lKC4
 WsFgDLL2/vwLipzSm3ALoOm9aEfIBvbjWWliV1XAatRlmPYXDydN/XOJrCBhIvA3SuWKAZf/DxS
 pWwkazJrwKt01e7wZ0prGzwqoAAZx8aAMEpr230lpro0qSFKmRbxpv9+lTMt3A+dCxzAS/MffKM
 T9lfGyhd34+hVsP5elqxzH6zEfian4f1tk9IMH6wRTGV8CchTv5e7gLKrGVjuNLkJpgff00ggHu
 qEb1Ni/kipWyO9orRmD6c4QB00s8Ha3pCaOd+4JbSo1peOFdqZIeYe3NpPf15nnjiI+74T+5PfR
 wD9JwXUkpT+hXWr/C9+20MLV1+Sijy2lJPuW614o+sxkmxYhDxeGsJnjgggU0p/tGakiScD4lhE
 +IywaFBb4esFoNIAXpkZjTC+bIZRwekHrHh5HJyMLotXlMTerh0xpW/zs8dcIPhz2FDwsyADuJP
 QhpOYtfs7YNGy/DFKAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX4Y6Us7TwgXI+
 BEF5bpW+9K9114mLSmDh9h3o3AD4A2d7VY2lNQdtmvQQIw4Lple0pp9OVwmbaewVcnxWVTssBFr
 yRi5rzW0kKGtaui4cVSJLuQq/IYCFIA=
X-Proofpoint-ORIG-GUID: RLiV4AM40clGbkI18LuG1L-NzgZ8o2Zm
X-Proofpoint-GUID: RLiV4AM40clGbkI18LuG1L-NzgZ8o2Zm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054

On 11/10/26 12:16 PM, Aaron M. Brown wrote:
> Add a selftest for the exits KVM reports to userspace on s390x, mainly
> KVM_EXIT_S390_SIEIC. This patch adds the harness and the instruction
> intercept tests:
> 
> - DIAG 0x500: inject an external call, check it is pending, resume, and
>    compare the registers with those synced in kvm_run.
> - DIAG 0x501: check the opcode and diagnose code in ipa and ipb.
> - DIAG 0x501 with registers set beforehand: check they are intact.
> 
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../kvm/include/s390/kvm_lifecycle.h          |  35 +++
>   tools/testing/selftests/kvm/s390/kvm_exit.c   | 212 ++++++++++++++++++
>   3 files changed, 248 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
>   create mode 100644 tools/testing/selftests/kvm/s390/kvm_exit.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 17a4256e9081..a46a75c90e66 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -232,6 +232,7 @@ TEST_GEN_PROGS_s390 += s390/irq_routing
>   TEST_GEN_PROGS_s390 += mmu_stress_test
>   TEST_GEN_PROGS_s390 += pre_fault_memory_test
>   TEST_GEN_PROGS_s390 += s390/irq_injection
> +TEST_GEN_PROGS_s390 += s390/kvm_exit
>   
>   TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
>   TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
> diff --git a/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h b/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
> new file mode 100644
> index 000000000000..7dec11a6e214
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Definition of structs for KVM lifecycle tests.
> + *
> + * Copyright IBM Corp. 2026
> + *
> + * Authors:
> + *  Nitya Khamar (nkhamar@linux.ibm.com)
> + *  Aaron Malik Brown (aaronmbr@linux.ibm.com)
> + */
> +#ifndef SELFTEST_KVM_LIFECYCLE_H
> +#define SELFTEST_KVM_LIFECYCLE_H
> +
> +#include "kvm_util.h"
> +#include <stdbool.h>
> +
> +struct kvm_lifecycle_testdef {
> +	const char *name;
> +	bool (*test)(void);
> +};
> +
> +struct kvm_parameters {
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	void *guest_code;
> +	struct kvm_run *run;
> +	unsigned int interrupt_type;
> +	struct kvm_s390_irq *irq;
> +	struct kvm_s390_irq_state *irq_state;
> +	struct {
> +		bool immediate_exit_condition;
> +	} manual_parameters;
> +};

In this patch I don't see any benefit in having this struct.
I'm hoping there's some use for it in later patches.

> +
> +#endif /* SELFTEST_KVM_LIFECYCLE_H */
> diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
> new file mode 100644
> index 000000000000..140358357c67
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test for KVM Exits to userspace on s390x
> + *
> + * Copyright IBM Corp. 2026
> + *
> + * Authors:
> + *  Nitya Khamar <nkhamar@linux.ibm.com>
> + *  Aaron Malik Brown <aaronmbr@linux.ibm.com>
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "kselftest.h"
> +#include <errno.h>
> +#include "processor.h"
> +#include "ucall_common.h"
> +#include "sie.h"
> +#include "kvm_lifecycle.h"
> +
> +#define NUM_GPRS 16
> +#define DIAG_ASSEMBLY_CODE 0x501
> +#define IPA_DIAG 0x83
> +
> +static struct kvm_parameters create_vm_kvm_exit(struct kvm_parameters parameters)

Why aren't we using a pointer to the argument?

> +{
> +	parameters.vm = vm_create_with_one_vcpu(&parameters.vcpu,
> +						parameters.guest_code);
> +	return parameters;
> +}
> +
> +static void cleanup_kvm(struct kvm_parameters *parameters)
> +{
> +	kvm_vm_free(parameters->vm);
> +}

These two function generate >= 4 lines for a single line of useful code.

> +
> +static void compare_regs(struct kvm_regs *regs, struct kvm_sync_regs *sregs)
> +{
> +	int register_number;
> +
> +	for (register_number = 0; register_number < NUM_GPRS; register_number++)
> +		TEST_ASSERT_EQ(regs->gprs[register_number], sregs->gprs[register_number]);
> +}
> +
> +static void guestcode_instruction_intercept(void)
> +{
> +	asm volatile("diag 0,0, 0x500\n" :::);
> +	GUEST_DONE();
> +}
> +
> +static bool test_instruction_intercept(void)
> +{
> +	struct kvm_parameters param = {
> +		.guest_code = guestcode_instruction_intercept,
> +		.interrupt_type = KVM_S390_INT_EXTERNAL_CALL,
> +		.manual_parameters.immediate_exit_condition = false,
> +	};
> +	struct kvm_s390_irq_state irq_state = {};
> +	struct kvm_s390_irq irq = {};
> +	struct kvm_regs regs;
> +	int interrupts;
> +
> +	ksft_print_msg("Testing Instruction Intercept Exit\n");
> +	param = create_vm_kvm_exit(param);
> +	vcpu_run(param.vcpu);
> +	param.run = param.vcpu->run;
> +	irq.type = param.interrupt_type;
> +	irq.u.extcall.code = param.vcpu->id;
> +	irq_state.len = sizeof(irq);
> +	irq_state.buf = (unsigned long)&irq;
> +	param.irq = &irq;
> +	param.irq_state = &irq_state;
> +	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
> +		    "Failed with Unexpected icptcode of 0x%x\n",
> +		    param.run->s390_sieic.icptcode);
> +	interrupts = __vcpu_ioctl(param.vcpu, KVM_S390_SET_IRQ_STATE,
> +				  param.irq_state);

Why are we doing two things at the same time?
What does the IRQ code add to the test?



> +	TEST_ASSERT(interrupts >= 0, "Cannot Inject Interrupt (%d)", errno);

That should be a == 0, no?
Documentations says "0 on success".

> +	irq_state.buf = (unsigned long)&irq;
> +	irq_state.len = sizeof(irq);
> +	interrupts = __vcpu_ioctl(param.vcpu, KVM_S390_GET_IRQ_STATE,
> +				  &irq_state);
> +	TEST_ASSERT(interrupts > 0,
> +		    "Expected pending interrupt after injection, got %d", interrupts);

Here it's fine since the rc returns the number of bytes KVM copied.
But we could actually check for a number being at least len(irq_state)

> +	TEST_ASSERT_EQ(irq.type, KVM_S390_INT_EXTERNAL_CALL);
> +	TEST_ASSERT_EQ(irq.u.extcall.code, param.vcpu->id);
> +	vcpu_run(param.vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
> +		    "Expected ICPT_INST from GUEST_DONE after inject, got 0x%x\n",
> +		    param.run->s390_sieic.icptcode);
> +	vcpu_regs_get(param.vcpu, &regs);
> +	compare_regs(&regs, &param.run->s.regs);
> +	cleanup_kvm(&param);
> +	return true;
> +}
> +
> +static void guestcode_diagnose_hypercall(void)
> +{
> +	asm volatile("diag 0,0, 0x501\n" :::);
> +}
> +
> +static bool test_diagnose_code(void)
> +{
> +	struct kvm_parameters param = {
> +		.guest_code = guestcode_diagnose_hypercall,
> +		.manual_parameters.immediate_exit_condition = false,
> +	};
> +	ksft_print_msg("Testing Diagnosis Hypercall Exit\n");

Instruction is called diagnose according to the POP.

> +	param = create_vm_kvm_exit(param);
> +	vcpu_run(param.vcpu);
> +	param.run = param.vcpu->run;
> +	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
> +		    "Failed with Unexpected Exit Reason of %u and icptcode of 0x%x\n",
> +		    param.run->exit_reason, param.run->s390_sieic.icptcode);
> +	TEST_ASSERT(param.run->s390_sieic.ipa >> 8 == IPA_DIAG,
> +		    "Failed with Unexpected Opcode of %u\n",
> +		    param.run->s390_sieic.ipa >> 8);
> +	TEST_ASSERT(param.run->s390_sieic.ipb >> 16 == DIAG_ASSEMBLY_CODE,
> +		    "Failed with Unexpected Diagnose Code of %u\n",
> +		    param.run->s390_sieic.ipb >> 16);
> +	cleanup_kvm(&param);
> +	return true;
> +}
> +
> +static void guestcode_diagnose_conditional(void)
> +{
> +	asm volatile("lghi %%r3,0x3333\n"
> +		"lghi %%r5, 0x555\n"
> +		"lghi %%r6, 0x3333\n"
> +		"cgrjne %%r6, %%r3, 1f\n"
> +		"diag 0,0, 0x501\n"
> +		"1:\n"
> +		:
> +		:
> +		: "r3", "r5", "r6"
> +	);
> +	GUEST_DONE();
> +}
> +
> +static bool test_diagnose_conditional_code(void)
> +{
> +	struct kvm_parameters param = {
> +		.guest_code = guestcode_diagnose_conditional,
> +		.manual_parameters.immediate_exit_condition = false,
> +	};
> +	struct kvm_regs regs;
> +
> +	ksft_print_msg("Testing Diagnosis Hypercall for Conditional Code Exit\n");

What is this testing?


> +	param = create_vm_kvm_exit(param);
> +	vcpu_run(param.vcpu);
> +	param.run = param.vcpu->run;
> +	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
> +		    "Failed with Unexpected Exit Reason of %u and icptcode of 0x%x\n",
> +		    param.run->exit_reason, param.run->s390_sieic.icptcode);
> +	TEST_ASSERT(param.run->s390_sieic.ipa >> 8 == IPA_DIAG,
> +		    "Failed with Unexpected Opcode of %u\n",
> +		    param.run->s390_sieic.ipa >> 8);
> +	TEST_ASSERT(param.run->s390_sieic.ipb >> 16 == DIAG_ASSEMBLY_CODE,

Which diag assembly code?
There's a huge number of them and this test already uses 2.

> +		    "Failed with Unexpected Diagnose Code of %u\n",
> +		    param.run->s390_sieic.ipb >> 16);
> +	vcpu_regs_get(param.vcpu, &regs);
> +	TEST_ASSERT_EQ(regs.gprs[3], 0x3333);
> +	TEST_ASSERT_EQ(regs.gprs[5], 0x555);
> +	TEST_ASSERT_EQ(regs.gprs[6], 0x3333);
> +	cleanup_kvm(&param);
> +	return true;
> +}
> +
> +static void test(void)
> +{
> +	int i;
> +	struct kvm_lifecycle_testdef testlist[] = {
> +		{
> +			.name = "Testing Instruction Intercepts",
> +			.test = test_instruction_intercept,
> +		},
> +		{
> +			.name = "Testing DIAG Code",
> +			.test = test_diagnose_code,
> +		},
> +		{
> +			.name = "Testing Conditional DIAG Code",
> +			.test = test_diagnose_conditional_code,
> +		},
> +	};
> +
> +	ksft_print_header();
> +	ksft_set_plan(ARRAY_SIZE(testlist));
> +
> +	for (i = 0; i < ARRAY_SIZE(testlist); i++) {
> +		if (testlist[i].test())
> +			ksft_test_result_pass("%s\n", testlist[i].name);
> +		else
> +			ksft_test_result_skip("%s\n", testlist[i].name);
> +	}
> +}
> +
> +int main(void)
> +{
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_USER_MEMORY2));
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SYNC_REGS));
> +	test();
> +	ksft_finished();
> +}

