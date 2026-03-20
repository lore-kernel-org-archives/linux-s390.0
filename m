Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD33A6EE2;
	Fri, 20 Mar 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009850; cv=none; b=uTxwlikYBcSswOnDhahfIqkfYXX2C5N9uSx/RHoYppHfUR99JU3+xp3+HhPrIwfBh/KBPm1gR0GKXfFrT/tE/XOLyoN6BOF8CKcnEUeAY44Rvd138IT7pjRjt2xXIs/O61Gcn5pIj5QAZ78bkAklDAzEI2cNwft0Ikki76IxPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009850; c=relaxed/simple;
	bh=Cqhof3gI/dA4RCzM9gUJd/IqrwbD7Bt0mOk+6KlyF6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMyeXSeKE1NTIiAmZHtS/AkkoqJ+xcHL40L1aDLRsbzZz0vWx+A+vurM9Vhp8Qj9UeGdB0GlZ/QfIVqbv0J4roKCiOaKgcP/JuwJafRXkFY6TvDO/dpQ5J8N4U/JlGtdAV7N6FNm/pZW37KYor9eXSg0VsgfNEZs/75vw/M9wNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MoGxGwtm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MoGxGwtm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K5DBET1189773;
	Fri, 20 Mar 2026 12:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0j+mUp
	Q1XoN18pgPDjeuHd6/3ghqqwD5RjV2M3kedhs=; b=MoGxGwtmQiIOzY04Au8UUV
	OWUibYVJFgV7y5f+t3bm1r7KaPJXHHh6f6bIuEK6c6T/tbesv9GoxSYqxUXejM5Q
	9XC1wLtXcDRx4pupA+DwIvWVjd5WZsndsxxhlgGXw+ReIydxUTetDb3X3HDNP79x
	AFby21ZBFGYWWfff2Q8ss/9w0OF6EJunA9gT9jM9c/+SAefLxBONGF+DBAXbZfiW
	q+AP/CvE2tYE+yGgS75lyWwML4RHAiDmMmT/yFwZMoZ+pBbs0Z2u78JJj2VyMZ7K
	jT90BUjbyuP8MfOTuEuSGlGQUEgtp+FJ8vly75fyD607aZXLEa+69ekjWEfZP30Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfwtra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 12:30:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K8K6dQ028459;
	Fri, 20 Mar 2026 12:30:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1pwpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 12:30:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KCUgR161604218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 12:30:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B62220043;
	Fri, 20 Mar 2026 12:30:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F5B020040;
	Fri, 20 Mar 2026 12:30:42 +0000 (GMT)
Received: from osiris (unknown [9.111.11.140])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Mar 2026 12:30:42 +0000 (GMT)
Date: Fri, 20 Mar 2026 13:30:40 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] s390/idle: Provide arch specific
 kcpustat_field_idle()/kcpustat_field_iowait()
Message-ID: <20260320123040.9681B35-hca@linux.ibm.com>
References: <20260225145146.1031705-1-hca@linux.ibm.com>
 <20260225145146.1031705-3-hca@linux.ibm.com>
 <abGUxzhVmz2YOaEj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abGUxzhVmz2YOaEj@localhost.localdomain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wpO4DVIwkvtv4qnrZuoJO8o2pkfnh5U7
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bd3df7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=OSDMBbB0WUiQY_-soqwA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA5NiBTYWx0ZWRfX8du7o1ygsPx3
 2pMbQ1BNq8aWMO5JUgp5leEhg83vmEmwbCeYrs0T1e7S6iZexQBAxVPeDoSs0aP1TX+F6FYq93u
 Ds8TQMuc0wt5sJE5r5m9NBXlCYWFvuHuOeS1jPKoz2fACKLOqbAQX4WGUlhF6Grj3Cq6oRhuoti
 G4VPqHG+IVaU6vaPhRSawBx5Yt35qMT+1p0wUDiqO+dNY/Qydnus73ihQBNxkt4G+5wSZH/brwK
 A0Qm93G802ssqgf2qBzkcAf9sQoqrHhgPz4jmP5QRxz7lmQWhYPVNiX5w/5L7kLSkL9DiA5tJFt
 uHJ11Fuiqe3Zg1b4OBUxJujPGiNJlqnUDgMOEtFmbD9Ebct0SLKTYPuJMHOeMO0S1wIZOd+taeL
 a2Weoi42G9IkaMQQ+17aI6PfbXjt6g2C1x9BVKRtRgQJShMFvv2WK8559GmjTC+bx84gYCqe5vr
 mik+4VbQPWDzS6o4/xg==
X-Proofpoint-GUID: wpO4DVIwkvtv4qnrZuoJO8o2pkfnh5U7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200096

On Wed, Mar 11, 2026 at 05:13:59PM +0100, Frederic Weisbecker wrote:
> Le Wed, Feb 25, 2026 at 03:51:45PM +0100, Heiko Carstens a écrit :
> > diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> > index 4873fe9d891b..19fd1541a0f3 100644
> > --- a/arch/s390/kernel/entry.S
> > +++ b/arch/s390/kernel/entry.S
> > @@ -378,8 +378,13 @@ SYM_CODE_END(pgm_check_handler)
> >  SYM_CODE_START(\name)
> >  	STMG_LC	%r8,%r15,__LC_SAVE_AREA
> >  	GET_LC	%r13
> > -	stckf	__LC_INT_CLOCK(%r13)
> > +	lg	%r12,__LC_IDLE_DATA(%r13)
> > +	asi	__IDLE_SEQUENCE(%r12),1
> > +	stcke	__LC_INT_CLOCK(%r13)
> >  	stpt	__LC_SYS_ENTER_TIMER(%r13)
> > +	mvc	__IDLE_CLOCK_EXIT(16,%r12),__LC_INT_CLOCK(%r13)
> > +	ALTERNATIVE "bcr 15,0", "bcr 14,0", ALT_FACILITY(45)
> > +	asi	__IDLE_SEQUENCE(%r12),1
> 
> Would it be possible to instead do that with &kc->idle_sleeptime_seq ?
> This should sum up to a simple increment as well. This way you don't need
> those nested seqcounts.

Yes, that was my first thought when implementing this. But decided
against it since I thought it wouldn't be such a good idea to directly
access members of common code locking structures from asm
code. However, since you mention this too, I'll reconsider :)

Please move forward with your current patch set and ignore this patch
for now. I'll provide an updated version later, however will be on
vacation for now.
