From: Tejun Heo <tj@kernel.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Mon, 25 Jan 2016 14:38:36 -0500
Message-ID: <20160125193836.GH3628@mtj.duckdns.org>
References: <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com>
 <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris>
 <569F5E29.3090107@de.ibm.com>
 <20160120103036.GJ6357@twins.programming.kicks-ass.net>
 <20160120104758.GD6373@twins.programming.kicks-ass.net>
 <20160120153007.GC5157@mtj.duckdns.org>
 <20160123020313.GA4915@linux.vnet.ibm.com>
 <20160125084942.GA7354@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160125084942.GA7354@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hello, Christoph.

On Mon, Jan 25, 2016 at 09:49:42AM +0100, Christoph Hellwig wrote:
> FYI, my use case was also related to percpu-ref.  The percpu ref API
> is unfortunately really hard to use and will almost always involve
> a work queue due to the complex interaction between percpu_ref_kill
> and percpu_ref_exit.  One thing that would help a lot of callers would

That's interesting.  Can you please elaborate on how kill and exit
interact to make things complex?

> be a percpu_ref_exit_sync that kills the ref and waits for all references
> to go away synchronously.

That shouldn't be difficult to implement.  One minor concern is that
it's almost guaranteed that there will be cases where the
synchronicity is exposed to userland.  Anyways, can you please
describe the use case?

Thanks.

-- 
tejun
