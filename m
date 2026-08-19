Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B83451988;
	Wed, 19 Aug 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138578; cv=none; b=PyrreuugXT4gc0CXfF18B8JoLE+v7i4FMw5Te/7PGHFIqkz4Klzo8ijXadpCezPFNgvrLAweUrfVIdo9NOfk8Gq/nonCXP3cRrp7Yp3RHL0n+naS5pTZYbkvrPzSmM/GtIbbC+B57FJmtYZmNMstOpzlTVxSzDmHSacyrG7/JyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138578; c=relaxed/simple;
	bh=vNaYPS7ASBrra6xgZFkyEYLRFDpLghhkvoE1/Qqtwc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiyTtMnlDE4oqQPH/Qie++86lOMSznGy4ghqkuYA0Ghebi7PM6Ocqy6TOAv0vAIDodw1ghlHutjFln2KM9ySS6K99l/uEVH3t2tvi1fQMqr1V0Yuti4xNS+cfhtX+CnP8dnCf886bufgI3Cp5rPrUCAdx7QvwtUW32ITlVTh3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f7BVfJNf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f7BVfJNf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAVi2W3085603;
	Wed, 19 Aug 2026 11:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VhrjR7Dvibkc/tY2r/d68B7h17kDTS
	CK/BgHhTQHldk=; b=f7BVfJNfV545ICdvgTLAj3ZfGE8Lvu83qnNSup7fBwsZqk
	LF54wUVYrHhwwOPyMqBKTl2qDxjVZN4g1ZUtTG3mL027hARZMJLEiDxKph56rqLv
	UGdTaLCO47d0ZIJoZwMzc6Y6bc1cbiWcXYXm4F8A1mVFWseIqLl+1MiZxL7kgt2g
	1gb77NRyu/UeXLlVXGgWjwDr020jxWLdYD7ya6DkRONqC/WPfV5wuvC7qDZIYhKP
	/r0gaRRtmLDa5Lmz4rNhFsGCnbcJWDiovY3vK/Jcehioz58p4SFphWG3/OPUG4et
	0nY9WexJ/2SSH+RWN5845VNLENg4EO4HULJqTdng==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu43888-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:22:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JBBNUo021770;
	Wed, 19 Aug 2026 11:22:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw8qfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:22:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JBMpJW47055106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 11:22:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D0222004B;
	Wed, 19 Aug 2026 11:22:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4341F20049;
	Wed, 19 Aug 2026 11:22:51 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Aug 2026 11:22:51 +0000 (GMT)
Date: Wed, 19 Aug 2026 13:22:50 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Fix fail path in crst_table_upgrade()
Message-ID: <9e707e9c-2da5-4325-9bf3-b41aefb2f8ab-agordeev@linux.ibm.com>
References: <20260811121316.2622460-1-agordeev@linux.ibm.com>
 <20260811141203.12308B7d-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811141203.12308B7d-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4NSBTYWx0ZWRfXw8gtIIbYoAKA
 9WT55qNS+KAWyXqXG7PptrcK2tQn2Qu1mi6YiBDhGkSE5ewiAuZjUjt95I0Ojy96qZEhSJjw8Ip
 4HY0CP7lz5iJPNOnQA4daND2RgXSlF4=
X-Proofpoint-GUID: veCJnSX8UJ4GnSxBgynb19oHvKeB3W8G
X-Proofpoint-ORIG-GUID: veCJnSX8UJ4GnSxBgynb19oHvKeB3W8G
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a859210 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=hJ7KTuLPrbn1ANyxZ0cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4NSBTYWx0ZWRfXwCrBTcoa/SQI
 MOaCTVEcqYKvdkUp08O9SnUsItZbNZsa2RUs1q9MvE4s9QVg2RF/QA+lQFSaaq0T4LmCxQjS4cC
 KFvIwogygF2RyWSGoZmwpfGZ909W9edy2xxs8V8YP8tE2IQUNqr1dEbMfGv0X5pyhYZWbvyvIa0
 XAWYq9utW6G0mRCmuaRcD5gp6PlJGk8Yj2gMSBBWmFb0muFiVK62xglzcJmx2yQcwAC9rXml1L4
 3uV236Wy1asXLExinVtnw3gsC4ljv/g4jsCYWxhnWj7vs1tAFKXnqcyqoNhoy+YiWRF0Vlmeo6j
 rcVB7ROfMsA+MMcF7gA2s+z7FiZgA3SCWwfsQXA6GV+eN0Edf4waTDAmsZy+uoTkoXlx9m8AI5P
 Lr7nLdxnuGbPdQsWtYnOr91vzzwB+A0ZNR1BEK3twtN2UEXz1UI5spEsxQ0/IDJI2WskN+W+t4U
 y3/dQ2EB4YLo3qmAYEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190085

On Tue, Aug 11, 2026 at 04:12:03PM +0200, Heiko Carstens wrote:
> On Tue, Aug 11, 2026 at 02:13:16PM +0200, Alexander Gordeev wrote:
> > On a 4-to-5 level upgrade (unlike 3-to-5) p4d local variable
> > stays NULL. If the pgd allocation then fails, the fault code
> > path calls pagetable_dtor(virt_to_ptdesc(p4d)) with NULL.
> > 
> > Fixes: 502269ab98b5 ("s390/mm: add missing ctor/dtor on page table upgrade")
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  arch/s390/mm/pgalloc.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> > index 9610770fcf6d..87a8bdb3e51e 100644
> > --- a/arch/s390/mm/pgalloc.c
> > +++ b/arch/s390/mm/pgalloc.c
> > @@ -69,14 +69,19 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
> >  	if (asce_limit == _REGION2_SIZE) {
> >  		p4d = crst_table_alloc(mm);
> >  		if (unlikely(!p4d))
> > -			goto err_p4d;
> > +			return -ENOMEM;
> >  		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
> >  		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
> >  	}
> >  	if (end > _REGION1_SIZE) {
> >  		pgd = crst_table_alloc(mm);
> > -		if (unlikely(!pgd))
> > -			goto err_pgd;
> > +		if (unlikely(!pgd)) {
> > +			if (p4d) {
> > +				pagetable_dtor(virt_to_ptdesc(p4d));
> > +				crst_table_free(mm, p4d);
> > +			}
> > +			return -ENOMEM;
> > +		}
> >  		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
> >  		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
> >  	}
> > @@ -106,12 +111,6 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
> >  	on_each_cpu(__crst_table_upgrade, mm, 0);
> >  
> >  	return 0;
> > -
> > -err_pgd:
> > -	pagetable_dtor(virt_to_ptdesc(p4d));
> > -	crst_table_free(mm, p4d);
> > -err_p4d:
> > -	return -ENOMEM;
> >  }
> 
> Imho this makes the code even more uglier than it is/was. This is also yet
> another bug which is/was only possible after loop unrolling happened with
> [1]. Another bug, which would not have been possible without the rework back
> then, is [2].
> 
> So I would _much_ rather prefer to go back to what we had with [1], of course
> including the additional dtor/ctor code. But that code was much more readable
> compared to what we have now, especially considering the additional fix which
> is proposed now.

Frankly, to me personally the old version is more difficult to read.
In addition, in case of 3-5 upgrade on 4-5 allocation failure it has
(a) 4-level table leak and (b) useless 3-4 upgrade.

Should all of those get fixed, I doubt the end result will look as
simple as the original version. But I can try if you insist.

> [1] 31932757c612 ("s390/mm: optimize page table upgrade routine")
> [2] b5efb63acf7b ("s390/mm: Add NULL pointer check to crst_table_free() base_crst_free()")

Thanks!
