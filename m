Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1499338639.19466.25.camel@perches.com>
Subject: Re: [PATCH 12/18] drivers: s390: Move static and inline before
 return type
From: Joe Perches <joe@perches.com>
Date: Thu, 06 Jul 2017 03:57:19 -0700
In-Reply-To: <20170706102940.GG3217@osiris>
References: <cover.1499284835.git.joe@perches.com>
         <3f980cd89084ae09716353aba3171e4b3815e690.1499284835.git.joe@perches.com>
         <20170706102940.GG3217@osiris>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Klaus-Dieter Wacker <kdwacker@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2017-07-06 at 12:29 +0200, Heiko Carstens wrote:
> On Wed, Jul 05, 2017 at 01:02:21PM -0700, Joe Perches wrote:
> > Make the code like the rest of the kernel.
[]
> > diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.cqq
[]
> > @@ -2408,7 +2408,7 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> >  	return rc;
> >  }
> > 
> > -int inline qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
> > +inline int qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
> >  {
> 
> Actually the function could be made static, and "inline" should be removed,
> considering the large function body.

I agree to a certain extent.

It's only used once and  it looks like Klaus-Dieter Wacker
just missed adding static to this function.

$ git log --stat -p -1 ce73e10ee0cb6
commit ce73e10ee0cb6cde1c5075a2803da0f0eb5b2324
Author: Klaus-Dieter Wacker <kdwacker@de.ibm.com>

But it also looks like inline is too often used in several
drivers/s390/net/*.c files, where most of those static inline
functions are only used once.

$ git grep -w inline drivers/s390/net/*.c | wc -l
42

Maybe inline removals should be a separate pass for all those.
