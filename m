Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219A3A7193;
	Mon,  1 Jun 2026 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320479; cv=none; b=AofsShUlAErzuUJWYP9ltTwDrrMD5CRmcXrQUS5mGdhNyhtC6qd8oANAxPLnqoleTs+Z6B2cwI68Gsgt4sL5ooOhvd+RhzKMfQPE4pe6K13FZ13Q1ppfb1ABwBPCQVKzmpp7kW/2lA1mH+TPdeTmWwt4CpmLk8NAp46GfytOf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320479; c=relaxed/simple;
	bh=l0wxMOmtEnbn4zjzJJOP6/yTO2xDucd57f0h6PoI0EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig1+3cxoAr0dzsFjDUx1w07+SrxKqEjWIxRvWdSNDxt2nfwKrkT1WbYcx7pg3sDD5/MAb9v3SLHxgdJ1U3dvwvPFY0Gst63L0AqmzANymL1ojQ5DW29Ndu2RFnT9AJiMsV/4SW7iABYYvjGRnoqDmZV0Q/CDBasoCHgKqtRpj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o4qp11Y7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o4qp11Y7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6514PBbD1648854;
	Mon, 1 Jun 2026 13:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SARPWTEuRfjw3T5vNjMILtSlDyV771
	4zY8PJaO7Vqf4=; b=o4qp11Y7IlrYQ5DpkGB2UWEv8FJnZ7Or76I9or4VWqEokh
	bXesNM82xwUjZ36NUKYZ8CN9fKjDDkzJTK6ipkk7QmxOYV6/KcFXS3Dy5cyfi3wQ
	/6TVm/+bdP/liSbWMA164xpMYkdVPxW7Uek3JmZ05OsMINQ0rqS2UhbBxm+RqBJQ
	qut9qGFLHHP/QRJ9DA4w3M0xHQas1HZ30cqg0NXGMIzKPJNbO7F92H6T4JoN8CBe
	2Tnk0UWzPjWLROrXKAdc5+8jXPO5mpn7v687K1w+D5eGHA4exyTlK1sNEtQN4D/y
	yw/wWnOvuPB2vPZYz60Bv0o7cYmUd2pJvqQzuP4w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd40x3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:27:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651DQXeH027601;
	Mon, 1 Jun 2026 13:27:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh66q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:27:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651DRqo435127756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 13:27:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C3CF2004B;
	Mon,  1 Jun 2026 13:27:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E568F2004E;
	Mon,  1 Jun 2026 13:27:51 +0000 (GMT)
Received: from osiris (unknown [9.111.34.21])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 13:27:51 +0000 (GMT)
Date: Mon, 1 Jun 2026 15:27:50 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/7] s390/percpu: Infrastructure for more efficient
 this_cpu operations
Message-ID: <20260601132750.9109A3b-hca@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-2-hca@linux.ibm.com>
 <403de21c-957e-41ca-8c03-0bd110c49ec3-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403de21c-957e-41ca-8c03-0bd110c49ec3-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzMSBTYWx0ZWRfX65PRbUmNOLHT
 maaLiwpXlw3wp5RX6izIRkPAfhYZr2dkPfnC9BB9lg4Ga3D6+5qv+6y/vvQcSnzA2TORpd40Yfa
 EJSgLO8yaZrJf0UZ49arTw4iE720QngGlgGt1h71108fjU1lFJwjIvZM7h0HWtWdUKt8uqKM4Ic
 tORHjyKD0GGwlHScnYMSqTnHXVTW3nhBairEzVJkSaIJBFI+Cr+2Q9jsYGF1fu2v3EIvEmHE2Zq
 /ulWFB8n5t2rp3b/dVxi2pX6/o9Q/M3Mn7P7Nl3tQSP1d1HQe3EUIwzqxxmTfrxYfcnDRmVEbdW
 tXLsac2C7Ir5sKF7Rulwl/Cuha5hMyVpFJOgK0uyO2rBgiXj6YnvfsEzTXR4EoMaGYLQOktangw
 h3POTvNvHm2Q53+8Q1PLhanqJ2xPV5Jicep+l315cd723kzhqOV7Cf2DDNNum7u7BaKq4kF6cY/
 iYGy7LnMZBhlUn5k26g==
X-Proofpoint-GUID: kR8l7OquSIthIScLUwsEzYxLFuPvZiv4
X-Proofpoint-ORIG-GUID: kR8l7OquSIthIScLUwsEzYxLFuPvZiv4
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1d88dd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=9Ba2Qp-rqZAVEFSaFE0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010131

On Mon, Jun 01, 2026 at 09:10:47AM +0200, Alexander Gordeev wrote:
> On Tue, May 26, 2026 at 07:56:56AM +0200, Heiko Carstens wrote:
> > Get rid of the conditional branch with the following code sequence:
> > 
> >   11a8e6:       c0 30 00 d0 c5 0d       larl    %r3,1b33300
> 
> Annotating with similar comments as above would help:
> 
> 	... <- address of percpu var
> 	... <- add percpu offset
> 
> >   11a8ec:       b9 04 00 43             lgr     %r4,%r3
> >   11a8f0:       eb 00 43 c0 00 52       mviy    960,4
> >   11a8f6:       e3 40 03 b8 00 08       ag      %r4,952
> >   11a8fc:       eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
> >   11a902:       eb 00 03 c0 00 52       mviy    960,0
> >   11a908:       b9 08 00 25             agr     %r2,%r5
> >   11a90c        07 fe                   br      %r14

Sure.

> > +static __always_inline void percpu_entry(struct pt_regs *regs)
> > +{
> > +	struct lowcore *lc = get_lowcore();
> > +
> > +	if (user_mode(regs))
> > +		return;
> > +	regs->cpu = lc->cpu_nr;
> > +	regs->percpu_register = lc->percpu_register;
> > +	lc->percpu_register = 0;
> 
> This assignment is required when the task is migrated to a new CPU, so
> the lowcore would not be corrupted with the stale percpu_register value.
> Otherwise, it is restored in percpu_exit() if there was no migration.
> Right?

This, but it is also required to have a "clean" starting point for the
new context (exception, irq, nmi), since the new context does not run
in a percpu code section - if that context would be interrupted then
the next context might see that the previous context was running in a
percpu code section, while it was not. Therefore lc->percpu_register
must be saved and set to 0 before the new context may use percpu ops
and/or fault.

> > +	if ((insn & 0xff0f) != 0xe300)
> 
> Any reason mask/not to check the register number as well?

Just to save code. If there would be a mismatch with the percpu
register, something serious would be wrong..
But that cannot happen(tm) :)

> > +	/* Check if process has been migrated to a different CPU. */
> > +	if (regs->cpu == lc->cpu_nr)
> > +		return;
> > +	/* Fixup percpu base register */
> > +	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
> > +	regs->gprs[reg] += lc->percpu_offset;
> 
> Such one reads bit better:
> 
> 	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
> 	regs->gprs[reg] += __per_cpu_offset[reg];

That reads better, but it is wrong. 'reg' is not the index of the
current cpu into __per_cpu_offset[].

It could be changed to

	regs->gprs[reg] += __per_cpu_offset[lc->cpu_nr];

but then again that's exactly lc->percpu_offset. I don't see a reason
to create worse code here.

> > + * Inline assemblies making use of this typically have a code sequence like:
> > + *
> > + *   MVIY_PERCPU(...) <- start of percpu code section
> > + *   AG_ALT(...)      <- add percpu offset; must be the second instruction
> > + *   atomic_op	      <- atomic op
>                  \t here, but should be spaces?

I can't follow? We have tabs in comments all over the place in s390 code.

> Probably it worth noting that no extra instructions between atomic_op
> and MVIY_ALT may exist (e.g. in the future), especially ones that use
> the percpu_register.

That's not true. There may be additional instructions, they may just
not use the same register that is used for the percpu variable.

But that was true before this patch as well, even though it might not
have been "obvious".

> >  	unsigned long flags;
> >  	unsigned long last_break;
> > +	unsigned int cpu;
> > +	unsigned char percpu_register;
> 
> May be name it as this_cpu and this_cpu_reg(ister)?

Here I disagree. *If* a task would be migrated then such naming would
be very confusing: regs->this_cpu would contain the cpu number of the
_previous_ cpu where the task was running on, but not the number of
the current cpu.
So you would end up with checks like:

	if (regs->this_cpu != this_cpu)

to figure out if a task was migrated. This doesn't look right to me.
