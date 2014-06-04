Return-path: <ath10k-bounces+kvalo=adurom.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
Date: Wed, 4 Jun 2014 11:35:37 +0200
Message-ID: <CAMuHMdXsoFUXj4jLMWN6NY7Um19KwWO9Rhx=9=gqWu_K5Ev2kQ@mail.gmail.com>
Subject: Re: [PATCH 0/10] use safer test on the result of find_first_zero_bit
From: Geert Uytterhoeven <geert@linux-m68k.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/ath10k/>
List-Post: <mailto:ath10k@lists.infradead.org>
List-Help: <mailto:ath10k-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ath10k" <ath10k-bounces@lists.infradead.org>
Errors-To: ath10k-bounces+kvalo=adurom.com@lists.infradead.org
List-Archive: <https://lore.kernel.org/ath10k/>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: driverdevel <devel@driverdev.osuosl.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, iss_storagedev@hp.com, Linux-sh list <linux-sh@vger.kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Julia,

On Wed, Jun 4, 2014 at 11:07 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus may
> return a larger number than the maximum position argument if that position
> is not a multiple of BITS_PER_LONG.

Shouldn't this be fixed in find_first_zero_bit() instead?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
ath10k mailing list
ath10k@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/ath10k
