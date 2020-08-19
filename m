Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47048 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgHSVji (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 17:39:38 -0400
Message-ID: <1597873172.4030.2.camel@HansenPartnership.com>
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 19 Aug 2020 14:39:32 -0700
In-Reply-To: <CAOMdWSJRR0BhjJK1FxD7UKxNd5sk4ycmEX6TYtJjRNR6UFAj6Q@mail.gmail.com>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
         <20200817091617.28119-2-allen.cryptic@gmail.com>
         <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
         <202008171228.29E6B3BB@keescook>
         <161b75f1-4e88-dcdf-42e8-b22504d7525c@kernel.dk>
         <202008171246.80287CDCA@keescook>
         <df645c06-c30b-eafa-4d23-826b84f2ff48@kernel.dk>
         <1597780833.3978.3.camel@HansenPartnership.com>
         <f3312928-430c-25f3-7112-76f2754df080@kernel.dk>
         <1597849185.3875.7.camel@HansenPartnership.com>
         <CAOMdWSJRR0BhjJK1FxD7UKxNd5sk4ycmEX6TYtJjRNR6UFAj6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.cryptic@gmail.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com, stefanr@s5r6.in-berlin.de, airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>, sre@kernel.org, kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com, jassisinghbrar@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com, Ulf Hansson <ulf.hansson@linaro.org>, mporter@kernel.crashing.org, alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk, manohar.vanga@gmail.com, mitch@sfgoth.com, David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org, openipmi-developer@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, Romain Perier <romain.perier@gmail.com>

On Wed, 2020-08-19 at 21:54 +0530, Allen wrote:
> > [...]
> > > > Since both threads seem to have petered out, let me suggest in
> > > > kernel.h:
> > > > 
> > > > #define cast_out(ptr, container, member) \
> > > >     container_of(ptr, typeof(*container), member)
> > > > 
> > > > It does what you want, the argument order is the same as
> > > > container_of with the only difference being you name the
> > > > containing structure instead of having to specify its type.
> > > 
> > > Not to incessantly bike shed on the naming, but I don't like
> > > cast_out, it's not very descriptive. And it has connotations of
> > > getting rid of something, which isn't really true.
> > 
> > Um, I thought it was exactly descriptive: you're casting to the
> > outer container.  I thought about following the C++ dynamic casting
> > style, so out_cast(), but that seemed a bit pejorative.  What about
> > outer_cast()?
> > 
> > > FWIW, I like the from_ part of the original naming, as it has
> > > some clues as to what is being done here. Why not just
> > > from_container()? That should immediately tell people what it
> > > does without having to look up the implementation, even before
> > > this becomes a part of the accepted coding norm.
> > 
> > I'm not opposed to container_from() but it seems a little less
> > descriptive than outer_cast() but I don't really care.  I always
> > have to look up container_of() when I'm using it so this would just
> > be another macro of that type ...
> > 
> 
>  So far we have a few which have been suggested as replacement
> for from_tasklet()
> 
> - out_cast() or outer_cast()
> - from_member().
> - container_from() or from_container()
> 
> from_container() sounds fine, would trimming it a bit work? like
> from_cont().

I'm fine with container_from().  It's the same form as container_of()
and I think we need urgent agreement to not stall everything else so
the most innocuous name is likely to get the widest acceptance.

James
