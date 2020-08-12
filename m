Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgHLMcJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Aug 2020 08:32:09 -0400
MIME-Version: 1.0
References: <20200716030847.1564131-1-keescook@chromium.org>
 <87h7tpa3hg.fsf@nanos.tec.linutronix.de> <202007301113.45D24C9D@keescook>
 <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com> <202008111427.D00FCCF@keescook>
In-Reply-To: <202008111427.D00FCCF@keescook>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 12 Aug 2020 18:01:55 +0530
Message-ID: <CAOMdWS+nJr+g1c0Kb99Z=HwQjHtH_-NCC9hW-o6xFs4huGKsqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Modernize tasklet callback API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oscar Carter <oscar.carter@gmx.com>, Romain Perier <romain.perier@gmail.com>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, alsa-devel@alsa-project.org, Kernel Hardening <kernel-hardening@lists.openwall.com>

Kees,

> Was a Coccinelle script used for any of these conversions? I wonder if
> it'd be easier to do a single treewide patch for the more mechanical
> changes.

No, I should have written one. Will do it.

> And, actually, I still think the "prepare" patches should just be
> collapsed into the actual "covert" patches -- there are only a few.

Okay. It's been done and pushed to:
https://github.com/allenpais/tasklets/tree/V4

> After those, yeah, I think getting these sent to their respective
> maintainers is the next step.

 Please look at the above branch, if it looks fine, let me know
if I can add your ACK on the patches.
>
> Sure! I will add it to the tracker. Here's for the refactoring:
> https://github.com/KSPP/linux/issues/30
>
> and here's for the removal:
> https://github.com/KSPP/linux/issues/94
>
> if you can added details/examples of how they should be removed, that'd
> help other folks too, if they wanted to jump in. :)

Sure, Thank you.

- Allen
