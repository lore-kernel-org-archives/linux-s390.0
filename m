Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B783A1CF3;
	Thu, 21 May 2026 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359879; cv=none; b=LVydI6alrOd9jLOPScPIOBy2ZIUSDQQvHBsjXCMdKYgq6DgqY0bs8XwD9s8oDY/icPHSJdD7/uPhXKl7fSGNVEq5dVBK9aLQ2Hux/fqvcU7H5u9omPEDRhO75OxObcgKMNLnYzPWGNIVfTA3Q7DPTzXPsm/yWROqBCH7D1qT8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359879; c=relaxed/simple;
	bh=cT1NHvCijnSFVhPIJzure9Juz+hu4OcI+FtQ7278PTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVioq3t4pOerfWmaAtL77taMMV7PsZJ9tGloJFtwE6W2rtneb9R9saM4vK/QXEDE0lqrtU0kn7MVaDaInlXxhlqqWiyR62MPk4zQn6c2jm2KiK1/fCvU6GvP0I0fVbCXVl8uiT/GF+gOKxf2LjiR0gaTbWZAiKPXTatr8LWLZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nLmRKQyG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nLmRKQyG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L3U9lT823931;
	Thu, 21 May 2026 10:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lWQvaj
	w5esho2QNRuupjIbIJAr9FP1JTUXGf4GkEI48=; b=nLmRKQyGHFnFFN8flN//AB
	ScTqqPoJ9WqkFiZbATqRixGSkaSVCmKJVE3kikhCrWyv0MfYjeVvWylKznth4HlH
	jh77aW6YtVR3YJQ7uHGg9Ls6gSlxGYh0gG3/nEfHmAk+EXTIMfTLUvcWbVOvgLTm
	PpzQy7z9ytTNJk1fB5OVnXg2HW0TkLNsiMpHMYPa3ct3RErgdS+cjtrCb0bE9koF
	5S0RDBtTi2AW7YYzyuZ9kQIq8zVuahGOPSqwotgKnLEB8SavUT7DvreDda7dI1uG
	PxzLZFi2LBeoOohXvjpm1qm0ZxEyF5H3TrV6KvasE6yhqAufNcZzenG4I3HwPFyw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88n6kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:37:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LAO5qJ009458;
	Thu, 21 May 2026 10:37:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkbmsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:37:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LAbjBZ31261180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 10:37:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10B3220043;
	Thu, 21 May 2026 10:37:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D897420040;
	Thu, 21 May 2026 10:37:44 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 May 2026 10:37:44 +0000 (GMT)
Date: Thu, 21 May 2026 12:37:42 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: David Laight <david.laight.linux@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260521103742.9603C8c-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
 <9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
 <20260520233409.0683f595@pumpkin>
 <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lvv7t4zGJC3MjsV0ROrQFq4HEnllbgJy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwNSBTYWx0ZWRfX1t1bCVSo6OHE
 tQufhv+7Kx+T5Q3qU5KGHjKW4xOBU68URrjZt0lX7WR2hk5TRQA1ZP9ZRJMMqUUSQVDek8kXdoU
 Jod+UGtC7p+xIqtn5aowK1d0N7oespHWKPaju6VsxZMtGJFKD3iVqvGoCP27g2GzbXqbpZ+nR3K
 9NaHmd1c3qsWknR+0Xd21xhcWpKQ5Qzzy9j1NZlnzYrDqXTwi7FtS5K2LnFUN0qWdXMN3x8ncyC
 Xpcsw3U552JSrJIiyJsnSKUrhX2jUE+XFGf7I2F5XdMcPV1SNtcriV1Ei5UKUfyI+PAUeuh9WTM
 dEgCTKS5dk3ixMy2EE8s/WSSAiUOBZp6hK0oGneQjK/3fEXfpPPxg4js/ARWiHmj9RvpFp2/U44
 tSDkaFAZjcW9TTx2dHk+1vZ8925kXReFkiPLPvoka/JdiYBg2Txr6csxbGjaOUS9JLCn/U8mlDB
 pdaD0yOV7l5LCWF0X4g==
X-Proofpoint-GUID: Bqpt3Z9NfyzYGCoGE0Ee1ZrZI9wuTQ2u
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0ee07d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=fj3Xm2Irtfqz1L6NPSIA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210105

On Wed, May 20, 2026 at 05:23:37PM -0700, Yang Shi wrote:
> > > If I understand correctly, you replaced preempt_disable() and
> > > preempt_enable() with seq begin and seg end, and seq begin and seq end
> > > can be optimized by mvyi instruction on S390. So you just need a single
> > > mvyi instruction for each instead of read-modify-write the seq count.
> > > 
> > > But you need some extra overhead for context switch (save and restore
> > > the seq count register) and need to check whether it is still on the
> > > same cpu once resuming execution. And there is also penalty if it is
> > > migrated to another CPU (need to rerun this_cpu ops).
> > Not as I understand it.
> > What happens is the context switch code 'corrupts' the register being
> > used to access per-cpu data so that it is correct for the new cpu.
> > The write of zero after the sequence is there to stop the register
> > being corrupted outside of this code window.
> 
> Thanks for elaborating it. I misunderstood some nuance. I read the patch #2
> commit message, now I think I understand how it works.

As background: s390 has so called prefix pages; the first two pages of every
CPU are percpu, via a special prefixing mechanism. Parts of the pages can be
used by operating systems as percpu data area, which we use to have fast
access to e.g. the 'current' pointer, the pid, percpu_offset of the current
cpu, etc.

Helpful is also that for instructions which access memory with a base register
zero, its contents are assumed to be zero for address generation by the
hardware, regardless of its real contents. That is, the above

        ag %r4,952

is the short version of

        ag %r4,952(%r0)

The eight bytes at offset 952 of the current CPU's prefix page are added to
register 4. Real contents of register 0 are irrelevant for such address
generations; reducing register pressure.

> Borrowed the disassemble from patch #2 commit message:
> 
>   11a8e6:       c0 30 00 d0 c5 0d       larl    %r3,1b33300
>   11a8ec:       b9 04 00 43             lgr     %r4,%r3
>   11a8f0:       eb 00 43 c0 00 52       mviy    960,4
>   11a8f6:       e3 40 03 b8 00 08       ag      %r4,952
>   11a8fc:       eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
>   11a902:       eb 00 03 c0 00 52       mviy    960,0
>   11a908:       b9 08 00 25             agr     %r2,%r5
>   11a90c        07 fe                   br      %r14
> 
> 11a8f0 loads the percpu offset and mark the percpu code section begin, I
> believe this is needed with percpu page table too because we need load local
> percpu offset.

No, 11a8f0 _writes_ the base register number, which contains the percpu
address used by the percpu atomic op at 11a8fc, to offset 960 of the first
prefix page. It could also be written like

	mviy 960(%r0),4

maybe that makes it more obvious what happens. And yes, this marks the
beginning of a percpu code section. The percpu offset is added to register r4
at 11a8f6 with the ag instruction. This could also be written like

	ag %r4,952(%r0)

This reads the eight byte percpu_offset from offset 952 of the first prefix
page, and adds it to register r4.

> 11a920 loads 0 to the register to mark the percpu code section end, this is
> not needed with percpu page table.

I guess you meant 11a902. But yes, this marks the end of the percpu code
section. Just that this is not a register, but a memory location where is
written to.

> And you need to save the register at the irq/exception entry, then restore
> it at exit. But you also need to check whether migration happens or not, if
> it happens kernel needs to rewrite the register with correct percpu offset
> and needs to check whether the interrupted instruction is "ag".

Yes.

> If it is "ag" instruction (11a8f6) , kernel needs to recalculate the percpu
> address, right?

No, if it is within the percpu code section and it is _not_ the ag instruction,
the percpu base register needs to be adjusted (that's by the way a bug in
patch two, which has this logic inverted - my mistake).

> It sounds a little bit hacky to me TBH and incur some extra overhead for
> "migration detection" and fixup.

Sure, it is hacky, and the small overhead part is of course true.

Compared to the percpu page table proposal the two mviy instructions above
would go away, as well as the extra interrupt/exception overhead. Besides
that your proposal is way less hacky.

> > > So it seems have more overhead than the percpu page table approach IIUC.
> > > We don't need all the steps with percpu page table. And there is no
> > > penalty for migration.
> > This code looks like it relies on 'page zero' already being percpu.
> > So it probably isn't really that different.
> > Some values like the 'preemption disable count' and 'current' could be
> > (maybe are?) written into page zero to give fast access.
> 
> I don't quite get what you mean about 'page zero'.

Hopefully the above description with prefix pages explains it?
