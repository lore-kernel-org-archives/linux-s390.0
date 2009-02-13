From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [Patch] [S390]  Fix appldata build break with !NET
Date: Fri, 13 Feb 2009 14:43:36 +0100
Message-ID: <20090213144336.69a45d32@osiris.boeblingen.de.ibm.com>
References: <20090213175526.d0590862.sfr@canb.auug.org.au>
	<49954589.9060604@in.ibm.com>
	<49955945.2080809@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <49955945.2080809@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: schwidefsky@de.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Feb 2009 16:58:05 +0530
"Sachin P. Sant" <sachinp@in.ibm.com> wrote:

> With CONFIG_NET not set appldata build breaks on s390.
> 
> arch/s390/appldata/built-in.o: In function appldata_get_net_sum_data:
> appldata_net_sum.c:(.text+0x2684): undefined reference to dev_get_stats
> appldata_net_sum.c:(.text+0x2688): undefined reference to init_net
> appldata_net_sum.c:(.text+0x268c): undefined reference to init_net
> appldata_net_sum.c:(.text+0x2694): undefined reference to dev_base_lock
> 
> The following patch fixes the issue for me.

Added to our patch queue. Thanks, Sachin!
