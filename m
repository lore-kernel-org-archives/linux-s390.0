Return-Path: <linux-kernel-owner+w=401wt.eu-S1753654AbXJWHa1@vger.kernel.org>
Date: Tue, 23 Oct 2007 09:28:44 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] net: fix xfrm build - missing scatterlist.h include
Message-ID: <20071023072843.GJ25962@kernel.dk>
References: <1193076664-13652-1-git-send-email-jens.axboe@oracle.com> <1193076664-13652-3-git-send-email-jens.axboe@oracle.com> <20071023051316.GB10055@osiris.boeblingen.de.ibm.com> <20071023051640.GL16425@kernel.dk> <20071023054441.GA24546@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071023054441.GA24546@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, mingo@elte.hu, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 23 2007, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> net/xfrm/xfrm_algo.c: In function 'skb_icv_walk':
> net/xfrm/xfrm_algo.c:555: error: implicit declaration of function 'sg_set_page'
> make[2]: *** [net/xfrm/xfrm_algo.o] Error 1

Thanks, arch fallout... Applied.

-- 
Jens Axboe
