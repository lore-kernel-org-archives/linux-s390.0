From: Tejun Heo <tj@kernel.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Fri, 15 Jan 2016 11:40:23 -0500
Message-ID: <20160115164023.GH3520@mtj.duckdns.org>
References: <56978452.6010606@de.ibm.com>
 <20160114195630.GA3520@mtj.duckdns.org>
 <5698A023.9070703@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5698A023.9070703@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 15, 2016 at 08:30:43AM +0100, Christian Borntraeger wrote:
> On 01/14/2016 08:56 PM, Tejun Heo wrote:
> > Hello,
> > 
> > Thanks a lot for the report and detailed analysis.  Can you please
> > test whether the following patch fixes the issue?
> > 
> > Thanks.
> > 
> 
> 
> Yes, the deadlock is gone and the system is still running.
> After some time I had the following WARN in the logs, though.
> Not sure yet if that is related.

Hmmm... doesn't seem to be related.  I'll spruce up the patch and
route it through cgroup tree w/ stable cc'd.  Please keep me posted on
the lockdep issue.

Thanks!

-- 
tejun
