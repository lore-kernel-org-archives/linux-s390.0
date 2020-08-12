Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200716030847.1564131-1-keescook@chromium.org>
 <87h7tpa3hg.fsf@nanos.tec.linutronix.de> <202007301113.45D24C9D@keescook>
 <CAOMdWSJQKHAWY1P297b9koOLd8sVtezEYEyWGtymN1YeY27M6A@mail.gmail.com>
 <202008111427.D00FCCF@keescook> <s5hpn7wz8o6.wl-tiwai@suse.de>
In-Reply-To: <s5hpn7wz8o6.wl-tiwai@suse.de>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 12 Aug 2020 17:02:50 +0530
Message-ID: <CAOMdWS+FJm0NZfbj+yyShX2edX6_9w5K+rA+_u+Z6-rrjcwucg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Modernize tasklet callback API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, alsa-devel@alsa-project.org, Oscar Carter <oscar.carter@gmx.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Romain Perier <romain.perier@gmail.com>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>

>
> I have a patch set to convert the remaining tasklet usage in sound
> drivers to either the threaded IRQ or the work, but it wasn't
> submitted / merged for 5.8 due to the obvious conflict with your API
> changes.
> Each conversion is rather simple, but it's always a question of the
> nature of each tasklet usage which alternative is the best fit.
>
> FWIW, the current version is found in test/kill-tasklet branch of
> sound git tree
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Great. Currently my tree has these converted to use the new
tasklet_setup() api. I will add these to my threaded IRQ/work tree
(which is still wip).

Thanks.


-- 
       - Allen
