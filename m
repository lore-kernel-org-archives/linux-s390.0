Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234D40EBB4;
	Fri, 21 Aug 2026 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341283; cv=none; b=kv6I7mh5PiauSq/PTbjP7F2dPTvVUToTKNY8WjO0c88TzDVRCQvXgJpssbHfDbNU9mX+i1TU15j8KFQIVOyYkd7WSdAkwcUwTfMPf8jS2bmU2++82jWPeLrSv2c0nJXSJPedd76BBThLEkpZqOfd5qnWhh4m+l6vbSw5L3mtz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341283; c=relaxed/simple;
	bh=V03czHBvcXj15Eoe67ytInq0Q8g+ENX+27nzFecvQ4M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YdiNdpKhoe4ozbhATY/BZGrDhGwb8wH2VIcx1PAlnsU+5mcY5MiWlX6S372QtGh+feuNRu09GYfUjcNNx5gQvGg064JETLCkdCVMegzC2rWnFw+2ttW8TRWSZJghtGXGPSQ29FX4MlB6ol+bReWWNq5BZ+6Tx4ObPzhFYiimcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bvh2Ph12; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bvh2Ph12"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVhKI2363840;
	Fri, 21 Aug 2026 19:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kqAB3u
	+uPaYd6muFGRaDfQmu42PwvFJ4uoWOnYY0FQ8=; b=bvh2Ph12WMkEvXpaJIO58V
	Qg2K1okscp7yZHBHfEabDSjim7TaHPQ6CvF4dksH5PE3EloiYuhYHnBJcERhcFv4
	wifZoYbtwqORQHnNFpqeEr5XJXpo8qkY+C1XvSptr7viFAJZ6HcH9jo/pYgpFuwu
	oZsQy4kWtki2ROgNpIBHDYMQXhifNm5/8kvie6oyGdb0jORTNv4B4/BIfskilZ88
	1Hot6zvYPDlqq59g4MBWc8iEsrFlqYAs3u5WMQAfqdfLnkLukXjsmhY6oKW+0t1U
	Z4gbFdZ1EmwlLombBVFrAkah663CvkOWznGf021quNLIT7BMB8TKSToo7yeKaszg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0uv8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJQGri032289;
	Fri, 21 Aug 2026 19:41:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpsfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfAfx38404532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DBC20043;
	Fri, 21 Aug 2026 19:41:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8104F2004B;
	Fri, 21 Aug 2026 19:41:09 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:09 +0000 (GMT)
Message-ID: <efe98d13-6883-475e-abd2-911218b6bbe8@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 09/25] unwind_user/eh_frame: Add support for
 reading .eh_frame section
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-10-jremus@linux.ibm.com>
 <20260818150549.2009E1F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818150549.2009E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88a9da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=tsU7PuWUzG7qZv_JgPMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MbKbvALoZfKLTKailz094drnBM6Mah6C
X-Proofpoint-GUID: MbKbvALoZfKLTKailz094drnBM6Mah6C
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXxsUaV2YrlsmH
 KRaA6frpG5HLtub+7qYsSgAOD9hTiac8bH7GQagXygRwxtHivNP4d1D/VHc2ihQG5LkV/pNstco
 riqo3hFj1U+KCIwyyFjvXQBllEAto98=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX303B/3UNkEqf
 2Aud6hweLGFRPsLY4h2RGYQAtbjpZ9tBkYPYmUsNvld5WQu8F0U1/JNVURB+Q4UXwuEaOncrGVb
 6v+ADKbS7k9KYctgkVw75DvMO+Kqfw2enTraW8AMz8wtGJ1+Mqg/nbKv/SxnepPhmESF6nufTfR
 wAah401PaxmG+Rs53K7ob9qxwSbg4PJsnzexi2eZ/em2u8ydxrIY8xqH3lha31EUwjwlbGlwAnM
 lx0qII2LR16H+JuhzfhVpbGdANAlo7mzxlB6O0ULAOv/Q7uVnW2OKqj6oRJrzeXXX7xT5Wr/U4A
 kWqgePmqDEgwvwR2XpMIXepujArrwHoUMxLrQ2L1BdF03IkAa46SL5BW09Gq5PMomWdZhHpaqXf
 zFHNv4Nw8yvy0SoGDD167stM3xUdAuqXglmsgelkcw2u7ntHM0ssubDU6/z8X1Q6cxldCEnXEEF
 0lg8k3o0B/bILV5ZGpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On 8/18/2026 5:05 PM, sashiko-bot@kernel.org wrote:

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>>  static __always_inline int read_encoded_pointer(struct eh_frame_section *sec,
>> +                                               struct eh_frame_fde *fde,
>>                                                 unsigned long *addr,
>>                                                 unsigned long end,
>>                                                 u8 encoding,
>>                                                 unsigned long *value)
>>  {
> [ ... ]
>> +	case DW_EH_PE_funcrel:
>> +		if (!fde)
>> +			return -EINVAL;
>> +		result = fde->func_addr;
>> +		break;
> [ ... ]
>> +static __always_inline int __read_fde(struct eh_frame_section *sec,
>> +				      unsigned long fde_addr,
>> +				      struct eh_frame_fde *fde)
>> +{
> [ ... ]
>> +	scoped_user_read_access_size(fde_ptr, 4 + length, Efault) {
>> +		/* Read PC begin (function start address) */
>> +		ret = read_encoded_pointer(sec, fde, &cur, end, fde->cie.fde_addr_enc, &func_addr);
> 
> [Severity: High]
> Does this code use an uninitialized value for the function address?
> 
> If the user-space eh_frame section specifies the DW_EH_PE_funcrel
> encoding for fde_addr_enc, read_encoded_pointer() will attempt to evaluate
> fde->func_addr.
> 
> However, fde->func_addr is not populated until the end of __read_fde(),
> after the function address has already been parsed. Could this allow a
> crafted eh_frame to use uninitialized kernel stack memory in its
> address calculation?

Valid finding.  I'll remove support for DW_EH_PE_funcrel, as it cannot
be used for the PC begin (function start address) nor PC range (function
size).

> 
>> +		if (ret)
>> +			return ret;
>> +		if (func_addr < sec->text_start || func_addr >= sec->text_end)
>> +			return -EINVAL;
> [ ... ]
>> +	fde->func_addr		= func_addr;

>> +static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
>> +					 struct eh_frame_fde *fde,
>> +					 unsigned long *cur_ptr,
>> +					 unsigned long end,
>> +					 unsigned long *ip_ptr,
>> +					 unsigned long target_ip,
>> +					 struct eh_frame_cfi_context *ctx)
>> +{
> [ ... ]
>> +	case DW_CFA_offset: {
>> +		u8 reg = DW_CFA_operand(opcode);

		unsigned long _offset;

>> +		long offset;
>> +		int idx;
>> +
>> +		ret = read_uleb128(&cur, end, &offset);

		ret = read_uleb128(&cur, end, &_offset);

> 
> [Severity: Low]
> Is the offset variable the correct type here?
> 
> The read_uleb128() function expects a pointer to an unsigned long, but
> offset is defined as a signed long. This creates an incompatible pointer
> type warning during the build.
> 
>> +		if (ret)
>> +			return ret;
>> +		offset *= fde->cie.data_align;

		offset = _offset * fde->cie.data_align;

> [ ... ]
>> +	case DW_CFA_restore: {
>> +		u8 reg = DW_CFA_operand(opcode);
>> +		int idx;
>> +
>> +		idx = reg_to_index(reg);
>> +		if (idx >= 0)
>> +			ctx->state.reg_rule[idx] = REG_UNDEFINED_IMPLICIT;
>> +		break;
>> +	}
> 
> [Severity: High]
> Does this instruction handler violate the DWARF specification?
> 
> The DWARF standard requires DW_CFA_restore to change the rule for the
> indicated register back to the rule assigned by the initial instructions in
> the CIE. By unconditionally setting it to REG_UNDEFINED_IMPLICIT instead
> of restoring the CIE initial rule, this could corrupt the register recovery
> state and cause unwinding to fail.

I agree.  But libgcc's unwinder does handle DW_CFA_restore and
DW_CFA_restore_extended like that.  There is even a comment in
libgcc/unwind-dw2-execute_cfa.h:

	/* FIXME, this is wrong; the CIE might have said that the
	   register was saved somewhere.  */

I will implement and check whether saving the CIE state and restoring to
that (as specified) still produces correct results.  I will also implement
support for DW_CFA_restore_extended.

> 
> [ ... ]
>> +		case DW_CFA_def_cfa_register: {
>> +			unsigned long reg;
>> +

			if (ctx->state.cfa_rule != CFA_REG_OFFSET)
				return -EINVAL;

Likewise for DW_CFA_def_cfa_offset, as the DWARF specification states
for both:

"This operation is valid only if the current CFA rule is defined to use
a register and offset."

>> +			ret = read_uleb128(&cur, end, &reg);
>> +			if (ret)
>> +				return ret;
>> +
>> +			ctx->state.cfa_rule = CFA_REG_OFFSET;
>> +			ctx->state.cfa_regnum = reg;
>> +			break;
>> +		}
> [ ... ]
>> +static __always_inline int __find_frame_row(struct eh_frame_section *sec,
>> +					    struct eh_frame_fde *fde,
>> +					    unsigned long ip,
>> +					    struct unwind_user_frame *frame)
>> +{
>> +	struct eh_frame_cfi_context ctx;
>> +	int ret;
>> +
>> +	/* TODO: Signal frame - not supported yet */
>> +	if (fde->cie.signal_frame)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = __do_cfi_program(sec, fde, ip, &ctx);
> 
> [Severity: High]
> Can this leak kernel stack memory?
> 
> The eh_frame_cfi_context ctx structure is allocated on the stack without
> being zero-initialized. In __do_cfi_program(), some fields are manually
> initialized, but cfa_offset is omitted.
> 
> If an attacker provides a crafted eh_frame using DW_CFA_def_cfa_register
> as the first state-modifying instruction, it changes cfa_rule to
> CFA_REG_OFFSET without setting cfa_offset. The uninitialized kernel stack
> garbage in ctx.state.cfa_offset is then subsequently copied into
> frame->cfa.offset, allowing it to be used as an offset to read memory.
> 

Valid.  Fixed by checking that the CFA rule is register with offset.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

