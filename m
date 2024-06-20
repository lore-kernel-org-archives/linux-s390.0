Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF51AB531;
	Thu, 20 Jun 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882409; cv=none; b=LtZdZgYtxgXTI5cYpvw6VDRnL++cjyFFr4osRe9N++zCsHi1BwLjuO/b+VVNZOHD7b2WqZu4J4W/ogm4f+DWHu92I0wNre/x1bKnWbc6v09aUqCNSedFigIaM6xzdI0VBkeynIsLwmvLvD2+P1gHlq6+SJeAlg5m/i8WjRQG6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882409; c=relaxed/simple;
	bh=Qvc2VsIeV/KOshYOTSuDHzfWS7c7S6Xphxjq5XUCf8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oT6DjxACdy6A6ZEv4ZA6TmjSYoqZxGJal8ncYkro7vGF4SZC9+2KXdExlhlqPIVid3zqwAZg7ltSe+v0um5WAeYUXGNg3MTAj79F/xONS4um5VJQ7LmrBz7Jggrsw0DWLpaXhSNxPVnlhKpNuif9BXUPNP4kAeUnRkGnTXZwdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sco1L1Qu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sco1L1Qu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KALHcM006405;
	Thu, 20 Jun 2024 11:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	YZXiRJkZp+S7FTPMS+D2ZuQxPKOUSyTFYbKHne7ZT5o=; b=sco1L1Qul3NLmvY7
	3RniI9GgoDivy+1t0YiTaU5LzOQYP8MWZ15udgMNUlnsaeaKHTSdeQ9ptYS5n2E8
	E12n3lFzpEaA5qlMa1LnXjs5YqL/ioiYOS3UxPUapD4QrgVPsCC0Wgkat0p1NR3k
	mL3qDZVeW4N1WxsMt7+TUkGECIfoHkn2X+4O3t6R1546fRC4Y+wWHjf3nuahdBkj
	KRwDFWK/kBfcQuVXI52ZZ9ocdkr2j1wUmCgpbqfvakTrwRjO7Zbjj4bWNVlbu0vC
	AJiOYF2O+R05518H5atdjdAEf0vZu/ideRwacyZ2a3Xem4LueOoXDCYdEDaAhU5q
	zvmQyQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvhtw88ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 11:19:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45KBJek8028469;
	Thu, 20 Jun 2024 11:19:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvhtw88ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 11:19:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KB7Xek009425;
	Thu, 20 Jun 2024 11:19:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgn53a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 11:19:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45KBJXvd57016618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 11:19:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EA3F2004D;
	Thu, 20 Jun 2024 11:19:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDB2220040;
	Thu, 20 Jun 2024 11:19:32 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 11:19:32 +0000 (GMT)
Message-ID: <aaef3e0fe22ad9074de84717f36f316204ae088c.camel@linux.ibm.com>
Subject: Re: [PATCH v5 33/37] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David
 Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami
 Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil
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
Date: Thu, 20 Jun 2024 13:19:32 +0200
In-Reply-To: <CAG_fn=V8Tt28LE9FtoYkos=5XG4zP_tDP1mF1COfEhAMg2ULqQ@mail.gmail.com>
References: <20240619154530.163232-1-iii@linux.ibm.com>
	 <20240619154530.163232-34-iii@linux.ibm.com>
	 <CAG_fn=V8Tt28LE9FtoYkos=5XG4zP_tDP1mF1COfEhAMg2ULqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IrkS3GjvPqTFqcgU2dJPG6AOUTabmxFK
X-Proofpoint-GUID: QnnWeFxfRe5FVGujes4q0S_lbJThwNlL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=807 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406200074

On Thu, 2024-06-20 at 10:36 +0200, Alexander Potapenko wrote:
> On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > put_user() uses inline assembly with precise constraints, so Clang
> > is
> > in principle capable of instrumenting it automatically.
> > Unfortunately,
> > one of the constraints contains a dereferenced user pointer, and
> > Clang
> > does not currently distinguish user and kernel pointers. Therefore
> > KMSAN attempts to access shadow for user pointers, which is not a
> > right
> > thing to do.
>=20
> By the way, how does this problem manifest?
> I was expecting KMSAN to generate dummy shadow accesses in this case,
> and reading/writing 1-8 bytes from dummy shadow shouldn't be a
> problem.
>=20
> (On the other hand, not inlining the get_user/put_user functions is
> probably still faster than retrieving the dummy shadow, so I'm fine
> either way)

We have two problems here: not only clang can't distinguish user and
kernel pointers, the KMSAN runtime - which is supposed to clean that
up - can't do that either due to overlapping kernel and user address
spaces on s390. So the instrumentation ultimately tries to access the
real shadow.

I forgot what the consequences of that were exactly, so I reverted the
patch and now I get:

Unable to handle kernel pointer dereference in virtual kernel address
space
Failing address: 000003fed25fa000 TEID: 000003fed25fa403
Fault in home space mode while using kernel ASCE.
AS:0000000005a70007 R3:00000000824d8007 S:0000000000000020=20
Oops: 0010 ilc:2 [#1] SMP=20
Modules linked in:
CPU: 3 PID: 1 Comm: init Tainted: G    B            N 6.10.0-rc4-
g8aadb00f495e #11
Hardware name: IBM 3931 A01 704 (KVM/Linux)
Krnl PSW : 0704c00180000000 000003ffe288975a (memset+0x3a/0xa0)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000000 000003fed25fa180 000003fed25fa180
000003ffe28897a6
           0000000000000007 000003ffe0000000 0000000000000000
000002ee06e68190
           000002ee06f19000 000003fed25fa180 000003ffd25fa180
000003ffd25fa180
           0000000000000008 0000000000000000 000003ffe17262e0
0000037ee000f730
Krnl Code: 000003ffe288974c: 41101100           la      %r1,256(%r1)
           000003ffe2889750: a737fffb           brctg =20
%r3,000003ffe2889746
          #000003ffe2889754: c03000000029       larl  =20
%r3,000003ffe28897a6
          >000003ffe288975a: 44403000           ex      %r4,0(%r3)
           000003ffe288975e: 07fe               bcr     15,%r14
           000003ffe2889760: a74f0001           cghi    %r4,1
           000003ffe2889764: b9040012           lgr     %r1,%r2
           000003ffe2889768: a784001c           brc   =20
8,000003ffe28897a0
Call Trace:
 [<000003ffe288975a>] memset+0x3a/0xa0=20
([<000003ffe17262bc>] kmsan_internal_set_shadow_origin+0x21c/0x3a0)
 [<000003ffe1725fb6>] kmsan_internal_unpoison_memory+0x26/0x30=20
 [<000003ffe1c1c646>] create_elf_tables+0x13c6/0x2620=20
 [<000003ffe1c0ebaa>] load_elf_binary+0x50da/0x68f0 =20
 [<000003ffe18c41fc>] bprm_execve+0x201c/0x2f40=20
 [<000003ffe18bff9a>] kernel_execve+0x2cda/0x2d00=20
 [<000003ffe49b745a>] kernel_init+0x9ba/0x1630=20
 [<000003ffe000cd5c>] __ret_from_fork+0xbc/0x180=20
 [<000003ffe4a1907a>] ret_from_fork+0xa/0x30=20
Last Breaking-Event-Address:
 [<000003ffe2889742>] memset+0x22/0xa0
Kernel panic - not syncing: Fatal exception: panic_on_oops

So is_bad_asm_addr() returned false for a userspace address.
Why? Because it happened to collide with the kernel modules area:
precisely the effect of overlapping.

VMALLOC_START: 0x37ee0000000
VMALLOC_END:   0x3a960000000
MODULES_VADDR: 0x3ff60000000
Address:       0x3ffd157a580
MODULES_END:   0x3ffe0000000

Now the question is, why do we crash when accessing shadow for modules?
I'll need to investigate, this does not look normal. But even if that
worked, we clearly wouldn't want userspace accesses to pollute module
shadow, so I think we need this patch in its current form.

[...]
