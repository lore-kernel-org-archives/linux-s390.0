Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB24EC43461
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 12:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B563261278
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 12:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhDLMSx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:18:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238378AbhDLMSv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Apr 2021 08:18:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CC4D8B037379;
        Mon, 12 Apr 2021 08:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ABwWBexBJyV8j58hgND3E1g4f7pGvXfOcmLNOf4iOq0=;
 b=dqnmH4TOHLJjKyRtYNh+yFlAsqOURct+uwirvsoTe74xoWEDOxpwmJ00ur4PzGDAZhzs
 386KM0Tcx2sD4pZy1HO19bWbNBrOrGfeDaIQASwl1B0V8LRYw8Zq+xBDN2GzzplriqVE
 wIMTeYS4QXbUTtyMs3Mp95pQwlRDY5i28iA6j59qnqszEV8YxcK20l3QKxaqqtVG+Spl
 zHOWQhRBmruQKDzdCUv/UN0W5UOtsRSGO5Og1vUyG52Uue0CNhL0u5zHKEGbyNaku7Hy
 1Q1lEgRVnjvD9qZREM36F1BqqQapjO5kj0inbH8hH3RNKRZmGGbr/FAlDrovn8ToMM0V WQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vkddx838-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 08:18:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CCI77d011290;
        Mon, 12 Apr 2021 12:18:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 37u39hhswp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 12:18:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CCIBlP46137786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 12:18:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EE95AE045;
        Mon, 12 Apr 2021 12:18:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 470B5AE053;
        Mon, 12 Apr 2021 12:18:11 +0000 (GMT)
Received: from ibm-vm (unknown [9.145.2.56])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 12:18:11 +0000 (GMT)
Date:   Mon, 12 Apr 2021 14:18:09 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org
Subject: Re: Inaccessible pages & folios
Message-ID: <20210412141809.36c349d6@ibm-vm>
In-Reply-To: <20210409194059.GW2531743@casper.infradead.org>
References: <20210409194059.GW2531743@casper.infradead.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dQPiHhALfHWzcL4npjuxoyQdiGNFh8MQ
X-Proofpoint-ORIG-GUID: dQPiHhALfHWzcL4npjuxoyQdiGNFh8MQ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_09:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120083
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 9 Apr 2021 20:40:59 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> Hi Claudio,
>=20
> I'm working on making the page cache manage memory in larger chunks
> than PAGE_SIZE [1] [2].  In doing so, I came across this call that

yes, I had read the LWN article with great interest

> you added:
>=20
> @@ -2807,6 +2807,13 @@ int __test_set_page_writeback(struct page
> *page, bool keep_write) inc_zone_page_state(page,
> NR_ZONE_WRITE_PENDING); }
>         unlock_page_memcg(page);
> +       access_ret =3D arch_make_page_accessible(page);
>=20
> I'm going to change __test_set_page_writeback() to take a folio [3]
> and now I'm wondering what interface you'd like to use.  My
> preference would be to rename arch_make_page_accessible() to
> arch_make_folio_accessible() and pass a folio, at which time you
> would make the entire folio (however many pages might be in it)
> accessible.  If you would rather, we can leave the interface as
> arch_make_page_accessible(), in which case we'll just call it N times
> in __test_set_page_writeback() (and I won't need to touch gup.c).

For the rename case, how would you handle gup.c?

Consider that arch_make_page_accessible deals (typically) with KVM
guest pages. Once you bundle up the pages in folios, you can have
different pages in the same folio with different properties.

In case of failure, you could end up with a folio with some pages
processed and some not processed. Would you stop at the first error?
What would the state of the folio be? On s390x we use the PG_arch_1 bit
to mark secure pages, how would that work with folios?

and how are fault handlers affected by this folio conversion? would
they still work on pages, or would that also work on folios? on s390x
we use the arch_make_page_accessible function in some fault handlers.

a possible approach maybe would be to keep the _page variant, and add a
_folio wrapper around it

for s390x the PG_arch_1 is very important to prevent protected pages
from being fed to I/O, as in that case Very Bad Things=E2=84=A2 would happe=
n.

sorry for the wall of questions, but I actually like your folio
approach and I want to understand it better, so we can find a way to
make everything work well together

> Let me know what you want.
>=20
> [1] https://lwn.net/Articles/849538/
> [2]
> https://lore.kernel.org/linux-mm/20210409185105.188284-1-willy@infradead.=
org/
> [3]
> https://git.infradead.org/users/willy/pagecache.git/commitdiff/85297eb08f=
1b034b9652ea63dd053e3be4d7de7f
>=20
> PS: The prototype is in gfp.h.  That's not really appropriate; gfp.h
> is about allocating memory, and this call really has nothing to do
> with memory allocation.  I think mm.h is a better place for it, if
> you can't find a better header file than that.

I had put it there because arch_alloc_page and arch_free_page are also
there, and the behaviour, from a kernel point of view, is similar
(unaccessible/unallocated pages will trigger a fault).=20

I actually do not have a preference regarding where the prototype
lives, as long as everything works. If you think mm.h is more
appropriate, go for it :)

