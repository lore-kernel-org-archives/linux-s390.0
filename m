Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCIqa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 04:46:30 -0400
MIME-Version: 1.0
References: <20200716030847.1564131-1-keescook@chromium.org>
 <87h7tpa3hg.fsf@nanos.tec.linutronix.de> <202007301113.45D24C9D@keescook>
In-Reply-To: <202007301113.45D24C9D@keescook>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 3 Aug 2020 14:16:15 +0530
Message-ID: <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Modernize tasklet callback API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oscar Carter <oscar.carter@gmx.com>, Romain Perier <romain.perier@gmail.com>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, alsa-devel@alsa-project.org, Kernel Hardening <kernel-hardening@lists.openwall.com>

Kees,

>
> [heavily trimmed CC list because I think lkml is ignoring this
> thread...]
>
> On Thu, Jul 30, 2020 at 09:03:55AM +0200, Thomas Gleixner wrote:
> > Kees,
> >
> > Kees Cook <keescook@chromium.org> writes:
> > > This is the infrastructure changes to prepare the tasklet API for
> > > conversion to passing the tasklet struct as the callback argument instead
> > > of an arbitrary unsigned long. The first patch details why this is useful
> > > (it's the same rationale as the timer_struct changes from a bit ago:
> > > less abuse during memory corruption attacks, more in line with existing
> > > ways of doing things in the kernel, save a little space in struct,
> > > etc). Notably, the existing tasklet API use is much less messy, so there
> > > is less to clean up.
> > >
> > > It's not clear to me which tree this should go through... Greg since it
> > > starts with a USB clean-up, -tip for timer or interrupt, or if I should
> > > just carry it. I'm open to suggestions, but if I don't hear otherwise,
> > > I'll just carry it.
> > >
> > > My goal is to have this merged for v5.9-rc1 so that during the v5.10
> > > development cycle the new API will be available. The entire tree of
> > > changes is here[1] currently, but to split it up by maintainer the
> > > infrastructure changes need to be landed first.
> > >
> > > Review and Acks appreciated! :)
> >
> > I'd rather see tasklets vanish from the planet completely, but that's
> > going to be a daring feat. So, grudgingly:
>
> Understood! I will update the comments near the tasklet API.
>
> > Acked-by: Thomas Gleixner <tglx@linutronix.de>
>

Here's the series re-based on top of 5.8
https://github.com/allenpais/tasklets/tree/V3

Let me know how you would want these to be reviewed.

Also, I was thinking if removing tasklets completely could be a task
on KSPP wiki. If yes, I did like to take ownership of that task. I have a
couple of ideas in mind, which could be discussed in a separate email.

Thanks.

-- 
       - Allen
