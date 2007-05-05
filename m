Return-Path: <linux-kernel-owner+w=401wt.eu-S1754610AbXEESlp@vger.kernel.org>
Date: Sat, 05 May 2007 11:41:30 -0700 (PDT)
Message-Id: <20070505.114130.102613546.davem@davemloft.net>
Subject: Re: [patch] af_iucv: compile fix - adopt to skbuff changes.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070505132058.GC13660@osiris.boeblingen.de.ibm.com>
References: <20070505132058.GC13660@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: heiko.carstens@de.ibm.com
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, fpavlic@de.ibm.com, schwidefsky@de.ibm.com, acme@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Sat, 5 May 2007 15:20:58 +0200

> [patch] af_iucv: compile fix - adopt to skbuff changes.
> 
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
>   CC [M]  net/iucv/af_iucv.o
> net/iucv/af_iucv.c: In function `iucv_fragment_skb':
> net/iucv/af_iucv.c:984: error: structure has no member named `h'
> net/iucv/af_iucv.c:985: error: structure has no member named `nh'
> net/iucv/af_iucv.c:988: error: incompatible type for argument 1 of
> 			`skb_queue_tail'
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Frank Pavlic <fpavlic@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Applied, thanks Heiko.
