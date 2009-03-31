Return-Path: <linux-kernel-owner+w=401wt.eu-S1755408AbZCaVlp@vger.kernel.org>
Date: Tue, 31 Mar 2009 14:41:18 -0700 (PDT)
Message-Id: <20090331.144118.07019379.davem@davemloft.net>
Subject: Re: [PATCH] ETHOC: fix build breakage on s390
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090330115202.GA13719@avionic-design.de>
References: <20090330113015.21576898@osiris.boeblingen.de.ibm.com>
	<20090330115202.GA13719@avionic-design.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: thierry.reding@avionic-design.de
Cc: heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 30 Mar 2009 13:52:02 +0200

> * Heiko Carstens wrote:
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > Let driver depend on HAS_IOMEM to avoid build breakage on s390:
> > 
> >   CC      drivers/net/ethoc.o
> > drivers/net/ethoc.c: In function 'ethoc_read':
 ...
> > Cc: Thierry Reding <thierry.reding@avionic-design.de>
> > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
 ...
> Acked-by: Thierry Reding <thierry.reding@avionic-design.de>

Applied.
