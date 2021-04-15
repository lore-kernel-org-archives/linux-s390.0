Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB878C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 09:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A1F61222
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 09:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhDOJ3O (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:29:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230474AbhDOJ3H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Apr 2021 05:29:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F93oM7018448;
        Thu, 15 Apr 2021 05:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fYYSiSybJCyjBG7cY1xtclD406julvU110dchFTKCOw=;
 b=oANYrB/riK5Glq1ifnANe5hCeS4d6mWZRtnyv7Z4n7EmoSmUVtsmZJrv8Sd0BSsoNCYR
 jiipNKa6NCWw188Wq44DEhDRcqbvPRod69hxJ10yPI6yNTDGUgIjhVMggiDpfZGMDZBL
 Mf730753jgQaYEw7xeDK0ZbK/pNc4/ZxQIVlpcuuT8AFGPZMJmWFbBish3z/A4WkhUrr
 RIvjKrINNc+ff9HZuvbTH+eEaZetgGOLi8jrtVeg4R8WvUP5160hZp6OmyYgjO2fwl1E
 y4S8dv634MpULitqEm/61gz24DYwTUxAHLxzJ0DM2jCrWvi0WRgr6y44NcHvfPhxO/Qo Gw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37xfrnnbug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 05:28:21 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13F9SJKB023776;
        Thu, 15 Apr 2021 09:28:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 37u3n8j10k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 09:28:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13F9SHil24445406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 09:28:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9F8AA405B;
        Thu, 15 Apr 2021 09:28:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8128A4054;
        Thu, 15 Apr 2021 09:28:16 +0000 (GMT)
Received: from ibm-vm (unknown [9.145.0.91])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Apr 2021 09:28:16 +0000 (GMT)
Date:   Thu, 15 Apr 2021 11:28:14 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org
Subject: Re: Inaccessible pages & folios
Message-ID: <20210415112814.303f7f02@ibm-vm>
In-Reply-To: <20210412135514.GK2531743@casper.infradead.org>
References: <20210409194059.GW2531743@casper.infradead.org>
        <20210412141809.36c349d6@ibm-vm>
        <20210412124341.GJ2531743@casper.infradead.org>
        <20210412153718.06e30c9c@ibm-vm>
        <20210412135514.GK2531743@casper.infradead.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gXFqvqi7oycuidFou8Eb73-IE3GgCf53
X-Proofpoint-GUID: gXFqvqi7oycuidFou8Eb73-IE3GgCf53
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 12 Apr 2021 14:55:14 +0100
Matthew Wilcox <willy@infradead.org> wrote:

[...]

> 
> I was only thinking about the page cache case ...
> 
>         access_ret = arch_make_page_accessible(page);
>         /*
>          * If writeback has been triggered on a page that cannot be
> made
>          * accessible, it is too late to recover here.
>          */
>         VM_BUG_ON_PAGE(access_ret != 0, page);
> 
> ... where it seems all pages _can_ be made accessible.

yes, for that case it is straightforward

> > also, I assume you keep the semantic difference between get_page and
> > pin_page? that's also very important for us  
> 
> I haven't changed anything in gup.c yet.  Just trying to get the page
> cache to suck less right now.

fair enough :)
 
> > > So what you're saying is that the host might allocate, eg a 1GB
> > > folio for a guest, then the guest splits that up into smaller
> > > chunks (eg 1MB), and would only want one of those small chunks
> > > accessible to the hypervisor?  
> > 
> > qemu will allocate a big chunk of memory, and I/O would happen only
> > on small chunks (depending on what the guest does). I don't know
> > how swap and pagecache would behave in the folio scenario.
> > 
> > Also consider that currently we need 4k hardware pages for protected
> > guests (so folios would be ok, as long as they are backed by small
> > pages)
> > 
> > How and when are folios created actually?
> > 
> > is there a way to prevent creation of multi-page folios?  
> 
> Today there's no way to create multi-page folios because I haven't
> submitted the patch to add alloc_folio() and friends:
> 
> https://git.infradead.org/users/willy/pagecache.git/commitdiff/4fe26f7a28ffdc850cd016cdaaa74974c59c5f53
> 
> We do have a way to allocate compound pages and add them to the page
> cache, but that's only in use by tmpfs/shmem.
> 
> What will happen is that (for filesystems which support multipage
> folios), they'll be allocated by the page cache.  I expect other
> places will start to use folios after that (eg anonymous memory), but
> I don't know where all those places will be.  I hope not to be
> involved in that!
> 
> The general principle, though, is that the overhead of tracking
> memory in page-sized units is too high, and we need to use larger
> units by default. There are occasions when we need to do things to
> memory in smaller units, and for those, we can choose to either
> handle sub-folio things, or we can split a folio apart into smaller
> folios.
> 
> > > > a possible approach maybe would be to keep the _page variant,
> > > > and add a _folio wrapper around it    
> > > 
> > > Yes, we can do that.  It's what I'm currently doing for
> > > flush_dcache_folio().  
> > 
> > where would the page flags be stored? as I said, we really depend on
> > that bit to be set correctly to prevent potentially disruptive I/O
> > errors. It's ok if the bit overindicates protection (non-protected
> > pages can be marked as protected), but protected pages must at all
> > times have the bit set.
> > 
> > the reason why this hook exists at all, is to prevent secure pages
> > from being accidentally (or maliciously) fed into I/O  
> 
> You can still use PG_arch_1 on the sub-pages of a folio.  It's one of
> the things you'll have to decide, actually.  Does setting PG_arch_1 on
> the head page of the folio indicate that the entire page is
> accessible, or just that the head page is accessible?  Different page
> flags have made different decisions here.

ok then, I think the simplest and safest thing to do right now is to
keep the flag on each page


in short:
* pagecache -> you can put a loop or introduce a _folio wrapper for
  arch_make_page_accessible
* gup.c -> won't be touched for now, but when the time comes, the
  PG_arch_1 bit should be set for each page

