Return-path: <ath10k-bounces+kvalo=adurom.com@lists.infradead.org>
Date: Wed, 4 Jun 2014 11:52:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
Subject: RE: [PATCH 0/10] use safer test on the result of find_first_zero_bit
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1725705F@AcuExch.aculab.com>
Message-ID: <alpine.DEB.2.10.1406041148590.2441@hadrien>
References: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAMuHMdXsoFUXj4jLMWN6NY7Um19KwWO9Rhx=9=gqWu_K5Ev2kQ@mail.gmail.com>
 <alpine.DEB.2.10.1406041137270.2441@hadrien>
 <063D6719AE5E284EB5DD2968C1650D6D1725705F@AcuExch.aculab.com>
MIME-Version: 1.0
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
To: David Laight <David.Laight@ACULAB.COM>
Cc: driverdevel <devel@driverdev.osuosl.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, "iss_storagedev@hp.com" <iss_storagedev@hp.com>, Linux-sh list <linux-sh@vger.kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, 'Julia Lawall' <julia.lawall@lip6.fr>, Geert Uytterhoeven <geert@linux-m68k.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On Wed, 4 Jun 2014, David Laight wrote:

> From: Julia Lawall
> > On Wed, 4 Jun 2014, Geert Uytterhoeven wrote:
> >
> > > Hi Julia,
> > >
> > > On Wed, Jun 4, 2014 at 11:07 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> > > > Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus may
> > > > return a larger number than the maximum position argument if that position
> > > > is not a multiple of BITS_PER_LONG.
> > >
> > > Shouldn't this be fixed in find_first_zero_bit() instead?
> >
> > OK, I could do that as well.  Most of the callers currently test with >=.
> > Should they be left as is, or changed to use ==?
>
> Do we want to add an extra test to find_first_zero_bit() and effectively
> slow down all the calls - especially those where the length is a
> multiple of 8 (probably the most common).

Currently, most of the calls test with >=, and most of the others seem to
need to (either the size value did not look like a multiple of anything in
particular, or it was eg read from a device).

Note that it is BITS_PER_LONG, so it seems like it is typically 32 or 64,
not 8.

> Maybe the documented return code should be changed to allow for the
> existing behaviour.

Sorry, I'm not sure to understand what you suggest here.

thanks,
julia

_______________________________________________
ath10k mailing list
ath10k@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/ath10k
