Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18253A7F41;
	Tue, 18 Aug 2026 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080302; cv=none; b=HaCxkEaNsZEwa1TR0FlkmQbfdoscGQmQK5Q4Mx649p1YWY3lnCtLROAfELVhZvs2qnE8D1Iv/zxFfUQ2kUsSr5LS6Uika2GTio/v9SeYGZVL2/7PjHu3YHGk8+KY8LOKw8lpzpjilqqlEW3JO00XAMMI0c+4aZuwrYkx/3pzb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080302; c=relaxed/simple;
	bh=5YS75tYEXcAd4++9k/Oecg0utVeYRWcInN64CA2N8WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5QmKE7nojKgWrJzvNTD4ltbyAYr9lVQeeRGMjKf0qdU1NHzvca92DIiUk8xgTmggd42lWFMwwMYHgraVVlbXlQRGPDuuJ9zPQn3BWja5Z6Nu0L0rYE8DYy+o1V67rWAY4PAhJm3wZh/x/r5NSwKc60HvZNn6cYiV8+uGg9ctmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eOweMK1n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eOweMK1n"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IHVbVZ3306846;
	Tue, 18 Aug 2026 19:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b7tG9R
	h2kYHQtj+P/9jEmyk08d3tTzv1eL4GNQmDZiE=; b=eOweMK1nGQBuIS6dWNr9ab
	sftx3ztNP3klJtUC2kbaK5270moLoPML+reQiSYVLVX80MTxjXNKx4xAjvMcmsfc
	1lkzp5vumZc4CPzPx5UKEqoG03F1usw6d1tuqlE8jSjDY6xdiiV55It1rPpJWNQ0
	5NYDA4lNUEAmFSJ2wLZPohzAC88qAHEsOqtqP4W6gGr2cXbd6qJepsYxMdcFN+YS
	P2UbHmBURxzOSbOw+vyR8rO0vPB3R8LmBNT3pNRzWgFUkNZGR/dRO5q5HFk9SY2x
	JiKyMrR6AkJXikSTuphKlepHUd42pWSPEUuW2YU1HCGZaBaJHVYKo5nmcSwG078Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqtbwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:11:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJBKJs016989;
	Tue, 18 Aug 2026 19:11:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek50we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:11:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJBYVR30540050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:11:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DBA120043;
	Tue, 18 Aug 2026 19:11:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C443C20040;
	Tue, 18 Aug 2026 19:11:33 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.142.99])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:11:33 +0000 (GMT)
Message-ID: <48ec2595-9458-47f2-8b80-2e6c4a507d1c@linux.ibm.com>
Date: Tue, 18 Aug 2026 21:11:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq: Out-of-line rseq_exit_user_update() for KMSAN
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260818181328.2963038-1-iii@linux.ibm.com>
 <20260818183249.5EF411F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260818183249.5EF411F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX/ptN2jPoiRMP
 QovMknJNPVzEoed4PI5zHyQwpbKnNIAd5GMmRGa3FfSUny730O80KkJDv+5Pc8EqjOUxxqlNHuF
 y9JX+dn3zNNblczk+OEZsd2OBDsEJoF0hh5hA2rjdbI7tHcM8YfZphvFEsnvY18MKdSD8C6Ji4x
 4OBcLB6feegZk98g1Ak+fdSabf/Od5jSEqJcmepcutfRm+NM/TG5CSGxM+u7nrv8pVXeCMNkIjc
 cLOy83S0cBrav3nW3IzDER7KawaJF10B0gIZug8yIsC6dW3qt58qFyu7nX402wwo5vzlLPuAsdS
 BI+E1EdFna0E+pfY1SjsynQfq5Pdlq73u7KwUZf1qo+lbSyDQi3+aY1X84ZHWyeanbPbaNpcK/Q
 z7dGUodlb1MGOfr6EdUdjxpKDIa+4KI7QptsaW/M0dHvYg+cYuLNmSgKlFS6/uaEcU782u8z3ko
 4+EZzFSdGCcfIDrAV9Q==
X-Proofpoint-ORIG-GUID: g3QSq8E1zMROrwVPMMfbGt6hoOruyNXF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX9dbwLqG4GlTE
 wCx1LG9M9Ujb65dpOxfHY+PdzBvILFS5hY/+zLhxzyZJZ4yeschfrm1dlv0yHgkyiGixSuq7f7C
 p7lWYMYIKXbL71hbpeJ/6ryky3aJMMw=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84ae6b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DhBsoQSJM1Zyby4fqycA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g3QSq8E1zMROrwVPMMfbGt6hoOruyNXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180140



On 8/18/26 20:32, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] KMSAN false positive in `__rseq_grant_slice_extension` due to missing out-of-line wrapper in `noinstr` context.
> --
> 
> --- Patch [1]: [PATCH] rseq: Out-of-line rseq_exit_user_update() for KMSAN ---
> commit 34d84b6249995289ac0487f7b7677244a859e66c
> Author: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> rseq: Out-of-line rseq_exit_user_update() for KMSAN
> 
> This patch fixes a KMSAN false positive on s390x caused by
> rseq_exit_user_update() being inlined into a noinstr context, which leaves
> KMSAN shadow memory uninitialized for stack variables. It resolves the
> false positive by out-of-lining rseq_exit_user_update() and compiling it
> with KMSAN instrumentation.
> 
>> diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
>> index 31ce349ed42ce..defe1900e041a 100644
>> --- a/include/linux/rseq_entry.h
>> +++ b/include/linux/rseq_entry.h
>> @@ -596,7 +596,8 @@ static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_regs *r
>>    * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
>>    * slow path there will handle the failure.
>>    */
>> -static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, struct task_struct *t)
>> +static __always_inline bool rseq_exit_user_update_inline(struct pt_regs *regs,
>> +							 struct task_struct *t)
>>   {
> 
> [Severity: High]
> This isn't a regression introduced by this patch, but
> __rseq_grant_slice_extension() appears to have the same KMSAN false
> positive.
> 
> In include/linux/rseq_entry.h:__rseq_grant_slice_extension():
> 
> 	struct rseq_slice_ctrl usr_ctrl;
> 	...
> 		unsafe_get_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
> 		if (likely(!(usr_ctrl.request)))
> 			return false;
> 
> 		/* Grant the slice extention */
> 		usr_ctrl.request = 0;
> 		usr_ctrl.granted = 1;
> 		unsafe_put_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
> 
> Because __rseq_grant_slice_extension() is unconditionally __always_inline,
> it gets inlined into the noinstr function irqentry_exit(). The
> unsafe_get_user() call reads into the local stack variable usr_ctrl, but
> KMSAN's instrumentation is disabled here, leaving the shadow memory
> uninitialized.
> 
> When unsafe_put_user() is called with usr_ctrl.all, it invokes
> instrument_put_user() which explicitly calls kmsan_copy_to_user(). This
> evaluates the shadow memory of usr_ctrl.all, sees it as uninitialized,
> and produces a false positive.
> 
> Should __rseq_grant_slice_extension() also be out-of-lined similar to
> how this patch handles rseq_exit_user_update() to prevent this?

Agreed, thanks.

I will wait for feedback for the out-of-lining approach, and if it's
favorable, I will post another patch for __rseq_grant_slice_extension().
