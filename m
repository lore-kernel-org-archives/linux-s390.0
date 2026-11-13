Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565325;
	b=zIVCyK4KVHjTX17R3XM7jaThhQE7fb/qPFfL4sK13gmzbyi8UknpY9bIbRcYoGWFXjKE
	 Iz6tTOLVIVUOxCQndsxuudwLFoHq5VYBqh2xy7AypLXuNBLMfPuLr5x3HzzYwoZ/nj7yV
	 Bs4VXTxL1wA6puAC6525sn/VLBexAwVs5pwcPvP39PAkQu4196s/Lp6I699sykjJNRac9
	 epBpNodV8g20hFrQSOEZqaNuHruKkYe/DDT7NTxQvJSm3VmmrbmeFfel5TIiBxszVnTTB
	 WqLoVqgcuX/bXOJuk4+s/XUoicUaC+isySzJRuQMfSlE5L0VXix4LaV2C6zk1yJZDHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v+vyV3UOl++HuSrl3vMCAuMBq6aOqxxEnDkZGA0chQ0=;
	b=BztmMxD97Ns8A3Gqlu3elmNkNhhgBsIJkq8sJVnWL6KhLvMNkVky9u9IPGG/H2X+yygn
	 VmcPunc/HkGE189Jm687cl5UZl02j3uVTEJEwDs1kR4aSyOyILTNIM4ojEv7/EL/NOnYp
	 WXYhMiTw5cXSs3fAh3TgX6HgEHiqB3RqjjjtuUXwdSHUWdqFqSa06QNZQaP9shPUsJ4b0
	 FEf17zRnR/FPbELm3kimUb1MaWhONmQQaWotmi2CFhZtnj5+DVf4HSiGayvMFvwaZuxSz
	 95tVtRn5D9lwtpMK8X2B2CbEk+1C5PnOsysaqXxDzJe4nOz8SG8rsObtSt0Asak7TTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GhvVvrIw;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB0606A331;
	Fri, 13 Nov 2026 10:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ADB0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GhvVvrIw
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8j3NW736038;
	Fri, 13 Nov 2026 10:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v+vyV3
	UOl++HuSrl3vMCAuMBq6aOqxxEnDkZGA0chQ0=; b=GhvVvrIw/RWiFyXP1Q6P67
	nhRJGK1HEzkpTCuhFOixs/u/iqJiQlR+bfYUoJzISSj/tc2UcWkZ+dednwONWaDO
	LE1J4H5buzuu3/gQ6ntMsPF11TzfmyOwATuDRaRaeTVIgR3n22gGm01Bx8dYGQI4
	4EwporSdhRSyJRCdsl7OEiDG3VNkmvJydPS26DKgzE9VRu4QkIIzKMw48KJcfzKU
	CPY9n9ZXypqd4S5llQZ3+UjWV+X8bPZfO5gE/izXfhWSsOAlxS0AryLu4hdQY+0o
	e63y3OmFnjkH3BqfBMdlJFti9IDY5gkLgJwyKeqT8SRaLj4lNM0KlZ8u8VDhukVg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntjsha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 10:22:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8Z6jr911795;
	Fri, 13 Nov 2026 10:22:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd521xrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 10:22:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADALvXT39977276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 10:21:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 900E120043;
	Fri, 13 Nov 2026 10:21:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37A4A20040;
	Fri, 13 Nov 2026 10:21:57 +0000 (GMT)
Received: from [9.111.25.141] (unknown [9.111.25.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 10:21:57 +0000 (GMT)
Message-ID: <35f1ccbe-41cb-4fe0-894d-2b7c6cb10d93@linux.ibm.com>
Date: Fri, 13 Nov 2026 11:21:57 +0100
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
Subject: Re: [PATCH 2/6] KVM: s390: selftests: Add SIGP and program exception
 tests
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>, kvm@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-3-aaronmbr@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261110111619.61760-3-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0MCBTYWx0ZWRfXwCLxcZcYWs6k
 bYaiGusOfwZz+pLiBMCdH0bqoA6/RNWkIG8WBoR9SiSkmqQ58vu48WLHJxpJAUK9i9+EZkuYkbF
 W8uib6yftqHj8t6i7Ha6ZAs4IlqDp3rwuR/d4CILExKroXpbIuVoeugSzZuXnDbKXIKdtLWYm3z
 uSroibTbc++5eAgWB7hSriJORI99H1mgFCs7Z0S4Y2uSKDysSo2usOjsAjH9xwFtRQdBDgGcMY2
 ppsDZn95RnzZjXzYBX3QOH79Aqx03dBnJ7xxSC2CIbEeXsdg/O8hUpVF8I/qmHPBPGo2jkhR04P
 fxXNVKeniw7I8uxFiq8zscAijBh/USPl/hLmw5bMC5s37VDG84X4j18bY6gI1LP3pUWxS/tYmpZ
 gjNowLZGeJj1AmyQoXMHT68qo9oKLQoe7JHckmaURWSiNTTwVDLP1gX5YS0eCTM7fg6JQp7IUqw
 85ukOSjCVp7awgCQi/w==
X-Proofpoint-ORIG-GUID: U04FDe-ZCCuBrFArh0MdhhkYatPulcbu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0MCBTYWx0ZWRfX6tUBkROGBzFV
 GCF7M3Ae9eubM4wVrzTHJ63EEadBN4yst46eTV+IUkR+dDPbopusHY+DUVKYIi4v24SUfLgGrHQ
 ayvtpgb+5VFMXTzVobQulqTeYv2Ymbo=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af6e4cc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=PP9wsWBRfFXHjqpQ1ngA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U04FDe-ZCCuBrFArh0MdhhkYatPulcbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130040

On 11/10/26 12:16 PM, Aaron M. Brown wrote:
> Add tests for:
> 
> - SIGP: a second vCPU stops vCPU 0. Both vCPUs are set to operating
>    first, as KVM ignores a stop order sent to a stopped vCPU. Check for
>    ICPT_STOP.
> - Addressing exception (DAT off): check for program code 0x05.
> - Segment translation exception (DAT on): check for program code 0x10.
> 
> The program new PSW is set to a disabled wait so the guest exits
> deterministically.
> 
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390/kvm_exit.c | 146 ++++++++++++++++++++
>   1 file changed, 146 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
> index 140358357c67..4a6f01ff14ca 100644
> --- a/tools/testing/selftests/kvm/s390/kvm_exit.c
> +++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
> @@ -25,6 +25,12 @@
>   #define NUM_GPRS 16
>   #define DIAG_ASSEMBLY_CODE 0x501
>   #define IPA_DIAG 0x83
> +#define PSW_MASK_64BIT_DAT_OFF  0x0000000180000000ULL
> +#define PGM_CODE_SEGMENT_TRANSLATION 0x10
> +#define PGM_CODE_GPA_ADDRESS 0x8e
> +#define PGM_CODE_MASK        0x7f
> +#define PGM_NEW_PSW_GPA 0x1d0
> +#define PSW_DISABLED_WAIT 0x0002000180000000ULL
>   
>   static struct kvm_parameters create_vm_kvm_exit(struct kvm_parameters parameters)
>   {
> @@ -174,6 +180,134 @@ static bool test_diagnose_conditional_code(void)
>   	return true;
>   }
>   
> +/*
> + * Make a program interrupt end in a disabled wait, which KVM reports to
> + * userspace as ICPT_WAIT. This does not depend on how KVM handles
> + * repeated operation exceptions.
> + */
> +static void set_pgm_new_psw_disabled_wait(struct kvm_vm *vm)
> +{
> +	uint64_t *new_psw = addr_gpa2hva(vm, PGM_NEW_PSW_GPA);
> +
> +	new_psw[0] = PSW_DISABLED_WAIT;
> +	new_psw[1] = 0;
> +}
> +
> +static void guestcode_sigp(void)
> +{
> +	asm volatile(
> +		"lghi %%r3, 0\n"
> +		"sigp %%r1, %%r3, 0x05\n"
> +		:
> +		:
> +		: "r1", "r3"
> +	);
> +	GUEST_DONE();
> +}
> +
> +static bool test_sigp_signals(void)
> +{
> +	struct kvm_parameters param = {
> +		.guest_code = guestcode_sigp,
> +		.manual_parameters.immediate_exit_condition = false,
> +	};
> +	struct kvm_mp_state mp_state = { .mp_state = KVM_MP_STATE_OPERATING };
> +	struct kvm_vcpu *vcpu1;
> +	struct kvm_regs regs;
> +
> +	ksft_print_msg("Testing SIGP KVM Exit\n");
> +	param = create_vm_kvm_exit(param);
> +	vcpu1 = vm_vcpu_add(param.vm, 1, guestcode_sigp);

Yeah, this makes the struct in patch 1 even worse.
One VCPU is in the struct, the other one is a local variable...

> +	/* New vCPUs are stopped, and KVM ignores a SIGP STOP sent to one */
> +	vcpu_mp_state_set(param.vcpu, &mp_state);
> +	vcpu_mp_state_set(vcpu1, &mp_state);
> +	vcpu_regs_get(param.vcpu, &regs);
> +	regs.gprs[3] = 0x3333;
> +	vcpu_regs_set(param.vcpu, &regs);
> +	vcpu_run(vcpu1);

I'm a huge fan of \n between logical code blocks.
The comments are a good start already but a \n before the comments would 
bring it home.

> +	/* vcpu1 exits after GUEST_DONE() ucall */
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu1, KVM_EXIT_S390_SIEIC);
> +	vcpu_run(param.vcpu);
> +	param.run = param.vcpu->run;
> +	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT_EQ(param.run->s390_sieic.icptcode, ICPT_STOP);
> +	/*
> +	 * The pending SIGP STOP stops vcpu0 before it runs any guest code
> +	 * (the guest would clear r3), so r3 keeps the marker value.
> +	 */
> +	TEST_ASSERT_EQ(param.run->s.regs.gprs[3], 0x3333);
> +	cleanup_kvm(&param);
> +	return true;
> +}
> +

[...]

> +
> +static bool test_translation_exceptions(void)
> +{
> +	struct kvm_parameters param = {};
> +	uint16_t pgm_code;
> +
> +	ksft_print_msg("Testing Translation Exception KVM Exit\n");
> +	param.guest_code = guestcode_translation_exception;
> +	param = create_vm_kvm_exit(param);
> +	set_pgm_new_psw_disabled_wait(param.vm);
> +	vcpu_run(param.vcpu);
> +	param.run = param.vcpu->run;
> +	TEST_ASSERT_KVM_EXIT_REASON(param.vcpu, KVM_EXIT_S390_SIEIC);
> +	TEST_ASSERT_EQ(param.run->s390_sieic.icptcode, ICPT_WAIT);
> +	pgm_code = *(uint16_t *)addr_gpa2hva(param.vm, PGM_CODE_GPA_ADDRESS);
> +	TEST_ASSERT((pgm_code & PGM_CODE_MASK) == PGM_CODE_SEGMENT_TRANSLATION,
> +		    "Expected PGM code 0x10 (segment translation), got 0x%x\n", pgm_code);
> +	cleanup_kvm(&param);
> +	return true;
> +}

TBH, I don't know what we gain from these mem exception tests.
In their current state they are HW/FW tests and not KVM tests.

We could test PGM exits but I think I already added PGM forwarding tests 
when I added the feature.

For these to have a benefit we'd need to check mem exceptions for 
instructions which are actually emulated and not interpreted.

> +
>   static void test(void)
>   {
>   	int i;
> @@ -190,6 +324,18 @@ static void test(void)
>   			.name = "Testing Conditional DIAG Code",
>   			.test = test_diagnose_conditional_code,
>   		},
> +		{
> +			.name = "Testing SIGP Exits",
> +			.test = test_sigp_signals,
> +		},
> +		{
> +			.name = "Testing Address Exceptions",
> +			.test = test_address_exceptions,
> +		},
> +		{
> +			.name = "Testing Translation Exceptions",
> +			.test = test_translation_exceptions,
> +		},
>   	};
>   
>   	ksft_print_header();

