Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312883612ED;
	Mon,  1 Jun 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325383; cv=none; b=XVG3zkqZl39Nqih+ygev0O2V7+wRZL73SFfp3827twqYjtHGD/0g2BPH86xcKmFPy8rOc5Z6DRmfQLWXzOGJyw5JiqyDxbsUe1aYseHGNGiaO6fWs/5XVl9SCUefhlaOousn/29wVCzC/WOfhzfP1hG/bVXp1rxwA+F8H+VagAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325383; c=relaxed/simple;
	bh=FeMsvJJzeYhRoJDPNFBePywBUT8uBtym6g7sO8ZzRB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9+CuP15gXbmGxG3g6SmBmFAkrIwerax/CLsalPjQ39/YJ7Tediom8V6ZKzczSKrx9FQaGoWwrf5H1yJCblp8ClNxgGvYtGxFoD21GquiNu3l+2Xxe/S9uZAAPx/dsUUKXS9cll/UQwL9AP7+Ct/oQ4nIhGPbL6yEfCTmqnA4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PU/Sizai; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PU/Sizai"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65145xIp1445229;
	Mon, 1 Jun 2026 14:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pyFDV7roijXlHD7NSjVY6M1PBVgB8M
	JlxhyQwTqfGCI=; b=PU/SizaiTETn8LQ5G6X//0cYiFdXq0ug0Bd0kZVa6k0oeD
	FkXcKft2Y/L6I86ZBecN3mIwRITGjG72NLPjzoU3aIXaa4IGqKAbxk5fbbORN93G
	4VMqBzxhJACogjlanneMFWLMUUd6q37qY/AF54jkVtcqLkb/A4+H43Qq9HwKSCQG
	gB/mznVJSj9zcavS6hhHdrm7rP5fk6fvP+Q2PtCPxtwUOkH1BwukRUWziFK2Zfgu
	8+s2GJ0yrsfQiy3par2CcY4casNdYJ7jVGLJmJgBdU4DBzOhSJ4b3XbDzecxOtFx
	T7n+KdwPEOl7bkjMpti6XFxpcokqVJsmC2fivtBg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht0vxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 14:49:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651EdEXd007606;
	Mon, 1 Jun 2026 14:49:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q6tcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 14:49:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651Ena9247382922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 14:49:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 696E12004D;
	Mon,  1 Jun 2026 14:49:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4656E2004B;
	Mon,  1 Jun 2026 14:49:36 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 14:49:36 +0000 (GMT)
Date: Mon, 1 Jun 2026 16:49:35 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/7] s390/percpu: Infrastructure for more efficient
 this_cpu operations
Message-ID: <491a0085-9ba1-431b-9752-c1ac3fd602be-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-2-hca@linux.ibm.com>
 <403de21c-957e-41ca-8c03-0bd110c49ec3-agordeev@linux.ibm.com>
 <20260601132750.9109A3b-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601132750.9109A3b-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PmSc9tl0DqjvaalreETxnmYLqoZP8D0B
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1d9c04 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=9dMDt39-WkXxi3cQ8MYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE0NiBTYWx0ZWRfX+aIOIcFA3i1V
 5PdWBdlAEmYukgGO7mkyQktObiJdDYVpP52d69rjluJJNlreN0wy0kwUJcvFE1FOB1kOm55a4QA
 fEKePJ+a94XSEjEDDr/4AfDwan3/Gpb6OOhdWRlLNJk74UQWMKpC8GLoo76Q5OJwxVaMCpmhZCP
 B0R4L/tG9Y6hJ65SZtMiko1vLUDq0XaHABInz19L0GZsfrIzaBuN952dx9yFxOOizIHxsJpDnyW
 olgb3KLkKgm+ZKpQJ5UQRI8X/7pw7vl3NlcaNoWcJDcmIAZ6qpPovwPxtNGUcVGS0Jui5WobYB6
 GLOrD3X+MmDJo5V4hYntknFjciw6QHzlffxZVPQyoElSiP46O3b2ovQEHu0aJC5VDse1U+DYzZm
 Ub7QND46GuLFJC5ZdDw2I3hwZjo2ZY1sIIdgDov6i29o75jjmMpSGf1Nw4sE9Pt15rOHmRRKnPJ
 NQVMKROtdb60PC9tAqA==
X-Proofpoint-ORIG-GUID: PmSc9tl0DqjvaalreETxnmYLqoZP8D0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010146

On Mon, Jun 01, 2026 at 03:27:50PM +0200, Heiko Carstens wrote:
...
> > > +	if ((insn & 0xff0f) != 0xe300)
> > 
> > Any reason mask/not to check the register number as well?
> 
> Just to save code. If there would be a mismatch with the percpu
> register, something serious would be wrong..

Is it worth checking the disp then? ;)

> But that cannot happen(tm) :)
...

> > > +	/* Check if process has been migrated to a different CPU. */
> > > +	if (regs->cpu == lc->cpu_nr)
> > > +		return;
> > > +	/* Fixup percpu base register */
> > > +	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
> > > +	regs->gprs[reg] += lc->percpu_offset;
> > 
> > Such one reads bit better:
> > 
> > 	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
> > 	regs->gprs[reg] += __per_cpu_offset[reg];
> 
> That reads better, but it is wrong. 'reg' is not the index of the
> current cpu into __per_cpu_offset[].
> 
> It could be changed to
> 
> 	regs->gprs[reg] += __per_cpu_offset[lc->cpu_nr];
> 
> but then again that's exactly lc->percpu_offset. I don't see a reason
> to create worse code here.
> 
> > > + * Inline assemblies making use of this typically have a code sequence like:
> > > + *
> > > + *   MVIY_PERCPU(...) <- start of percpu code section
> > > + *   AG_ALT(...)      <- add percpu offset; must be the second instruction
> > > + *   atomic_op	      <- atomic op
> >                  \t here, but should be spaces?
> 
> I can't follow? We have tabs in comments all over the place in s390 code.

The other '<-' comments below and above use spaces, but this one
mixes spaces with '\t'.

> > Probably it worth noting that no extra instructions between atomic_op
> > and MVIY_ALT may exist (e.g. in the future), especially ones that use
> > the percpu_register.
> 
> That's not true. There may be additional instructions, they may just
> not use the same register that is used for the percpu variable.

That is what I tried to say, but I also thought it is intentionally
only two instructions between mviy brackets allowed: ag + atomic_op.
Am I wrong here?

> But that was true before this patch as well, even though it might not
> have been "obvious".

Hmm.. I do not get it. We would not get scheduled away before this patch,
aren't we?
