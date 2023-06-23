Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB66DEB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 20:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjFWUzm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 16:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjFWUzK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 16:55:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2706C1739
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 13:53:56 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bd729434fa0so1040003276.1
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687553635; x=1690145635;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+Lb4tbjiSa+kuWkus5+uNOtZtK47d1/7X36bo2p7gA=;
        b=4RCSLl8Y2NF41WdIp75r3joTs4JKmXt96ShX5WeKbiIayJOXjRi3jCwY6UrOSjcABZ
         k+TSHexRU93yszqh5KtArv3znI1zFQxG4wYM4goRSD8adLmSwj+uCYiMjFg/6JlT10Mg
         K5tXr5SCHxSdWzEtgbp1QwYY0BK5qjMKZ6JKY5ue6u6OGEVIlXXKnWmOqvpg2us1uyv9
         ifK37WJd3GceHQOXqFw7ozSrZO2mU8D4k30JpUezZ3Igr0Xiz6+eWLjm6/60oMzR5ZSm
         Ng+YR12eeqDVA82TQA1zJ84H2jqXumCuTiRe3k956saFDcwEVwpIzb+EnpbC/q1qChXt
         4yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687553635; x=1690145635;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+Lb4tbjiSa+kuWkus5+uNOtZtK47d1/7X36bo2p7gA=;
        b=FaMC707nL1uYAwjPmeQWy5gxqryCnguoW+QT0W1cAvENKeXl95wPLPaN35dRYLuqA3
         s9/PJwUAL9quEdYxQqrRSyT0ofTLkkUeqS/brqAcFBxxQHx/DfOxKAWxGDQ5nz53NyS/
         7huElCDTjbPaLcZYgRCSNTatt8r4VItr6EL9jxgM0H5lxXPeXX6Us1juHSSLHG7xD1XM
         y2NROYoKzHbdW7BPUWlD69MOHbN1GJ0ZycBv/fX+PsnJjx0jwJWbCxsyUTDDglO16C72
         GEEj10Fc7LHiULwdj+o9NotAKiZrut/8Y/oEOlWlyZZHDTklPGshbjNczqHpZbQTVrd0
         4fEw==
X-Gm-Message-State: AC+VfDzmjvICJpPkf4N+oCl4r/yllSCohldW2sfn4/C42oXUJTEZm3qn
        I9nYMlqcbV47UXZPhSsHCl2zyA==
X-Google-Smtp-Source: ACHHUZ45YEjheFSs2jnf04uCGwbusldF+66NzwG1Udu3co/l77v+vwBkpgZSvq3yDyWBVUlkkdYCOg==
X-Received: by 2002:a81:6cd7:0:b0:56d:9e9:c2a1 with SMTP id h206-20020a816cd7000000b0056d09e9c2a1mr26769379ywc.16.1687553635180;
        Fri, 23 Jun 2023 13:53:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t191-20020a8183c8000000b0057085b18cddsm2684659ywf.54.2023.06.23.13.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:53:54 -0700 (PDT)
Date:   Fri, 23 Jun 2023 13:53:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alexander Gordeev <agordeev@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: prospective 13/12 s390 pgtable_list patch
In-Reply-To: <ZJVl7ZJiborhmtYh@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Message-ID: <232e20a5-ef6-41cf-4073-92fcb3a01453@google.com>
References: <a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com> <ZJVl7ZJiborhmtYh@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 23 Jun 2023, Alexander Gordeev wrote:
> On Thu, Jun 22, 2023 at 10:49:43PM -0700, Hugh Dickins wrote:
> > Hi Gerald,
> > 
> > It's that moment you've been dreading: I'm hoping that you can, please,
> > take a look at the patch below, and try building and running with it,
> > on top of the v2 series of 12 I sent out on Tuesday.
> > 
> > If this seems okay to you, I'll send it properly as 13/12 of that series,
> > to the full Cc list; but of course you may find I've missed typos and worse
> > - please don't waste your time on it if it's rubbish, but so far as I can
> > tell, it is complete and ready now.
> > 
> > Thanks!
> > Hugh
> 
> Hi Hugh,
> 
> Gerald is off until Monday and I think is not able to answer right now.

Thanks a lot for stepping in, Alexander.

> 
> We had discussions with regard to how to better approach your series and
> did not come to a conclusion unfortunatelly.
> 
> Gerald had several concerns - one of them is global mm_pgtable_list_lock,
> wich is luckily avoided with this follow-up patch. But there were others,
> which I am not able to articulate in detail.
> 
> While you are doing an outstanding job in trying to adjust our fragmented
> page tables reuse scheme, one of the ideas emerged was to actually give it
> up: partially or may be even fully. That is - not to reuse page tables
> returned via pte_free_defer() or not to reuse them at all. To assess this
> possible new approaches some statistics is needed and am working on a
> prototype that would allow collecting it.
> 
> Note, our existing code is extremly complicated already and we had hard
> time fixing (at least one) ugly race related to that. With the changes
> you suggest that complexity (to me personally) multiplies. But that well
> could be the other way around and I am just not smart enough to grasp it.
> At least the claim that page_table_free() no longer needs the two-step
> release indicates that.

Yes, I had to cool myself down to a low temperature, and think about it
for several hours before arriving at that conclusion.  It would be nice
if I could point to one fact which explains it convincingly (something
along the lines of "look, we already took it off the list in that case");
but didn't manage to put it into words, and ended up deciding that we
each have to do our own thinking to convince ourselves on that issue.

> 
> I am sorry that it is probably not the status you would like to hear,

Not a problem for me at all: you're absolutely right to question whether
the existing, and the added, complexity is worth it - all of us who have
looked into that code have wondered the same.

Initially I refused to even try to get into it; but in the end was quite
proud that I had, given time, managed to work with it.  But no problem
if that work is quickly discarded in favour of simplicity.

> but I still wonder what is your opinion on that do-not-reuse-fragments

I don't want to sway you one way or the other on that: I just want to
work with whatever you decide.  I know Matthew Wilcox would prefer if
powerpc and s390 went about things in the same way (but they do have
different constraints, so I don't necessarily agree); but I did not
feel able to persuade powerpc to adopt s390's more complex approach,
nor to persuade s390 to downgrade to powerpc's simpler approach.

> approach? Would it simplify pte_free_defer() or had no effect?

It would certainly simplify it a lot.  Whether it would just be a
matter of deleting my attempt to list_add() from __tlb_remove_table(),
so restoring the per-mm lock, and forgetting the SLAB_TYPESAFE_BY_RCU;
or whether it would go further, and most of the PP-AA bit tracking fall
away, I cannot predict - depends rather on who does the job, and how
far they choose to take it.

Two notes I want to throw into the mix:

One, FWIW my guess is that for most mms, the s390 PP-AA tracking adds very
little value; but without it, perhaps there is some mm, some workload, which
degrades to the point of using only half of the pgtable memory it allocates.

Two, maybe you'll see this as a further complication, to avoid getting into,
rather than a simplification: but it occurred to me while working here that
s390 has no need to keep the pgtable_trans_huge_deposit/withdraw() code in
mm/pgtable.c separate from the mm/pgalloc.c code.  They can use just the
one list, and deposit/withdraw simply keep a count of how many immediately
usable free pgtables must always be kept in reserve on that list.  (But
this would not be true at all for powerpc.)

> 
> Anyway, that is just another option and I will try your patch.

Thank you, please do, if you have the time: my series does need some
kind of s390 solution, depending on whatever s390 has in its tree at
the time: for now I should at least be showing the 13/12 (preferably
known to build and appearing to work!), even if all it does is help
people to say "no, that's too much".

Hugh
