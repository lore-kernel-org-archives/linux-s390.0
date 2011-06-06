From: David Miller <davem@davemloft.net>
Subject: Re: [BUG] net: cpu offline cause napi stall
Date: Mon, 06 Jun 2011 14:50:51 -0700 (PDT)
Message-ID: <20110606.145051.267562411413352856.davem@davemloft.net>
References: <20110601181253.GA2374@osiris.boeblingen.de.ibm.com>
	<1306958592.3946.0.camel@edumazet-laptop>
	<20110601204233.GA2410@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20110601204233.GA2410@osiris.boeblingen.de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: heiko.carstens@de.ibm.com
Cc: eric.dumazet@gmail.com, blaschka@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

=46rom: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 1 Jun 2011 22:42:34 +0200

> On Wed, Jun 01, 2011 at 10:03:12PM +0200, Eric Dumazet wrote:
>> Le mercredi 01 juin 2011 =E0 20:12 +0200, Heiko Carstens a =E9crit :
>> > On Wed, Jun 01, 2011 at 06:55:21PM +0200, Eric Dumazet wrote:
>> > > > +	/* Append NAPI poll list from offline CPU. */
>> > > > +	list_splice_init(&oldsd->poll_list, &sd->poll_list);
>> > > > =20
>> > > >  	raise_softirq_irqoff(NET_TX_SOFTIRQ);
>> > > >  	local_irq_enable();
>> > >=20
>> > > Please make sure we raise NET_RX_SOFTIRQ on new cpu if necessary=
=2E
>> >=20
>> > Well, see two lines below the list_splice_init() call ;)
>>=20
>> I see nothing... NET_TX_SOFTIRQ and NET_RX_SOFTIRQ are not the same=20
>=20
> Indeed. I must be blind.

Can I get a final version of this patch with proper commit log message,
signoffs, etc.?

Thanks!
