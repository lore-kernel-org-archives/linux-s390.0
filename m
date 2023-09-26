Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AC2E7D242
	for <linux-s390@archiver.kernel.org>; Tue, 26 Sep 2023 07:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjIZH2o (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 26 Sep 2023 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIZH2n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 Sep 2023 03:28:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12644E5;
        Tue, 26 Sep 2023 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=duR83MibJT6qlE9mMsYQ9/keQTqkbC/pWU3tvR9QgHY=; b=x/oew8DiFEvZNAtyPwobf/9MVe
        zwg6pkQj3B6wkuUdQbtpy6crHeCzVMLUw9o5yk0T6YAC14cSl9guFm+2dq6kVvIseWyy49HSzhAd0
        n9DmqvXigE+V7zNdAO4hac2Hb71I4Do0rI/9Y2k9++6uyn+QU2qdwIL6JzE787HQd08eGa4YUb74H
        SEinanYFXxGPnzRDHdGrmoXRNbXiyqXI/KRt0M6oXa9TKa8rhLQuv2dljVJOUWipInIfkQM5dGgPi
        6Gp5h3CfN1pf3b7G00+3pW13iMrmh6o8RLHtid5CrA1zf3FOXJJ4x09ujjHe5gFM2L8tLo0pQBYHQ
        +7FHZT7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ql2Um-00FnQh-0f;
        Tue, 26 Sep 2023 07:28:36 +0000
Date:   Tue, 26 Sep 2023 00:28:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] more s390 updates for 6.6 merge window
Message-ID: <ZRKIJJNnOVNzyP/J@infradead.org>
References: <20230907112743.6134-E-hca@linux.ibm.com>
 <CAHk-=wgZP5uKXLmunUNotMo0cXhz=un5BzB_fB4zaefVR2Ex2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZP5uKXLmunUNotMo0cXhz=un5BzB_fB4zaefVR2Ex2Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 07, 2023 at 11:02:23AM -0700, Linus Torvalds wrote:
> On Thu, 7 Sept 2023 at 04:27, Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> >   Note that the set_memory_xx() family comes with an int num_pages
> >   parameter which overflows with 8TB. This could be addressed by
> >   changing the num_pages parameter to unsigned long, however requires
> >   to change all architectures, since the module code expects an int
> >   parameter (see module_set_memory()).
> 
> Bah. We should just do this. Change the 'start' to a pointer, and
> change the page count to 'unsigned long'.
> 
> Changing module_set_memory() to take the right kind of function
> pointer looks trivial too.
> 
> I'm not even sure why we did that "unsigned long addr" thing, but I
> assume it is because of our (very very _very_ old) historical
> get_free_pages() model.
> 
> We should probably change get_free_pages() too, but that literally
> goes back to linux-0.01. It's horrendously bad, but it's _very_
> traditional, and it comes from the VM code historically using bitops
> on the page pointers.

Yes, please.  And maybe pick a better name for the void * returning
version.  kmalloc_pages/kfree_pages?  or is that to close to
kmalloc/kfree?

