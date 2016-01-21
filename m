From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Thu, 21 Jan 2016 09:23:09 +0100
Message-ID: <56A0956D.3010002@de.ibm.com>
References: <5698A023.9070703@de.ibm.com> <56990C9E.7020801@de.ibm.com>
 <20160118183205.GW6357@twins.programming.kicks-ass.net>
 <569D3370.6040503@de.ibm.com> <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com> <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris> <569F5E29.3090107@de.ibm.com>
 <20160120103036.GJ6357@twins.programming.kicks-ass.net>
 <20160120105302.GE6373@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160120105302.GE6373@twins.programming.kicks-ass.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/20/2016 11:53 AM, Peter Zijlstra wrote:
> On Wed, Jan 20, 2016 at 11:30:36AM +0100, Peter Zijlstra wrote:
>> On Wed, Jan 20, 2016 at 11:15:05AM +0100, Christian Borntraeger wrote:
>>> [  561.044066] Krnl PSW : 0704e00180000000 00000000001aa1ee (remove_entity_load_avg+0x1e/0x1b8)
>>
>>> [  561.044176] ([<00000000001ad750>] free_fair_sched_group+0x80/0xf8)
>>> [  561.044181]  [<0000000000192656>] free_sched_group+0x2e/0x58
>>> [  561.044187]  [<00000000001ded82>] rcu_process_callbacks+0x3fa/0x928
>>
>> Urgh,.. lemme stare at that.
> 
> Christian, can you test with the remove_entity_load_avg() call removed
> from free_fair_sched_group() ?
> 
> It will slightly mess up accounting, but should be non fatal and avoids
> this current issue.

With Tejuns "cpuset: make mm migration asynchronous" and this hack
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfdc0e6..0847bab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8099,8 +8099,8 @@ void free_fair_sched_group(struct task_group *tg)
                if (tg->cfs_rq)
                        kfree(tg->cfs_rq[i]);
                if (tg->se) {
-                       if (tg->se[i])
-                               remove_entity_load_avg(tg->se[i]);
+//                     if (tg->se[i])
+//                             remove_entity_load_avg(tg->se[i]);
                        kfree(tg->se[i]);
                }
        }

things look good now on the scheduler/cgroup front. Thank you for your
quick responses and answers.

There is another area now that triggers use after free (scsi). Posted here
for reference, I will start a new thread with the scsi folks.
Seems that Greg will have some work with 4.4.

[41345.563824] Unable to handle kernel pointer dereference in virtual kernel address space
[41345.563831] failing address: 000000fa36228000 TEID: 000000fa36228803
[41345.563833] Fault in home space mode while using kernel ASCE.
[41345.563837] AS:0000000000f60007 R3:000000ff627ff007 S:000000ff6264e000 P:000000fa36228400 
[41345.563873] Oops: 0011 ilc:2 [#1] SMP DEBUG_PAGEALLOC
[41345.563878] Modules linked in: nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp iptable_filter ip_tables x_tables bridge stp llc btrfs xor raid6_pq ecb ghash_s390 prng aes_s390 des_s390 des_generic sha512_s390 sha256_s390 sha1_s390 sha_common eadm_sch nfsd auth_rpcgss oid_registry nfs_acl lockd grace vhost_net tun vhost macvtap macvlan kvm sunrpc dm_service_time dm_multipath dm_mod autofs4
[41345.563910] CPU: 42 PID: 0 Comm: swapper/42 Not tainted 4.4.0+ #105
[41345.563912] task: 000000fa5cf08000 ti: 000000fa5cf04000 task.ti: 000000fa5cf04000
[41345.563914] Krnl PSW : 0704e00180000000 000000000033523a (dio_bio_complete+0xf2/0x100)
[41345.563922]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 EA:3
Krnl GPRS: 0000000000000000 000000fa5cf04000 0000000000000001 0000000000000000
[41345.563925]            000000000033523a 0000000000000000 0000000000000000 000000fa3b4f62e0
[41345.563927]            000000fa47e20a00 000000fa36228000 000000fa00001000 000000fa47e20a38
[41345.563929]            0000000000001000 000000000083a288 000000000033523a 000000fa5be2bbe8
[41345.563937] Krnl Code: 000000000033522c: a784ffb6		brc	8,335198
           0000000000335230: b9040029		lgr	%r2,%r9
          #0000000000335234: c0e5000f0f4e	brasl	%r14,5170d0
          >000000000033523a: 58c09014		l	%r12,20(%r9)
           000000000033523e: a7f4ffec		brc	15,335216
           0000000000335242: 0707		bcr	0,%r7
           0000000000335244: 0707		bcr	0,%r7
           0000000000335246: 0707		bcr	0,%r7
[41345.563984] Call Trace:
[41345.563986] ([<000000000033523a>] dio_bio_complete+0xf2/0x100)
[41345.563988]  [<00000000003354ea>] dio_bio_end_aio+0x42/0x168
[41345.563991]  [<000000000051ff92>] blk_update_request+0x102/0x468
[41345.563996]  [<00000000006020c0>] scsi_end_request+0x48/0x1d0
[41345.563998]  [<0000000000603d30>] scsi_io_completion+0x110/0x688
[41345.564002]  [<0000000000529676>] blk_done_softirq+0xb6/0xd0
[41345.564005]  [<0000000000142054>] __do_softirq+0xd4/0x4b0
[41345.564007]  [<000000000014280a>] irq_exit+0xe2/0x100
[41345.564009]  [<000000000010ce7a>] do_IRQ+0x6a/0x88
[41345.564013]  [<000000000081852e>] io_int_handler+0x11a/0x25c
[41345.564017]  [<0000000000104940>] enabled_wait+0x58/0xe8
[41345.564018] ([<0000000000104928>] enabled_wait+0x40/0xe8)
[41345.564021]  [<0000000000104de2>] arch_cpu_idle+0x32/0x48
[41345.564025]  [<000000000018f43e>] default_idle_call+0x3e/0x58
[41345.564027]  [<000000000018f6b8>] cpu_startup_entry+0x260/0x358
[41345.564030]  [<0000000000115692>] smp_start_secondary+0xf2/0x100
[41345.564033]  [<0000000000818afa>] restart_int_handler+0x62/0x78
[41345.564034]  [<0000000000000000>]           (null)
[41345.564036] INFO: lockdep is turned off.
[41345.564037] Last Breaking-Event-Address:
[41345.564042]  [<00000000002d6a6e>] kmem_cache_free+0x1e6/0x3a0
[41345.564044]  
[41345.564046] Kernel panic - not syncing: Fatal exception in interrupt
