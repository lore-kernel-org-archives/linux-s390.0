Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Oct 2017 18:30:14 +0900 (KST)
Message-Id: <20171024.183014.399601216375547757.davem@davemloft.net>
Subject: Re: [PATCH v2] net: smc_close: mark expected switch fall-through
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171022013530.GA15859@embeddedor.com>
References: <20171021202100.Horde.z-7P99HVhWm0m3hXj5cOjur@gator4166.hostgator.com>
        <20171022013530.GA15859@embeddedor.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: garsilva@embeddedor.com
Cc: ubraun@linux.vnet.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Sat, 21 Oct 2017 20:35:30 -0500

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I placed the "fall through" comment
> on its own line, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> Changes in v2:
>  Move the "fall through" comment on its own line
>  above the rest of the sentence.

Applied.
