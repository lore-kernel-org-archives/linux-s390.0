From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Wed, 20 Jan 2016 11:15:05 +0100
Message-ID: <569F5E29.3090107@de.ibm.com>
References: <56978452.6010606@de.ibm.com>
 <20160114195630.GA3520@mtj.duckdns.org> <5698A023.9070703@de.ibm.com>
 <56990C9E.7020801@de.ibm.com>
 <20160118183205.GW6357@twins.programming.kicks-ass.net>
 <569D3370.6040503@de.ibm.com> <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com> <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160120070740.GA3395@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/20/2016 08:07 AM, Heiko Carstens wrote:
> On Tue, Jan 19, 2016 at 02:38:45PM -0500, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Jan 19, 2016 at 08:36:18PM +0100, Christian Borntraeger wrote:
>>> No, its not a task_struct. Activating some more debug information did indeed 
>>> revealed several other issues (overwritten redzones etc). Unfortunately I 
>>> only saw the broken things after the facts, so I do not know which code did that.
>>> When I disabled the cgroup controllers in libvirt I was no longer able to trigger
>>> the bugs. Still trying to narrow things down.
>>
>> Hmmm... that's worrying.  CONFIG_DEBUG_PAGEALLOC sometimes can catch
>> these sort of bugs red-handed.  Might worth trying.
> 
> Christian, just to avoid that you get surprised like I did:
> CONFIG_DEBUG_PAGEALLOC requires in the meantime an additional kernel
> parameter "debug_pagealloc=on" to be active.
> 
> That change was introduced a year ago, so it was probably only me who
> wasn't aware of that change :)

I had CONFIG_DEBUG_PAGEALLOC, but not the command line. :-(

With that enabled I now have:

[  561.043895] Unable to handle kernel pointer dereference in virtual kernel address space
[  561.043902] failing address: 000000fa14b30000 TEID: 000000fa14b30803
[  561.043905] Fault in home space mode while using kernel ASCE.
[  561.043911] AS:0000000000fa5007 R3:000000ff627ff007 S:000000ff62759800 P:000000fa14b30400 
[  561.043953] Oops: 0011 ilc:3 [#1] SMP DEBUG_PAGEALLOC
[  561.043964] Modules linked in: nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp iptable_filter ip_tables x_tables bridge stp llc btrfs xor raid6_pq ghash_s390 prng ecb aes_s390 des_s390 des_generic sha512_s390 sha256_s390 sha1_s390 sha_common eadm_sch nfsd auth_rpcgss vhost_net tun oid_registry nfs_acl lockd vhost macvtap macvlan grace sunrpc dm_service_time dm_multipath dm_mod autofs4
[  561.044057] CPU: 52 PID: 215 Comm: ksoftirqd/52 Not tainted 4.4.0+ #94
[  561.044062] task: 000000fa5bc48000 ti: 000000fa5bc50000 task.ti: 000000fa5bc50000
[  561.044066] Krnl PSW : 0704e00180000000 00000000001aa1ee (remove_entity_load_avg+0x1e/0x1b8)
[  561.044080]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 EA:3
Krnl GPRS: 0000000000000000 000000fa0933b3d8 000000fa0b411860 000000fa14b30000
[  561.044087]            00000000001ad750 0000000000000001 0000000000000000 000000000000000a
[  561.044093]            0000000000d28b0c 0000000000c4ba28 0000000000000028 0000000000000140
[  561.044095]            000000fa389f0348 000000000084cfb0 00000000001ad774 000000fa5bc53b88
[  561.044105] Krnl Code: 00000000001aa1dc: c0d0003516ea	larl	%r13,84cfb0
           00000000001aa1e2: e33020780004	lg	%r3,120(%r2)
          #00000000001aa1e8: e30020880004	lg	%r0,136(%r2)
          >00000000001aa1ee: e34030580004	lg	%r4,88(%r3)
           00000000001aa1f4: b9e90014		sgrk	%r1,%r4,%r0
           00000000001aa1f8: ec140095007c	cgij	%r1,0,4,1aa322
           00000000001aa1fe: eb11000a000c	srlg	%r1,%r1,10
           00000000001aa204: ec160013007c	cgij	%r1,0,6,1aa22a
[  561.044170] Call Trace:
[  561.044176] ([<00000000001ad750>] free_fair_sched_group+0x80/0xf8)
[  561.044181]  [<0000000000192656>] free_sched_group+0x2e/0x58
[  561.044187]  [<00000000001ded82>] rcu_process_callbacks+0x3fa/0x928
[  561.044194]  [<00000000001676a4>] __do_softirq+0xd4/0x4b0
[  561.044199]  [<0000000000167abe>] run_ksoftirqd+0x3e/0xa8
[  561.044204]  [<000000000018d5bc>] smpboot_thread_fn+0x16c/0x2a0
[  561.044210]  [<0000000000188704>] kthread+0x10c/0x128
[  561.044216]  [<000000000083d8a2>] kernel_thread_starter+0x6/0xc
[  561.044220]  [<000000000083d89c>] kernel_thread_starter+0x0/0xc
[  561.044223] INFO: lockdep is turned off.
[  561.044225] Last Breaking-Event-Address:
[  561.044230]  [<00000000001ad76e>] free_fair_sched_group+0x9e/0xf8
[  561.044237]  
[  561.044241] Kernel panic - not syncing: Fatal exception in interrupt


Will look into that and see if fixing this makes the problem go away.
(unless somebody else has a quick idea)

Christian
