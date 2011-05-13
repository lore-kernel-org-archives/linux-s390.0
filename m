From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: Re: [patch 1/9] [PATCH] qeth: convert to hw_features part 2
Date: Fri, 13 May 2011 09:57:10 +0200
Message-ID: <20110513075710.GA41213@tuxmaker.boeblingen.de.ibm.com>
References: <20110513044500.190198403@de.ibm.com> <20110513044547.424857838@de.ibm.com> <20110513073807.GA18312@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110513073807.GA18312@rere.qmqm.pl>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq@rere.qmqm.pl>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 13, 2011 at 09:38:07AM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> On Fri, May 13, 2011 at 06:45:01AM +0200, frank.blaschka@de.ibm.com w=
rote:
> > From: Frank Blaschka <frank.blaschka@de.ibm.com>
> > Set rx csum default to hw checksumming again.
> > Remove sysfs interface for rx csum (checksumming) and TSO (large_se=
nd).
> > With the new hw_features it does not work to keep the old sysfs
> > interface in parallel. Convert options.checksum_type to new hw_feat=
ures.
>=20
> Please see following patch (replacing qeth_l3_main.c part of your pat=
ch) for
> an illustration of my earlier comments.
>

Thx for the illustration. I will review and do some more testing. For n=
ow
Dave should apply my latest patch set so we get this stuff into next me=
rge
window.=20
