Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2869C3368B2;
	Thu,  9 Jul 2026 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576645; cv=none; b=YxmclwQTI2TyD/Uwvd4/IMsPqa/aLhLFxd3jqUcHlF0cMdVIIX/8XOdQvOHws0hDflYDOxxcme4z3fejJeh8NQcgc5cCnNbC10dgIy3WiG0gz1tIxeIHUvHD+1Dgykp3HZ4BPh0uaHOmfMpEPpeJydbn0wsz9BsrjAz8ZbeGn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576645; c=relaxed/simple;
	bh=KvvxIP31OYibvgv6C2eDmY70zHkncKeJdtbst8uCmwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQs1tawtKJrYuGw+v9Syb47mBoc7CAkHAxBojkFrfTs3IfsntiGZuI681OZffPcm4ONl9s0rOzvlK6aL39FAOZo5bKbcpKWdO9rCI9GVeK4Acxy6W/98KD0KknMGjx2jB/Ip2Twdf/cA/mw4mBzdeZYundNYqv9pekoZYptIBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YbTm6fjh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YbTm6fjh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668NIkOB664209;
	Thu, 9 Jul 2026 05:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OjWkybwxB2L51WRe8lfd1E396H3jc3
	N7Y6aiaMEwaEQ=; b=YbTm6fjh+07R/kQ6JLBqowV27RUXCh0d9Qp1XbaUov+HF5
	W8NYoixc2YOoyEohxjkh6+AngxRKSG73B9SwaZIkY07PleZOfS1U3F9o9FObFPIk
	p5M09Vn88usbCDkRfdF4q1txHIpVQkFq5iBzquTbDcShlKZSDcXU0cJZL9Pg3jIc
	hsKa/v5Dx9evrvW4FYlxvmh6KbJoOAGbLC9antocyYPR8uQ+tLkiW4XP7TLZnael
	QOunnd9WjbPOK70lFvgXLPuZkwNvamBy6YHBHR5egK+NIjClhPHxWFvNPd+ST8an
	OzoqcydMthUe/s+pYTecD4ABsT0fWQnlqbUqdpag==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknqpv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 05:57:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6695nsBu012923;
	Thu, 9 Jul 2026 05:57:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ybfcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 05:57:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6695vG8424051986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 05:57:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6B1B20043;
	Thu,  9 Jul 2026 05:57:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A77D20040;
	Thu,  9 Jul 2026 05:57:16 +0000 (GMT)
Received: from osiris (unknown [9.111.65.145])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 05:57:16 +0000 (GMT)
Date: Thu, 9 Jul 2026 07:57:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uapi: Remove obsolete unistd_32.h from Kbuild file
Message-ID: <20260709055715.25563Ade-hca@linux.ibm.com>
References: <20260701134727.882734-1-thuth@redhat.com>
 <c8182a6f-6196-4389-936d-23d8f9cd1891-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8182a6f-6196-4389-936d-23d8f9cd1891-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4f3841 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=EZM7hEf-NH7Mg6IGJ04A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: xviRxyaPafp6P19OZ6ZyR2JpUUyZGU5G
X-Proofpoint-ORIG-GUID: xviRxyaPafp6P19OZ6ZyR2JpUUyZGU5G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfXxIu0d9jugA6v
 yUgY1kqM7TILrcNf+ePPDLiGiaj/AS0W3auJgJApJajdJXDRsNQp3Rr2btgCBs2cYojwQcsW8j4
 HAVpsrrSrDUsYkYd7DAQWBBasQX95k0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfX7RAiXfpTJLi4
 DKv2Vq+gre5H8tKGT5u8rZ+gpQ+GIFGlzDPn38nrjNubdIxkw9KDRDGLDaBlyhui7Ea+aFlq2ly
 NV6iS9iMHznWbltx+YmHVf61zRAU1yZPIqAyPqnEFLP9tswqlEMDvyJzzTrGE4Md1lUirSm12nN
 vdZQp17CaMliqp6IhIlsTvL8bHet963Oo1WY82fzMyxQ7pwVtzCEzTqHYe8HHX6T7y3V8u3WK/y
 QWXpFqJeE8E1h2zaYIZeNNghYTOMMRV/cS4drQfWBbaEIUDiMFTNYXmpgrlvjAqky7fz0MOGPuV
 JUo7byrKVkO8yT4JlfdtVfE/+rN7nAXNbureFEhBpoB2LqcnaiOGBv8MBpzMSWx1wkulfFhaMsM
 vCuv1jqR1w6Ewvo5uwCJCBZx46IrIeGr18o7oPV5RuUpLMBrLJa3HXbvgl3NMtF+w6z0CLQw/XM
 uVK8xtg1eKygVoRaGBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090052

On Wed, Jul 08, 2026 at 02:47:01PM +0200, Alexander Gordeev wrote:
> On Wed, Jul 01, 2026 at 03:47:27PM +0200, Thomas Huth wrote:
> 
> Hi Thomas,
> 
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > unistd_32.h is not build anymore since commit 4ac286c4a8d90
> > ("s390/syscalls: Switch to generic system call table generation").
> > Thus drop the superfluous line from the Kbuild file now, too.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  arch/s390/include/uapi/asm/Kbuild | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
> > index 46c1ff0b842a1..378151cef3cce 100644
> > --- a/arch/s390/include/uapi/asm/Kbuild
> > +++ b/arch/s390/include/uapi/asm/Kbuild
> > @@ -1,4 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > -generated-y += unistd_32.h
> >  generated-y += unistd_64.h
> 
> On repeated builds it results in:
> 
>   SYSHDR  arch/s390/include/generated/uapi/asm/unistd_32.h
>   REMOVE  arch/s390/include/generated/uapi/asm/unistd_32.h

How did you achieve that unistd_32.h is actually generated? The required
syscall table information to generate such a header file is not present.
This looks very odd to me.

The above should be impossible with current upstream code, and I cannot
reproduce it. Any chance you applied Thomas' patch on top of an old commit
which still includes compat support?

> A complete removal would require changes to arch/s390/kernel/syscalls/Makefile
> at least,

I don't think so.

> but we still  might want to have unistd_32.h around.

No, that doesn't make sense. compat support is completely gone, including all
header files. The patch looks fine as it is for me, but we need to sort out
what you reported.
