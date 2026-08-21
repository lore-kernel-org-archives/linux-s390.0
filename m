Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9229CE9;
	Fri, 21 Aug 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341928; cv=none; b=XsbWo0nZ/RgwCZKY9LBmqyM+qS7DxkuMtL9lSEdoV5uCDmZ1kys+0neEvs5GGKKHc8WbZLtGct90zEFyANtazRDvCxmTjDaw6+WTcjZskRVsMtrYHFy/3NI6vVbQBqSbEpX7sQUheBo7pZBWXzrkxAdypLMC8AzpcA5GTRBgdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341928; c=relaxed/simple;
	bh=raM7edroxA4BTCvcNmyqen1I4l9zNC25hgRTTYSyLUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICxiXbfvtsBECLr5cEQwesB8LUU+Eda0K6Y3ADSFMR8uNCJnyhRbNuKrBtjxZi5lf95WxnDWSuswjCFwlxBgEgXPmI/9q39HxZfb2VLD5Fp66nVBPPdfy8joqSIRq/2w2ipusV04K0MggKBIseWFIYlhsfWP2wnqP5pIOK5nZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p9qb2VB8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p9qb2VB8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVt552315324;
	Fri, 21 Aug 2026 19:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oLekv4
	kGz94dzwTHWVX5EP2JJ3+XqCBUQM8dXklBW4M=; b=p9qb2VB8EMBmpfOsBq3d1+
	SLtLTlDtAwi/FdDkuhHHUQKFUscXXX0qNGCdQQvOleCRzRK04LNPWaF8I8aHeEJS
	vmWngk26XR23/Rh9DgRjtday2phOC930giFGtdTwgJ+7HNW3rnKiYJX2mQG6kBH8
	ruMhXi+isJ9MxboeA9SG2Zgpi0IgGiqGZvUN2AeVuG+i5t1EWa/IrGwKsTwNgRWq
	5hV4oayzeYVwKL1gfb7JOrp1HuZmxVxhGzV2Uc7owWacfOKqGyhHIpr8igdZt00W
	kmmTnTxJi8R3SVdGWNa61DwX1hzA7zuhqwrfRy6RIvU8Zm5jeJitQ3/HxmeLvanw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1ut5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:51:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfKXW023504;
	Fri, 21 Aug 2026 19:51:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twpr21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:51:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJpW8v52101388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:51:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1509A20043;
	Fri, 21 Aug 2026 19:51:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4485A20040;
	Fri, 21 Aug 2026 19:51:30 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:51:30 +0000 (GMT)
Message-ID: <61ff69a3-63fd-4f16-9546-793d21160a90@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:51:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/25] unwind_user: Implement .eh_frame handling
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818132113.737ae646@robin>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818132113.737ae646@robin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a88ac4a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=mWN4hPR01vCUSsCsGC4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zPTohlV01kibFUXh60AMuety6aFPKTXJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXympanK3kngLb
 ehsXQ6eNvcDaBDeBNfxJowMlZdAExi9yCJJxDmLmyfHBb4qORoAHZbxNw08O8laRurEDjdLkols
 CLcHoPOlcbtxCZ9jLReH+dhar+OF8xI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX7ejXnbjKsNxN
 pDKurvkdzeNROG+RsmW97GkWOB1m89KzCaD4cZso22/3tfaPA3TnX2Tono/J4ZBDoRgLr5TDE1T
 BgkaRa9y/WCuKM58G8xLLB3Zcnb6FRzD9T4HMcmCXts5pRyEGvelAVEimpLT2RCY5WuFm/9LjLX
 2CzBCtxButh59uCCJ5A/OSfeCn8ObmMdYqngfWobv08b0kFHWYiqhVm5xfZ3tSZBC615hOqqOf4
 ADEYY21V++edsErRCN2XTT1aUZt8PbrZjd5S2zLNHzi0dwoJvP6xvZYjzTpziSLQx2YiMRSd55k
 VlOiuf+cyfsi0YVWA7wwE0f6Tay/jy8kMH1tzmL/zdCU5ajC8I4OAG0LZyB+cML5j9kK24iRImd
 bB46JIxd9f3rrnnFhyae9efQS9fRCelUwacn3/k7pc7hQp0XaRILGySj9lf8NXE4BmAmEcVp9pJ
 ARzxwxKbTI1Mu/46ZdQ==
X-Proofpoint-ORIG-GUID: aFQEHKneQAlXEJ__7IjoIA07Bm_IK_E1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

Hello Steven!

On 8/18/2026 7:21 PM, Steven Rostedt wrote:
> On Tue, 18 Aug 2026 16:49:29 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:
> 
>> This series adds support for parsing DWARF Call Frame Information (CFI)
>> from the .eh_frame_hdr and .eh_frame sections of user space ELF files.
> 
> Very nice! I don't have time this week to look at it, but I just
> applied the series and tried it out with:

Thanks!

> 
>   perf record --call-graph fp,defer trace-cmd report ~/trace.dat
> 
> And did a: perf -D script
> 
> And found this:
> 
> 264990534603 0x19370 [0x78]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 1165/1165: 0x105700000005
> ... FP chain: nr:10
> .....  0: 00007f5feafd362a
> .....  1: 00007f5feb249781
> .....  2: 00007f5feb2498de
> .....  3: 000055935526fbdc
> .....  4: 00005593552649e6
> .....  5: 000055935523c2d0
> .....  6: 000055935523d24c
> .....  7: 0000559355227bfe
> .....  8: 00007f5feaef9f75
> .....  9: 00007ffdaf879d38
>  ... thread: trace-cmd:1165
>  ...... dso: /proc/kcore
> trace-cmd    1165   264.990473:     395990 cpu/cycles/P: 
>         ffffffff8477d8d3 check_preemption_disabled+0x13 ([kernel.kallsyms])
>         ffffffff819aa495 rcu_is_watching+0x15 ([kernel.kallsyms])
>         ffffffff816dbcff unwind_next_frame+0x45f ([kernel.kallsyms])
>         ffffffff81642e91 arch_stack_walk+0xa1 ([kernel.kallsyms])
>         ffffffff81a2e633 stack_trace_save+0x93 ([kernel.kallsyms])
>         ffffffff82251210 kasan_save_stack+0x30 ([kernel.kallsyms])
>         ffffffff822541b0 kasan_record_aux_stack+0xb0 ([kernel.kallsyms])
>         ffffffff819c1e2a __call_rcu_common+0xca ([kernel.kallsyms])
>         ffffffff821be05f kmem_cache_free+0x2ef ([kernel.kallsyms])
>         ffffffff8233e4a7 vfs_fstatat+0x57 ([kernel.kallsyms])
>         ffffffff8233e573 __do_sys_newfstatat+0x83 ([kernel.kallsyms])
>         ffffffff84772a8e do_syscall_64+0x7e ([kernel.kallsyms])
>         ffffffff8100012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
>             7f5feafd362a __GI___fstatat64+0xa (/usr/lib/x86_64-linux-gnu/libc.so.6)
>             7f5feb249781 tep_load_plugins_hook+0xd1 (/usr/local/lib64/libtraceevent.so.1.9.0)
>             7f5feb2498de tep_load_plugins+0x35 (/usr/local/lib64/libtraceevent.so.1.9.0)
>             55935526fbdc tcmd_load_plugins+0x85 (/usr/local/bin/trace-cmd)
>             5593552649e6 tracecmd_alloc_fd+0x2da (/usr/local/bin/trace-cmd)
>             55935523c2d0 read_trace_header+0x62 (/usr/local/bin/trace-cmd)
>             55935523d24c trace_report+0x869 (/usr/local/bin/trace-cmd)
>             559355227bfe main+0x90 (/usr/local/bin/trace-cmd)
>             7f5feaef9f75 __libc_start_call_main+0x75 (/usr/lib/x86_64-linux-gnu/libc.so.6)
>             7ffdaf879d38 [unknown] ([unknown])
> 
> I injected trace_printk() into the code to make sure it was using the
> eh_frame unwinding:
> 
> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 85fc82252af1..585f022bcabe 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -200,6 +200,7 @@ static int unwind_user_next(struct unwind_user_state *state)
>  		case UNWIND_USER_TYPE_EH_FRAME:
>  			switch (unwind_user_next_eh_frame(state)) {
>  			case 0:
> +				trace_printk("USE EH_FRAME\n");
>  				return 0;
>  			case -ENOENT:
>  				continue;	/* Try next method. */
> @@ -208,8 +209,9 @@ static int unwind_user_next(struct unwind_user_state *state)
>  			}
>  			break;
>  		case UNWIND_USER_TYPE_FP:
> -			if (!unwind_user_next_fp(state))
> -				return 0;
> +			if (!unwind_user_next_fp(state)) {
> +				trace_printk("USE FRAME POINTER\n");
> +				return 0; }
>  			continue;
>  		default:
>  			WARN_ONCE(1, "Undefined unwind bit %d", bit);
> 
> And have this:
> 
> # trace-cmd show
> [..]
>        trace-cmd-1136    [001] .....   239.482498: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.482501: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.482504: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.482507: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.482821: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.482825: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.482828: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.482831: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.482834: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483004: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483007: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483010: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483013: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483016: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483230: unwind_user: USE FRAME POINTER
>        trace-cmd-1136    [001] .....   239.483234: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483238: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483240: unwind_user: USE EH_FRAME
>        trace-cmd-1136    [001] .....   239.483243: unwind_user: USE EH_FRAME
> [..]

Thanks for giving it a spin!

> Note, the compile had one warning (with all patches applied):
> 
>   vmlinux.o: warning: objtool: eh_frame_find+0x270c: call to eh_frame_do_expression.isra.0() with UACCESS enabled

I need to resolve those objtool warnings after my vacation.  Any idea
how to get around the arch eh_frame_do_expression() callback issue?
Is there a mean to temporarily give up the UACCESS if it is within a
scoped guard region?

> I'll try to get time when I get back from my travels next week to look
> at each of the patches.
> 
> I also do not think this makes sframe obsolete. I believe there's holes
> with eh_frame and some may not like the complexity of it. But this
> gives us an honest look at what options are available to us.
> 
> Thanks for doing this!

It was fun and I learned quite a bit about .eh_frame, .eh_frame_hdr,
and GNU_EH_FRAME doing so.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

