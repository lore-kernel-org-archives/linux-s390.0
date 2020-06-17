Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 17 Jun 2020 14:55:53 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v4 0/3] mm, treewide: Rename kzfree() to kfree_sensitive()
Message-ID: <20200617125553.GO9499@dhcp22.suse.cz>
References: <20200616015718.7812-1-longman@redhat.com>
 <fe3b9a437be4aeab3bac68f04193cb6daaa5bee4.camel@perches.com>
 <20200616230130.GJ27795@twin.jikos.cz>
 <20200617003711.GD8681@bombadil.infradead.org>
 <20200617071212.GJ9499@dhcp22.suse.cz>
 <20200617110820.GG8681@bombadil.infradead.org>
 <20200617113157.GM9499@dhcp22.suse.cz>
 <20200617122321.GJ8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617122321.GJ8681@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: dsterba@suse.cz, Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Dan Carpenter <dan.carpenter@oracle.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fscrypt@vger.kernel.org, ecryptfs@vger.kernel.org, kasan-dev@googlegroups.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

On Wed 17-06-20 05:23:21, Matthew Wilcox wrote:
> On Wed, Jun 17, 2020 at 01:31:57PM +0200, Michal Hocko wrote:
> > On Wed 17-06-20 04:08:20, Matthew Wilcox wrote:
> > > If you call vfree() under
> > > a spinlock, you're in trouble.  in_atomic() only knows if we hold a
> > > spinlock for CONFIG_PREEMPT, so it's not safe to check for in_atomic()
> > > in __vfree().  So we need the warning in order that preempt people can
> > > tell those without that there is a bug here.
> > 
> > ... Unless I am missing something in_interrupt depends on preempt_count() as
> > well so neither of the two is reliable without PREEMPT_COUNT configured.
> 
> preempt_count() always tracks whether we're in interrupt context,
> regardless of CONFIG_PREEMPT.  The difference is that CONFIG_PREEMPT
> will track spinlock acquisitions as well.

Right you are! Thanks for the clarification. I find the situation
around preempt_count quite confusing TBH. Looking at existing users
of in_atomic() (e.g. a random one zd_usb_iowrite16v_async which check
in_atomic and then does GFP_KERNEL allocation which would be obviously
broken on !PREEMPT if the function can be called from an atomic
context), I am wondering whether it would make sense to track atomic
context also for !PREEMPT. This check is just terribly error prone.

-- 
Michal Hocko
SUSE Labs
