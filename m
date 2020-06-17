Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 17 Jun 2020 13:31:57 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v4 0/3] mm, treewide: Rename kzfree() to kfree_sensitive()
Message-ID: <20200617113157.GM9499@dhcp22.suse.cz>
References: <20200616015718.7812-1-longman@redhat.com>
 <fe3b9a437be4aeab3bac68f04193cb6daaa5bee4.camel@perches.com>
 <20200616230130.GJ27795@twin.jikos.cz>
 <20200617003711.GD8681@bombadil.infradead.org>
 <20200617071212.GJ9499@dhcp22.suse.cz>
 <20200617110820.GG8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617110820.GG8681@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: dsterba@suse.cz, Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Dan Carpenter <dan.carpenter@oracle.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fscrypt@vger.kernel.org, ecryptfs@vger.kernel.org, kasan-dev@googlegroups.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

On Wed 17-06-20 04:08:20, Matthew Wilcox wrote:
> On Wed, Jun 17, 2020 at 09:12:12AM +0200, Michal Hocko wrote:
> > On Tue 16-06-20 17:37:11, Matthew Wilcox wrote:
> > > Not just performance critical, but correctness critical.  Since kvfree()
> > > may allocate from the vmalloc allocator, I really think that kvfree()
> > > should assert that it's !in_atomic().  Otherwise we can get into trouble
> > > if we end up calling vfree() and have to take the mutex.
> > 
> > FWIW __vfree already checks for atomic context and put the work into a
> > deferred context. So this should be safe. It should be used as a last
> > resort, though.
> 
> Actually, it only checks for in_interrupt().

You are right. I have misremembered. You have made me look (thanks) ...

> If you call vfree() under
> a spinlock, you're in trouble.  in_atomic() only knows if we hold a
> spinlock for CONFIG_PREEMPT, so it's not safe to check for in_atomic()
> in __vfree().  So we need the warning in order that preempt people can
> tell those without that there is a bug here.

... Unless I am missing something in_interrupt depends on preempt_count() as
well so neither of the two is reliable without PREEMPT_COUNT configured.

-- 
Michal Hocko
SUSE Labs
