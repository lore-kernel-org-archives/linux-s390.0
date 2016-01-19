From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Tue, 19 Jan 2016 20:36:18 +0100
Message-ID: <569E9032.3070903@de.ibm.com>
References: <56978452.6010606@de.ibm.com>
 <20160114195630.GA3520@mtj.duckdns.org> <5698A023.9070703@de.ibm.com>
 <56990C9E.7020801@de.ibm.com>
 <20160118183205.GW6357@twins.programming.kicks-ass.net>
 <569D3370.6040503@de.ibm.com> <20160119095518.GC3528@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160119095518.GC3528@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/19/2016 10:55 AM, Heiko Carstens wrote:
> On Mon, Jan 18, 2016 at 07:48:16PM +0100, Christian Borntraeger wrote:
>> On 01/18/2016 07:32 PM, Peter Zijlstra wrote:
>>> On Fri, Jan 15, 2016 at 04:13:34PM +0100, Christian Borntraeger wrote:
>>>>> Yes, the deadlock is gone and the system is still running.
>>>>> After some time I had the following WARN in the logs, though.
>>>>> Not sure yet if that is related.
>>>>>
>>>>> [25331.763607] DEBUG_LOCKS_WARN_ON(lock->owner != current)
>>>>> [25331.763630] ------------[ cut here ]------------
>>>>> [25331.763634] WARNING: at kernel/locking/mutex-debug.c:80
>>>
>>>> I restarted the test with panic_on_warn. Hopefully I can get a dump to check
>>>> which mutex this was.
>>>
>>> Hard to reproduce warnings like this tend to point towards memory
>>> corruption. Someone stepped on the mutex value and tickles the sanity
>>> check.
>>>
>>> With lockdep and debugging enabled the mutex gets quite a bit bigger, so
>>> it gets more likely to be hit by 'random' corruption.
>>>
>>> The locking in seq_read() seems rather straight forward.
>>
>> I was able to reproduce. The dump shows a mutex that has an owner field, which
>> does not exists as a task so this all looks fishy. The good thing is, that I
>> can reproduce the issue within some hours. (exact same backtrace). Will add some
>> more debug data to get a handle where we come from.
> 
> Did the owner field show to something that still looks like a task_struct?

No, its not a task_struct. Activating some more debug information did indeed 
revealed several other issues (overwritten redzones etc). Unfortunately I 
only saw the broken things after the facts, so I do not know which code did that.
When I disabled the cgroup controllers in libvirt I was no longer able to trigger
the bugs. Still trying to narrow things down.

Christian
