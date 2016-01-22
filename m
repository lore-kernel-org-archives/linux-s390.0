From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH cgroup/for-4.5-fixes] cpuset: make mm migration
 asynchronous
Date: Fri, 22 Jan 2016 10:22:32 -0500
Message-ID: <20160122152232.GB32380@htj.duckdns.org>
References: <56978452.6010606@de.ibm.com>
 <20160114195630.GA3520@mtj.duckdns.org>
 <5698A023.9070703@de.ibm.com>
 <20160115164023.GH3520@mtj.duckdns.org>
 <20160119171841.GP3520@mtj.duckdns.org>
 <56A23BA8.1040403@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56A23BA8.1040403@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, cgroups@vger.kernel.org, kernel-team@fb.com
List-ID: <linux-s390.vger.kernel.org>

Hello, Christian.

On Fri, Jan 22, 2016 at 03:24:40PM +0100, Christian Borntraeger wrote:
> Hmmm I just realized that this patch slightly differs from the one that
> I tested. Do we need a retest?

It should be fine but I'd appreciate if you can test it again.

Thanks.

-- 
tejun
