Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566237;
	b=k1Y93ibwYBSFsVv/V+451/pF4mBDt6bNoG+06utWk/CE2BL73n7AQdvIvt7RiMNvFBOP
	 spHaTH0rw9R1Pc6hhT1WgMpdu81d60QHPJu56Ym/AFcantuWuyCJDXPgPG1mMRqpAFaav
	 4JVvI5rRF8nccMScsaHqamPXDDLQEWV4WSGJ/tG1iLkZ5QDmzUEGlbaPaBCHnk0TRSr8Y
	 4v2QHhSe77st7E9jZwrPGTaInrIT448VrBFS7MYBkE3sjtjfihCu8T6CXVQdAjGMma2zo
	 NdK3m0AZKJoEv3gio1xwGPWvW/oM/bmHCIhbEC3N6nZll01os3LeGmoUCcv8toywurA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566237;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CU/bJu8/OViteQViORWfiZjqIc4ONxeHouLSmWJTqVs=;
	b=CfxSguR17uyloGKrl7ms4b3HI4dm7G+4fyBJeBNOnJL1wv+OKeJ1/OljriftDnGkiUoP
	 aStKuPW7RGyeFXi9ygnXUBVKoKP6hbEzo2ArX/wPVO+IdKUj0zBrPaWtbyf4FRafw+W7P
	 lHQTvSSt3l/cDcTLMPqX9L8x2j3vz1lNePP7N266Dc+MHi3I5RasuD+oXzVoNapJyH+x3
	 Z3mIhahe6FPa+u0a+tPm/EH83JeT9HdUoeWWPv+iOfe2QdXAVho2leZJS43k1OV8v8iCx
	 id3NU8yDK8ejJ3ku3sDYRlQJ0fSTqv9EKaxWXZGa9fzYe2OqCBfRlD0pEMD8NocUX8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZqnwEa8y;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81333606A323;
	Fri, 13 Nov 2026 10:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81333606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZqnwEa8y
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD9ZAFv2491315;
	Fri, 13 Nov 2026 10:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CU/bJu
	8/OViteQViORWfiZjqIc4ONxeHouLSmWJTqVs=; b=ZqnwEa8yUJCfWVojJ2GvlC
	1in3Q9AjD3R3OWozA2HfFbpjJ+BhgGp+/JTrmWhI3J3UNpWdLMJS2UFtrl9937A9
	rGlGKtcT5mV5T7FweaZp4blVybv2d0wWmxE1qGyY/OGNQHj5jhUgUwAmNGtLqJtz
	ua9lvytY4wNtnQj390zLLKX4ATeGZ3zQ0Upg3+LPcpEX6FkGJCJIZKBc/msrs1XX
	QQROwh66S8Ia23lMba32DuYNUOB7W58JJcbN4ZRcDxnGJYHjvoiRxEwaIBIj+uGY
	1TqoF/wIr+IpORnxNLPfpPUk5gg9vZJ3ff0ukoj3wzBT2c66yjOnNCScpqLax1QQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq7anew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 10:37:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8Z4Ru2008374;
	Fri, 13 Nov 2026 10:37:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85bk9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 10:37:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADAb9Pi44040622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 10:37:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63E4F20043;
	Fri, 13 Nov 2026 10:37:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2818620040;
	Fri, 13 Nov 2026 10:37:09 +0000 (GMT)
Received: from [9.111.25.141] (unknown [9.111.25.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 10:37:09 +0000 (GMT)
Message-ID: <e7ab806c-97ab-4e41-8649-bff248fd7c86@linux.ibm.com>
Date: Fri, 13 Nov 2026 11:37:08 +0100
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
Subject: Re: [PATCH 3/6] KVM: s390: selftests: Add wait state and VM lifecycle
 tests
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>, kvm@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-4-aaronmbr@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261110111619.61760-4-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0MCBTYWx0ZWRfXxoxI33ssD+cP
 I0J+v4njVVV1te3bNu9eis9v+yH6isapY1v/Oh1DJCsCL4npZwxWXsZ9t9TwZV39oUEYXjmg2Ll
 0EJS2gpRFIVCGR3GPUhQU4zeTk3CK1U=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af6e85b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qQmIUtfkHXCNvzcoEsAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nLQS2xMAnZrxXbGmMAlHt8U3bVemHGq7
X-Proofpoint-GUID: nLQS2xMAnZrxXbGmMAlHt8U3bVemHGq7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0MCBTYWx0ZWRfXz7iuKPCI3FGV
 u1ajOHugwjD72i7Nug+seP5/w0msXrf+tAKb6Z1fr2YEOjJBzxdSfwD8VHpI2DVExVb7UoXptik
 q3bsLY5/86AETOsei2Wbel0dvfJ59HtvYRbrAhVL2WpCm6plBu1b/ECtNLwullhYN609+RZWJwA
 W7IB28XPLVzElsA1b7G3cnve6k4uEGnOlSj/vTvp0aub8O2Rwx/80wIM06mj3+eSUdK/m/X5D/0
 tHTWjM5v7q8zLFfDFb+z0W/ngSETwVWI1PFnEHbzOQp5h71cUvMU6sqaepJs0xIFlKMTuuId+98
 VE94mReM7CoWMgfolS6l6bZBJsqvUlUux8Xv1JFFqlvs6rSBrc3UcSwwCcIBjH9p0VRfSz52eWM
 4K9SckoLsRA1LfCeY2f6xyxdqPEScy5akuLh2QEIJjFL7Z78NL4qyrM9yeF8xJbttFclwK7oJVS
 FzJw+70LOsxFfp+GdZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130040

On 11/10/26 12:16 PM, Aaron M. Brown wrote:
> Add two tests:
> 
> - Wait state: the guest loads a PSW with the wait bit (bit 14) set and
>    the I/O, external and machine-check masks (bits 6, 7, 13) clear.
>    Check for ICPT_WAIT and the wait bit in the PSW.
> - VM create and destroy: before the first KVM_RUN, check that
>    exit_reason is KVM_EXIT_UNKNOWN and immediate_exit is clear.
> 
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390/kvm_exit.c | 78 +++++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
> index 4a6f01ff14ca..2f73eae1954a 100644
> --- a/tools/testing/selftests/kvm/s390/kvm_exit.c
> +++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
> @@ -27,6 +27,7 @@
>   #define IPA_DIAG 0x83
>   #define PSW_MASK_64BIT_DAT_OFF  0x0000000180000000ULL
>   #define PGM_CODE_SEGMENT_TRANSLATION 0x10
> +#define PSW_WAIT_BIT_MASK (1ULL << (63 - 14))

ptrace.h should have this covered, it even seems to typedef the psw.

>   #define PGM_CODE_GPA_ADDRESS 0x8e
>   #define PGM_CODE_MASK        0x7f
>   #define PGM_NEW_PSW_GPA 0x1d0
> @@ -308,6 +309,75 @@ static bool test_translation_exceptions(void)
>   	return true;
>   }
>   
> +static uint64_t psw_save[2] __aligned(16);

LPSWE needs a DW alignment, not a QW one, so 8 should be enough.

> +
> +static void guestcode_wait_state(void)
> +{
> +	register uint64_t *psw_ptr asm("r4") = psw_save;
> +
> +	asm volatile(
> +		"lghi  %%r3, 0x3333\n"
> +		"lgrl  %%r7, 1f\n"
> +		"stg   %%r7, 0(%%r4)\n"
> +		"xgr   %%r5, %%r5\n"
> +		"stg   %%r5, 8(%%r4)\n"
> +		"lpswe 0(%%r4)\n"

That's convoluted.
Have a look at the kernel's __load_psw_mask() and friends.

> +		".align 8\n"
> +		"1: .quad 0x0002000180000000\n"
> +		:
> +		: "d"(psw_ptr)
> +		: "r3", "r5", "r7", "memory"
> +	);
> +}
> +
> +static bool test_wait_state(void)
> +{
> +	struct kvm_parameters param = {};
> +	struct kvm_regs regs;
> +
> +	ksft_print_msg("Testing Wait State Exit\n");
> +	param.guest_code = guestcode_wait_state;
> +	param = create_vm_kvm_exit(param);
> +	vcpu_run(param.vcpu);
> +	param.run = param.vcpu->run;
> +	TEST_ASSERT(param.run->exit_reason == KVM_EXIT_S390_SIEIC,
> +		    "Expected KVM_EXIT_S390_SIEIC, got %u\n",
> +		    param.run->exit_reason);
> +	TEST_ASSERT(param.run->s390_sieic.icptcode == ICPT_WAIT,
> +		    "Failed with Unexpected Exit Reason of %u and icptcode of 0x%x\n",
> +		    param.run->exit_reason, param.run->s390_sieic.icptcode);
> +	vcpu_regs_get(param.vcpu, &regs);
> +	TEST_ASSERT(regs.gprs[3] == 0x3333,
> +		    "Expected 0x3333 but got 0x%llx\n", regs.gprs[3]);
> +	/* Check PSW wait bit (bit 14 from MSB = bit 63-14 from LSB) */
> +	TEST_ASSERT((param.run->psw_mask & PSW_WAIT_BIT_MASK) != 0,
> +		    "PSW wait bit not set, PSW Mask = 0x%llx\n",
> +		    param.run->psw_mask);
> +	cleanup_kvm(&param);
> +	return true;
> +}
> +
> +static void guestcode_nop(void)
> +{
> +	GUEST_DONE();
> +}
> +
> +static bool test_vm_create_and_destroy(void)
> +{
> +	struct kvm_parameters parameters = {.guest_code = guestcode_nop};
> +
> +	ksft_print_msg("Testing VM Closure without Running vCPU\n");
> +	parameters = create_vm_kvm_exit(parameters);
> +	TEST_ASSERT(parameters.vcpu->run->exit_reason == KVM_EXIT_UNKNOWN,
> +		    "Unexpected Exit Reason Before vCPU Execution: %u\n",
> +		    parameters.vcpu->run->exit_reason);
> +	TEST_ASSERT(parameters.vcpu->run->immediate_exit == 0,
> +		    "Immediate Exit Unexpected Behavior: %d\n",
> +		    parameters.vcpu->run->immediate_exit);

Does the setup code even sync kvm_run?
Are we testing zero initialization of memory?

> +	cleanup_kvm(&parameters);
> +	return true;
> +}
> +
>   static void test(void)
>   {
>   	int i;
> @@ -336,6 +406,14 @@ static void test(void)
>   			.name = "Testing Translation Exceptions",
>   			.test = test_translation_exceptions,
>   		},
> +		{
> +			.name = "Testing Wait State",
> +			.test = test_wait_state,
> +		},
> +		{
> +			.name = "Testing VM Create and Destroy",
> +			.test = test_vm_create_and_destroy,
> +		},
>   	};
>   
>   	ksft_print_header();

