Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbfJaPZA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 11:25:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VFKZiq137361
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 11:24:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyym1ekx4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 11:24:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 31 Oct 2019 15:24:57 -0000
Date: Thu, 31 Oct 2019 16:24:49 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 0/3] s390/livepatch: Implement reliable stack tracing
 for the consistency model
References: <20191029143904.24051-1-mbenes@suse.cz>
 <20191029163450.GI5646@osiris>
 <alpine.LSU.2.21.1910301105550.18400@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1910301105550.18400@pobox.suse.cz>
Message-Id: <20191031152449.GA6133@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: gor@linux.ibm.com, borntraeger@de.ibm.com, jpoimboe@redhat.com, joe.lawrence@redhat.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org

On Wed, Oct 30, 2019 at 11:12:00AM +0100, Miroslav Benes wrote:
> On Tue, 29 Oct 2019, Heiko Carstens wrote:
> 
> > On Tue, Oct 29, 2019 at 03:39:01PM +0100, Miroslav Benes wrote:
> > > - I tried to use the existing infrastructure as much as possible with
> > >   one exception. I kept unwind_next_frame_reliable() next to the
> > >   ordinary unwind_next_frame(). I did not come up with a nice solution
> > >   how to integrate it. The reliable unwinding is executed on a task
> > >   stack only, which leads to a nice simplification. My integration
> > >   attempts only obfuscated the existing unwind_next_frame() which is
> > >   already not easy to read. Ideas are definitely welcome.
> > 
> > Ah, now I see. So patch 2 seems to be leftover(?). Could you just send
> > how the result would look like?
> > 
> > I'd really like to have only one function, since some of the sanity
> > checks you added also make sense for what we already have - so code
> > would diverge from the beginning.
> 
> Ok, that is understandable. I tried a bit harder and the outcome does not 
> look as bad as my previous attempts (read, I gave up too early).
> 
> I deliberately split unwind_reliable/!unwind_reliable case in "No 
> back-chain, look for a pt_regs structure" branch, because the purpose is 
> different there. In !unwind_reliable case we can continue on a different 
> stack (if I understood the code correctly when I analyzed it in the past. 
> I haven't found a good documentation unfortunately :(). While in 
> unwind_realiable case we just check if there are pt_regs in the right 
> place on a task stack and stop. If there are not, error out.
> 
> It applies on top of the patch set. Only compile tested though. If it 
> looks ok-ish to you, I'll work on it.

Yes, that looks much better. Note, from a coding style perspective the
80 characters per line limit is _not_ enforced on s390 kernel code; so
that might be a possibility to make the code a bit more readable.

Also it _might_ make sense to split the function into two or more
functions (without duplicating code). Not sure if that would really
increase readability though.

FWIW, I just applied your first patch, since it makes sense anyway.
