From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Fri, 15 Jan 2016 16:13:34 +0100
Message-ID: <56990C9E.7020801@de.ibm.com>
References: <56978452.6010606@de.ibm.com>
 <20160114195630.GA3520@mtj.duckdns.org> <5698A023.9070703@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5698A023.9070703@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/15/2016 08:30 AM, Christian Borntraeger wrote:
> On 01/14/2016 08:56 PM, Tejun Heo wrote:
>> Hello,
>>
>> Thanks a lot for the report and detailed analysis.  Can you please
>> test whether the following patch fixes the issue?
>>
>> Thanks.
>>
> 
> 
> Yes, the deadlock is gone and the system is still running.
> After some time I had the following WARN in the logs, though.
> Not sure yet if that is related.
> 
> [25331.763607] DEBUG_LOCKS_WARN_ON(lock->owner != current)
> [25331.763630] ------------[ cut here ]------------
> [25331.763634] WARNING: at kernel/locking/mutex-debug.c:80
> [25331.763637] Modules linked in: nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp iptable_filter ip_tables x_tables bridge stp llc btrfs xor raid6_pq ghash_s390 prng ecb aes_s390 des_s390 des_generic sha512_s390 sha256_s390 sha1_s390 sha_common eadm_sch nfsd auth_rpcgss oid_registry nfs_acl lockd vhost_net tun vhost macvtap macvlan grace sunrpc dm_service_time dm_multipath dm_mod autofs4
> [25331.763708] CPU: 56 PID: 114657 Comm: systemd-udevd Not tainted 4.4.0+ #91
> [25331.763711] task: 000000fadc79de40 ti: 000000f95e7f8000 task.ti: 000000f95e7f8000
> [25331.763715] Krnl PSW : 0404c00180000000 00000000001b7f32 (debug_mutex_unlock+0x16a/0x188)
> [25331.763726]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 EA:3
> Krnl GPRS: 0000004c00000037 000000fadc79de40 000000000000002b 0000000000000000
> [25331.763732]            000000000028da3c 0000000000000000 000000f95e7fbf08 000000fab8e10df0
> [25331.763735]            000000000000005c 000000facc0dc000 000000000000005c 000000000033e14a
> [25331.763738]            0700000000000000 000000fab8e10df0 00000000001b7f2e 000000f95e7fbc80
> [25331.763746] Krnl Code: 00000000001b7f22: c0200042784c	larl	%r2,a06fba
>            00000000001b7f28: c0e50006ad50	brasl	%r14,28d9c8
>           #00000000001b7f2e: a7f40001		brc	15,1b7f30
>           >00000000001b7f32: a7f4ffe1		brc	15,1b7ef4
>            00000000001b7f36: c03000429c9f	larl	%r3,a0b874
>            00000000001b7f3c: c0200042783f	larl	%r2,a06fba
>            00000000001b7f42: c0e50006ad43	brasl	%r14,28d9c8
>            00000000001b7f48: a7f40001		brc	15,1b7f4a
> [25331.763795] Call Trace:
> [25331.763798] ([<00000000001b7f2e>] debug_mutex_unlock+0x166/0x188)
> [25331.763804]  [<0000000000836a08>] __mutex_unlock_slowpath+0xa8/0x190
> [25331.763808]  [<000000000033e14a>] seq_read+0x1c2/0x450
> [25331.763813]  [<0000000000311e72>] __vfs_read+0x42/0x100
> [25331.763818]  [<000000000031284e>] vfs_read+0x76/0x130
> [25331.763821]  [<000000000031361e>] SyS_read+0x66/0xd8
> [25331.763826]  [<000000000083af06>] system_call+0xd6/0x270
> [25331.763829]  [<000003ffae1f19c8>] 0x3ffae1f19c8
> [25331.763831] INFO: lockdep is turned off.
> [25331.763833] Last Breaking-Event-Address:
> [25331.763836]  [<00000000001b7f2e>] debug_mutex_unlock+0x166/0x188
> [25331.763839] ---[ end trace 45177640eb39ef44 ]---
> 

I restarted the test with panic_on_warn. Hopefully I can get a dump to check
which mutex this was.

Christian
