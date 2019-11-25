Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36780 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfKYPvv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Nov 2019 10:51:51 -0500
Date: Mon, 25 Nov 2019 07:51:46 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
Message-ID: <20191125155146.GA2867037@devbig004.ftw2.facebook.com>
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
 <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
 <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
 <1574279778.9585.15.camel@lca.pw>
 <26dc5699-9223-3e35-65f3-955fef7a990a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26dc5699-9223-3e35-65f3-955fef7a990a@kernel.dk>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>, jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 04:17:51PM -0700, Jens Axboe wrote:
> On 11/20/19 12:56 PM, Qian Cai wrote:
> > On Fri, 2019-11-15 at 06:55 -0800, Tejun Heo wrote:
> >> On Thu, Nov 14, 2019 at 07:26:21PM -0500, Qian Cai wrote:
> >>>
> >>>
> >>>> On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
> >>>>
> >>>> Acked-by: Tejun Heo <tj@kernel.org>
> >>>
> >>> Tejun, suppose you will take this patch via your tree together with the series or should I Cc Andrew who normally handle this file?
> >>
> >> Patches in this area usually goes through Jens's block tree.
> > 
> > I remember that last time Jens had no interests in picking up trivial patches
> > like this one. See the commit d1a445d3b86c ("include/trace/events/writeback.h:
> > fix -Wstringop-truncation warnings").
> > 
> > Andrew, care to pick up this again?
> > 
> > https://lore.kernel.org/lkml/1573751861-10303-1-git-send-email-cai@lca.pw/
> 
> I'm fine with picking it up, this one isn't trivial and it's fixing
> warnings. But I didn't (and don't) carry f05499a06fb4 in my tree,
> so it'd be more logical to funnel this one through the tree that
> has the offending commit.

Yeah, I was being dumb.  This was from the commit which got applied to
cgroup tree as part of the cgroup id unification.  Applied to
cgroup/for-5.5.

Thanks.

-- 
tejun
