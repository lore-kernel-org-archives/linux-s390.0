Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE417E459;
	Wed, 12 Jun 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206687; cv=none; b=Z9JNXhWi/wRTe4pkxKlZ+xCfhn9DSu0XPLP9yUYH6aHeeurxNnt7huP9d+3rFaivtK6CRS31UGKTg8oxZbVJeHqEBf2RPJFZgJT9p17JAC/8T8KXUMypqKdmHzQKgaxnZp7GeGqarcBBTNrxVhsxL5rhWoFJjjoerzluAWHvx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206687; c=relaxed/simple;
	bh=BbRKLeBRXiAlrIOYGEopdh8kaUezPNfsznzzn4Gls7M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SUiCCTuabYYD0eJnI4iGNTNCvMdcvaA+m9VnniOlU4CZHPhmkoM7REV7aojkt5chO2Uncux0ZtRQsLc96r/I96sbMnCIXRH435mX52UKTQn3S6s3ybEIMg2+DI0UHDawhCX+33Rok6Sr7Ks+AX8BCJ/+OlYtuxkmuZjS4/bGvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=daXsUq4X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="daXsUq4X"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CFTKxU001593;
	Wed, 12 Jun 2024 15:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	sUlVOpLsB7ZgvZM2Yku0ftpL1kxmfJTOLslTgiO7Wc0=; b=daXsUq4XnojjxyDh
	rPr9puRhWpsPHbxnHsDA45+Ak7X/gc6/eWJlq6VdxuuBhEH2cVk8eSh7J3u1QF2r
	2iz25E/yYhBBavM9hj7cdamlNfKbIpe5TRTbWTPTPtOZrlKfDz80FREgwAB1N/DF
	39EGVItTyh5uFdosCCg+oduzzdN/nIs3unsVyF9+nEFGpXi4KsxPH20qUqW/6H4J
	h0rKBW/mTZGiAldxPaAojr7RqIwxh800XCERGPKVz5VhZN8i0eFcZOXIH+jt0ZYr
	HflGxrUP/wP4pLCTgE2r490Ih3S0EoY2sqIJLRKzcJdjw/YPj5w8LUWPnl0fi+2N
	AoA2qg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqebx80pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:37:40 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45CFbdDb014086;
	Wed, 12 Jun 2024 15:37:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqebx80pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:37:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45CFLocC003881;
	Wed, 12 Jun 2024 15:37:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mpy4ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:37:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45CFbXI411403582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 15:37:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187342004E;
	Wed, 12 Jun 2024 15:37:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B02D720040;
	Wed, 12 Jun 2024 15:37:32 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Jun 2024 15:37:32 +0000 (GMT)
Message-ID: <6403223315eda4e8023a828d6f40353c694d474e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/34] ftrace: Unpoison ftrace_regs in
 ftrace_ops_list_func()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko
 <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph
 Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco
 Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka
 Enberg <penberg@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil
 Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle
 <svens@linux.ibm.com>
Date: Wed, 12 Jun 2024 17:37:32 +0200
In-Reply-To: <20240102101712.515e0fe3@gandalf.local.home>
References: <20231213233605.661251-1-iii@linux.ibm.com>
	 <20231213233605.661251-2-iii@linux.ibm.com>
	 <20240102101712.515e0fe3@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rmQltXYdpFw9fTbDS6VlEHPVsYz_YHE3
X-Proofpoint-GUID: Ivcj_IlvBtvvOQzLTRy84LG3MKhmjE9t
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120110

On Tue, 2024-01-02 at 10:17 -0500, Steven Rostedt wrote:
> On Thu, 14 Dec 2023 00:24:21 +0100
> Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>=20
> > Architectures use assembly code to initialize ftrace_regs and call
> > ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> > ftrace_regs is poisoned on ftrace_ops_list_func entry(). This
> > causes
> > KMSAN warnings when running the ftrace testsuite.
>=20
> BTW, why is this only a problem for s390 and no other architectures?
>=20
> If it is only a s390 thing, then we should do this instead:
>=20
> in include/linux/ftrace.h:
>=20
> /* Add a comment here to why this is needed */
> #ifndef ftrace_list_func_unpoison
> # define ftrace_list_func_unpoison(fregs) do { } while(0)
> #endif
>=20
> In arch/s390/include/asm/ftrace.h:
>=20
> /* Add a comment to why s390 is special */
> # define ftrace_list_func_unpoison(fregs)
> kmsan_unpoison_memory(fregs, sizeof(*fregs))
>=20
> >=20
> > Fix by trusting the architecture-specific assembly code and always
> > unpoisoning ftrace_regs in ftrace_ops_list_func.
> >=20
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>=20
> I'm taking my ack away for this change in favor of what I'm
> suggesting now.
>=20
> > Reviewed-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0kernel/trace/ftrace.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 8de8bec5f366..dfb8b26966aa 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -7399,6 +7399,7 @@ __ftrace_ops_list_func(unsigned long ip,
> > unsigned long parent_ip,
> > =C2=A0void arch_ftrace_ops_list_func(unsigned long ip, unsigned long
> > parent_ip,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ftrace_ops *op, st=
ruct
> > ftrace_regs *fregs)
> > =C2=A0{
> > +	kmsan_unpoison_memory(fregs, sizeof(*fregs));
>=20
> And here have:
>=20
> 	ftrace_list_func_unpoison(fregs);
>=20
> That way we only do it for archs that really need it, and do not
> affect
> archs that do not.
>=20
>=20
> I want to know why this only affects s390, because if we are just
> doing
> this because "it works", it could be just covering up a symptom of
> something else and not actually doing the "right thing".
>=20
>=20
> -- Steve
>=20
>=20
> > =C2=A0	__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
> > =C2=A0}
> > =C2=A0#else
>=20

Ok, it has been a while, but I believe I have a good answer now. KMSAN
shadow for memory above $rsp is essentially random. Here is an example
(you'll need a GDB hack from [1] if you want to try this at home):

(gdb) x/5i do_nanosleep
   0xffffffff843607c0 <do_nanosleep>:   call   0xffffffffc0201000
Thread 3 hit Breakpoint 1, 0xffffffffc0201000 in ?? ()
(gdb) x/64bx kmsan_get_metadata($rsp - 64, 0)
0xffffd1000087bd38:     0x00    0x00    0x00    0x00    0x00    0x00 =20
0x00    0x00
0xffffd1000087bd40:     0x00    0x00    0x00    0x00    0x00    0x00 =20
0x00    0x00
0xffffd1000087bd48:     0x00    0x00    0x00    0x00    0x00    0x00 =20
0x00    0x00
0xffffd1000087bd50:     0x00    0x00    0x00    0x00    0xff    0xff =20
0xff    0xff
0xffffd1000087bd58:     0x00    0x00    0x00    0x00    0x00    0x00 =20
0x00    0x00
0xffffd1000087bd60:     0xff    0xff    0xff    0xff    0xff    0xff =20
0xff    0xff
0xffffd1000087bd68:     0xff    0xff    0xff    0xff    0xff    0xff =20
0xff    0xff
0xffffd1000087bd70:     0xff    0xff    0xff    0xff    0xff    0xff =20
0xff    0xff

So if assembly (in this case ftrace_regs_caller) allocates struct
pt_regs on stack, it may or may not be poisoned depending on what was
called before. So, by accident, on s390x it's poisoned and trips KMSAN,
and on x86_64 it's not. Based on this observation, I'd say we need
an unpoison call in all ftrace handlers (e.g., kprobe_ftrace_handler),
and not just this one.

But why is this the case? Kernel stacks are created by
alloc_thread_stack_node() using __vmalloc_node_range(__GFP_ZERO), so
they are fully unpoisoned. Then functions are called and return, their
locals are poisoned and unpoisoned. Interestingly enough, on return,
they are not poisoned back, even though

commit 37ad4ee8364255c73026a3c343403b5977fa7e79
Author: Alexander Potapenko <glider@google.com>
Date:   Thu Sep 15 17:04:13 2022 +0200

    x86: kmsan: don't instrument stack walking functions

says they do. So what if we introduce that [2]?

# echo "p:nanosleep do_nanosleep %di"
>/sys/kernel/tracing/kprobe_events
# echo 1 >/sys/kernel/debug/tracing/events/kprobes/nanosleep/enable
# sleep 1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
BUG: KMSAN: uninit-value in kprobe_ftrace_handler+0x5b9/0x790
 kprobe_ftrace_handler+0x5b9/0x790
 0xffffffffc02010de
 do_nanosleep+0x5/0x670
 hrtimer_nanosleep+0x169/0x3b0
 common_nsleep+0xc7/0x100
 __x64_sys_clock_nanosleep+0x4e2/0x650
 do_syscall_64+0x6e/0x120
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Local variable nd created at:
 do_filp_open+0x3b2/0x5e0

Quite similar to s390. Local variable nd is a random leftover from a
different call stack, which the modified instrumentation poisoned on
return from do_filp_open().

Alexander, what do you think about adding [2] upstream as an option
that can be enabled from the command line? Also, what do you think
about poisoning kernel stacks? Formally they are zeroed out, but I
think valid code has no business reading these zeroes.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=3D31878
[2]
https://github.com/iii-i/llvm-project/commits/msan-poison-allocas-before-re=
turning-2024-06-12/

