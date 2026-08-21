Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B872412279;
	Fri, 21 Aug 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341291; cv=none; b=iZFJfVPdteOeJzIBG2k4RVgsrLLoTmvqO+fT1dUqqZTTAONsId/IYsCTi2nWupYX6VbgN1zzX2UKRYQApFytcKQ7aywqj6m/K6yJyMUIV0cikkNBdP1nzJxecflbPahEmFQ+oKaYVd2pl+9924M+MO11ePZ3XkyO/p77wTN9jjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341291; c=relaxed/simple;
	bh=2mZSChKe2jaCnmnjlyVPEJ3MMlfBO1ZSwkUSNJc4tkc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DxzONhtyXVkC/zuNqbovIDpUZuSsIWc7pWAwtH3peJCutLYgoC8cw62Es93/KJoXP9BvMZDybFWofHi+xCKQByqCYcENdYyO+Q5R5AVSvP/yDdzr+z/+YdB0HqckaTaaFhNsOQTeXi9Gy2o+KW+iFJUJ1QXkUk2WOdkGkLQBdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hiBw6EkR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hiBw6EkR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVdOX1237148;
	Fri, 21 Aug 2026 19:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3kQ7wU
	RzWlMAZAA6IfSbykHOrE/QE2RmXZhBjKFXgY8=; b=hiBw6EkRL+ZvgchyXiqIRl
	WwPWvS6Mh8l6xqX9AEJaRHgRCPzE+q5OQt5rIfCwTsYllKltbTIwSb6hNT8PO8Ay
	ZX3hy2fWHrEpG5K12NGEWgbCjb0C0Ce39T6AyvMIamMQohV9Ti7/4lrXh8RG4RNM
	AhOUalKY+Orep22tHxlcCjfcad5EjXBUlLBb1tXHASFC82zKVKpPdSbqjOl900s+
	YQFjzABwoOLB9SFeHS/OfeP0/UfCab0vSBDqr+s0VitaQBrwWOCEMiat85U9cwvS
	c82GPpdrfkTZ8if0pTZOZTzzeoN0aYUcnQENqX52deS+YJco5O4rXgAwUHAtthxA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2knqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfJ0b006078;
	Fri, 21 Aug 2026 19:41:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngxd5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfGId52035862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BE9D2004F;
	Fri, 21 Aug 2026 19:41:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A932004B;
	Fri, 21 Aug 2026 19:41:15 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:15 +0000 (GMT)
Message-ID: <2324ecf7-212d-4127-928f-2f801a91f9c9@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 10/25] unwind_user/eh_frame: Detect .eh_frame_hdr
 sections in executables
To: sashiko-reviews@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-11-jremus@linux.ibm.com>
 <20260818151823.18F161F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818151823.18F161F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88a9e1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WBmAbrGhqh1Q4WOWoagr8c93-05RzzTf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX7yHkNY7vh88Q
 vZnMFhgRecWHcpxF8xtpbqhnTyOLJryYMaOyuUuyv/pTEsBXU8/tpmGfyL+S4g5EazR54+c2E+M
 M8CMxyxhVjEycqUoFMpxcO+iaScMuc1OD3knSCmVYuwyYQOTYmRbE+9cmfS7gm5cWBylIl4f1eA
 PRt2umcqJ73GvYkeKarOvYJC7HpOY7VefBHomyEwLZPazEr+MMcaXqBvHhDxwNqy3qu5PTRZoXb
 oHNW5FHKI11t9ZVjXqsCcuVZM41taBPrakYjFvzGpjQo8gS+lxNqOuuT+0D4as5zRNw6AWkYM22
 XvIkLu0FGPHEbmR8J/HO0CdA7K8uNWTiR2T0cXnlX4El5uZUBmVaNCi5Gz9hcpumWpzmgh+HOE9
 9DrR2sv+ZXeMU4JVKq0ZrAulTxGOGQB1zG1x+QGlsrhKSWvSEwftNETIjJKevswpdSXRo7/mz5p
 u6gMDHAX3GJTC9knZyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1pQmm9ypW916
 ifswf7l+3mwZqmhBPEbgS0cx7VtYyJvcBkw4PolHvpA/cMqtbsS2/bo3L3HLtfvFb0xTjuxhaxN
 NbgQ5++OvqMxxlV4IPKv6pnwlj8Emm4=
X-Proofpoint-ORIG-GUID: WBmAbrGhqh1Q4WOWoagr8c93-05RzzTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

On 8/18/2026 5:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing duplication of eh_frame_mt during fork() leaves child processes without stack unwind capability.

This is resolved by subsequent patch "unwind_user/eh_frame: Duplicate
registered .eh_frame[_hdr] section data on clone/fork".

> - [Medium] Executable segments with a trailing BSS section silently fail .eh_frame_hdr registration.

Josh, Steven, any thoughts?

>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c

>> +static void elf_add_eh_frame(const struct elf_phdr *text,
>> +			     const struct elf_phdr *eh_frame,
>> +			     unsigned long base_addr)
>> +{
>> +	unsigned long eh_frame_start, eh_frame_end,
>> +		      text_start, text_end;
>> +
>> +	eh_frame_start = base_addr + eh_frame->p_vaddr;
>> +	eh_frame_end   = eh_frame_start + eh_frame->p_memsz;
>> +
>> +	text_start   = base_addr + text->p_vaddr;
>> +	text_end     = text_start + text->p_memsz;
> 
> [Severity: Medium]
> Will this silently fail to register .eh_frame_hdr for segments with a
> trailing BSS section?
> 
> When an ELF executable segment has p_memsz > p_filesz crossing a page
> boundary, the loader maps the file-backed portion and creates a separate
> anonymous VMA for the BSS.
> 
> Because text_end is calculated using p_memsz, it may extend beyond the
> file-backed VMA boundary. When this is passed to eh_frame_add_section(),
> it uses vma_lookup() and checks if the entire segment resides in a single
> VMA:
> 
> kernel/unwind/eh_frame.c:eh_frame_add_section() {
>     ...
>     if (!text_vma ||
>         !(text_vma->vm_flags & VM_EXEC) ||
>         text_end > text_vma->vm_end) {
>         return -EINVAL;
>     ...
> }
> 
> Since the file-backed VMA ends before text_end in this scenario, won't the
> text_end > text_vma->vm_end check fail and terminate registration?
> 
>> +
>> +	/* Ignore return value, eh_frame[_hdr] section isn't critical */
>> +	eh_frame_add_section(eh_frame_start, eh_frame_end, text_start, text_end);
>> +}
> 

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

