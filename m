From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Patch] [s390] Fix init irq proc build break.
Date: Tue, 10 Feb 2009 12:40:58 +0100
Message-ID: <1234266058.23901.0.camel@localhost>
References: <20090210194121.80256b72.sfr@canb.auug.org.au>
	 <4991573C.8000609@in.ibm.com>  <499161C3.2070407@in.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <499161C3.2070407@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, heiko.carstens@de.ibm.com, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2009-02-10 at 16:45 +0530, Sachin P. Sant wrote:
> * Embed init_irq_proc(s390) within CONFIG_PROC_FS to fix a build
> break.
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>

I'll queue the patch to git390.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
