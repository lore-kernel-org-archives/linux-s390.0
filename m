Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1574279778.9585.15.camel@lca.pw>
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
From: Qian Cai <cai@lca.pw>
Date: Wed, 20 Nov 2019 14:56:18 -0500
In-Reply-To: <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
         <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
         <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 06:55 -0800, Tejun Heo wrote:
> On Thu, Nov 14, 2019 at 07:26:21PM -0500, Qian Cai wrote:
> > 
> > 
> > > On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
> > > 
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > 
> > Tejun, suppose you will take this patch via your tree together with the series or should I Cc Andrew who normally handle this file?
> 
> Patches in this area usually goes through Jens's block tree.

I remember that last time Jens had no interests in picking up trivial patches
like this one. See the commit d1a445d3b86c ("include/trace/events/writeback.h:
fix -Wstringop-truncation warnings").

Andrew, care to pick up this again?

https://lore.kernel.org/lkml/1573751861-10303-1-git-send-email-cai@lca.pw/
