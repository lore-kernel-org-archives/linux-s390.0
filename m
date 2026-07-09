Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC33D75DE;
	Thu,  9 Jul 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580374; cv=none; b=uJ8tI3EpbvxRdWpGDX59aKS1M9yAdmXskzKkoYyzV7W6NK77w8EOOxFD+Ro6RjCuIO3jeqlCqHDR8S59zWuCthtoix2+O12h6aE2kp9fbo8itp4yPcCJTZdJgNw2gDMP4PDck/FCTbEPhPO8O+Geu1ea+tJw88JmF8NsxhrBvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580374; c=relaxed/simple;
	bh=RHq8BNoGl8nbMqtbEvCqaVe6EL+3nwvn6iBeVhRgvj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/C48I2gxRHkfUEdTv+YvtchUo1U5HgGE83FRHmYjnceM5MOyJ6OoQG70x6g92nPR18T+uJaFaL3MidDN8LTPzg3Xol4UJdvyZUO+XOEBShkYB8k5eFboT5lM4j8aCIUijhZTJ3x3nFjtXtNPEhpdSJ76NiHEPrde4LS7yFkUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mhckzt52; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mhckzt52"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696Ibr41897887;
	Thu, 9 Jul 2026 06:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EEiiZfeBZ4XQhOF7kak5/7eB479i2d
	mxredS2frXfbQ=; b=mhckzt52b1DmYOYXNcG81H5NjqXFLKBSSVt2Ht6C18aFgR
	kHN5o9IkNvookZ+0jCbH3vEeOB0xClLE4y3AfLdpHrdj1/3tPLJ1IafuZEZwcox5
	+sgPQ6lmu3eJRJqFmZD1qegMvF1el1l3xRiD8YcNf0yHBB/yi1Ng/JuuP0KSo3vf
	hl1S5X+SEo61c8671EXVUdV9wBQTKnsHEg9GDTQcxxh2EZ8L4Vj+jl9s4GvFPzbB
	lixxAeeQEKnbyE+YpPs00MQXpkUUmNf6SftxWlPccgQJTXottiTXspbDngUp01Nr
	iJYIu6BvsnnUMd/KQcSqyDl82pwT5uuPslVjS5Wg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur05t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:59:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6696nkOP010263;
	Thu, 9 Jul 2026 06:59:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkbyx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:59:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6696xPv047382940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:59:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 180412004B;
	Thu,  9 Jul 2026 06:59:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C429C20043;
	Thu,  9 Jul 2026 06:59:24 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.48.151])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 06:59:24 +0000 (GMT)
Date: Thu, 9 Jul 2026 08:59:23 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uapi: Remove obsolete unistd_32.h from Kbuild file
Message-ID: <f0bf4797-7706-477e-a99e-7c895bfa77c0-agordeev@linux.ibm.com>
References: <20260701134727.882734-1-thuth@redhat.com>
 <c8182a6f-6196-4389-936d-23d8f9cd1891-agordeev@linux.ibm.com>
 <20260709055715.25563Ade-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709055715.25563Ade-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MiBTYWx0ZWRfX4nUOwRP5LGpq
 IBHoc3rXphnVmjNIJclqa89yKXolxP3JOBl1NzxcIGlOlhM4UsTrYpAYcXmASrOuLNNjDATwfOj
 zcWfG7lt4j6UD+qMjaWzg4So01tBy+k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MiBTYWx0ZWRfX+WLkvtqOH0mw
 8uDRn+yNhqzkZPtIjV1cXfyZGPJ/FVleV8zICqDX+H9RAvCVFKqi6mlNS3TumjsuSGigx1t2RLD
 C/KWfTD/c4cCZd81cCOLrI0Txlv2qKz0qPv1Qrf9bP+mCJDvUN3B5TTUh45K6W4ZwL2FvsIdeyZ
 adRhwHIKfHRvGrqn24D/Jh1b7EmkWAXwBXXLTAwEehFK8Uy3sD7i0+SXYalWozDhgETnu8AxbD1
 oDmBOVaqJDU5v1WzXor0+VfzmyNPn43X2DJjjHvQNSFFmO1m27eNzf9K2EqPGkX8SRfc0c7GTdm
 Mpc5l9lM6HbZqOL3MLOVU0tPJWIokUKmrrspwDHp40wGObx00k/jNymiZTdOnaI9m+BLUQrTXIW
 LzFZUD946Uwzj0MK6aoLE0Hm4hwkEh94h+8txbqlF/z2x6jO1HR98i9dN9KrtEkkaF/vaLp7ZQX
 ZLdewySgt997TRsZg7w==
X-Proofpoint-GUID: idM75CkxJb15l3yfLn4tgafoZDyV94eH
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4f46d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=31qeVufJgF_ueeuuHYsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: idM75CkxJb15l3yfLn4tgafoZDyV94eH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090062

On Thu, Jul 09, 2026 at 07:57:15AM +0200, Heiko Carstens wrote:
> > On repeated builds it results in:
> > 
> >   SYSHDR  arch/s390/include/generated/uapi/asm/unistd_32.h
> >   REMOVE  arch/s390/include/generated/uapi/asm/unistd_32.h
> 
> How did you achieve that unistd_32.h is actually generated? The required
> syscall table information to generate such a header file is not present.
> This looks very odd to me.
> 
> The above should be impossible with current upstream code, and I cannot
> reproduce it. Any chance you applied Thomas' patch on top of an old commit
> which still includes compat support?

I can not reproduce it anymore of course, but I am pretty sure I was
trying exactly that :/

> > A complete removal would require changes to arch/s390/kernel/syscalls/Makefile
> > at least,
> 
> I don't think so.
> 
> > but we still  might want to have unistd_32.h around.
> 
> No, that doesn't make sense. compat support is completely gone, including all
> header files. The patch looks fine as it is for me, but we need to sort out
> what you reported.

Yes, my report is false. Sorry for the noise.

Thanks!
