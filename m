Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgHZPNd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Aug 2020 11:13:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFC3C0613ED
        for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2020 08:13:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so1177001pgb.4
        for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2020 08:13:32 -0700 (PDT)
Date: Wed, 26 Aug 2020 08:13:29 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
Message-ID: <202008260811.1CE425B5C2@keescook>
References: <161b75f1-4e88-dcdf-42e8-b22504d7525c@kernel.dk>
 <202008171246.80287CDCA@keescook>
 <df645c06-c30b-eafa-4d23-826b84f2ff48@kernel.dk>
 <1597780833.3978.3.camel@HansenPartnership.com>
 <f3312928-430c-25f3-7112-76f2754df080@kernel.dk>
 <1597849185.3875.7.camel@HansenPartnership.com>
 <CAOMdWSJRR0BhjJK1FxD7UKxNd5sk4ycmEX6TYtJjRNR6UFAj6Q@mail.gmail.com>
 <1597873172.4030.2.camel@HansenPartnership.com>
 <CAEogwTCH8qqjAnSpT0GDn+NuAps8dNbfcPVQ9h8kfOWNbzrD0w@mail.gmail.com>
 <20200826095528.GX1793@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826095528.GX1793@kadam>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Allen Pais <allen.cryptic@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-atm-general@lists.sourceforge.net, manohar.vanga@gmail.com, airlied@linux.ie, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, sre@kernel.org, anton.ivanov@cambridgegreys.com, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux1394-devel@lists.sourceforge.net, maximlevitsky@gmail.com, richard@nod.at, deller@gmx.de, jassisinghbrar@gmail.com, linux-spi@vger.kernel.org, 3chas3@gmail.com, intel-gfx@lists.freedesktop.org, Jakub Kicinski <kuba@kernel.org>, mporter@kernel.crashing.org, jdike@addtoit.com, oakad@yahoo.com, s.hauer@pengutronix.de, linux-input@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, broonie@kernel.org, openipmi-developer@lists.sourceforge.net, mitch@sfgoth.com, linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, martyn@welchs.me.uk, dmitry.torokhov@gmail.com, linux-mmc@vger.kernel.org, Allen <allen.lkml@gmail.com>, linux-kernel@vger.kernel.org, alex.bou9@gmail.com, stefanr@s5r6.in-berlin.de, Daniel Vetter <daniel@ffwll.ch>, linux-ntb@googlegroups.com, Romain Perier <romain.perier@gmail.com>, shawnguo@kernel.org, David Miller <davem@davemloft.net>

On Wed, Aug 26, 2020 at 12:55:28PM +0300, Dan Carpenter wrote:
> On Wed, Aug 26, 2020 at 07:21:35AM +0530, Allen Pais wrote:
> > On Thu, Aug 20, 2020 at 3:09 AM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Wed, 2020-08-19 at 21:54 +0530, Allen wrote:
> > > > > [...]
> > > > > > > Since both threads seem to have petered out, let me suggest in
> > > > > > > kernel.h:
> > > > > > >
> > > > > > > #define cast_out(ptr, container, member) \
> > > > > > >     container_of(ptr, typeof(*container), member)
> > > > > > >
> > > > > > > It does what you want, the argument order is the same as
> > > > > > > container_of with the only difference being you name the
> > > > > > > containing structure instead of having to specify its type.
> > > > > >
> > > > > > Not to incessantly bike shed on the naming, but I don't like
> > > > > > cast_out, it's not very descriptive. And it has connotations of
> > > > > > getting rid of something, which isn't really true.
> > > > >
> > > > > Um, I thought it was exactly descriptive: you're casting to the
> > > > > outer container.  I thought about following the C++ dynamic casting
> > > > > style, so out_cast(), but that seemed a bit pejorative.  What about
> > > > > outer_cast()?
> > > > >
> > > > > > FWIW, I like the from_ part of the original naming, as it has
> > > > > > some clues as to what is being done here. Why not just
> > > > > > from_container()? That should immediately tell people what it
> > > > > > does without having to look up the implementation, even before
> > > > > > this becomes a part of the accepted coding norm.
> > > > >
> > > > > I'm not opposed to container_from() but it seems a little less
> > > > > descriptive than outer_cast() but I don't really care.  I always
> > > > > have to look up container_of() when I'm using it so this would just
> > > > > be another macro of that type ...
> > > > >
> > > >
> > > >  So far we have a few which have been suggested as replacement
> > > > for from_tasklet()
> > > >
> > > > - out_cast() or outer_cast()
> > > > - from_member().
> > > > - container_from() or from_container()
> > > >
> > > > from_container() sounds fine, would trimming it a bit work? like
> > > > from_cont().
> > >
> > > I'm fine with container_from().  It's the same form as container_of()
> > > and I think we need urgent agreement to not stall everything else so
> > > the most innocuous name is likely to get the widest acceptance.
> > 
> > Kees,
> > 
> >   Will you be  sending the newly proposed API to Linus? I have V2
> > which uses container_from()
> > ready to be sent out.
> 
> I liked that James swapped the first two arguments so that it matches
> container_of().  Plus it's nice that when you have:
> 
> 	struct whatever *foo = container_from(ptr, foo, member);
> 
> Then it means that "ptr == &foo->member".

I'm a bit stalled right now -- the merge window was keeping me busy, and
this week is the Linux Plumbers Conference. This is on my list, but I
haven't gotten back around to it. If you want, feel free to send the
container_from() patch; you might be able to unblock this faster than me
right now. :)

-Kees

-- 
Kees Cook
