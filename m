Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94523659F4;
	Mon, 23 Feb 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848903; cv=none; b=DTVOvrMrFBHd7/PDS6Go++hjUTsWDWhIQvP4XKB9HpEAOWeaHFrEwxZR17rPuVLkKSdm99C+O+G5T6XdMV8LprXISe1rVX3S0GNhJ44spSoM4oE56hQWqFf9xxJ8D24SemB94/xFLQbDq93ab1tJKclRfDvK+zequ/Kq449oJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848903; c=relaxed/simple;
	bh=36cWsecT1qUgOLTpdU6JzUMxBxZWBjM/D7IujN/u1qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoWUKCTtshHVvjETRbgCGVqote1sV+O1cHGNqiCCD/GUPhXCzDwhQusGvvJJF/dspPPEe71nQ6+cFGAe76r5BmUnnSRIQleb+GKTFDhYJ3wYizDBBobXLmtcDY/v5lsA7c3gH2dh34259GV7dE6LjWgBXqYUHtsSjMuMTzR7elY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jmSHJpDz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jmSHJpDz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N3Fab53184352;
	Mon, 23 Feb 2026 12:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B7n7tb
	tuq8gVlMaNwM7zMnYoFVVP0uXAjpdAB3YYewM=; b=jmSHJpDzpORS3K/nw8UPRH
	yNTnSMpwww6HkGx+RGbjaecwb+vi11LqxC2Q33mNPQ19ROggJ49Ag6xL+SWYnR1b
	UWya60UvkUdyDUsng0B1H9UXdtEgUx3nIRaJUmEM82UUk5eU+gX6PTYiw6avjEGs
	zuxNvvepaZqL/x0+dvbSh6MFx0PcIR8+8ZRkqOkRJtVyJ+aToplMDtxGQcLCD7fx
	9ANLli6BTQH+nHHstQkHDAmOGlm3DR+PL+S7cPu0d9H1ALAXu+i70uuQuSo8Rsp0
	zEeFuS2+VmioHfO0wE+0gcruNIL0VF43Ioc9VXIPFWzWmBEZkvXmhyGa5QOwj8Sw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24g6sv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 12:14:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NCALHb027800;
	Mon, 23 Feb 2026 12:14:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1mcnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 12:14:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NCET9w49545494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 12:14:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2B482004D;
	Mon, 23 Feb 2026 12:14:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9858B2004B;
	Mon, 23 Feb 2026 12:14:28 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.140.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Feb 2026 12:14:28 +0000 (GMT)
Message-ID: <10367bd9-4b9f-48d1-9ee7-8e8b1ec57909@linux.ibm.com>
Date: Mon, 23 Feb 2026 13:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpf,s390: add fsession support for
 trampolines
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260223084022.653186-1-dongml2@chinatelecom.cn>
 <20260223084022.653186-3-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260223084022.653186-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699c44ab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=JiIl2gRODhJS3gKvde8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oR92738kPA7ueINngB0n8_-9BFV3Xzqw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwNCBTYWx0ZWRfXzy/OWVwK8kMg
 D3NyYkBVRB8bsXjJIUnfOIGefi2fV4f/AJm3zdNCE5X+RkgA59epuGAHJ3Uplqq6FdS4IiRDmgQ
 FPF/Ng0S6V02p+Gm1JWiH5wWhCVH2Efl8nNfr0njfJHWHRA6n/xmNC2kso0XfNOaSnDmQ5ZFfbU
 z9MWQoxQ5ChjETbl1VlGc2Ns5glKOgFJxD5k8PJyzCsWMiQtx23yz/e5gxCHvUlbDB+IjMwnaFB
 3o9gNQsfRdxCrK0u7TleOEFKmu/+UGnugBIdWROq3VVYXMaO0IL1ebQDny1WZROwvF/2qpNTDrV
 GS4y0zzoHbcPon5ndarTFWs7H2s0KI4I5468ALrbQHgUlCLC4lQFGO9Vun/avDDo8ay+cSvXCuO
 tm7hnuwSsiAtWooADRcCpLp7WBulwP16gjBSV4qksB6ymw/uVYrSdxnjWAqc9E6mYnB9P0MkWbK
 9qVDRYUAlzZDRsXvwIA==
X-Proofpoint-ORIG-GUID: cmrsWhzXOMdcSLVsLbMslXilLpA109xW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230104


On 2/23/26 09:40, Menglong Dong wrote:
> Implement BPF_TRACE_FSESSION support for s390. The logic here is similar
> to what we did in x86_64.
>
> In order to simply the logic, we factor out the function invoke_bpf() for
> fentry and fexit.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>   arch/s390/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++++++-----
>   1 file changed, 59 insertions(+), 9 deletions(-)


Thank you for contributing this series!


In general this all looks very reasonable; I believe I found a few nits, 
please take a look at my comments below.


>
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 763d2491dfa3..ea0c81f18ece 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -2480,8 +2480,8 @@ struct bpf_tramp_jit {
>   	int ip_off;		/* For bpf_get_func_ip(), has to be at
>   				 * (ctx - 16)
>   				 */
> -	int arg_cnt_off;	/* For bpf_get_func_arg_cnt(), has to be at
> -				 * (ctx - 8)
> +	int func_meta_off;	/* For bpf_get_func_arg_cnt()/fsession, has
> +				 * to be at (ctx - 8)
>   				 */
>   	int bpf_args_off;	/* Offset of BPF_PROG context, which consists
>   				 * of BPF arguments followed by return value
> @@ -2585,6 +2585,28 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
>   	return 0;
>   }
>   
> +static int invoke_bpf(struct bpf_tramp_jit *tjit,
> +		      const struct btf_func_model *m,
> +		      struct bpf_tramp_links *tl, bool save_ret,
> +		      u64 func_meta, int cookie_off)
> +{
> +	int i, cur_cookie = (tjit->bpf_args_off - cookie_off) / sizeof(u64);
> +	struct bpf_jit *jit = &tjit->common;
> +
> +	for (i = 0; i < tl->nr_links; i++) {
> +		if (bpf_prog_calls_session_cookie(tl->links[i])) {
> +			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
> +
> +			emit_store_stack_imm64(jit, REG_0, tjit->func_meta_off, meta);
> +			cur_cookie--;
> +		}
> +		if (invoke_bpf_prog(tjit, m, tl->links[i], save_ret))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int alloc_stack(struct bpf_tramp_jit *tjit, size_t size)
>   {
>   	int stack_offset = tjit->stack_size;
> @@ -2614,8 +2636,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>   	int nr_bpf_args, nr_reg_args, nr_stack_args;
> +	int cookie_cnt, cookie_off, fsession_cnt;
>   	struct bpf_jit *jit = &tjit->common;
>   	int arg, bpf_arg_off;
> +	u64 func_meta;
>   	int i, j;
>   
>   	/* Support as many stack arguments as "mvc" instruction can handle. */
> @@ -2647,6 +2671,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   			return -ENOTSUPP;
>   	}
>   
> +	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
> +	fsession_cnt = bpf_fsession_cnt(tlinks);
> +
>   	/*
>   	 * Calculate the stack layout.
>   	 */
> @@ -2659,8 +2686,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	tjit->backchain_off = tjit->stack_size - sizeof(u64);
>   	tjit->stack_args_off = alloc_stack(tjit, nr_stack_args * sizeof(u64));
>   	tjit->reg_args_off = alloc_stack(tjit, nr_reg_args * sizeof(u64));
> +	cookie_off = alloc_stack(tjit, cookie_cnt * sizeof(u64));
>   	tjit->ip_off = alloc_stack(tjit, sizeof(u64));
> -	tjit->arg_cnt_off = alloc_stack(tjit, sizeof(u64));
> +	tjit->func_meta_off = alloc_stack(tjit, sizeof(u64));
>   	tjit->bpf_args_off = alloc_stack(tjit, nr_bpf_args * sizeof(u64));
>   	tjit->retval_off = alloc_stack(tjit, sizeof(u64));
>   	tjit->r7_r8_off = alloc_stack(tjit, 2 * sizeof(u64));
> @@ -2749,7 +2777,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   
>   	if (flags & BPF_TRAMP_F_IP_ARG)
>   		emit_store_stack_imm64(jit, REG_0, tjit->ip_off, (u64)func_addr);
> -	emit_store_stack_imm64(jit, REG_0, tjit->arg_cnt_off, nr_bpf_args);
> +	func_meta = nr_bpf_args;
> +	emit_store_stack_imm64(jit, REG_0, tjit->func_meta_off, func_meta);
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>   		/*
> @@ -2762,10 +2791,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, __bpf_tramp_enter);
>   	}
>   
> -	for (i = 0; i < fentry->nr_links; i++)
> -		if (invoke_bpf_prog(tjit, m, fentry->links[i],
> -				    flags & BPF_TRAMP_F_RET_FENTRY_RET))
> +	if (fsession_cnt) {
> +		/* clear all the session cookies' value */

Here and below: please use the existing style for single-line comments: 
full sentence starting with a capital letter and ending with a dot. 
Unfortunately the JIT is somewhat inconsistent in this area, but let's 
at least not introduce a new comment style here.

> +		for (i = 0; i < cookie_cnt; i++)
> +			emit_store_stack_imm64(jit, REG_0, cookie_off + 8 * i, 0);
> +		/* clear the return value to make sure fentry always gets 0 */
> +		emit_store_stack_imm64(jit, REG_0, tjit->retval_off, 0);
> +	}

Would it make sense to clear cookies right after invoke_bpf_prog() and 
only if bpf_prog_calls_session_cookie() is true?

Going one step further and reducing the size of cookies array would 
probably be ideal, but I guess this will complicate things 
significantly, so I'm not suggesting to do this.

> +
> +	if (fentry->nr_links) {

I think it's okay to drop this condition, invoke_bpf() is most likely 
inlined and the loop will automatically have 0 iterations in this case.

> +		if (invoke_bpf(tjit, m, fentry, flags & BPF_TRAMP_F_RET_FENTRY_RET,
> +			       func_meta, cookie_off))
>   			return -EINVAL;
> +	}
>   
>   	if (fmod_ret->nr_links) {
>   		/*
> @@ -2842,11 +2880,18 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   		EMIT6_PCREL_RILC(0xc0040000, 0, (u64)im->ip_epilogue);
>   	}
>   
> +	/* set the "is_return" flag for fsession */
> +	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
> +	if (fsession_cnt)
> +		emit_store_stack_imm64(jit, REG_W0, tjit->func_meta_off,
> +				       func_meta);
> +
>   	/* do_fexit: */
>   	tjit->do_fexit = jit->prg;
> -	for (i = 0; i < fexit->nr_links; i++)
> -		if (invoke_bpf_prog(tjit, m, fexit->links[i], false))
> +	if (fexit->nr_links) {
Same as for fentry.
> +		if (invoke_bpf(tjit, m, fexit, false, func_meta, cookie_off))
>   			return -EINVAL;
> +	}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>   		im->ip_epilogue = jit->prg_buf + jit->prg;
> @@ -2951,6 +2996,11 @@ bool bpf_jit_supports_arena(void)
>   	return true;
>   }
>   
> +bool bpf_jit_supports_fsession(void)
> +{
> +	return true;
> +}
> +
>   bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>   {
>   	if (!in_arena)
