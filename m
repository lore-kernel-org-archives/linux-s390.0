Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D973AF65D;
	Wed, 25 Mar 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433898; cv=none; b=lj033Rcle45kNhoXuBsPk0mgHYdvarEBJ7FEQqK594gvec8sOf8tja89jqP19WLS2eR2+4eXqwgS1LOwCzSDW2qk5NWo9Sf+UYl5Q+dG/5KkPZNlnz4MOjktVYhNOhG+WWM8NPWxI2oR2iOQQhgqYxbsZaTpABk27vtdqMTJC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433898; c=relaxed/simple;
	bh=dpTk7opSO3+4eIQAICAvmtJom6o+NrnQychxBHI3hmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFAiI2KnkFR0ra8ThnAw8al0ltWQOZjewe/EGsnI2m7PnR9zJng7iE60S33cN7qAc1f4Z8kvn0uGuBU9eWje0QzQDNzVZvrDXNdaY4DEoGhq9Y56q2ER/F7OlRVLKs43wRvCVqTvN9r+Fc+oXtpntwq5gURGQ6cxMSIzhrRk3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UMP1W11l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UMP1W11l"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3O4wL3189918;
	Wed, 25 Mar 2026 10:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U0iH5G
	CmctoEqmsReGDrELGGgJQ2ZN9+KUkFCDTkdv4=; b=UMP1W11lcY5VG9dAMjSg5i
	KKKdEktzRsw8scFeglDeoF9txdC6b1eUDdWWqG0jahJZZmP99GvbUWaaAg2Buy8n
	g9t5XZ3nq9vPlyE7RtGJOfpd/I1AKZCCCxmEiVm2ly7zlTuGCYDkhP3TboAGrsRV
	yjBNv/80dikeWSzgB8DpwIIEQoffnYmI1XSZNVo0XAFF4DRuLG2EtHAHMCyXz1yd
	YAMARHiHc6z30+gzwmJS+i/T1o9zF+Udj4ZrZK0c0/o6JGhfhMxhQskEN/lAgaqP
	7FYcvofFdxJ7mvust8vTQiAaYz2KBDjmEbU1PhG+imOCkqmQMTK3ivGibE6uUQtA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9yvwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 10:18:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P6cUc2026695;
	Wed, 25 Mar 2026 10:18:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kwyrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 10:18:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PAI3Ef51118494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 10:18:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C00F20043;
	Wed, 25 Mar 2026 10:18:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2664420040;
	Wed, 25 Mar 2026 10:18:03 +0000 (GMT)
Received: from [9.111.62.177] (unknown [9.111.62.177])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 10:18:03 +0000 (GMT)
Message-ID: <3e7d74b9-f5ab-4461-a6f4-2f917c869996@linux.ibm.com>
Date: Wed, 25 Mar 2026 11:18:02 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 5/5] s390x: Add test for STFLE
 interpretive execution (format-2)
To: Christoph Schlameuss <schlameuss@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?UTF-8?Q?Nico_B=C3=B6hr?=
 <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-5-5e52be2e4081@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260324-vsie-stfle-fac-v2-5-5e52be2e4081@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7RUGuV2Eu1ZMHRJI3wGEmGitBpsJl22b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3MyBTYWx0ZWRfX1GdO31m2L06f
 MONgib3d7PpOzdNRsK7Tm0dcg1OtxuNsrJ22oafRLxuqenarvWA+Oj51ZbHrF23ceinZUwE3LkE
 TQPhomSJHXljE0//usH5QFYNd3Xo3/Z0hb17uN2jnAJgdqsV8Ru4zHNiTE553M1877Kw18GyE07
 OnABkEE6xfzfYzLV3V+ixbpEzr48DzYS97v+41XN6lUiQIbzJJCAqHCr5KxEa+Y3h3bJJD30PH7
 24fjLa/oIas06KnJz/PXR1VAfNwjJb6jLCac36gCf8/tAoyu6c78eM1LxKtuzxhrywKXCOZT7dI
 RQ4hJZv84SjLMHpWfNJJjIx++9tT6rWbpW/UPGj0s9NKS4/Ynr2FkNvTANEBEN9bLdFlWZeyl4N
 fMnRJN28wqlKEB9qySeCQ16e6+F5OXZ5RcM4Pf2P/0Y3UasJkdfgL1abGL/ckw7cF3nKQTGpiEW
 6I80TEtAhIp4yTAsZ1Q==
X-Proofpoint-GUID: 7RUGuV2Eu1ZMHRJI3wGEmGitBpsJl22b
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c3b661 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=uopqdx4enuYLClWrsuAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250073

On 3/24/26 16:28, Christoph Schlameuss wrote:
> From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> 
> The STFLE instruction indicates installed facilities.
> SIE has facilities for the interpretive execution of STFLE.
> There are multiple possible formats for the control block.
> Use a snippet guest executing STFLE to get the result of
> interpretive execution and check the result.
> With the addition of the format-2 control block invalid format
> specifiers are now possible.
> Test for the occurrence of optional validity intercepts.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   lib/s390x/sie.c   | 11 +++++++
>   lib/s390x/sie.h   |  1 +
>   s390x/stfle-sie.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>   3 files changed, 92 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
> index 0fa915cf028a1b35a76aa316dfd97308094a4682..17f0ef7eff427002dd6d74d98f58ed493457a7ce 100644
> --- a/lib/s390x/sie.c
> +++ b/lib/s390x/sie.c
> @@ -42,6 +42,17 @@ void sie_check_validity(struct vm *vm, uint16_t vir_exp)
>   	report(vir_exp == vir, "VALIDITY: %x", vir);
>   }
>   
> +void sie_check_optional_validity(struct vm *vm, uint16_t vir_exp)
> +{
> +	uint16_t vir = sie_get_validity(vm);
> +
> +	if (vir == 0xffff)
> +		report_pass("optional VALIDITY: no");
> +	else
> +		report(vir_exp == vir, "optional VALIDITY: %x", vir);
> +	vm->validity_expected = false;
> +}
> +
>   void sie_handle_validity(struct vm *vm)
>   {
>   	if (vm->sblk->icptcode != ICPT_VALIDITY)
> diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
> index 3ec49ed0da6459a70689ce5a1a8a027a4113f2a4..8bea0b10b0a6894096ee83933a8bda11711a1949 100644
> --- a/lib/s390x/sie.h
> +++ b/lib/s390x/sie.h
> @@ -51,6 +51,7 @@ void sie(struct vm *vm);
>   void sie_expect_validity(struct vm *vm);
>   uint16_t sie_get_validity(struct vm *vm);
>   void sie_check_validity(struct vm *vm, uint16_t vir_exp);
> +void sie_check_optional_validity(struct vm *vm, uint16_t vir_exp);
>   void sie_handle_validity(struct vm *vm);
>   
>   static inline bool sie_is_pv(struct vm *vm)
> diff --git a/s390x/stfle-sie.c b/s390x/stfle-sie.c
> index 21cf8ff8b6f6e9d61ee304c5748c36f718da65ab..5b642d9e8c3d775e078c1f09b87ad6822cd28a32 100644
> --- a/s390x/stfle-sie.c
> +++ b/s390x/stfle-sie.c
> @@ -42,6 +42,7 @@ static struct guest_stfle_res run_guest(void)
>   	uint64_t guest_stfle_addr;
>   	uint64_t reg;
>   
> +	reset_guest(&vm);
>   	sie(&vm);
>   	assert(snippet_is_force_exit_value(&vm));
>   	guest_stfle_addr = snippet_get_force_exit_value(&vm);
> @@ -55,18 +56,73 @@ static struct guest_stfle_res run_guest(void)
>   static void test_stfle_format_0(void)
>   {
>   	struct guest_stfle_res res;
> +	int format_mask;
>   
>   	report_prefix_push("format-0");
> -	for (int j = 0; j < stfle_size(); j++)
> -		WRITE_ONCE((*fac)[j], prng64(&prng_s));
> -	vm.sblk->fac = (uint32_t)(uint64_t)fac;
> -	res = run_guest();
> -	report(res.len == stfle_size(), "stfle len correct");
> -	report(!memcmp(*fac, res.mem, res.len * sizeof(uint64_t)),
> -	       "Guest facility list as specified");
> +	/*
> +	 * There are multiple valid two bit format control values depending on
> +	 * the available facilities.
> +	 * The facility introduced last defines the validity of control bits.
> +	 */
> +	format_mask = sclp_facilities.has_astfleie2 ? 3 : sclp_facilities.has_astfleie1;

Without the KVM patches format_mask is 0.

> +	for (int i = 0; i < 4; i++) {

Why?
This test is only for format 0, no?

> +		if (i & format_mask)
> +			continue;

i & 0 is always false.

> +		report_prefix_pushf("format control %d", i);
> +		for (int j = 0; j < stfle_size(); j++)
> +			WRITE_ONCE((*fac)[j], prng64(&prng_s));
> +		vm.sblk->fac = (uint32_t)(uint64_t)fac | i;

Since my mask is 0 and i can be 0 - 3 where values >0 can lead to 
validities (optional) this test can run into a validity at any point.

> +		res = run_guest();
> +		report(res.len == stfle_size(), "stfle len correct");
> +		report(!memcmp(*fac, res.mem, res.len * sizeof(uint64_t)),
> +		       "Guest facility list as specified");
> +		report_prefix_pop();
> +	}
>   	report_prefix_pop();
>   }
>   
> +static void test_stfle_format_2(void)
> +{
> +	const int max_stfle_len = 8;
> +	int guest_max_stfle_len = 0;
> +	struct guest_stfle_res res;
> +	bool saturated = false;
> +
> +	report_prefix_push("format-2");
> +	for (int i = 1; i <= max_stfle_len; i++) {
> +		report_prefix_pushf("max STFLE len %d", i);
> +
> +		WRITE_ONCE((*fac)[0], i - 1);
> +		for (int j = 0; j < i; j++)
> +			WRITE_ONCE((*fac)[j + 1], prng64(&prng_s));
> +		vm.sblk->fac = (uint32_t)(uint64_t)fac | 2;
> +		res = run_guest();
> +		/* len increases up to maximum (machine specific) */
> +		if (res.len < i)
> +			saturated = true;
> +		if (saturated) {
> +			report(res.len == guest_max_stfle_len, "stfle len correct");
> +		} else {
> +			report(res.len == i, "stfle len correct");
> +			guest_max_stfle_len = i;
> +		}
> +		report(!memcmp(&(*fac)[1], res.mem, guest_max_stfle_len * sizeof(uint64_t)),
> +		       "Guest facility list as specified");
> +
> +		report_prefix_pop();
> +	}
> +	report_prefix_pop();
> +}
> +
> +static void test_no_stfle_format(int format)
> +{
> +	reset_guest(&vm);
> +	vm.sblk->fac = (uint32_t)(uint64_t)fac | format;
> +	sie_expect_validity(&vm);
> +	sie(&vm);
> +	sie_check_optional_validity(&vm, 0x1330);
> +}

This needs a prefix, right now I see three of these skip reports and I 
don't know which format was tested:
PASS: optional VALIDITY: no

But looking at the code above I wonder if that should be folded into the 
test above if the logic is fixed.

> +
>   struct args {
>   	uint64_t seed;
>   };
> @@ -119,20 +175,33 @@ static struct args parse_args(int argc, char **argv)
>   int main(int argc, char **argv)
>   {
>   	struct args args = parse_args(argc, argv);
> -	bool run_format_0 = test_facility(7);
>   
>   	if (!sclp_facilities.has_sief2) {
>   		report_skip("SIEF2 facility unavailable");
>   		goto out;
>   	}
> -	if (!run_format_0)
> +	if (!test_facility(7)) {
>   		report_skip("STFLE facility not available");
> +		goto out;
> +	}
>   
>   	report_info("PRNG seed: 0x%lx", args.seed);
>   	prng_s = prng_init(args.seed);
>   	setup_guest();
> -	if (run_format_0)
> -		test_stfle_format_0();
> +	test_stfle_format_0();
> +
> +	if (!sclp_facilities.has_astfleie1)
> +		test_no_stfle_format(1);
> +
> +	if (!sclp_facilities.has_astfleie2) {
> +		test_no_stfle_format(2);
> +		report_skip("alternate STFLE interpretive-execution facility 2 not available");
> +	} else {
> +		test_stfle_format_2();
> +	}
> +

Does this test work on LPAR and zVM?

> +	test_no_stfle_format(3);
> +
>   out:
>   	return report_summary();
>   }
> 

