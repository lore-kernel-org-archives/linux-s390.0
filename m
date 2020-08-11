Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgHKMQm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Aug 2020 08:16:42 -0400
MIME-Version: 1.0
References: <20200716030847.1564131-1-keescook@chromium.org>
 <87h7tpa3hg.fsf@nanos.tec.linutronix.de> <202007301113.45D24C9D@keescook> <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
In-Reply-To: <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 11 Aug 2020 17:46:29 +0530
Message-ID: <CAOMdWSLef4Vy=k-Kfp8RJ++=SsMwCQTU4+hEueK_APDGvJ-PaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Modernize tasklet callback API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oscar Carter <oscar.carter@gmx.com>, Romain Perier <romain.perier@gmail.com>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, alsa-devel@alsa-project.org, Kernel Hardening <kernel-hardening@lists.openwall.com>

Kees,

> >
>
> Here's the series re-based on top of 5.8
> https://github.com/allenpais/tasklets/tree/V3
>
> Let me know how you would want these to be reviewed.
>

  I see the first set of infrastructure patches for tasklets have
landed in Linus's tree. Good time to send out the ~200 patches?

- Allen
