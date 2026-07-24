Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147EF292B4B;
	Fri, 24 Jul 2026 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897324; cv=none; b=K3EFJR7jTGA0TSRaEJGxZ001blPKkKRaHfMW2eP0cuLka7nBKb6y/Q9y0ZGzqfkXVcVGYr0xYmTRty12r5b8oYvKPGQR1ILFIIvAT9m33nEmSCPo8JzNAT+lqcD8OScHKqQaduRm8/ZMEU7GA0LfI1pC5Sw3iTBQD/Gg8DR5xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897324; c=relaxed/simple;
	bh=hxeuMxwIIDiWpWhmU6f+zVfB6MOfOaAQSIHJk5Px21s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp0/jlDrDmvcRgvertBfzRvyxMVmuLe6f9GtaKVW2ksggZQELvClatwhrbx05v24TBuNUF5bqKHAoDOKIlToV9MENETwJZKuAgo63sp/3XcIzj3S8u+VB+FHZFU7PCcZk/2j4dIlSCT84NFK6uBWQBhCvJvmODjndWuL6FinnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KK059qn7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KK059qn7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCgqVD1770754;
	Fri, 24 Jul 2026 12:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ghPKTiG4PYb4t7QNoPwRfoDvIg1nWi
	/OdckbvOVdpfY=; b=KK059qn7GrQpr+Vnv9J+EnUy0aJsxCdiFMr8S1/29PjGUM
	17v3HWHU/JDB4DV7Bn+27KJpFD6NcFd60a6mgnxkPcsvWjxTR+9p9xAXIkfZd4Wc
	AhfRiGVrN4e8lUQEqciO/o0DhB6SdKeVyBX8CGQG5CH9bMJVA+EnKoH/ic3xzDo5
	hW7ZBSdcUvOg8/227SrIFMXQHmH92nOq5y7CMSliKMq53TxM3rO8ITXfLMZRJhkk
	oZELkg9HJCn2C4HqxgRcAUMAvrKnypfiMTacxtiDPIaCyx/48TBC7CIzj636vVqP
	0fDTvCd2zNV0BfI9M86s1Ac+uCgvDLvylAkFK8lQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77km36e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:48:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OCYc29002544;
	Fri, 24 Jul 2026 12:48:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wh0gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:48:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OCmUPh31457952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 12:48:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6E4020043;
	Fri, 24 Jul 2026 12:48:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7755B20040;
	Fri, 24 Jul 2026 12:48:30 +0000 (GMT)
Received: from osiris (unknown [9.111.14.151])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 12:48:30 +0000 (GMT)
Date: Fri, 24 Jul 2026 14:48:29 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Add missing vm_start <= addr check to
 do_secure_storage_access()
Message-ID: <20260724124829.220718A2a-hca@linux.ibm.com>
References: <20260717131407.855327-1-hca@linux.ibm.com>
 <d7022700-114e-4aa7-ac56-5b805f700daf-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7022700-114e-4aa7-ac56-5b805f700daf-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a635f23 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=QMJIu_iufyu0FRhpi0sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX2QBHBMz9MlQx
 xJliobP7AIdu5BQNbcG+Be8xW1eGoxswUUI3ObkY7LzgeZU45Q+RIbcxBuO9AqNOEuTeAHrVBVq
 b5g/CDCoH3BP4M9aWTvOEJM0niwMJvIz+8W/0vRu+TdF9dzfQMaD2xV5ApA49toNBy579WHEbQ9
 dv7ItXq0VrYT0yVOlP6lRwbksCnZKiRbeXnf3sjbJhlQk6dcRe7v2e7DsJHa9EM5lkaiV04Y8sP
 n9Y0i14cDhSSf0lY7dQAweRgQBodvrp+6im+Q7l8eWs5/7smtt9Wbu8pFe3fOdtiBvncxJgzB4M
 f9q/S1QpU8R/qlzMOcVG3RR97kd5ImBVhKR0Xzabp2fTi4ZU1ea/D1XdaugVwKtXnPI1R8MddKB
 BlDyKPyguYWXyX1BFFAtCfi7JVOe93kIA3UEEPZ7LTc6+nl6Yewnd7/bqVH/F1SDtybvfN1wuE1
 9c/UP9g27/jYMYXpBpQ==
X-Proofpoint-ORIG-GUID: m9viTt_TS8-edsulY9CePCgU6DIlsaJ9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX8QP490vBZRtd
 aSeRknyqZQHwc2yQsCJTRa1beqARO24LFgaVYEgN5+okSXCmi2YcVjoJ7ZDWVC6Ayjwtu4nQz47
 ADMehqL8u9MuD2lR0wxOcDdssEmZa2k=
X-Proofpoint-GUID: m9viTt_TS8-edsulY9CePCgU6DIlsaJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240115

On Fri, Jul 24, 2026 at 02:09:32PM +0200, Alexander Gordeev wrote:
> On Fri, Jul 17, 2026 at 03:14:07PM +0200, Heiko Carstens wrote:
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index 028aeb9c48d6..d6c58d78edc5 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -456,10 +456,9 @@ void do_secure_storage_access(struct pt_regs *regs)
> >  		if (faulthandler_disabled())
> >  			return handle_fault_error_nolock(regs, 0);
> >  		mm = current->mm;
> > -		mmap_read_lock(mm);
> > -		vma = find_vma(mm, addr);
> > +		vma = lock_mm_and_find_vma(mm, addr, regs);
> >  		if (!vma)
> > -			return handle_fault_error(regs, SEGV_MAPERR);
> > +			return handle_fault_error_nolock(regs, SEGV_MAPERR);
> >  		folio = folio_walk_start(&fw, vma, addr, 0);
> >  		if (!folio) {
> >  			mmap_read_unlock(mm);
> 
> The Sashiko feedback looks like a false positive to me.
> 
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

This has been integrated into the "[PATCH v4 0/8] s390: Reintroduce
support for DCACHE_WORD_ACCESS" series. First I thought of keeping
things separate, but decided then to address all of Sashiko reports
and make the code look quite similar to do_exception().

So v4 is the only series that matters, everything else can be ignored.

What is still missing is kmemleak handling for which Christian posted
a patch, but that appears to be incomplete. Or least my thinking is
that there will be a subsequent patch.

Christian?
