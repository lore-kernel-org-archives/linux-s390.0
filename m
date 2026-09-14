Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3844B69C;
	Mon, 14 Sep 2026 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385004; cv=none; b=H04CploajMvCHbk6F397O2muwV2pf4QUs0edw4/XdLgEpIorB08pAvq6DgmWPfC3y3tJBNcVC8oZeJnCGQP2C48Fslc9raFIZUKj0tEnXxeT1SyaGkwWBcQHx9Pcrkm+aMWinLV/7bS18tAd+VmeMuwi887TmsZCdolqUd/sBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385004; c=relaxed/simple;
	bh=oWqn9pftwcN/9oNSklX7JYROHSh7KQkXjgIKwWebXu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsl8UGUpkVo+CX3uFobfpkXqq87vv5l0s4Pmws59fonNf7ht+wiu8S/HAio+e3T30YcgZVY4JBsnKNnP98zFm0vATZONdcpUQxMQOxht557osO2NYZ3/lLj+/4j81BFJoLfSVEGjYLg7vKz+qwkcFhycsWTAO3z4ctnHXy5qe0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZsIflXgp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZsIflXgp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EA1Zjv547032;
	Mon, 14 Sep 2026 11:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JLLu/o
	G+cyhXUko09Gzghqb6hIqwWLnKxaGJlor8gjo=; b=ZsIflXgpGAoET3i/Z+fYZ1
	96OBQIJQFiZcFkpv5ETepj1HSxz3OG0VyOq/2s3PCh0u5Lif0XU/vQP/F/GTwHTG
	zgJMzKIlfNfq6nKHN+BmiFQaXuLlRIiaPApR/1VtVbQmH13hOkrYZJRjTNe+wf1D
	zeq5pZW0YDxwOK+Za8cPF+g63XMXdk+ol2pugtT1x7db4IC/vb5bGmBHFm+OksPO
	Ckcy1P0/tQSJ4v7/AwOHQdgNkWoRhZ2hqUKs2g4leqKPwuDduHA4odw/NH2pBXdo
	4uxPXJby89whLDzM8U5dUQQmC0WtIJ8lOB08+8Q0CAZEJ7z2YQf2bFsX+n8cSOfw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5drxus-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 11:23:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9o4FL2106306;
	Mon, 14 Sep 2026 11:23:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pwu3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 11:23:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EBN06s40239458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 11:23:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA2842004D;
	Mon, 14 Sep 2026 11:23:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C664E20040;
	Mon, 14 Sep 2026 11:22:59 +0000 (GMT)
Received: from [9.111.205.105] (unknown [9.111.205.105])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 11:22:59 +0000 (GMT)
Message-ID: <e0a73454-fd65-414e-8db9-36f2b7a061af@linux.ibm.com>
Date: Mon, 14 Sep 2026 13:22:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/24] unwind_user/eh_frame: Wire up unwind_user to
 eh_frame
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-12-jremus@linux.ibm.com>
 <20260821200722.8E9EC1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821200722.8E9EC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE1NiBTYWx0ZWRfX5qqI1AN/KlmY
 sgnLDunqraeim75A1cw3GbrhJ5irMTaZsIXgTttic6dgWW6cl77ITD3wTQqVpXBgpMvQnycDGUR
 RxwT/GRZcUkvLpTzAxWqMiPylTAtULx9u3gG3zwwkk0RHvPDL+pMl4/QPjifbIwR2tVhdOCwCUN
 IF/js608bq5fuQdd3zOsWgDoQIptUe6tzVvZAMmZMCLne1k5XTNUw5L3L+V9jptJz2mKWKDsb9d
 OddCIUiCxgO/0sMes2JYQpnsC32SzD1hjVyPsoDVmewv+mQfz8r4xgNLkzQW3RNxkdbp4ncQlsL
 tORR4E0dAG63WZQhtjhVeuURfwAJfaYHjphQeLfioBLSgmVt4V/xTCcnpNUH8IgnwGlgJlg+Stu
 rDZbRvV2b69BIFqMDKocjDBMl65QAelT2ntOIGsYGJ7HhWvAIjnusnpOYjKF2fT9ECp7rLw9ZE8
 YlMDbtDsaIcXOzo/4mg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa7d919 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=eEME7sabQ6DRVGjtH7YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RHVjn9rlqz1ynJCRQypcIdMxxISb-NXJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE1NiBTYWx0ZWRfX+LtzIHGPzBug
 ikUpqcNd56wzBmcDOHwKtnBlnrbwwOzcbeFuvkIOlFjauamkrobbHDDSu1Z81FGMcwHn9PUNhQb
 Gws2IqHKrgG483nGrntKNSush62PbRI=
X-Proofpoint-GUID: RHVjn9rlqz1ynJCRQypcIdMxxISb-NXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140156

On 8/21/2026 10:07 PM, sashiko-bot@kernel.org wrote:

> This commit hooks up the eh_frame infrastructure to the unwind_user
> interface. It enables the unwinder to use eh_frame data for user space
> stack traces.

>> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

>> @@ -173,6 +174,16 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
>>  	return unwind_user_next_common(state, &fp_frame);
>>  }
>>  
>> +static int unwind_user_next_eh_frame(struct unwind_user_state *state)
>> +{
>> +	struct unwind_user_frame frame;
>> +
>> +	/* eh_frame expects the frame to be local storage */
>> +	if (eh_frame_find(state->ip, &frame))
> 
> [Severity: Medium]
> Does this need to adjust state->ip for return addresses?
> 
> Since state->ip points to the instruction after the call, if a function
> call is the final instruction of a block or function, passing the
> unadjusted ip to eh_frame_find() might cause it to match the next
> function's FDE instead of the caller's.
> 
> Would it be better to pass an adjusted instruction pointer (like
> state->topmost ? state->ip : state->ip - 1) to ensure the correct unwind
> rules are retrieved during normal user space unwinding?

I have this on my list of improvements for unwind user for quite some
time, as I have observed this on s390 (see below for details), but
wanted to postpone as enhancement once .eh_frame or .sframe unwinding
have landed.

Should unwind user only internally adust the IP used for the lookup
(as suggested by Sashiko above)?  Or should it adjust the RA returned
by unwind_user_next_common(), so that the adjusted value surfaces in
callchains?

perf does adjust the printed IPs for perf record --call-graph dwarf,
as one can easily tell from the following output on s390.  Instructions
must be 2-byte aligned on s390 and they are not except for the topmost:

objdump    2802   515.787731:     100010 software/task-clock/P:
             3ff846904b0 _dl_relocate_object_no_relro+0x580 (/usr/lib/ld64.so.1)
             3ff84691bab _dl_relocate_object+0x1b (/usr/lib/ld64.so.1)
             3ff8469d7d3 dl_main+0x1b83 (/usr/lib/ld64.so.1)
             3ff8469a14b _dl_sysdep_start+0x1db (/usr/lib/ld64.so.1)
             3ff8469b903 _dl_start+0x723 (/usr/lib/ld64.so.1)
             3ff8469a733 _start+0x13 (/usr/lib/ld64.so.1)

> 
>> +		return -ENOENT;
>> +	return unwind_user_next_common(state, &frame);
>> +}
>> +

On s390 I regularly observe the following case where above would prevent
the callchain to erroneously end in internal_addseverity+0x0:

objdump    1060    26.324199:     100010 task-clock:ppp:
             3ff9ec908b4 dfs_traversal.part.0+0x34 (/usr/lib/ld64.so.1)
             3ff9ec90900 dfs_traversal.part.0+0x80 (/usr/lib/ld64.so.1)
             3ff9ec90e68 _dl_sort_maps+0x4b8 (/usr/lib/ld64.so.1)
             3ff9ec84aa2 _dl_fini+0x252 (/usr/lib/ld64.so.1)
             3ff9e856b06 __run_exit_handlers+0x176 (/usr/lib64/libc.so.6)
             3ff9e856c00 internal_addseverity+0x0 (/usr/lib64/libc.so.6)  <!!!

unwind user needs to determine the next IP as RA - 1, as the return
address of a function with __attribute__((noreturn)), such as exit(),
might point at the following function:

$ objdump -d /usr/lib64/libc.so.6
...
000000000004dee0 <exit>:
   4dee0:       eb ef f0 70 00 24       stmg    %r14,%r15,112(%r15)
   4dee6:       a7 59 00 01             lghi    %r5,1
   4deea:       e3 f0 ff 60 ff 71       lay     %r15,-160(%r15)
   4def0:       a7 49 00 01             lghi    %r4,1
   4def4:       c0 30 00 0d 9b a2       larl    %r3,201638 <__exit_funcs>
   4defa:       c0 e5 ff ff fe 9b       brasl   %r14,4dc30 <__run_exit_handlers>

000000000004df00 <internal_addseverity>:
   4df00:       eb 9f f0 48 00 24       stmg    %r9,%r15,72(%r15)
   4df06:       c0 10 00 0d 9b 9d       larl    %r1,201640 <severity_list>
   4df0c:       e3 f0 ff 60 ff 71       lay     %r15,-160(%r15)
...

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

