From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [BUG] net: cpu offline cause napi stall
Date: Wed, 01 Jun 2011 22:03:12 +0200
Message-ID: <1306958592.3946.0.camel@edumazet-laptop>
References: <20110601103356.GA45482@tuxmaker.boeblingen.de.ibm.com>
	 <1306930399.3476.1.camel@edumazet-laptop>
	 <20110601163628.GA2418@osiris.boeblingen.de.ibm.com>
	 <1306947321.2890.5.camel@edumazet-laptop>
	 <20110601181253.GA2374@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20110601181253.GA2374@osiris.boeblingen.de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Frank Blaschka <blaschka@linux.vnet.ibm.com>, davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Le mercredi 01 juin 2011 =C3=A0 20:12 +0200, Heiko Carstens a =C3=A9cri=
t :
> On Wed, Jun 01, 2011 at 06:55:21PM +0200, Eric Dumazet wrote:
> > > +	/* Append NAPI poll list from offline CPU. */
> > > +	list_splice_init(&oldsd->poll_list, &sd->poll_list);
> > > =20
> > >  	raise_softirq_irqoff(NET_TX_SOFTIRQ);
> > >  	local_irq_enable();
> >=20
> > Please make sure we raise NET_RX_SOFTIRQ on new cpu if necessary.
>=20
> Well, see two lines below the list_splice_init() call ;)

I see nothing... NET_TX_SOFTIRQ and NET_RX_SOFTIRQ are not the same=20
