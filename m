From: Christoph Hellwig <hch@lst.de>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Tue, 26 Jan 2016 17:41:20 +0100
Message-ID: <20160126164120.GA3047@lst.de>
References: <20160120070740.GA3395@osiris> <569F5E29.3090107@de.ibm.com> <20160120103036.GJ6357@twins.programming.kicks-ass.net> <20160120104758.GD6373@twins.programming.kicks-ass.net> <20160120153007.GC5157@mtj.duckdns.org> <20160123020313.GA4915@linux.vnet.ibm.com> <20160125084942.GA7354@lst.de> <20160125193836.GH3628@mtj.duckdns.org> <20160126145157.GA31177@lst.de> <20160126152846.GO3628@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160126152846.GO3628@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 26, 2016 at 10:28:46AM -0500, Tejun Heo wrote:
> Hmmm... why do you need to call percpu_ref_exit() from process
> context?  All it does is freeing the percpu counter and resetting the
> state, both of which can be done from any context.

I checked and that's true indeed.  You cought me doing cargo cult
programming as the callers I looked at already do this.
