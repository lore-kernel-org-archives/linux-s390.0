From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Fri, 07 Dec 2012 14:39:19 +0000
Subject: Re: qethconf does not work correctly over bonding devices
Message-Id: <1354891159.24668.7.camel@BR9GV9YG.de.ibm.com>
In-Reply-To: <50C1E7C5.3020607@gmail.com>
References: <50C1E7C5.3020607@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> On 12/07/2012 01:55 PM, Xose Vazquez Perez wrote:
> > hi,
> >
> > # qethconf vipa add "IP" bond0 : up and running.
> >
> > # qethconf vipa del "IP" bond0 : it does not work.
> >
> > # qethconf list_all : this shows nothing.
> >
> > tested on SLES 10-SP4, LPAR z10 2097 E64
> >
> > -thanks-
> 
> done with s390-tools-1.17.0

What do you want to configure here? Mixing qethconf with a bonding
interface does not make sense. qethconf is a configuration tool for
OSA-Express cards in Layer3 mode; thus it should be used for qeth
interfaces only, not for bonding interfaces. Bonding on the other side
requires Layer2 slaves; thus there is no need to make use of qethconf
for OSA bonding slaves.

Kind regards, Ursula Braun, IBM Germany
