Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057D1CD219;
	Fri,  6 Dec 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477122; cv=none; b=AePRJm3x55whjoCZCTo+tMoqzDHVOzXsElNKfyYjjGJeqlD5vgc7dGeu8Tt5ahksCiJOrzOkkFQM5suwNGWbrdnMz9TlviL/hGyGZ/cddLcpScQ1eNwmEHqTdR8XyuMA7ZzdwUznc+VurPs61zA9bBfT8XPd263XwaxGwQ/660w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477122; c=relaxed/simple;
	bh=WkxUZmi3pnNlkbYCoGcUcUNXIVcAzpOl3fQlVAgSdnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc8hDBMoSszwAakeR77RaMqIJ03qJZNGFXCGPbPZ4QZTWQm4Mo2yRzgAXRvXnWpJQBoQGRK8mw6pOp1ub18uH9kShm8kq4skFau8kcbb6cKxjCmem+C4o5pfyP4pAXt+nS0Uq7KBvlN+PLWNriuOBlONYDheGYGatEo91K6XjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QzLceQVi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QzLceQVi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5KUr8a011023;
	Fri, 6 Dec 2024 09:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RZS6F1TKgzJqFxis0CrZzfpp//nfgL
	kDyjeydfC6dVc=; b=QzLceQVio46n4VJnVjsTBKG7JWiYjMOnX94zbJNo9HHaEn
	Bg6zUM+0R8TruDBeTNigXuAs+6XimhS/+fwamln9DpY91ygxV3zn3F2/FnkBU4zp
	GhvtFgTTbYd8aWspcXdXrw6kdeOuuHIk6jEmqi7rAlU0L9+c/RXh7bfhDqwG3F54
	UoMdAYw8c9+y2SboQkbW9jKTdcN5PnY72g9sxDz04U1KwqGUSGAyCBLUN5y+N2zg
	9LHEf2e1VoN8JhbyWCsQxPmsF5GrrYASa+WunSCy0Af9QQ+XxDlqMA0e33aUXl52
	g6naz0zidXpLJqZzhYpJoYAfVw5FUoh0EAkPkqBg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bk99jmtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:25:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B65J76C008622;
	Fri, 6 Dec 2024 09:24:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jwwkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:24:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B69Ot1v10486200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 09:24:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA7E020043;
	Fri,  6 Dec 2024 09:24:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F032320040;
	Fri,  6 Dec 2024 09:24:54 +0000 (GMT)
Received: from osiris (unknown [9.171.17.195])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Dec 2024 09:24:54 +0000 (GMT)
Date: Fri, 6 Dec 2024 10:24:53 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Guillaume Morin <guillaume@morinfr.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Eric Hagberg <ehagberg@janestreet.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <20241206092453.9026-A-hca@linux.ibm.com>
References: <Z1EJssqd93w2erMZ@bender.morinfr.org>
 <20241206045019.GA2215843@thelio-3990X>
 <Z1KLLXpzrDac-oqF@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1KLLXpzrDac-oqF@bender.morinfr.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7EedieBvwZ570EpYYf5NVEvE0HRd2YQh
X-Proofpoint-ORIG-GUID: 7EedieBvwZ570EpYYf5NVEvE0HRd2YQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=539 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060065

On Fri, Dec 06, 2024 at 06:27:09AM +0100, Guillaume Morin wrote:
> On 05 Dec 21:50, Nathan Chancellor wrote:
> > >  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> > > +/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
> > > +static inline bool can_follow_write_pud(pud_t pud, struct page *page,
> > > +					struct vm_area_struct *vma,
> > > +					unsigned int flags)
> > > +{
> > > +	/* If the pud is writable, we can write to the page. */
> > > +	if (pud_write(pud))
> > > +		return true;
> > > +
> > > +	if (!can_follow_write_common(page, vma, flags))
> > > +		return false;
> > > +
> > > +	/* ... and a write-fault isn't required for other reasons. */
> > > +	return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
> > 
> > This looks to be one of the first uses of pud_soft_dirty() in a generic
> > part of the tree from what I can tell, which shows that s390 is lacking
> > it despite setting CONFIG_HAVE_ARCH_SOFT_DIRTY:
> > 
> >   $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper defconfig mm/gup.o
> >   mm/gup.c: In function 'can_follow_write_pud':
> >   mm/gup.c:665:48: error: implicit declaration of function 'pud_soft_dirty'; did you mean 'pmd_soft_dirty'? [-Wimplicit-function-declaration]
> >     665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
> >         |                                                ^~~~~~~~~~~~~~
> >         |                                                pmd_soft_dirty
> > 
> > Is this expected?
> 
> Yikes! It does look like an oversight in the s390 code since as you said
> it has CONFIG_HAVE_ARCH_SOFT_DIRTY and pud_mkdirty seems to be setting
> _REGION3_ENTRY_SOFT_DIRTY. But I'll let the s390 folks opine.
> 
> I don't mind dropping the pud part of the change (even if that's a bit
> of a shame) if it's causing too many issues.

It would be quite easy to add pud_soft_dirty() etc. helper functions
for s390, but I think that would be the wrong answer to this problem.

s390 implements pud_mkdirty(), but it is only used in the context of
HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD, which s390 doesn't support. So
this function should probably be removed from s390's pgtable.h.

Similar the pud_soft_dirty() and friends helper functions should only
be implemented if common code support for soft dirty would exist,
which is currently not the case. Otherwise similar fallbacks like for
pmd_soft_dirty() (-> include/linux/pgtable.h) would also need to be
implemented.

So IMHO the right fix (at this time) seems to be to remove the above
pud part of your patch, and in addition we should probably also drop
the partially implemented pud level soft dirty bits in s390 code,
since that is dead code and might cause even more confusion in future.

Does that make sense?
