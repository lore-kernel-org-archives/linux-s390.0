Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB98C433E0
	for <linux-s390@archiver.kernel.org>; Fri, 26 Feb 2021 16:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECBD64F03
	for <linux-s390@archiver.kernel.org>; Fri, 26 Feb 2021 16:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhBZQE5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Feb 2021 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBZQE4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 Feb 2021 11:04:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E015C061574;
        Fri, 26 Feb 2021 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nlrPN6RKsKi94KSjI+2dR6vaJd54WtU/wGcRKq1SGac=; b=ONNF7yjdRI1tRIpo0PQk8cAljg
        u3YfDpfRVp8NNTh+ucghqkv8ngoXtpV/axBTq+P3Js4/AgyZgZ+aekEOAxYXOgmJ79Hs1Dv9GhdgP
        lX3X4f0Fk5rpkhvUZD135Bxge8SpbXgAWybC2Mc3IKg3MN09I5BSb50Xa+8zU8k06Bq9FTNaxAdo+
        3yACY5ecnhSeenvfblbCjWFkZUpNoCN1FOipQcGGa0h3ERmwuB8zyX+2Ub/weelZ0uph9wN5CPbRO
        SBH78t+9xvcw1R03B/mfNcNRPENtIas77/vSrsXz649FAQPO+oDNpa6wrW/A0DObSZ2Hw+inIYCx9
        /OSQsC6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFfas-00CDLc-Ux; Fri, 26 Feb 2021 16:03:59 +0000
Date:   Fri, 26 Feb 2021 16:03:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Freeing page tables through RCU
Message-ID: <20210226160354.GE2723601@casper.infradead.org>
References: <20210225205820.GC2858050@casper.infradead.org>
 <20210226144200.GV2643399@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226144200.GV2643399@ziepe.ca>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Feb 26, 2021 at 10:42:00AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 25, 2021 at 08:58:20PM +0000, Matthew Wilcox wrote:
> 
> > I'd like to hear better ideas than this.
> 
> You didn't like my suggestion to put a sleepable lock around the
> freeing of page tables during flushing?
> 
> I still don't see how you convert the sleepable page walkers to use
> rcu??

I don't want to convert the sleepable ones to use RCU ... I want to
convert the non-sleeping ones to use RCU.  A page_table_free_lock might
work, but it might have its own problems later (eg a sleeping lock can't
be acquired under RCU or spinlock, and it can't be a spinlock because
it'd have to be held while we wait for IPIs).

I think it would solve my immediate problem, and I wonder if it might
solve some other problems ...
