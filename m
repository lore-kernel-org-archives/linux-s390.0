Return-path: <ath10k-bounces+kvalo=adurom.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1406041148590.2441@hadrien>
References: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAMuHMdXsoFUXj4jLMWN6NY7Um19KwWO9Rhx=9=gqWu_K5Ev2kQ@mail.gmail.com>
 <alpine.DEB.2.10.1406041137270.2441@hadrien>
 <063D6719AE5E284EB5DD2968C1650D6D1725705F@AcuExch.aculab.com>
 <alpine.DEB.2.10.1406041148590.2441@hadrien>
Date: Wed, 4 Jun 2014 12:55:29 +0200
Message-ID: <CAMuHMdXPBQTYA0c=1hkC7943-_J59TVSFaEKsfY1F2ogV=Ld+A@mail.gmail.com>
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
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: driverdevel <devel@driverdev.osuosl.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, "iss_storagedev@hp.com" <iss_storagedev@hp.com>, Linux-sh list <linux-sh@vger.kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, David Laight <David.Laight@aculab.com>, Arnd Bergmann <arnd@arndb.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Julia,

On Wed, Jun 4, 2014 at 11:52 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> Maybe the documented return code should be changed to allow for the
>> existing behaviour.
>
> Sorry, I'm not sure to understand what you suggest here.

include/asm-generic/bitops/find.h:

| /**
|  * find_first_zero_bit - find the first cleared bit in a memory region
|  * @addr: The address to start the search at
|  * @size: The maximum number of bits to search
|  *
|  * Returns the bit number of the first cleared bit.
|  * If no bits are zero, returns @size.

"If no bits are zero, returns @size or a number larger than @size."

|  */
| extern unsigned long find_first_zero_bit(const unsigned long *addr,
|                                          unsigned long size);

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
