From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: Re: [PATCH] net: s390: convert to hw_features
Date: Tue, 19 Apr 2011 16:11:42 +0200
Message-ID: <20110419141142.GA42906@tuxmaker.boeblingen.de.ibm.com>
References: <20110419104320.314AB13A66@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110419104320.314AB13A66@rere.qmqm.pl>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 19, 2011 at 12:43:20PM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> options.large_send was easy to get rid of. options.checksum_type has =
deeper
> roots so is left for later cleanup.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Hi Micha,

thx for the patch. There are some small issues I will fix up.
I will add the patch to my queue. It might be a good time to
get rid of the large_send and checksum sysfs attribute as well.
I will work on that too, thx again ...

=46rank
