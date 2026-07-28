Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB453B4E84;
	Tue, 28 Jul 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227406; cv=none; b=iNHnPLs+r5BryftmNoUU+rZLC4Ux6Ir7kl9jejRF7EFg/hRNpRqkKlz7obfPvUx8e0othGG5VdBIv0CWt/ClKaS8W18RGWN+T0Un5qav8MGIYSOI19qnrElH3C+EFDQk602+2FHarED9ixHE3YGZBSalBDC/ZFTlIls4UH4Nohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227406; c=relaxed/simple;
	bh=TVBozHyTZSWrU9SLVxE0XN7O5JnTG+0kxN/B/K4gP/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcKglRmfVzQNoaWF4tIvKRCbvmsti+/ZHfbmJUq706MSUB97s3xcIGCP8yCiF8mLwhUTYbwQ+FnBr+itsIkfMMiadAI2lh0OE9/8ILieyxlvdHxdNu7RYpJLe3ArTn1egMqjWOfsgr26XWG8tvEG/qd8CNsDjymtIV8cnWu6Ds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQWLbHDc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQWLbHDc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S8Hsbc405236;
	Tue, 28 Jul 2026 08:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aZP40m365rNP4C2cbGzLmzWy37xzdG
	JC93vOAIBvzyI=; b=qQWLbHDcBq3qB5oWFt1Z+8EzQOpjrZJ+I/JZrrBS8fD4Rw
	M68AKl5Z7ZFTVKCc6vT9YPrRjdlSHNOyTRsUFN1IxYtNXbwfXXuVVkQQaRrxVQrP
	0V6YcWuEip4e6j3XmxHnRdo5c+Tnd1FeS/8+L0H5tishTWA/46yPJjaksZ6fdEkW
	Qfuk1PcTgo5rwHYhaUcWBkkR3h9zQ2cL6KzMWW3uGAbux/WRWihnt/BB2ZMaz4Jh
	QV5OG6sr7atDRKVWNlt7O+Xn91XCA4GTD6Br4f6Qlv+tn1vk9E+qLwPCd/AuLXd9
	oUbupEsGCxBH/LhtF1qUMCgR4ShWAKlF9DwRoNSQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj3ntv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 08:29:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S8QMQR031487;
	Tue, 28 Jul 2026 08:29:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg8rmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 08:29:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S8ToOr30343628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 08:29:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 824FA2006E;
	Tue, 28 Jul 2026 08:29:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 074852006A;
	Tue, 28 Jul 2026 08:29:50 +0000 (GMT)
Received: from osiris (unknown [9.111.74.81])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jul 2026 08:29:49 +0000 (GMT)
Date: Tue, 28 Jul 2026 10:29:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/crypto: Replace cond_resched() with schedule()
Message-ID: <20260728082948.13361Ab7-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-2-hca@linux.ibm.com>
 <f88846b24b1250f89b503b6ddfda318c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88846b24b1250f89b503b6ddfda318c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA3MCBTYWx0ZWRfX4EVf2Ux4lTDX
 Ow+zQXSX90+l2/Pg1OmUTAw9Oh+95NzGrkQnM5JUoCeu7QIR69QUc3V51CNJblhJeswCyAasdOF
 AVfvYwYecY08KKWa7R3bhGzox3UEf7Q=
X-Proofpoint-GUID: 8-qVzuiuD6SeWWxQlMcPo6HUMz2JuOdz
X-Proofpoint-ORIG-GUID: 8-qVzuiuD6SeWWxQlMcPo6HUMz2JuOdz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA3MCBTYWx0ZWRfX3ZrdQZ+8DggM
 BCz/TwskXhg53j4Z5V5tFJf1gtuY1qLl0NWqMf9bUjKGQ8jbLoxc5mW/zzy0YLzBthGpGEQ0Mq4
 lS3jckTz3fsCAAjn6kbC8d9MVFQh4smv//W4pe47GrJ5TE7QZ/HscL2DorgzSS2OpLh/Ttdis8C
 Z/TgeW9sPIew4v3g8BLU96l9LHMkvxd4uxGTuA2rkoUOdP0fi5y/ZnWUL0Dknq2SE9jbbl9xH93
 /wxiC+Iiqp2WTgdyWbEN7oW1OLqvuzTsok9D8q3HznsYwUtU8MBiOqgjsWQL2PnIzGUvtMNChYJ
 F8pQHKq7x06ESz21N3tnvtICOViHfQwij7aq8C/eSUB1t+yk0cmA+IhvKmV+h3c8dGUdbDKrG6/
 RDh1Q5NJDfTJ8YWCZaBSUm939m90sJtW7BzINpWsVZ62WgGEWgDRh9az6Vnliuib6StNXNpiZtN
 LI6x6qhhwREYVKNkfpg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a686883 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=mTrsI-zAvygo25pkSN0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280070

On Tue, Jul 28, 2026 at 09:05:16AM +0200, Harald Freudenberger wrote:
> On 2026-07-27 18:24, Heiko Carstens wrote:
> > The comment for all cond_resched() calls in crypto code says that the
> > process should be scheduled away to avoid instant re-invocation of a
> > callback. This is not what cond_resched() would do or did.
> > 
> > Replace cond_resched() with a call to schedule() which comes closer, but
> > it looks more like this code wants an msleep() call.
> > 
> > Note that with [1] cond_resched() is always compiled away and becomes a
> > no-op.
> > 
> > [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/crypto/paes_s390.c  | 8 ++++----
> >  arch/s390/crypto/phmac_s390.c | 4 ++--
> >  2 files changed, 6 insertions(+), 6 deletions(-)

...

> > -			cond_resched();
> > +			schedule();
> >  			return -ENOSPC;
> >  		}
> >  		break;
> 
> Ok for me but we agreed to have all this code going via Herbert Xu.
> So please address this patch to Herbert and the crypto mailing list.
> And then I'll add my Reviewed-by.

Well, the main question still remains: why did the code use cond_resched()?

This doesn't make sense to me, at least when reading the comment. So to me
even the schedule() approach I proposed is questionable. Why didn't the code
use msleep() instead? Or can we just remove cond_resched() entirely without
any replacement?
