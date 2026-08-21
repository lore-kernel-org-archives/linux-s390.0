Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60371412C0F;
	Fri, 21 Aug 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341303; cv=none; b=MfRXPSuNX1ZuQHWO38F6bYan9i8qYnw0vhzjkmPEi5B1mvDAhCnyFCH6hwk3n2Nj36SJMjBkz+F3oVi3VAYClK1nCl0R4bNuWfZ0qoAX32++LoSt98w2msqHB5hX/gAYmJ/GLFWxP9fzFcWNFRUISUnts8Mai3uG7w51Rl5WVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341303; c=relaxed/simple;
	bh=C1h8cYutg8ilPVv6MJvkMMSVUIeFsG5fyJC54j00myk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TwcbC+iFLsR0DkOj0WYvRqKSC+pgX6ZWcDoo2ddUnf77xdtYTeAqaySUqC5c8t9Rz9oD6HJXzkEDFYZFG8FJ4tUYCSyu+Q7klghKPhyFbiy4XgBpGwfIiWFMtb1R/xP4T6w18wLAJchMdtPo8lklPmHfiM+rZIzoo90spQ9YxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RvXBS8rc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RvXBS8rc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVcxl1237144;
	Fri, 21 Aug 2026 19:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EJLMQt
	S3zJmf4qmR650jrS60sln5OJBOKC6JOWsOoNQ=; b=RvXBS8rcv8Bg1L5YApWz7i
	xgwknKEPkoH9qfwPFyhsZ5bHFe2WFOtm+Ul4BXg14umwqLxlK/Ocd8DmlXWFYfXN
	iju59cNzkjqoKmBCQKTx9xx/UPClsU2phAEY1yLSg0MkchhVWZ3l9W8a5RGRvG/I
	ThvRdqvN4KteZ3ISYpTsHPJG9kPodZDsCENpwXiAYDLIkF2Ez7LZ7kf3qGwx6tzo
	JLrmAhiM8zB7NuV0r/8WQLZqxSzxfPGmpIegGRdvP18Zzq1jG0aHAS/VSLvaCIFM
	hrMEzZ+li67LrrSOJdHgCpq3dMhM5q6lkn4IBHsI47CRXdK/GVOU0oTV9KWK5BVA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2knsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfKx2020612;
	Fri, 21 Aug 2026 19:41:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpsh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfYha46858736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A12B2004B;
	Fri, 21 Aug 2026 19:41:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 433382004D;
	Fri, 21 Aug 2026 19:41:33 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:33 +0000 (GMT)
Message-ID: <9b0f18c7-6687-4d17-b151-9b9171bc7624@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 16/25] unwind_user/eh_frame: Add linear .eh_frame
 search fallback
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-17-jremus@linux.ibm.com>
 <20260818150605.0C2E81F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818150605.0C2E81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88a9f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=qL-RlL_1mRJ9lt97Hb8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w5celDaAkP2dWYBeXoJhMwslRs2Isk1U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXy+OhtpNwQSXU
 G8bqSNCeQaH9piJNdcMVCvmOodptDIwRXpSReFmPwYq9gbgXc73qzruPy9t7hxW8hOLTp5OsRgS
 l66gSQt+AOcfHpMxXN7jlYSnOM6X65rixh1xmneyDCfqwrjFu3Q+RCdHkc8STzC/UnjBLJL++Ej
 WssW1fPtPJOr5MzLIpV9xKxIKNq1ViqvCUmg2yX+q72YRkOJKhiShTlCFQZcm0O6OzKc5Ziq1oH
 O8Sb4DQnSyVu4D5V/8BMpFPwiKL4HEPslvIHiZ0uFpHQrDffOLJqDv4zaKKskDWkitwRaM35xGh
 Fonh6mAzPKcNCEXzllupm/ad3CN8CB9rNRBEuqXvh0xeKTgoxPGORM69CrLradgMdNasazFn2FT
 ukGhhz7oTUcJDD6FQGbvVJkputJD6FfsRE6mlfpQzPXpyrkJ6U/sijtuCOueBje1CvqxNsJkdVt
 N9kES/lDeFQqw9stmBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX5EQ/V0nzMabL
 xRROWJ73PYiXGLqENLyBQWUqgEWt0siPr/J97yvrQJkiSh+Ly78Ny22g5QTrEGRFFRkWzAboKXb
 uPS4StsYImykkUFg+CalaTKtQP0A60g=
X-Proofpoint-ORIG-GUID: w5celDaAkP2dWYBeXoJhMwslRs2Isk1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

On 8/18/2026 5:06 PM, sashiko-bot@kernel.org wrote:
> This commit adds a linear search fallback for .eh_frame sections when
> the .eh_frame_hdr lacks a binary search table. It also introduces validation
> logic for the referenced .eh_frame section, guarded by a new config
> option EH_FRAME_LINEAR_SEARCH.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> @@ -590,6 +589,82 @@ static __always_inline int __find_fde(struct eh_frame_section *sec,
>>  	return -EFAULT;
>>  }
>>  
>> +#ifdef CONFIG_EH_FRAME_LINEAR_SEARCH
>> +
>> +static __always_inline int __find_fde_lsearch(struct eh_frame_section *sec,
>> +					      unsigned long ip,
>> +					      struct eh_frame_fde *fde)
>> +{
>> +	unsigned long start = sec->eh_frame_start;
>> +	unsigned long vma_end = sec->eh_frame_vma_end;
>> +	unsigned long cur;
>> +	int ret;
>> +
>> +	/* Linear search through .eh_frame */
>> +	cur = start;
>> +	while (cur >= start && cur < vma_end) {
> 
> [Severity: High]
> Since the section header only provides the start address, this loop iterates
> all the way to vma_end. As noted in the commit message, many binaries lack
> a zero terminator.
> 
> If an unresolved IP is scanned, will this read past the actual section
> boundary into padding or other sections, return -EINVAL on garbage data, and
> subsequently cause the caller to permanently remove the section?

True.  I mentioned this in the patch description and notes that linear
.eh_frame search should better not be used.  I will drop this patch, as
the issue is now documented with RFC v1.
>> +#else /* !CONFIG_EH_FRAME_LINEAR_SEARCH */
>> +
>> +static __always_inline int __find_fde_lsearch(struct eh_frame_section *sec,
>> +					      unsigned long ip,
>> +					      struct eh_frame_fde *fde)
>> +{
>> +	return 0;
>> +}
> 
> [Severity: Critical]
> Does returning 0 here falsely indicate success when linear search is
> disabled?

My bad!  Got this wrong during rebase when splitting out linear search
into this separate patch.  Would need to return -ENOENT instead if this
should ever get picked up again.

> If a binary lacks a search table, __find_fde() will call this stub.
> Returning 0 causes the caller, eh_frame_find(), to proceed with an
> uninitialized fde stack variable:
> 
> kernel/unwind/eh_frame.c:eh_frame_find() {
>     struct eh_frame_fde fde;
>     ...
>     ret = __find_fde(sec, ip, &fde);
>     if (!ret)
>         ret = __find_frame_row(sec, &fde, ip, frame);
>     ...
> }
> 
> Could this lead to corrupted stack traces or arbitrary memory reads by
> consuming the uninitialized fde context? Should this return -ENOENT
> instead?

True.  See above.
>> +static int eh_frame_validate_section(struct eh_frame_section *sec)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * Validate .eh_frame_hdr binary search table
>> +	 * (incl. all referenced FDE and CIE in .eh_frame).
>> +	 */
>> +	ret = eh_frame_validate_eh_frame_hdr(sec);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Validate .eh_frame CIE and FDE.  Skip if linear search
>> +	 * is disabled, as many .eh_frame sections lack a zero
>> +	 * terminator and the section end if unknown.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_EH_FRAME_LINEAR_SEARCH)) {
>> +		ret = eh_frame_validate_eh_frame(sec);
>> +		if (ret)
>> +			return ret;
>> +	}
> 
> [Severity: High]
> Does this unconditionally apply linear validation to all binaries when
> CONFIG_EH_FRAME_LINEAR_SEARCH is enabled, even if they already have a valid
> binary search table?

Yes, that was on purpose, as it would validate both .eh_frame_hdr and
.eh_frame sections.

> 
> If the binary lacks a zero terminator, eh_frame_validate_eh_frame() will
> read out of bounds up to vma_end, fail with -EINVAL, and reject the entire
> section.
> 
> Will this permanently break unwinding for valid binaries that were
> previously working fine via the binary search table?
> 
>> +
>> +	return 0;
>> +}
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

