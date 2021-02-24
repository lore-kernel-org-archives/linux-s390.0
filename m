Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3555C433E0
	for <linux-s390@archiver.kernel.org>; Wed, 24 Feb 2021 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AE164F07
	for <linux-s390@archiver.kernel.org>; Wed, 24 Feb 2021 16:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhBXQrR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:47:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28306 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235168AbhBXQrO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Feb 2021 11:47:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OGapVn077678;
        Wed, 24 Feb 2021 11:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=vxPLVSafA+rrqEMdv9yR3L6N5QcyTEEVsLcIAajGaNs=;
 b=L2qu5y627/YwWwRl4AJkRQp0zeI1skeWgrs/7tUwldzerSPZliq2U3nZQsFdeCqhsqnw
 nOLNz1JhnKlhKD6PTBhLUjreQ2C46eOjvV2wuiXJPF5ehsOwXn2mg268PyVjdDK6eDbN
 wM9Z6Fh/bhzTOkg7uS8z3yjQTTX67iMdDAUsvG9ZhPSTvYYDvpgoBp4McuOiQ7ZdZKDg
 BMumuWcuNOTDf8CZYXm09P+4RqZCrpzqpP1FgeJGUQQMrBSQCZIbzrD13nua78Wb65vE
 V27pyOJMHpLy06mXJR0lYJpgud+f2PxDqJMNab2TEpKVc+Ravzicytrqzj6NaVGKmY2h VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wma7fg7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 11:46:15 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OGbVU8084599;
        Wed, 24 Feb 2021 11:46:15 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wma7fg72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 11:46:15 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OGil0J017520;
        Wed, 24 Feb 2021 16:46:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 36tt289xs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 16:46:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OGjvv715466786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 16:45:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50DADA4054;
        Wed, 24 Feb 2021 16:46:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2FD0A4065;
        Wed, 24 Feb 2021 16:46:09 +0000 (GMT)
Received: from thinkpad (unknown [9.171.7.180])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 24 Feb 2021 16:46:09 +0000 (GMT)
Date:   Wed, 24 Feb 2021 17:46:08 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        shu wang <malate_wangshu@hotmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/5] hugetlb: add hugetlb helpers for soft dirty
 support
Message-ID: <20210224174608.7c9ca5ed@thinkpad>
In-Reply-To: <20210217162415.GA6519@xz-x1>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
        <20210211000322.159437-2-mike.kravetz@oracle.com>
        <20210217162415.GA6519@xz-x1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_06:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 17 Feb 2021 11:24:15 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Feb 10, 2021 at 04:03:18PM -0800, Mike Kravetz wrote:
> > Add interfaces to set and clear soft dirty in hugetlb ptes.  Make
> > hugetlb interfaces needed for /proc clear_refs available outside
> > hugetlb.c.
> > 
> > arch/s390 has it's own version of most routines in asm-generic/hugetlb.h,
> > so add new routines there as well.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  arch/s390/include/asm/hugetlb.h | 30 ++++++++++++++++++++++++++++++
> >  include/asm-generic/hugetlb.h   | 30 ++++++++++++++++++++++++++++++
> >  include/linux/hugetlb.h         |  1 +
> >  mm/hugetlb.c                    | 10 +---------
> >  4 files changed, 62 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> > index 60f9241e5e4a..b7d26248fb1c 100644
> > --- a/arch/s390/include/asm/hugetlb.h
> > +++ b/arch/s390/include/asm/hugetlb.h
> > @@ -105,6 +105,11 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
> >  	return pte_mkdirty(pte);
> >  }
> >  
> > +static inline pte_t huge_pte_mkyoung(pte_t pte)
> > +{
> > +	return pte_mkyoung(pte);
> > +}
> > +
> >  static inline pte_t huge_pte_wrprotect(pte_t pte)
> >  {
> >  	return pte_wrprotect(pte);
> > @@ -115,9 +120,34 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
> >  	return pte_modify(pte, newprot);
> >  }
> >  
> > +static inline bool huge_pte_soft_dirty(pte_t pte)
> > +{
> > +	return pte_soft_dirty(pte);
> > +}
> > +
> > +static inline pte_t huge_pte_clear_soft_dirty(pte_t pte)
> > +{
> > +	return pte_clear_soft_dirty(pte);
> > +}
> > +
> > +static inline pte_t huge_pte_swp_clear_soft_dirty(pte_t pte)
> > +{
> > +	return pte_swp_clear_soft_dirty(pte);
> > +}
> > +
> 
> Indeed asm/hugetlb.h of s390 didn't include asm-generic/hugetlb.h as what was
> normally done by asm/hugetlb.h of other archs.  Do you know why it's special?
> E.g. huge_pte_wrprotect() of s390 version is actually the same of the default
> version.

That is for "historical reasons", and yes, it doesn't look like it makes a lot
of sense any more.

The history part:

When s390 hugetlb support was introduced in 2008, there was no
asm-generic/hugetlb.h, and also no huge_pte_xxx primitives at all. They were
actually introduced because of s390, since the hugetlb common code did not
make any difference between pte and pmd types, see commit 7f2e9525ba55
("hugetlbfs: common code update for s390").

Back then, only few architectures with hugetlb support existed, and instead
of creating an asm-generic/hugetlb.h, I just added the primitives to the
individual arch include files.

5 years later, more huge_pte_xxx primitives were needed, and it appeared
to make sense to introduce asm-generic/hugetlb.h, see commit 106c992a5ebe
("mm/hugetlb: add more arch-defined huge_pte functions"). However, for s390,
all those primitives still needed special care, so we were / are the only
architecture not including that.

Then we fundamentally changed the way how we deal with that "hugetlb code
is treating pmds as ptes" issue. Instead of caring about that in all
huge_pte_xxx primitives, huge_ptep_get() will now return a nicely faked pte
for s390, i.e. something that looks like a pte would look like, and not the
real pmd/pud value. With that, hugetlb code can do all its pte handling on
that fake pte, and the conversion back to a proper pmd/pud is done in
set_huge_pte().

This is also why it will go very wrong on s390 if you directly look at
or manipulate a huge pte (i.e. pmd or pud) via its pointer, and not use
huge_ptep_get() and set_huge_pte().

Since that change, most of the huge_pte_xxx primitives are now the default
pte_xxx primitives also for s390, but apparently nobody thought about moving
to asm-generic/hugetlb.h.

> When I looked at the huge_pte_wrprotect() I also see that there seems to have
> no real user of __HAVE_ARCH_HUGE_PTE_WRPROTECT.  Not sure whether it can be
> dropped.  My gut feeling is that s390 should also include asm-generic/hugetlb.h
> but only redefine the helper only if necessary, since I see no point defining
> the same helper multiple times.

Your gut feeling seems right, I will look into cleaning that up. But don't
let that keep you from adding things there for now.

The __HAVE_ARCH_HUGE_PTE_WRPROTECT is not related to any s390-specifics,
I think it was already unused when it was introduced with commit c4916a008665a
("hugetlb: introduce generic version of huge_pte_wrprotect"). Maybe it was
just added for completeness or future support, because the corresponding
__HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT did / does have some users.
