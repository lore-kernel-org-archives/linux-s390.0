Return-Path: <hch@lst.de>
Date: Tue, 16 May 2017 17:51:32 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: RFC: better timer interface
Message-ID: <20170516155132.GA1494@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mark Gross <mark.gross@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 16, 2017 at 05:45:07PM +0200, Arnd Bergmann wrote:
> This looks really nice, but what is the long-term plan for the interface?
> Do you expect that we will eventually change all 700+ users of timer_list
> to the new type, or do we keep both variants around indefinitely to avoid
> having to do mass-conversions?

I think we should eventually move everyone over, but it might take
some time.

> If we are going to touch them all in the end, we might want to think
> about other changes that could be useful here. The main one I have
> in mind would be moving away from 'jiffies + timeout' as the interface,
> and instead passing a relative number of milliseconds (or seconds)
> into a mod_timer() variant. This is what most drivers want anyway,
> and if we have both changes (callback argument and expiration
> time) in place, we modernize the API one driver at a time with both
> changes at once.

Yes, that sounds useful to me as well.  As you said it's an independent
but somewhat related change.  I can add it to my series, but I'll
need a suggestions for a good and short name.  That already was the
hardest part for the setup side :)
