Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555333;
	b=fyW9cjk6RIBUUMIB+seAUaluT3+ajF7glzVi87d+nZVJVm6ghGXFIirq/o1Byl9hgVk5
	 Dj+T//O+bebYwLp/hi9D7pBiC4B13uR2tJDXwM0yiFp0p1xqBdy+kaSBFI6TtNEzBdmbx
	 KbYI2NgUNdNDSpwny0HS036sWIKujha4tuuGJXgKm67en6Dr1Ipz/o6xFlLaCb8yPtAGF
	 4hjsEILp1my+qxN7buz2d9wrQ5xXi27WCNYYKNIg293xTXRpkvdA670dQMjaRAsZdLSXe
	 ixSZbMX4TSd7NxRPaWVwuf+Vet468LvDSND48Lqj+Q33zV7X1v+tSUHLWtN0TIkhCTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555333;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qTnig7zC5pLjxm9m59TXQlChEZTk5WYxI0U3w8qOtMc=;
	b=2oeWDOU/jk+Da1vuEHPQnM+E061+H7cgpti1XS1b9PYK7cxBifvFvNxUdRxek2qvCgKb
	 BnrkeMZm9NLkD4opcVeo53cCcMBxEc4uJzcycJ/V7MefKW2eMNKhOTg9hPMPZO7ENzJcO
	 i0IOBp7TI/mWFV3tOFV1vuYqAt5Wdg3djR1mAM1psGYsJRtjMlnWDSKw1Jz8vZw7eL5qk
	 3JfB5T+KejEqRFwKt6kTzhlIhgspO/O9zLerhSw1a0zFpW3QyiYtVQHvqfh+OTyXKdPjR
	 blgRMz5VL6WQrDrdLd03GS9GFTNalBPLeZwkCpid2UrNewQjVn6uIde+VR1+BGa73VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RkKjHsjV;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51758606A321;
	Fri, 13 Nov 2026 07:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51758606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RkKjHsjV
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD7Kxju2377190;
	Fri, 13 Nov 2026 07:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qTnig7
	zC5pLjxm9m59TXQlChEZTk5WYxI0U3w8qOtMc=; b=RkKjHsjV2w05G1ksKcnQES
	SfpKOQ/B0Or6l5SAUBYN3YiALsYonmbLGPG2O2S/fVfm/m8SkqZ+NzyAISNvpKts
	OAt5YHixn9aD7zf6LNvwelsDrFeCst90geQ4zKR5FW1dOWpI886yqpApccsivFUQ
	iHPQJbQjdz/NJ3Er+Sr3DgsNbxK7ZaUR7zYEfLC2briqOogv2vbX1+HoWjP/ECPF
	+90va3dRHlEaPu4CH6HiY132aD0kU0HDr46zw9q7Qn6tgjNll/N64IZYpJPquI4C
	RXuJvrey7zhA53LNtA6nEW3cS1rp/ZfboOlBjoQKyl9anFBvs1Mu4U1fgg57OOnQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6jf5p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 07:35:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD5JvT21741183;
	Fri, 13 Nov 2026 07:35:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfawwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 07:35:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AD7ZTbv19792562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 07:35:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9917858056;
	Fri, 13 Nov 2026 07:35:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2117658052;
	Fri, 13 Nov 2026 07:35:29 +0000 (GMT)
Received: from [9.61.250.111] (unknown [9.61.250.111])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Nov 2026 07:35:29 +0000 (GMT)
Message-ID: <6df96ce4-7065-4c2c-b3d0-1874bedefdd1@linux.ibm.com>
Date: Fri, 13 Nov 2026 02:35:28 -0500
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
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-2-aaronmbr@linux.ibm.com>
 <90cf2229-af79-4f08-b001-753dc7a86aa2@linux.ibm.com>
Content-Language: en-US
From: Aaron Brown <aaronmbr@linux.ibm.com>
In-Reply-To: <90cf2229-af79-4f08-b001-753dc7a86aa2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dOg5tRj4iga1cXHeFW9lWm-pVDEBIvrN
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af6bdc4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=owjdTxqFgtlei93qGv4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dOg5tRj4iga1cXHeFW9lWm-pVDEBIvrN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAyOCBTYWx0ZWRfX645K7Nx8EV9J
 2wekf7MB06pMl9/qbSVyTCwLgr9HC/Peq2xv8iqCkDzcymutPxBPMv+xhVvxQAzx7r41FCXgWlH
 ilxSK+udO23d6saxb+733Ay+XSpZ/gmBu1xWnKfXWHtldpun5Z1jD1Gq4FeVdY260Du6MKqdRSM
 7PqhdQuoPP1YeWJT7j4hrEWzR87kwST1G5CVR7xLstO3ftFAZdWC1vcl6HKOgMnmb758JizQVso
 dXRyW6b0wL54iyAFnjyLTT0WM7HewhMh/bfuizRmtQ3eEIXfH2hI2j8dcqx3iPeYKTkSdKgBANG
 yMPKc7alGDGLvP8Hiwibla/rXjhNxdaSBJ3lICoj5WVbOXV5TzLUkkJInJQ9Gp+4WTadnusuiRS
 uWvCwXuFiZWMWdsu0QUhT0MWkBVJdMgE2bN9i8lsI1SSj1jinkh+pTzKgbRw75DVOgw5VyrzAM0
 lg7Wq2sr7yf9p+zhMhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAyOCBTYWx0ZWRfX49E147FwrMyx
 dqhAFF6BRE9fA/kh1NrglYWEtIyT73XEUkPpQ4bN9ANpm0lpT0NACNjeszArtjtpBaC7sZUkEgG
 SyMRvT2Ndfzq9LSHXxt08FleYHNUujg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130028

On 11/12/26 8:45 AM, Janosch Frank wrote:
> On 11/10/26 12:16 PM, Aaron M. Brown wrote:
[...]
>> +++ b/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Definition of structs for KVM lifecycle tests.
>> + *
>> + * Copyright IBM Corp. 2026
>> + *
>> + * Authors:
>> + *  Nitya Khamar (nkhamar@linux.ibm.com)
>> + *  Aaron Malik Brown (aaronmbr@linux.ibm.com)
>> + */
>> +#ifndef SELFTEST_KVM_LIFECYCLE_H
>> +#define SELFTEST_KVM_LIFECYCLE_H
>> +
>> +#include "kvm_util.h"
>> +#include <stdbool.h>
>> +
>> +struct kvm_lifecycle_testdef {
>> +    const char *name;
>> +    bool (*test)(void);
>> +};
>> +
>> +struct kvm_parameters {
>> +    struct kvm_vm *vm;
>> +    struct kvm_vcpu *vcpu;
>> +    void *guest_code;
>> +    struct kvm_run *run;
>> +    unsigned int interrupt_type;
>> +    struct kvm_s390_irq *irq;
>> +    struct kvm_s390_irq_state *irq_state;
>> +    struct {
>> +        bool immediate_exit_condition;
>> +    } manual_parameters;
>> +};
> 
> In this patch I don't see any benefit in having this struct.
> I'm hoping there's some use for it in later patches.

Yeah I may have added it a bit prematurely, as most of these fields are 
only used by the ucontrol tests later in the series, so patch 1 doesn't 
need them. I'll drop the struct from this patch and use local variables
in the next version, thanks

[...]
>> +
>> +static struct kvm_parameters create_vm_kvm_exit(struct kvm_parameters 
>> parameters)
> 
> Why aren't we using a pointer to the argument?
> 
>> +{
>> +    parameters.vm = vm_create_with_one_vcpu(&parameters.vcpu,
>> +                        parameters.guest_code);
>> +    return parameters;
>> +}
>> +
>> +static void cleanup_kvm(struct kvm_parameters *parameters)
>> +{
>> +    kvm_vm_free(parameters->vm);
>> +}
> 
> These two function generate >= 4 lines for a single line of useful code.
> 

Good point, I'll remove these helpers as well and just call
vm_create_with_one_vcpu() and kvm_vm_free() directly
>> +
>> +static void compare_regs(struct kvm_regs *regs, struct kvm_sync_regs 
>> *sregs)
>> +{
>> +    int register_number;
>> +
>> +    for (register_number = 0; register_number < NUM_GPRS; 
>> register_number++)
>> +        TEST_ASSERT_EQ(regs->gprs[register_number], sregs- 
>> >gprs[register_number]);
>> +}
>> +
>> +static void guestcode_instruction_intercept(void)
>> +{
>> +    asm volatile("diag 0,0, 0x500\n" :::);
>> +    GUEST_DONE();
>> +}
>> +
>> +static bool test_instruction_intercept(void)
>> +{
>> +    struct kvm_parameters param = {
>> +        .guest_code = guestcode_instruction_intercept,
>> +        .interrupt_type = KVM_S390_INT_EXTERNAL_CALL,
>> +        .manual_parameters.immediate_exit_condition = false,
>> +    };
>> +    struct kvm_s390_irq_state irq_state = {};
>> +    struct kvm_s390_irq irq = {};
>> +    struct kvm_regs regs;
>> +    int interrupts;
>> +
>> +    ksft_print_msg("Testing Instruction Intercept Exit\n");
>> +    param = create_vm_kvm_exit(param);
>> +    vcpu_run(param.vcpu);
>> +    param.run = param.vcpu->run;
>> +    irq.type = param.interrupt_type;
>> +    irq.u.extcall.code = param.vcpu->id;
>> +    irq_state.len = sizeof(irq);
>> +    irq_state.buf = (unsigned long)&irq;
>> +    param.irq = &irq;
>> +    param.irq_state = &irq_state;
>> +    TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
>> +    TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
>> +            "Failed with Unexpected icptcode of 0x%x\n",
>> +            param.run->s390_sieic.icptcode);
>> +    interrupts = __vcpu_ioctl(param.vcpu, KVM_S390_SET_IRQ_STATE,
>> +                  param.irq_state);
> 
> Why are we doing two things at the same time?
> What does the IRQ code add to the test?

You're right, we should focus on only  testing the exit, moreover 
irq_injection has gotten its own test file now, ill drop this
in v2 >> +    TEST_ASSERT(interrupts >= 0, "Cannot Inject Interrupt 
(%d)", errno);
> 
> That should be a == 0, no?
> Documentations says "0 on success".
> 

Indeed, this can also go away in v2, lets keep it simple
>> +    irq_state.buf = (unsigned long)&irq;
>> +    irq_state.len = sizeof(irq);
>> +    interrupts = __vcpu_ioctl(param.vcpu, KVM_S390_GET_IRQ_STATE,
>> +                  &irq_state);
>> +    TEST_ASSERT(interrupts > 0,
>> +            "Expected pending interrupt after injection, got %d", 
>> interrupts);
> 
> Here it's fine since the rc returns the number of bytes KVM copied.
> But we could actually check for a number being at least len(irq_state)

Good point, I will note that for possibly extending the irq tests in the 
future! >> +    TEST_ASSERT_EQ(irq.type, KVM_S390_INT_EXTERNAL_CALL);
>> +    TEST_ASSERT_EQ(irq.u.extcall.code, param.vcpu->id);
>> +    vcpu_run(param.vcpu);
>> +    TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
>> +    TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
>> +            "Expected ICPT_INST from GUEST_DONE after inject, got 
>> 0x%x\n",
>> +            param.run->s390_sieic.icptcode);
>> +    vcpu_regs_get(param.vcpu, &regs);
>> +    compare_regs(&regs, &param.run->s.regs);
>> +    cleanup_kvm(&param);
>> +    return true;
>> +}
>> +
>> +static void guestcode_diagnose_hypercall(void)
>> +{
>> +    asm volatile("diag 0,0, 0x501\n" :::);
>> +}
>> +
>> +static bool test_diagnose_code(void)
>> +{
>> +    struct kvm_parameters param = {
>> +        .guest_code = guestcode_diagnose_hypercall,
>> +        .manual_parameters.immediate_exit_condition = false,
>> +    };
>> +    ksft_print_msg("Testing Diagnosis Hypercall Exit\n");
> 
> Instruction is called diagnose according to the POP.

I will update that accordingly, thanks !

>> +    param = create_vm_kvm_exit(param);
>> +    vcpu_run(param.vcpu);
>> +    param.run = param.vcpu->run;
>> +    TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
>> +    TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
>> +            "Failed with Unexpected Exit Reason of %u and icptcode of 
>> 0x%x\n",
>> +            param.run->exit_reason, param.run->s390_sieic.icptcode);
>> +    TEST_ASSERT(param.run->s390_sieic.ipa >> 8 == IPA_DIAG,
>> +            "Failed with Unexpected Opcode of %u\n",
>> +            param.run->s390_sieic.ipa >> 8);
>> +    TEST_ASSERT(param.run->s390_sieic.ipb >> 16 == DIAG_ASSEMBLY_CODE,
>> +            "Failed with Unexpected Diagnose Code of %u\n",
>> +            param.run->s390_sieic.ipb >> 16);
>> +    cleanup_kvm(&param);
>> +    return true;
>> +}
>> +
>> +static void guestcode_diagnose_conditional(void)
>> +{
>> +    asm volatile("lghi %%r3,0x3333\n"
>> +        "lghi %%r5, 0x555\n"
>> +        "lghi %%r6, 0x3333\n"
>> +        "cgrjne %%r6, %%r3, 1f\n"
>> +        "diag 0,0, 0x501\n"
>> +        "1:\n"
>> +        :
>> +        :
>> +        : "r3", "r5", "r6"
>> +    );
>> +    GUEST_DONE();
>> +}
>> +
>> +static bool test_diagnose_conditional_code(void)
>> +{
>> +    struct kvm_parameters param = {
>> +        .guest_code = guestcode_diagnose_conditional,
>> +        .manual_parameters.immediate_exit_condition = false,
>> +    };
>> +    struct kvm_regs regs;
>> +
>> +    ksft_print_msg("Testing Diagnosis Hypercall for Conditional Code 
>> Exit\n");
> 
> What is this testing?

It is only testing that r3-r6 survive the intercept, so I think I can 
merge it into the DIAG 0x501 test for v2 >> +    param = 
create_vm_kvm_exit(param);
>> +    vcpu_run(param.vcpu);
>> +    param.run = param.vcpu->run;
>> +    TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
>> +    TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_INST,
>> +            "Failed with Unexpected Exit Reason of %u and icptcode of 
>> 0x%x\n",
>> +            param.run->exit_reason, param.run->s390_sieic.icptcode);
>> +    TEST_ASSERT(param.run->s390_sieic.ipa >> 8 == IPA_DIAG,
>> +            "Failed with Unexpected Opcode of %u\n",
>> +            param.run->s390_sieic.ipa >> 8);
>> +    TEST_ASSERT(param.run->s390_sieic.ipb >> 16 == DIAG_ASSEMBLY_CODE,
> 
> Which diag assembly code?
> There's a huge number of them and this test already uses 2.
This is for the virtio notify hypercall (500) in particular, I will be 
more explicit with the variable names in v2 ! >> +            "Failed 
with Unexpected Diagnose Code of %u\n",
>> +            param.run->s390_sieic.ipb >> 16);
>> +    vcpu_regs_get(param.vcpu, &regs);
>> +    TEST_ASSERT_EQ(regs.gprs[3], 0x3333);
>> +    TEST_ASSERT_EQ(regs.gprs[5], 0x555);
>> +    TEST_ASSERT_EQ(regs.gprs[6], 0x3333);
>> +    cleanup_kvm(&param);
>> +    return true;
>> +}
>> +
>> +static void test(void)
>> +{
>> +    int i;
>> +    struct kvm_lifecycle_testdef testlist[] = {
>> +        {
>> +            .name = "Testing Instruction Intercepts",
>> +            .test = test_instruction_intercept,
>> +        },
>> +        {
>> +            .name = "Testing DIAG Code",
>> +            .test = test_diagnose_code,
>> +        },
>> +        {
>> +            .name = "Testing Conditional DIAG Code",
>> +            .test = test_diagnose_conditional_code,
>> +        },
>> +    };
>> +
>> +    ksft_print_header();
>> +    ksft_set_plan(ARRAY_SIZE(testlist));
>> +
>> +    for (i = 0; i < ARRAY_SIZE(testlist); i++) {
>> +        if (testlist[i].test())
>> +            ksft_test_result_pass("%s\n", testlist[i].name);
>> +        else
>> +            ksft_test_result_skip("%s\n", testlist[i].name);
>> +    }
>> +}
>> +
>> +int main(void)
>> +{
>> +    TEST_REQUIRE(kvm_has_cap(KVM_CAP_USER_MEMORY2));
>> +    TEST_REQUIRE(kvm_has_cap(KVM_CAP_SYNC_REGS));
>> +    test();
>> +    ksft_finished();
>> +}
> 
thanks for the constructive comments Janosch, I will get to updating this,

Aaron
