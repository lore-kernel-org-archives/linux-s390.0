Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRVuO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 18 Oct 2020 17:50:14 -0400
MIME-Version: 1.0
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
In-Reply-To: <20200817091617.28119-1-allen.cryptic@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 18 Oct 2020 23:50:00 +0200
Message-ID: <CAFLxGvxsHD6zvTJSHeo2gaoRQfjUPZ6M=5BirOObHFjGqnzfew@mail.gmail.com>
Subject: Re: [PATCH] arch: um: convert tasklets to use new tasklet_setup() API
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Allen Pais <allen.cryptic@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 3chas3@gmail.com, Jens Axboe <axboe@kernel.dk>, stefanr@s5r6.in-berlin.de, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sebastian Reichel <sre@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Helge Deller <deller@gmx.de>, dmitry.torokhov@gmail.com, jassisinghbrar@gmail.com, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>, mporter@kernel.crashing.org, alex.bou9@gmail.com, Mark Brown <broonie@kernel.org>, martyn@welchs.me.uk, manohar.vanga@gmail.com, mitch@sfgoth.com, "David S. Miller" <davem@davemloft.net>, kuba@kernel.org, Kees Cook <keescook@chromium.org>, linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org, openipmi-developer@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, DRI mailing list <dri-devel@lists.freedesktop.org>, linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, devel@driverdev.osuosl.org, Allen Pais <allen.lkml@gmail.com>, Romain Perier <romain.perier@gmail.com>

On Mon, Aug 17, 2020 at 11:17 AM Allen Pais <allen.cryptic@gmail.com> wrote:
>
> From: Allen Pais <allen.lkml@gmail.com>
>
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  arch/um/drivers/vector_kern.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Anton, can you please review this patch?

-- 
Thanks,
//richard
