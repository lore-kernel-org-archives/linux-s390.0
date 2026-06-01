Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376313D902C;
	Mon,  1 Jun 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326502; cv=none; b=EsI6eECMMEeolM9ijq3Kt1Oid9gfqzH4tJv739XgE6V1YpPRa8QokjFbtJouY5A6SgrWvyhLcV0qUibinH4UEj/0ejFu8q+z1GmLAn03aDA4wDbLeZhIlNaG1kbZNNwJpKUR7abKSTXhmD6ANCqE5Ac+aj3U6HowbGddnY6dieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326502; c=relaxed/simple;
	bh=gRM0b1XDd5Hw7LstDwqB0g9aBI5qo/T2ZrC0ozfX3sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDLSzqdLqjlIKLLTOmBA8drvkz4PCOKYxMfg3Up2Ud9VQeiLvGjMwHXgt2TuR11WbEcuhlJsHL4ilMIXykrpcFZmjHAhVLwuLXRJOC6/02ytROfHZso1yoyk9aZKMHeyUNWXz+2dsLu8Uskk513ggdH8LsQPiJ/UF5pKiVfBNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cPsuaYLT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cPsuaYLT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651CxBtG3621258;
	Mon, 1 Jun 2026 15:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SrOY8GMLjf4gF2U8V5uaZ8RWKf5Ni+
	dSn9o8LfZGaxw=; b=cPsuaYLTgujQbFpw0wdQinIxgqR3jg2irSdKChIBsh7sMh
	Rtiz9HImVQ2Et84/++BnK1YAYqAfEKmGTU1xn2fU9etMjc7fVredcU721hrVIdxV
	dUUSIX/w8yoLKUYhG9jUtUotYvoQzhZvu8L06GwuWvuinSpMopdnGQuyCLw/kF+D
	jUW/JcCLxokbpjloLpGh1ZSkd+64NIccYPCJtBc6wxuXuQrNaLzU2boTA/Tm+V8e
	3bmBcpqsDZaF4qz7K2Dk4hZbrA3q9w8RtRko4PswlzO9CEIgroKkmII0GYhzJdj/
	NGr8leavyX6vIQEX3UTi+EA5G6k5mEP+CmrUPLeA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd41ebt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:08:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Es9FG022975;
	Mon, 1 Jun 2026 15:08:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jxpr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:08:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651F8FJP48038372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:08:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B55020043;
	Mon,  1 Jun 2026 15:08:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C874720040;
	Mon,  1 Jun 2026 15:08:14 +0000 (GMT)
Received: from osiris (unknown [9.111.34.21])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 15:08:14 +0000 (GMT)
Date: Mon, 1 Jun 2026 17:08:13 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/7] s390/percpu: Infrastructure for more efficient
 this_cpu operations
Message-ID: <20260601150813.9109C90-hca@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-2-hca@linux.ibm.com>
 <403de21c-957e-41ca-8c03-0bd110c49ec3-agordeev@linux.ibm.com>
 <20260601132750.9109A3b-hca@linux.ibm.com>
 <491a0085-9ba1-431b-9752-c1ac3fd602be-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491a0085-9ba1-431b-9752-c1ac3fd602be-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1MSBTYWx0ZWRfX8VPMrnoSNk+G
 HP9X8vvom2hbnH8zZnNupq4k28kfIHPIOcxPF1eNi0XphLpzgaBeVvYHOtzCv40AXSN+iom0Y+r
 KfiXEMXcZi5S2m4Cj9zeeE7XSzbxKoa8H/iSFdKi3osEzWgeVi9RmqNImlDcommRaAGqLjbmPyu
 7mVzKJe0UtU4n3nXMkleNdY7AEHluG690MJ83Zq1uACPdEUR5kyWucD6hIo172B/kWhOd9Nzdaj
 ZxNPUIt69NqNzqYAGr/KQKIqzmzazpUNe6r7H5aWN/E9Lxc33JuRdWT639D3QlXsAT52xnv7sLs
 9dsSMhk8DH+4l+YlP7WpXtwH24i4rSAyMrsKZ4Lx/bRGCCqzj8l/j61CQmq0urCGnH0GamaBVrl
 TFRAXNt5L8rwuxT6uJXqBtuSc+Cv0+ZBpZWkgmRw+Y+sEg0IzOVJIMltHJ2gcnRtBW+ggkqrw+3
 P7wQhESRHc51+qfeJhw==
X-Proofpoint-GUID: WKGuvRzT9FEGBySlllnz4cZoX7ZEad4K
X-Proofpoint-ORIG-GUID: WKGuvRzT9FEGBySlllnz4cZoX7ZEad4K
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1da064 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zNz0Go2lK3Arz9sM8YQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010151

On Mon, Jun 01, 2026 at 04:49:35PM +0200, Alexander Gordeev wrote:
> On Mon, Jun 01, 2026 at 03:27:50PM +0200, Heiko Carstens wrote:
> ...
> > > > +	if ((insn & 0xff0f) != 0xe300)
> > > 
> > > Any reason mask/not to check the register number as well?
> > 
> > Just to save code. If there would be a mismatch with the percpu
> > register, something serious would be wrong..
> 
> Is it worth checking the disp then? ;)

It is: the check makes sure this is an AG instruction, which adds the
percpu offset from lowcore - by checking that the displacement is
correct, as well as that the base register is zero.

There could be a different AG instruction within the inline assembly,
for whatever reason.

> > > > + * Inline assemblies making use of this typically have a code sequence like:
> > > > + *
> > > > + *   MVIY_PERCPU(...) <- start of percpu code section
> > > > + *   AG_ALT(...)      <- add percpu offset; must be the second instruction
> > > > + *   atomic_op	      <- atomic op
> > >                  \t here, but should be spaces?
> > 
> > I can't follow? We have tabs in comments all over the place in s390 code.
> 
> The other '<-' comments below and above use spaces, but this one
> mixes spaces with '\t'.

Because it is not possible to use tabs there. We put tabs in our
comments whenever possible.

> > > Probably it worth noting that no extra instructions between atomic_op
> > > and MVIY_ALT may exist (e.g. in the future), especially ones that use
> > > the percpu_register.
> > 
> > That's not true. There may be additional instructions, they may just
> > not use the same register that is used for the percpu variable.
> 
> That is what I tried to say, but I also thought it is intentionally
> only two instructions between mviy brackets allowed: ag + atomic_op.
> Am I wrong here?

Yes, you are wrong. You can use as many instructions as you want, as
long as the inline assembly follows the rules with respect to the
register which contains the percpu variable.

But seriously: all of this works only with atomic ops, so I don't see
reason why one put more instructions there. We actively try to keep
our inline assemblies as small as possible.

Even though with relocatable lowcore and alternatives the C code looks
huge, while it only generates very few instructions.

> > But that was true before this patch as well, even though it might not
> > have been "obvious".
> 
> Hmm.. I do not get it. We would not get scheduled away before this patch,
> aren't we?

True. What I tried to say: before and after this patch there was and
is no code which _uses_ the pointer of the percpu variable more than
once. Accessing the percpu variable twice within such a section would
be potentially broken, since between two accesses an interrupt / nmi
could happen, which could modify the percpu var contents, which again
could result in loss of information.
