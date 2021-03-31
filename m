Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66FCC433C1
	for <linux-s390@archiver.kernel.org>; Wed, 31 Mar 2021 11:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9214B61994
	for <linux-s390@archiver.kernel.org>; Wed, 31 Mar 2021 11:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhCaLs6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:48:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235246AbhCaLsr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Mar 2021 07:48:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VBYVSk138586;
        Wed, 31 Mar 2021 07:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CtlaEh0bThhl9VNepNhx7T4hpXb2VWye1XWaiwj4iIs=;
 b=JQCVWETbxX8sbSdIRFuQ2z/wLP+f71a51g2CoIR94cJV27VpRiAZQyh3JEUCykNCm2s4
 19LVic/A9O8iQskVVRUP7+t8KfqcQdd/ufvgc8uhzBpDFuz5GL1iubTKUFTGuGcZBeOS
 XFDRSbisRtyouLialbz0I0nG82hmzKomVprMmJi3oBv9xy5+11GOEl2wazaVP4b75bze
 Zr+r+n6XauTtMngKpGrzGQndiO3zTpn3dFmtP+NYY9xNCYychVyVxkrLHz04E28B0qn4
 504jbyd0LGSgt/JQHM8YR/b620o5Vho1vwQgSAqP1wPgkjE3CJTJRALzeQDtZvAsRetE TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mn0w68nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 07:47:36 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12VBaGZW146128;
        Wed, 31 Mar 2021 07:47:35 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mn0w68n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 07:47:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12VBgGb6013453;
        Wed, 31 Mar 2021 11:47:33 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 37mawjrhh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 11:47:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12VBlAET30277966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 11:47:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7BFFAE057;
        Wed, 31 Mar 2021 11:47:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3296FAE053;
        Wed, 31 Mar 2021 11:47:29 +0000 (GMT)
Received: from thinkpad (unknown [9.171.76.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 31 Mar 2021 11:47:29 +0000 (GMT)
Date:   Wed, 31 Mar 2021 13:47:27 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA
 hinting fault
Message-ID: <20210331134727.47bc1e6d@thinkpad>
In-Reply-To: <CAHbLzkrYd+5L8Ep+b83PkkFL_QGQe_vSAk=erQ+fvC6dEOsGsw@mail.gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
        <20210330164200.01a4b78f@thinkpad>
        <CAHbLzkrYd+5L8Ep+b83PkkFL_QGQe_vSAk=erQ+fvC6dEOsGsw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JhmfzsLpl6Eyz4qmbSFiYgozawPRCTy2
X-Proofpoint-ORIG-GUID: mC8g5vCKeKkxGAl85C6v5SMv_dys8Rsw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_03:2021-03-30,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=573 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 30 Mar 2021 09:51:46 -0700
Yang Shi <shy828301@gmail.com> wrote:

> On Tue, Mar 30, 2021 at 7:42 AM Gerald Schaefer
> <gerald.schaefer@linux.ibm.com> wrote:
> >
> > On Mon, 29 Mar 2021 11:33:06 -0700
> > Yang Shi <shy828301@gmail.com> wrote:
> >  
> > >
> > > When the THP NUMA fault support was added THP migration was not supported yet.
> > > So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
> > > THP migration has been supported so it doesn't make too much sense to still keep
> > > another THP migration implementation rather than using the generic migration
> > > code.  It is definitely a maintenance burden to keep two THP migration
> > > implementation for different code paths and it is more error prone.  Using the
> > > generic THP migration implementation allows us remove the duplicate code and
> > > some hacks needed by the old ad hoc implementation.
> > >
> > > A quick grep shows x86_64, PowerPC (book3s), ARM64 ans S390 support both THP
> > > and NUMA balancing.  The most of them support THP migration except for S390.
> > > Zi Yan tried to add THP migration support for S390 before but it was not
> > > accepted due to the design of S390 PMD.  For the discussion, please see:
> > > https://lkml.org/lkml/2018/4/27/953.
> > >
> > > I'm not expert on S390 so not sure if it is feasible to support THP migration
> > > for S390 or not.  If it is not feasible then the patchset may make THP NUMA
> > > balancing not be functional on S390.  Not sure if this is a show stopper although
> > > the patchset does simplify the code a lot.  Anyway it seems worth posting the
> > > series to the mailing list to get some feedback.  
> >
> > The reason why THP migration cannot work on s390 is because the migration
> > code will establish swap ptes in a pmd. The pmd layout is very different from
> > the pte layout on s390, so you cannot simply write a swap pte into a pmd.
> > There are no separate swp primitives for swap/migration pmds, IIRC. And even
> > if there were, we'd still need to find some space for a present bit in the
> > s390 pmd, and/or possibly move around some other bits.
> >
> > A lot of things can go wrong here, even if it could be possible in theory,
> > by introducing separate swp primitives in common code for pmd entries, along
> > with separate offset, type, shift, etc. I don't see that happening in the
> > near future.  
> 
> Thanks a lot for elaboration. IIUC, implementing migration PMD entry
> is *not* prevented from by hardware, it may be very tricky to
> implement it, right?

Well, it depends. The HW is preventing proper full-blown swap + migration
support for PMD, similar to what we have for PTE, because we simply don't
have enough OS-defined bits in the PMD. A 5-bit swap type for example,
similar to a PTE, plus the PFN would not be possible.

The HW would not prevent a similar mechanism in principle, i.e. we could
mark it as invalid to trigger a fault, and have some magic bits that tell
the fault handler or migration code what it is about.

For handling migration aspects only, w/o any swap device or other support, a
single type bit could already be enough, to indicate read/write migration,
plus a "present" bit similar to PTE. But even those 2 bits would be hard to
find, though I would not entirely rule that out. That would be the tricky
part.

Then of course, common code would need some changes, to reflect the
different swap/migration (type) capabilities of PTE and PMD entries.
Not sure if such an approach would be acceptable for common code.

But this is just some very abstract and optimistic view, I have not
really properly looked into the details. So it might be even more
tricky, or not possible at all.

> 
> >
> > Not sure if this is a show stopper, but I am not familiar enough with
> > NUMA and migration code to judge. E.g., I do not see any swp entry action
> > in your patches, but I assume this is implicitly triggered by the switch
> > to generic THP migration code.  
> 
> Yes, exactly. The migrate_pages() called by migrate_misplaced_page()
> takes care of everything.
> 
> >
> > Could there be a work-around by splitting THP pages instead of marking them
> > as migrate pmds (via pte swap entries), at least when THP migration is not
> > supported? I guess it could also be acceptable if THP pages were simply not
> > migrated for NUMA balancing on s390, but then we might need some extra config
> > option to make that behavior explicit.  
> 
> Yes, it could be. The old behavior of migration was to return -ENOMEM
> if THP migration is not supported then split THP. That behavior was
> not very friendly to some usecases, for example, memory policy and
> migration lieu of reclaim (the upcoming). But I don't mean we restore
> the old behavior. We could split THP if it returns -ENOSYS and the
> page is THP.

OK, as long as we don't get any broken PMD migration entries established
for s390, some extra THP splitting would be acceptable I guess.
