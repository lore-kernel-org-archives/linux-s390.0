Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50306C433B4
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A07061288
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbhDLNhw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:37:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238958AbhDLNht (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Apr 2021 09:37:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CDXkBi103776;
        Mon, 12 Apr 2021 09:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=t/LgmIg+oXyDm8fg/J+4/mJ1k+zrQk3JCCZKCPjrcC4=;
 b=oWl9OJRynpk9S7iF6DxkEz9B0Gc8y3FEj4Rt94rBI+FW5rpvx8xY+bQjya6EroErsxYT
 9cUKedOhdFCBsB7WxmHBhIXNdTexGtdSp7nSkJISzcO/39h2lW8VeqyS2grDhwt6YZ+l
 CAEuxE+aKPCqEix+hVykP8kDJaqXVZp604OmPhMU8d5fLV1vz53Cm++9p1yNNoVxrzS4
 P83PUjdvsR2yAmGCADDbuCBiuEyIa1TrqtwLsMXQyg1PRRkWRwPRpcZ8mvl2bprdxXG7
 9dA/bTZmc3VjWzirswd7Fm6kqSMTNQjMDXztpz+Fe+rA2NQpuUWQeesC+5Powd5p74Jj Zg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37usjb4adh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 09:37:25 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CDXj2N020766;
        Mon, 12 Apr 2021 13:37:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 37u3n8sun4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 13:37:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CDbLfB3015348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 13:37:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D666F11C05B;
        Mon, 12 Apr 2021 13:37:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C85811C050;
        Mon, 12 Apr 2021 13:37:21 +0000 (GMT)
Received: from ibm-vm (unknown [9.145.2.56])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 13:37:21 +0000 (GMT)
Date:   Mon, 12 Apr 2021 15:37:18 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org
Subject: Re: Inaccessible pages & folios
Message-ID: <20210412153718.06e30c9c@ibm-vm>
In-Reply-To: <20210412124341.GJ2531743@casper.infradead.org>
References: <20210409194059.GW2531743@casper.infradead.org>
        <20210412141809.36c349d6@ibm-vm>
        <20210412124341.GJ2531743@casper.infradead.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RLJtcaL5Qrf1CPL9D3cV1ZtlRX8jdmiM
X-Proofpoint-GUID: RLJtcaL5Qrf1CPL9D3cV1ZtlRX8jdmiM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_10:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120091
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 12 Apr 2021 13:43:41 +0100
Matthew Wilcox <willy@infradead.org> wrote:

[...]

> > For the rename case, how would you handle gup.c? =20
>=20
> At first, I'd turn it into
> arch_make_folio_accessible(page_folio(page));

that's tricky. what happens if some pages in the folio cannot be made
accessible?

also, I assume you keep the semantic difference between get_page and
pin_page? that's also very important for us

> Eventually, gup.c needs to become folio-aware.  I haven't spent too
> much time thinking about it, but code written like this:
>=20
>                 page =3D pte_page(pte);
>                 head =3D try_grab_compound_head(page, 1, flags);
>                 if (!head)
>                         goto pte_unmap;
>                 if (unlikely(pte_val(pte) !=3D pte_val(*ptep))) {
>                         put_compound_head(head, 1, flags);
>                         goto pte_unmap;
>                 }
>                 VM_BUG_ON_PAGE(compound_head(page) !=3D head, page);
>=20
> is just crying out for use of folios.  Also, some of the gup callers
> would much prefer to work in terms of folios than individual struct
> pages (imagine an RDMA adapter that wants to pin several gigabytes of
> memory that's allocated using hugetlbfs for example).
>=20
> > Consider that arch_make_page_accessible deals (typically) with KVM
> > guest pages. Once you bundle up the pages in folios, you can have
> > different pages in the same folio with different properties. =20
>=20
> So what you're saying is that the host might allocate, eg a 1GB folio
> for a guest, then the guest splits that up into smaller chunks (eg
> 1MB), and would only want one of those small chunks accessible to the
> hypervisor?

qemu will allocate a big chunk of memory, and I/O would happen only on
small chunks (depending on what the guest does). I don't know how swap
and pagecache would behave in the folio scenario.

Also consider that currently we need 4k hardware pages for protected
guests (so folios would be ok, as long as they are backed by small
pages)

How and when are folios created actually?

is there a way to prevent creation of multi-page folios?

> > In case of failure, you could end up with a folio with some pages
> > processed and some not processed. Would you stop at the first error?
> > What would the state of the folio be? On s390x we use the PG_arch_1
> > bit to mark secure pages, how would that work with folios?
> >=20
> > and how are fault handlers affected by this folio conversion? would
> > they still work on pages, or would that also work on folios? on
> > s390x we use the arch_make_page_accessible function in some fault
> > handlers. =20
>=20
> Folios can be mapped into userspace at an unaligned offset.  So we
> still have to work in pages, at least for now.  We might have some
> optimised path for aligned folios later.
>=20
> > a possible approach maybe would be to keep the _page variant, and
> > add a _folio wrapper around it =20
>=20
> Yes, we can do that.  It's what I'm currently doing for
> flush_dcache_folio().

where would the page flags be stored? as I said, we really depend on
that bit to be set correctly to prevent potentially disruptive I/O
errors. It's ok if the bit overindicates protection (non-protected
pages can be marked as protected), but protected pages must at all
times have the bit set.

the reason why this hook exists at all, is to prevent secure pages from
being accidentally (or maliciously) fed into I/O

> > for s390x the PG_arch_1 is very important to prevent protected pages
> > from being fed to I/O, as in that case Very Bad Things=E2=84=A2 would
> > happen.
> >=20
> > sorry for the wall of questions, but I actually like your folio
> > approach and I want to understand it better, so we can find a way to
> > make everything work well together =20
>=20
> Great!
>=20
> > > PS: The prototype is in gfp.h.  That's not really appropriate;
> > > gfp.h is about allocating memory, and this call really has
> > > nothing to do with memory allocation.  I think mm.h is a better
> > > place for it, if you can't find a better header file than that. =20
> >=20
> > I had put it there because arch_alloc_page and arch_free_page are
> > also there, and the behaviour, from a kernel point of view, is
> > similar (unaccessible/unallocated pages will trigger a fault).=20
> >=20
> > I actually do not have a preference regarding where the prototype
> > lives, as long as everything works. If you think mm.h is more
> > appropriate, go for it :) =20
>=20
> Heh, I see how you got there from the implementors point of view ;-)
> I'll move it ...

