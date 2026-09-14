Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730F4756CE;
	Mon, 14 Sep 2026 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397444; cv=none; b=mEI+2rD7fCUNBBXvo4B6bI2PynnSHdVr5eUbQmFUeMBegYvjtsItNfonCoYelG9MHKH+vgFz5B/bQpb09wRaloHyPsBwHf8jjEH0bi/HNVmNBrZ4/3ixEWhnE2ldFFGCRNuHnXyVv2D4p8wkO+h8DOrFpS1XMgVWftuWumBKsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397444; c=relaxed/simple;
	bh=cwna8Bial48kIDcqkrkO7CHZDp8fjkpFwRaUFTlmNJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tcg6WuKaJOrNkq7KmJQukEOhcviwxVV/GlPzeJDll8KzzMD/3HKz5t2abK6dMgitlUH4xQZsIu7QqZ5uiUtI6G3EXnBiQ3eYxxkoQT/EZx9ZhXx1fWGpO6lSBq0YJC3cUk1jXr69/RUKzfGrKi5FLHmbA//Fcq5+K5z4MrKiY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ms8ldR/J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ms8ldR/J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EETgCD2306781;
	Mon, 14 Sep 2026 14:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3hOeMC
	ri7jwZOnE0IonyVfgEmL5uYiu5W2LI0RMwPDY=; b=Ms8ldR/JxZXm0uwVIiupaS
	CzsU+ITKo7ULzkZ46mrLHkFk6Vjcv6qwtf9lXtP6ia4WB+mCvo6q4zC8TW7Y16sg
	Qt28ZXzjj1ln3NTT6e3VOV7CzAittScZGEWAMDNTj71YGz5of7eaTW9xqZS9zJCl
	otJY+vUEY6enbzyTTPVGc4fHQNDM4sd3HMnImIEm8sJW2o0PKM05Qqt+ulTsGYTi
	R0uqkTL9NAmxaV9TLBA4qCYlF44Quv4LTXy4DAMZ68vPLZWtqiwoqEh9Ixh7H4G9
	GGTkyQWSCXdu/WdM1+6oT8xA+uNyrUXaWAsp6poo3OJoxrQTTDbnlLQpyVCf1mVA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4t3nq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:50:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED595b2333737;
	Mon, 14 Sep 2026 14:50:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnjjgpgnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:50:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EEoYkf28901936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 14:50:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C32620043;
	Mon, 14 Sep 2026 14:50:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1535320040;
	Mon, 14 Sep 2026 14:50:34 +0000 (GMT)
Received: from [9.111.205.105] (unknown [9.111.205.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 14:50:34 +0000 (GMT)
Message-ID: <65f6fb59-085f-4223-b8e9-358c9af458a8@linux.ibm.com>
Date: Mon, 14 Sep 2026 16:50:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 17/24] unwind_user/eh_frame: Add support for DWARF
 expressions
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-18-jremus@linux.ibm.com>
 <20260821201856.706821F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821201856.706821F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bVpYJxDZh8K2NzDE8QMqqhnz-VGXEA4_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX5ww2/7XJW4dG
 iuc4Rmu2ZasYTXmvbuCmNaviHLGOUDqLa/zXRd9+4cqmVT58croCFMJI/0X3RjylmO11UHZZd+l
 XBsRF/heQegZPjWrVOxZ6BryjUaqKMw=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa809bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=QVt8ylwSJS-iOULjLIcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bVpYJxDZh8K2NzDE8QMqqhnz-VGXEA4_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX+52457hW5dJP
 w7K7RNEzevabKIchHXxcFbwdTMYmlcZ+dnW1gwy3jqk40a6a1jVZ4wLjC6lg5Ko/lQhlSPLwBLr
 W8SLUvbqcSAfTy6FlFgYfTHSSPWMCohkNtWDrjNhx17kl45aB+MLxN1IdNPGP3ev3z9OFxPhX86
 4pRs3b+g7E46usn1gDcMGgGSezAiuHK51qGB4ungr49S3du/4eB6aDBO8hdHdpYhoLMN99XAttx
 1rT+x9ciVt7cL1CLno1xWQAzPvrPdmtHbnjozRC4DRF1LxOsvXKQBXBnHR/idizITnM/EN0HN7D
 VsHFBwJJ5rgoVxH6sMx222vgE4h4ZW5/e68kuDL9WRGmTNNB/4ZR1SHeqojSG/wXKZy8LzJPHQw
 xWIdk3KnCr4TrkobjmcXf9w4oEg3TEALMAqRRB+hlGPAw8fvxnqzVeBjD83+lZXl6MSt3rkCr4u
 RYgb7XvawA5d4LmCwZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140201

On 8/21/2026 10:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:

>     Enable architectures to handle DWARF expressions in DWARF CFI
>     instructions DW_CFA_def_cfa_expression, DW_CFA_expression, and
>     DW_CFA_val_expression. Limit the maximum expression length to a
>     reasonable size, while enabling architectures to override the
>     limit.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> @@ -803,6 +772,27 @@ static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
>>  			break;
>>  		}
>>  
>> +		case DW_CFA_def_cfa_expression: {
>> +			unsigned long expr_len;
>> +			char expr[EH_FRAME_MAX_EXPRESSION_LENGTH];
>> +
>> +			ret = read_uleb128(&cur, end, &expr_len);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (cur + expr_len < cur || cur + expr_len > end)
>> +				return -EINVAL;
>> +
>> +			if (expr_len > sizeof(expr))
>> +				return -EOPNOTSUPP;
>> +			unsafe_copy_from_user(&expr, (void __user *)cur, expr_len, Efault);
> 
> [Severity: Low]
> Does this unaligned stack buffer passed to unsafe_copy_from_user() cause
> undefined behavior?
> 
> Passing a 1-byte aligned char array to unsafe_copy_from_user() violates C
> alignment rules. In architecture-specific implementations, the macro
> explicitly casts the destination pointer to larger integer types (e.g.,
> u64 *) to perform optimized word-sized memory assignments. Dereferencing
> an unaligned pointer is Undefined Behavior in C.

AFAIK [unsafe_]copy_from_user() has no source or destination alignment
requirements.

The reported concern appears to be specific to the proposed x86
implementation (see next patch "[RFC PATCH v2 18/24] x86/uaccess: Add
unsafe_copy_from_user() implementation"), which casts the pointers
to u64 *, u32 *, and so on.

> 
> While x86 hardware gracefully handles unaligned memory accesses, the
> compiler's optimizer is legally allowed to assume u64 * is 8-byte aligned
> and could emit trapping instructions. Furthermore, if this generic .eh_frame
> code is later enabled on architectures with strict hardware alignment
> enforcement, it will immediately trigger alignment exceptions.

This is currently enforced very early by "[RFC PATCH v2 07/24]
unwind_user/eh_frame: Add support for reading .eh_frame_hdr section":

	/*
	 * Unaligned access to .eh_frame[_hdr] fields using
	 * unsafe_get_user() via UNSAFE_GET_USER_INC()
	 */
	BUILD_BUG_ON(!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS));

> 
> Could this buffer be declared with __aligned(8) or as an array of u64?

I don't think this makes sense.

> 
>> +			ret = eh_frame_do_def_cfa_expression(expr, expr_len, target_ip, &ctx->state);
>> +			if (ret)
>> +				return ret;
>> +			cur += expr_len;
>> +			break;
>> +		}
>> +
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

