Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A243B3FD;
	Fri, 21 Aug 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341316; cv=none; b=AxTSjRPk6pnuewkdWN91k+JYvc2kxzVidhHIaM+BNkG783QmqDGm5vndmdBJzsm4ssafmrL6Vs9SG6RBGEXG+QyyoaXKDdCs2qkKEULHpWhvd4w7NYFE3uE5va03QH04SZ1G/rLzU0tNllHJ1qCzpCr7vHm71lJby7UCJF9bIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341316; c=relaxed/simple;
	bh=vA/PybHXX/IC70HxBNbeDYjpHyOBPhh2Pkjau7sm3XQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iLxe4s67cyks72y4kdHjm6ASvEhZlV88q3202TSlBVCRRshtMytp414SjPl4q3NYCneMKyAjJBUi8PG3USjpJ6afKubCxhfmS+hEbncmDR733nXwiyBf8hf8oG/vteozvEnqOXEbN+tJzR1EX5Sq4b1Rg2T5KRbJCxmUQrlkV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fpQhNRqZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fpQhNRqZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVmUp492011;
	Fri, 21 Aug 2026 19:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iZfzyR
	meNFVb0Ajz22Ou4ktNzphDEYvhAtmt5Zzp+Dg=; b=fpQhNRqZA3MihkAKULF+Du
	D1C7ACtj06IFZamRkvvyym1Ns51sEh2/7TrRmn5kQrgh/GHWnWJqlfdae32nMqEX
	7VgdbO9XDdn/IPjp6wmFfzmRgaasdxNc86qHW7nZ001eq5WcS2/uFFnGuX4d/Btt
	VxRv1FkAlRGxRnM0JcoIpiwUNEcbsRugvPVjEyzhqXTFM7KsDO4fm2CIMAIbspPF
	HeUuqm/CKnincPEV2Tg0tMWqGlOjnozLKfNcI+HIzJN9/tqeLJTWLgZ6J7EeInf0
	+buFcbTTQCLiIYuZK+o4poT+/iVwEmfGWHN5K5GpEpu6REpDvQp0It4nt9KN1idQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0kt7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfN9o020636;
	Fri, 21 Aug 2026 19:41:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpsjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfkHo28770904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C35B2004F;
	Fri, 21 Aug 2026 19:41:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE2B62004B;
	Fri, 21 Aug 2026 19:41:45 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:45 +0000 (GMT)
Message-ID: <2f2a77a8-50d8-4882-8f04-8ca5922aa689@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 21/25] unwind_user/eh_frame/x86: Handle PLT
 expressions
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-22-jremus@linux.ibm.com>
 <20260818151001.88CF21F00A3D@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818151001.88CF21F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 71u6xi0lL83Yy1D3xLP-fhIHXOrcNCOY
X-Proofpoint-GUID: 71u6xi0lL83Yy1D3xLP-fhIHXOrcNCOY
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88a9fe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=wr-FIVCmD1lj4lj2J1QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX8WJP96JViIC1
 sev/gPFwcOEbTUGM6/eSwpMFgwfe3cD8MzRY1RtmLEOG/29PSotruzvnjIYGxNIL6RnKkA/+Oi/
 PVzxSWpk4ET0TYQubPFh2EiEZQd5Dp4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX6ajPlBCXzMN9
 e5xWBqsRWsMwWLRT7GJGrNNWmDEaRuBikcIDcQRF5qUvcyTBC9mrs3/DUdM/bmDLQUX3ESuAEbX
 Q4pf6UXDgJqPYTo799UgXJOS+vgtY2+4g53VVIBAvT3g5UlwBfO+kbfdNQsPs6ZuSYlINbf77n+
 tL33YBfYj0LSnvCmF9aexLxBi5RF4iBw7MMhsKQrCR4DiiaeYinVIrTz0c/JgCjMKFCa8J4OSiw
 VTJLGvlVtcMMnifJWQvcwRTV+1NjResgDecsJ2AQh7ngROJL8H7cQ5f3KcTcXwjeQ898k5i0rSj
 ijvJocJz3AsJ85cDugNDjkbSe3bnTRQz7k0VjI8w92MnP/7nLo1FbCnUV94K3AQv5CodmFse/rA
 CCVtXF298h9IME5gHX8DWporIg2OGs5M9kqhQwd+jZRZoqSl08WQkgVq37m+91iCwo36iNmdsIE
 /gSGfywdd59UKAu+rBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On 8/18/2026 5:10 PM, sashiko-bot@kernel.org wrote:

> This commit adds x86-specific support for unwinding through GNU linker
> generated PLT entries by handling the CFA expression found in .eh_frame.
> It explicitly aims to enable this for both i386 and x86-64 binaries.
> 
>> diff --git a/arch/x86/include/asm/unwind_user_eh_frame.h b/arch/x86/include/asm/unwind_user_eh_frame.h
>> index fdccbda2fe4b1..8268eb1a0ff5a 100644
>> --- a/arch/x86/include/asm/unwind_user_eh_frame.h
>> +++ b/arch/x86/include/asm/unwind_user_eh_frame.h
> [ ... ]
>> +static inline int eh_frame_do_def_cfa_expression(const char *expr,
>> +						 int size,
>> +						 unsigned long ip,
>> +						 struct eh_frame_reg_state *reg_state)
>> +{
> [ ... ]
>> +		sp_reg = DW_OP_breg_register(sp_op);
>> +		ip_reg = DW_OP_breg_register(ip_op);
>> +		if (sp_reg != EH_FRAME_REG_SP || ip_reg != EH_FRAME_REG_RA)
>> +			return -EOPNOTSUPP;
> 
> [Severity: Medium]
> Does this unconditionally reject 32-bit i386 PLT expressions?
> 
> The commit message mentions enabling unwinding for both i386 and x86-64,
> and the comment above notes the 32-bit DWARF registers 4 (ESP) and 8 (EIP).
> However, this check requires the parsed DWARF register values to match
> EH_FRAME_REG_SP (7) and EH_FRAME_REG_RA (16), which are exclusively the
> x86-64 register mappings. 
> 
> Will this cause valid i386 expressions to fail and return -EOPNOTSUPP?
> 
> While 32-bit eh_frame unwinding is currently disabled at a higher level
> for x86-64 tasks, this logic appears to contradict the intended architectural
> support.

When enabling i386 support, one would define EH_FRAME_REG_SP and
EH_FRAME_REG_RA to the respective i386 constants.  The PLT expressions
used by the GNU linker are otherwise the same.

For 32-bit compat (and x32?) this is different.  This may require
the definitions to be changed to functions that dynamically return the
respective register constant values.

> 
>> +
>> +		/* CFA = (SP + SP_offset) + (((IP & 0xf) >= N) << shift) */
>> +		reg_state->cfa_rule = CFA_REG_OFFSET;
>> +		reg_state->cfa_regnum = EH_FRAME_REG_SP;
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

