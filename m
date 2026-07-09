Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26E3793C3;
	Thu,  9 Jul 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592213; cv=none; b=e7UmoxFUYtHmRXXYPa9QVQuC2K1ITuq8c1ZnZC9JbHhFHQcXmnB79AS5VhQfofzf+WOuMJX99AC4rQ6XZw0EpxEgQtX9kIZsVdfBJi/l2JNCsj7BSEmcmLwK5RpJ/hwDeH0pZTDZb3siz/NgKc3sosUbWp4XTOZp75Czq6xOWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592213; c=relaxed/simple;
	bh=G8TXdPyXX4r9/IHDL0vfoQ6YiH1MdbFaXeCLgKPilCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGaFRF0IadoKcgZLgtIWJqbHrk2T1GlFuytecPqsRjxtozGMlvfsHZUW0YlicLmuhZjoqiTL0Oe7N6hUTac2bGpgviGQFDqwr3Fi53f+ZzdE1/CIPCzXhvxasdPa/XmXnvGnSxhgmBwkrN8uhBvd29cqy1ODLDhCUVawtKi0mDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LDIXOwuZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LDIXOwuZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IRad1535435;
	Thu, 9 Jul 2026 10:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LcR21pVQSsS6q51BCQ7n1ezEw2xUDh
	NARG3kLZ/qLCg=; b=LDIXOwuZslJWDBjIiXFGT64hg+MvsJDzSQTdEN+h449Uy4
	j4FNnBm4vNUQyd9bbekZnGUUUFF/xPSFDBaMeY5nfBxhxynfXIZVPXKc3vQ8nsHw
	MGj9VbW6dOrQDEGrfqBg/SuyuGitJO88scc9pfQysVeHYjN00k+UbvjBcJecSGoU
	K2dxG0ot95d58qLhDVScfh8ojKeMV/1k1lmxu39pmqK1yEb39V2o+U/XKNoJlQ/b
	DYj52SqneMMfwMG6a2UJFiruipHgghz1i01fsau+sFi1hmngALgx7/scjMjRp1/J
	gEpkY53JcB7lSxUw198fri0x/EstVlTEVjU9LzzQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknrmgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 10:16:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669A4bTx020019;
	Thu, 9 Jul 2026 10:16:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ycawy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 10:16:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669AGc3638011240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 10:16:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A432006A;
	Thu,  9 Jul 2026 10:16:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0A1720065;
	Thu,  9 Jul 2026 10:16:38 +0000 (GMT)
Received: from localhost (unknown [9.111.0.64])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 10:16:38 +0000 (GMT)
Date: Thu, 9 Jul 2026 12:16:37 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uapi: Remove obsolete unistd_32.h from Kbuild file
Message-ID: <tthwkjp@ub.hpns>
References: <20260701134727.882734-1-thuth@redhat.com>
 <c8182a6f-6196-4389-936d-23d8f9cd1891-agordeev@linux.ibm.com>
 <20260709055715.25563Ade-hca@linux.ibm.com>
 <f0bf4797-7706-477e-a99e-7c895bfa77c0-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0bf4797-7706-477e-a99e-7c895bfa77c0-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4f750b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=LvJBJGJDRD2OuXGQmAcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EkEOu9rQrDzJP1Mq2SwlhMWvrSXWsh1m
X-Proofpoint-ORIG-GUID: EkEOu9rQrDzJP1Mq2SwlhMWvrSXWsh1m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA5NCBTYWx0ZWRfXzLB4lQdxSlmU
 oVOfeeVel+22ztUfHCYep268dgBuhkfXPiWx2JACmw/UDmzVZMjqPzKeA/rKMldMMLJOSTOae9P
 gGruN7S5AkXj5fkoUyu6k4YL6Vj9Ckw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA5NCBTYWx0ZWRfX4PP4HAiwMHbl
 DcbK5R0oGzGZS5iA324s0ruRY7dtZTle8VYGCFymX+4DtqnEQx/6po96lcUYnbrBcmePJKavWbY
 Xo1TvkQkMV2LbF/Z6zxpYfpgYNw+fDWf+DmtQ5sSaXfsNIKO9e6B1Mp5X+OvMSW07wCihjfOdH0
 uL/j9g7k1oCJmrrUd6sxUBO8ABryKS7uSV94eEBjPB9s8gvHfgWKCc4YCsz1rSfBUbso7CeBoWU
 kJxwg9L/WAl+3mI71FsBUDdHvYYDQOytY5zIP8vIuRM7eDkJztRYn8APjuOXyKTjf0h1nNkjjjF
 4HWk8Ez0OVAcJWNo2BbCl8gDzHT1qwww1nfHwHVP063yrQnRHKiXBNT4HcdBtgThuEVgm3O254U
 VfpkOr2s4DD1FFLws28FH7nZ+sFGgud9QJszdBBPhUQuXXXLeCuIGeBjhdS1VpXHpYeppoSCN3E
 P5iMFF8Dlpd3DgB25Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090094

On Thu, Jul 09, 2026 at 08:59:23AM +0200, Alexander Gordeev wrote:
> On Thu, Jul 09, 2026 at 07:57:15AM +0200, Heiko Carstens wrote:
> > > On repeated builds it results in:
> > > 
> > >   SYSHDR  arch/s390/include/generated/uapi/asm/unistd_32.h
> > >   REMOVE  arch/s390/include/generated/uapi/asm/unistd_32.h
> > 
> > How did you achieve that unistd_32.h is actually generated? The required
> > syscall table information to generate such a header file is not present.
> > This looks very odd to me.
> > 
> > The above should be impossible with current upstream code, and I cannot
> > reproduce it. Any chance you applied Thomas' patch on top of an old commit
> > which still includes compat support?
> 
> I can not reproduce it anymore of course, but I am pretty sure I was
> trying exactly that :/
> 
> > > A complete removal would require changes to arch/s390/kernel/syscalls/Makefile
> > > at least,
> > 
> > I don't think so.
> > 
> > > but we still  might want to have unistd_32.h around.
> > 
> > No, that doesn't make sense. compat support is completely gone, including all
> > header files. The patch looks fine as it is for me, but we need to sort out
> > what you reported.
> 
> Yes, my report is false. Sorry for the noise.

Maybe you have not started with a clean tree.
Anyhow, I'm picking up this patch then.
