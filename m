Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFC43CEFE;
	Fri, 21 Aug 2026 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341322; cv=none; b=cmwVFN/1yFO+AnxlMsAwYtiEi/nzUhaS+IRTde1+daptIC2pKNHH5BqcXFvXfxcYEhYn3HAKnxXB+n0haHm1eqdSkeJDtlHfkJgJbEjIQZsDVsioiwrPm76MUHXyX1VMhm7mm6aPNQOWIAwAwYFChx6cVfLyOduRUMeRtA6iZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341322; c=relaxed/simple;
	bh=QXeZTm0Y9NM2GrxftAOfRPJrj0Q2sp0E9UiwtZbvs7c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I2Wpv7LbvA9hiq89IShK4pAfi5Iqoa24fG0c6ci5ZShaz9UvxwDqktXLBJQaJfhi9NzT1q1FoZ0CNsX0I0SxYg1Y0+dnZ1zv3IIqb0EApGUGhwfNYgBo143rnN9pgqoWy0954TX3OT1h/d5XKSAXRkA2OvrRXP2z6RfR4n+4N10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V9eFBLRk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V9eFBLRk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVtYx2253849;
	Fri, 21 Aug 2026 19:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ox+vux
	p19KgsMzmudLdkjZgBNUOW+p8zWHclBen6ivY=; b=V9eFBLRk70ECtvHDPRx2GD
	SIBVsKEloUQtFLQ8XvlnKMwI681TK92S7e4BVmiRVUhgi0IFPQclVLYkkMqWMRRB
	BQIQwR0J75PXRC/GAEKLzPRIG5CAFrlgkJkzVUu3aWcxmyJHQ7bV88UX/iJ9smuO
	aGaVxNy8nw0CFyZhX5z5o4DvrVUa8tKvnuxMS++PDmKIBKVfgOf5OmnXk8TJJvBm
	IoY+I7j0ZrN+ork+5tWQGpfm5f6wDFMhyBUFbo87OLknBEobDaXxAcHuj0PKqNlY
	PNIqvuXQUJJaAdPl1+gjzxni13ujdKHF+0jFPJKnCr14q4pZBuRtOenqdeGlORKg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4kpfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfJEv023496;
	Fri, 21 Aug 2026 19:41:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twpp6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfnf048955778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5844C2004F;
	Fri, 21 Aug 2026 19:41:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B0B2004B;
	Fri, 21 Aug 2026 19:41:48 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:48 +0000 (GMT)
Message-ID: <aaecfcba-5b53-4334-94cb-6f0d5b12a2e2@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 22/25] unwind_user/eh_frame/x86: Handle DRAP
 expressions
To: sashiko-reviews@lists.linux.dev, Indu Bhagat <indu.bhagat@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-23-jremus@linux.ibm.com>
 <20260818151047.92B1C1F00A3D@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818151047.92B1C1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX8Le9aNbZ2g+N
 GBrm63CKSXx8SNpmQFzkv6M5h3ohdwqjFBrIP6RKjchMgCiC8huMEgNDkeZxTZcHFlPA9W8LMuK
 0A/Tjcmv9IRYo6U2TuMwTWKqjRWZ1GA=
X-Proofpoint-GUID: 9b8ofk5EELOaBPI-QCJ8X0oXTmUMjMh-
X-Proofpoint-ORIG-GUID: 9b8ofk5EELOaBPI-QCJ8X0oXTmUMjMh-
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88aa02 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXxGewy4m1/s7j
 dRMYuLL5B0QjHCQb1csnwkNIWZlO7bO8sajKMZfgJjaFEPaOvL23JAZutdAVroE3HSPMn+wsaOa
 z7VZhakhVdaGthFBecUnnQROiwOUIAa9DdQIqA52XN/NJI5qfa1uRP80mXHZBUWyTM+kvMRPurf
 cRLrllMW408CWw+9nq1fI5InuJKks8sznRmv7HlKy1Z4jgbsmNgDAHXnHfecqXKGBs7DWOV3w4S
 9Q1sWOIdASc9sUHc947DYGMf7TQEjfIBjtt/cLoGO1O+nPZnRyqCwLum8OXGcLZ33VVizxeAeIE
 AAHBrON8UbCdwEh0i+zWI+LkQ1LVUQylOIPnC2v9CWnJFNnPPqrx1/gWfHntLAj63lz5v2xLudM
 /r1rIOqM3kNGTbhBP+RITPOwON3NiN3XNjtVjdeazn+xQaqoPF87+VbfaWzCFdCLKuguL0dxfR9
 RDhFAn3qz0OYs9jvy1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On 8/18/2026 5:10 PM, sashiko-bot@kernel.org wrote:

> GCC uses DRAP (Dynamic Realign Argument Pointer) when the stack needs
> to be dynamically realigned. This patch adds x86-specific handling for
> the CFA and FP DWARF expressions patterns used to describe how to unwind
> through such frames.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> @@ -1206,6 +1231,16 @@ static __always_inline int __find_frame_row(struct eh_frame_section *sec,
>>  		frame->fp.regnum = ctx.state.reg_regnum[FP_IDX];
>>  		frame->fp.offset = 0;
>>  		break;
>> +	case REG_REGISTER_OFFSET_DEREF:
>> +		if (ctx.state.reg_regnum[FP_IDX] > UINT_MAX)
>> +			return -EINVAL;
>> +		if (ctx.state.reg_offset[FP_IDX] < INT_MIN ||
>> +		    ctx.state.reg_offset[FP_IDX] > INT_MAX)
>> +			return -EOPNOTSUPP;
>> +		frame->fp.rule = UNWIND_USER_RULE_REG_OFFSET_DEREF;
> 
> [Severity: High]
> Will this rule cause unwinding to fail for inner stack frames?
> 
> When an inner stack frame requires DRAP evaluation, the unwinder evaluates
> UNWIND_USER_RULE_REG_OFFSET_DEREF in kernel/unwind/user.c:unwind_user_next_common()
> like this:
> 
> 	if (!state->topmost || unwind_user_get_reg(&fp, frame->fp.regnum))
> 		return -EINVAL;
> 
> Since inner frames are not topmost, this check will return -EINVAL and
> abort the unwinding process. Could this truncate backtraces that pass
> through dynamically realigned stack frames?

True, iif inner stack frame requires DRAP evaluation.  This is a
limitation of the common unwind user framework to only unwind SP, FP,
and RA instead of all registers.

But IIUC the requirement to evaluate DRAP can only occur for the topmost
frame, as an inner function would already be past DRAP once it calls
another function.  So this should not occur.

> 
>> +		frame->fp.regnum = ctx.state.reg_regnum[FP_IDX];
>> +		frame->fp.offset = ctx.state.reg_offset[FP_IDX];
>> +		break;
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

