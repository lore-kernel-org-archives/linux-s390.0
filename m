Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EE43E063;
	Mon, 14 Sep 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382717; cv=none; b=nIGrNB6pnhlqMljmA3IDrwKB2j/Sv9B3EvyOr5+uWos1/Mv6peh0u9cwYHBvw6z0JCiCmJ8kq2Glo1IxAdpR/mLUiDiGdt/N1Q8Z0Gx8pzbdqBQw+IAaxt4WRHCbi4npfB4z1BIg0ztnjs/cfuw2I8/V++HewNHmThl+fsTeb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382717; c=relaxed/simple;
	bh=6IwFBI99c2OL/kFG3/p1tkC7rJQaGlnGAewoVI4q7CE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nvckVhV4s78ZMG0ZswJzEneHkO0vwjUom9sCx2aYkqP5OSrVD6oXG6Pw8nDDqKYJAQdH3U4wjotq8Sy5zMGc9xyQOjU+TgHOds/42Apu+neCCHymTfxluLStqfOz/c4E9Qo32ssUkjB1jAkhEEO44t2kXITheUlXeTcQ9pGkONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FHkTmD/O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FHkTmD/O"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EA1Q7F1712866;
	Mon, 14 Sep 2026 10:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jTfMkH
	fqMJM46ZS9hxUIFLrih4MnMmT8+qXYLi3PTRU=; b=FHkTmD/O5ZHEx/goHVlGnN
	OVRkZd+iTJaUlByeTYUrR700sZ7rlivUtG34kxLxszucikt0APWvSSyhhF6E/FyX
	lhsr6t61mQTTreNtCnp4X81s5PyVfDEBQ40NDnq+0dVrZrayt5185522kddkWBdj
	n362UnyiXhWedhMarztZtGYNHexThNCPF4iOhQ9NcXMvX6ljZOEMLIUE4Eq5Tnzc
	LeKpLvhxYpNlW2aLnXFlCXC+mXt8NMCLR0j3a52fVnQzUwGmzx/GJloi9f5/epog
	QhemSkLRWMyjSD1he6SqS6kNeBQKXNk9jznjLWXdVdxyita6OhNX1Gd6c2j0zCug
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83gtny-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 10:45:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9o6Q92133403;
	Mon, 14 Sep 2026 10:45:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnk9j5a63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 10:45:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EAivDA51053022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 10:44:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDD432004E;
	Mon, 14 Sep 2026 10:44:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AF9E2004B;
	Mon, 14 Sep 2026 10:44:56 +0000 (GMT)
Received: from [9.111.205.105] (unknown [9.111.205.105])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 10:44:56 +0000 (GMT)
Message-ID: <cd0fd64c-8627-444b-90b4-0cf9611ea163@linux.ibm.com>
Date: Mon, 14 Sep 2026 12:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v2 09/24] unwind_user/eh_frame: Add support for
 reading .eh_frame section
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-10-jremus@linux.ibm.com>
 <20260821201618.6DBA21F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821201618.6DBA21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE1MCBTYWx0ZWRfXx1zPiQotBWMb
 s6jduk5WPXzZ7ZF7g/HvYn4MwYI2hK8GcePtyrz9ntKubP64N6H5iFzayrQooLB0HILKORvLJ49
 RWu0NNW5WOb1tz2c/5gBLxnNja7uBsm5oaAZgF39b/Fk7EvOWjjnHbuceCkFqOdAKaSklTQcrWl
 mZMwhSi5uxqo7BBsgVUEYALGq3Xbfe1V35uqcxCiq5m5+PwbZFqfyHCnLT8X7IE1wPKVzAwk07Z
 oIz2klb89gcLCf4STcjZDOVNHmrGqNVEVGyFcUCwwajHCK4WsqOZ98inNgMlwz+IX4uK9SH/EXS
 IhCLHnzXNJLarSeTC0I7nLjZrZei8YgoGgRCGyWQZA8IKVBMtyH7/TYVyypOcOlEmOckRSEZufq
 RhXLyTmGZLMYafA1JD5BNLaUX2ykm+abfTCzrZeoy3BQl0EWyi7xf6YgreClf5yOj15Y7h8nsDj
 z/snh3D6GuMk0vPSjzA==
X-Proofpoint-ORIG-GUID: HI3dDa751xnCplM-Bc_O1WJMJMCY6Xfm
X-Proofpoint-GUID: HI3dDa751xnCplM-Bc_O1WJMJMCY6Xfm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE1MCBTYWx0ZWRfX69p+hQNAHNfd
 j6HCpb7+haDx4aj/m0kOK7J9coSCbOOmU/Mz9wc72VZxBXWuIQjAmWWrT+YRNuqAREXllhj0gDb
 7FTmamF7SQYvt5PLaxOfZzh8zr3ap7k=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa7d02f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=WEngP23cLvfrQGMqwf8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140150

On 8/21/2026 10:16 PM, sashiko-bot@kernel.org wrote:

> In preparation for using .eh_frame to unwind user space stacks, add an
> eh_frame_find() interface for finding the .eh_frame[_hdr] information
> associated with a given text address.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> +static __always_inline int __read_cie(struct eh_frame_section *sec,
>> +				      unsigned long cie_addr,
>> +				      struct eh_frame_cie *cie)
>> +{
>> +	void __user *cie_ptr = (void __user *)cie_addr;
>> +	unsigned long cur = cie_addr, end;
> 
> [ ... ]
> 
>> +	scoped_user_read_access_size(cie_ptr, 4 + length, Efault) {
>> +		/* Read CIE_ID (must be 0 for CIE; FDE otherwise) */
>> +		UNSAFE_GET_USER_INC(cie_id, cur, end, Efault);
> 
> [Severity: High]
> Are we bypassing the pointer masking mitigation here?

True.  Fixed in next version likewise as for eh_frame_read_header() in
preceeding "[RFC PATCH v2 07/24] unwind_user/eh_frame: Add support for
reading .eh_frame_hdr section".

> 
> The scoped_user_read_access_size() macro shadows the passed pointer (cie_ptr)
> with a masked version to prevent speculative kernel accesses. However, the
> memory read via UNSAFE_GET_USER_INC() uses the separate unmasked cur variable.
> 
> Could this allow speculative out-of-bounds reads to access kernel memory?
> 
>> +		if (cie_id != EH_FRAME_CIE_ID)
>> +			return -EINVAL;

>> +static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
>> +					 struct eh_frame_fde *fde,
>> +					 unsigned long *cur_ptr,
>> +					 unsigned long end,
>> +					 unsigned long *ip_ptr,
>> +					 unsigned long target_ip,
>> +					 struct eh_frame_cfi_context *ctx)
>> +{
> 
> [ ... ]
> 
>> +	case DW_CFA_restore: {
>> +		u8 reg = DW_CFA_operand(opcode);
>> +		int idx;
>> +
>> +		if (ctx->cie)
>> +			return -EINVAL;
>> +
>> +		idx = reg_to_index(reg);
>> +		if (idx >= 0)

		if (idx >= 0) {

>> +			ctx->state.reg_rule[idx] = ctx->cie_state.reg_rule[idx];

			ctx->state.reg_regnum[idx] = ctx->cie_state.reg_regnum[idx];
			ctx->state.reg_offset[idx] = ctx->cie_state.reg_offset[idx];
		}

>> +		break;
>> +	}
> 
> [Severity: High]
> Does this properly restore the complete register state?
> 
> It appears only the rule type is restored from ctx->cie_state, but the
> offset (reg_offset) and register number (reg_regnum) are not restored and
> will remain at their previously modified values.

Valid.  I was in a rush to get all of the RFC v1 Sashiko AI review
resolved and was used to the struct unwind_user_rule_data approach,
where a single assignment is sufficient.  I will do likewise here
and introduce struct eh_frame_{cfa|reg}_rule_data:

struct eh_frame_cfa_rule_data {
	enum eh_frame_cfa_rule rule;
	unsigned long regnum;
	long offset;
};

struct eh_frame_reg_rule_data {
	enum eh_frame_reg_rule rule;
	unsigned long regnum;
	long offset;
};

struct eh_frame_state {
	struct eh_frame_cfa_rule_data cfa;
	struct eh_frame_reg_rule_data reg[NR_REGS];
};

struct eh_frame_cfi_context {
	struct eh_frame_state state;
	struct eh_frame_state state_stack[EH_FRAME_MAX_STATE_STACK];
	struct eh_frame_state cie_state;
	...

Another option would be to use struct unwind_user[_cfa]_rule_data.
For that purpose those would need to be updated to represent the
offset and register number as (unsigned) long.  The question is
how to deal with UNWIND_USER_CFA_RULE_{SP|FP}_OFFSET then.
eh_frame could internally use UNWIND_USER_CFA_RULE_REG_OFFSET and
only before returning the info to unwind user convert to
UNWIND_USER_CFA_RULE_{SP|FP}_OFFSET if appropriate.

I will explore that in a future version.

> 
> [ ... ]
> 
>> +		case DW_CFA_advance_loc4: {
>> +			unsigned long offset;
>> +			u32 delta;
>> +
>> +			UNSAFE_GET_USER_INC(delta, cur, end, Efault);
>> +			offset = delta * fde->cie.code_align;

			if (check_mul_overflow(delta, fde->cie.code_align, &offset))
				return -EINVAL;

> 
> [Severity: Medium]
> Can this calculation overflow?

Valid.  Will add a check in next version.

> 
> The multiplication of delta (a u32) and fde->cie.code_align (an unsigned int)
> evaluates as a 32-bit unsigned integer before being assigned to the 64-bit
> unsigned long offset.
> 
> If the product exceeds 32 bits, the high bits would be truncated, which might
> cause the unwinder to desync from the actual PC.
> 
>> +			ip += offset;

			if (check_add_overflow(loc, offset, &loc))
				return -EINVAL;

Likewise for all other DW_CFA_advance_loc* flavors.

>> +			break;
>> +		}
> 
> [ ... ]
> 
>> +		case DW_CFA_restore_extended: {
>> +			unsigned long reg;
>> +			int idx;
>> +
>> +			if (ctx->cie)
>> +				return -EINVAL;
>> +
>> +			ret = read_uleb128(&cur, end, &reg);
>> +			if (ret)
>> +				return ret;
>> +
>> +			idx = reg_to_index(reg);
>> +			if (idx >= 0)
>> +				ctx->state.reg_rule[idx] = ctx->cie_state.reg_rule[idx];
>> +			break;
>> +		}
> 
> [Severity: High]
> This seems to have the same register state restoration issue as DW_CFA_restore.
> Should reg_offset and reg_regnum also be restored here alongside the rule type?

Same as for DW_CFA_restore above.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

