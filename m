Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHRUKU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Aug 2020 16:10:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1788C061349
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2020 13:10:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so3760009plp.4
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2020 13:10:18 -0700 (PDT)
Date: Tue, 18 Aug 2020 13:10:14 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
Message-ID: <202008181309.FD3940A2D5@keescook>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
 <20200817091617.28119-2-allen.cryptic@gmail.com>
 <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
 <202008171228.29E6B3BB@keescook>
 <161b75f1-4e88-dcdf-42e8-b22504d7525c@kernel.dk>
 <202008171246.80287CDCA@keescook>
 <df645c06-c30b-eafa-4d23-826b84f2ff48@kernel.dk>
 <1597780833.3978.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597780833.3978.3.camel@HansenPartnership.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <axboe@kernel.dk>, Allen Pais <allen.cryptic@gmail.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com, stefanr@s5r6.in-berlin.de, airlied@linux.ie, daniel@ffwll.ch, sre@kernel.org, kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com, jassisinghbrar@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org, mporter@kernel.crashing.org, alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk, manohar.vanga@gmail.com, mitch@sfgoth.com, davem@davemloft.net, kuba@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org, openipmi-developer@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, Allen Pais <allen.lkml@gmail.com>, Romain Perier <romain.perier@gmail.com>

On Tue, Aug 18, 2020 at 01:00:33PM -0700, James Bottomley wrote:
> On Mon, 2020-08-17 at 13:02 -0700, Jens Axboe wrote:
> > On 8/17/20 12:48 PM, Kees Cook wrote:
> > > On Mon, Aug 17, 2020 at 12:44:34PM -0700, Jens Axboe wrote:
> > > > On 8/17/20 12:29 PM, Kees Cook wrote:
> > > > > On Mon, Aug 17, 2020 at 06:56:47AM -0700, Jens Axboe wrote:
> > > > > > On 8/17/20 2:15 AM, Allen Pais wrote:
> > > > > > > From: Allen Pais <allen.lkml@gmail.com>
> > > > > > > 
> > > > > > > In preparation for unconditionally passing the
> > > > > > > struct tasklet_struct pointer to all tasklet
> > > > > > > callbacks, switch to using the new tasklet_setup()
> > > > > > > and from_tasklet() to pass the tasklet pointer explicitly.
> > > > > > 
> > > > > > Who came up with the idea to add a macro 'from_tasklet' that
> > > > > > is just container_of? container_of in the code would be
> > > > > > _much_ more readable, and not leave anyone guessing wtf
> > > > > > from_tasklet is doing.
> > > > > > 
> > > > > > I'd fix that up now before everything else goes in...
> > > > > 
> > > > > As I mentioned in the other thread, I think this makes things
> > > > > much more readable. It's the same thing that the timer_struct
> > > > > conversion did (added a container_of wrapper) to avoid the
> > > > > ever-repeating use of typeof(), long lines, etc.
> > > > 
> > > > But then it should use a generic name, instead of each sub-system 
> > > > using some random name that makes people look up exactly what it
> > > > does. I'm not huge fan of the container_of() redundancy, but
> > > > adding private variants of this doesn't seem like the best way
> > > > forward. Let's have a generic helper that does this, and use it
> > > > everywhere.
> > > 
> > > I'm open to suggestions, but as things stand, these kinds of
> > > treewide
> > 
> > On naming? Implementation is just as it stands, from_tasklet() is
> > totally generic which is why I objected to it. from_member()? Not
> > great with naming... But I can see this going further and then we'll
> > suddenly have tons of these. It's not good for readability.
> 
> Since both threads seem to have petered out, let me suggest in
> kernel.h:
> 
> #define cast_out(ptr, container, member) \
> 	container_of(ptr, typeof(*container), member)
> 
> It does what you want, the argument order is the same as container_of
> with the only difference being you name the containing structure
> instead of having to specify its type.

I like this! Shall I send this to Linus to see if this can land in -rc2
for use going forward?

-- 
Kees Cook
