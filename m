Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA8219A63;
	Fri, 24 Jan 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707124; cv=none; b=bQijN87YpQee8JYEKhGYDLutu0Bs5AhLPiDDbrrhUWtA1Tf+P4JcWyrnBLyEbguYL6JA+QtT2fZSBMQZ1PyB44+5Ycs5vqkdMX2/ZOa9JpdDJ4WsW3hOujqCE10Ud/pI6e90uFcVYlymvcMwJJDcDO+uv4lN/Y2ZstUK2wEth7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707124; c=relaxed/simple;
	bh=2ol3g4zEnotMn+Tqc05SKX3jZbyRPlPEFPsyuF4RVfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAmjsEkTbhGVtoYU+jjt4Ji3/9b/zyL2mKduv9DMK4ePB6TD3D7Ub7g/Ylr20IeLNjvK6k5GWqLyouXzFbfAuOJnszmvJdO9ewshesToSNfVW/hEao37W+bNf9Qv1GAV1upWuXGtS730ixB7UM14BFH2Nl03XOltGBMFskcP7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pPut160S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pPut160S"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O19IQW020460;
	Fri, 24 Jan 2025 08:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Q5Xu11cNFIfbQr0SG+f2Y24NLZ2Zkc
	2hL7wTxnSGqPk=; b=pPut160SXJKL8arhgbivD9guU4q8i+F5eCdmfbkbsmmjlY
	ZKYPc9X9/PWfV4s2Tfgt8/Z8AjwSEUOa6plHRAVAAJaLl/tbsm1vRg+nmMMnZNex
	nY3h8QSIJSPBy0+lKJRbD5QM6iqlPQTxN26hRyyumlpWLjaD8D9nSopxEn1edDGW
	jZ0FDPUZgKkL6LSqQI4biqIc2wQTL/fyOiFCVRvotx/ku8s9x08oqdqUjP5ZZ6Ds
	T8U70YXLoRTgyGY4zLyqVuzTQVP5EWs2etuKd5gmTZLpWqDOodRIcCcDwUiaAIQm
	pRyKqvcM55+xvWwKdCDb+a+Xurc/n9yiS1U5MZNg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c0x92muw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 08:25:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8AWWr022370;
	Fri, 24 Jan 2025 08:25:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4kjdfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 08:25:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50O8P1F955771440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 08:25:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 544D6202B2;
	Fri, 24 Jan 2025 08:25:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FA72202B3;
	Fri, 24 Jan 2025 08:25:00 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.25.208])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jan 2025 08:25:00 +0000 (GMT)
Date: Fri, 24 Jan 2025 09:24:58 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
Message-ID: <Z5NOWvrOln4T0RCH@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250123160349.200154-1-agordeev@linux.ibm.com>
 <f1ff18a2-1b5e-4e9a-869b-9785faabf24d@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ff18a2-1b5e-4e9a-869b-9785faabf24d@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eN9lQ0YDGQGZRKbOwJ7SK2dPpZVVNMD9
X-Proofpoint-ORIG-GUID: eN9lQ0YDGQGZRKbOwJ7SK2dPpZVVNMD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=755 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240057

On Fri, Jan 24, 2025 at 08:58:07AM +0100, Kevin Brodsky wrote:

Kevin,
...
> Thank you for putting together this patch! I was completely unaware of
> this "upgrade" path on s390.
...
> > diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> > index a4e761902093..d33f55b7ee98 100644
> > --- a/arch/s390/mm/pgalloc.c
> > +++ b/arch/s390/mm/pgalloc.c
> > @@ -88,12 +88,14 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
> >  		if (unlikely(!p4d))
> >  			goto err_p4d;
> >  		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
> > +		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
> 
> This block seems to be equivalent to p4d_alloc_one(), maybe it would be
> preferable to just call p4d_alloc_one() here to avoid further mismatches
> in the future (and reduce duplication)?

Yes, I wanted to do exactly that (together with p4d_free() you noticed),
but then the whole thing with open coded pagetable_pgd_ctor() below gets
inconsistent. I would prefer to keep it this way as of now.

> >  	}
> >  	if (end > _REGION1_SIZE) {
> >  		pgd = crst_table_alloc(mm);
> >  		if (unlikely(!pgd))
> >  			goto err_pgd;
> >  		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
> > +		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
> 
> I was hoping this might be equivalent to pgd_alloc() but it does not
> include a call to crst_table_init(). Since adding it would be apparently
> undesirable (having read the other thread), it seems reasonable to add
> the explicit constructor call.

We were thinking about a follow-up cleanup that addresses it all, but this
patch is a targeted fix to catch up your and Qi Zheng series in the still
open merge window.

> >  	}
> >  
> >  	spin_lock_bh(&mm->page_table_lock);
> > @@ -130,6 +132,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
> >  	return 0;
> >  
> >  err_pgd:
> > +	pagetable_dtor(virt_to_ptdesc(p4d));
> >  	crst_table_free(mm, p4d);
> 
> Similarly, this could be a call to p4d_free().
> 
> - Kevin
> 
> >  err_p4d:
> >  	return -ENOMEM;

Thanks for the review!
