From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/3] kvm/powerpc: report guest steal time in host
Date: Thu, 07 May 2015 14:04:18 +0200
Message-ID: <554B54C2.70903@de.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com> <c0db7eafdd13fcec26a0398e2ad0b7225c3998e9.1430913088.git.naveen.n.rao@linux.vnet.ibm.com> <554A0D0D.8090209@de.ibm.com> <20150506164215.GB26540@naverao1-tp.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20150506164215.GB26540@naverao1-tp.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au, agraf@suse.de, mingo@redhat.com, ego@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Am 06.05.2015 um 18:42 schrieb Naveen N. Rao:
> On 2015/05/06 02:46PM, Christian Borntraeger wrote:
>> Am 06.05.2015 um 13:56 schrieb Naveen N. Rao:
>>> On powerpc, kvm tracks both the guest steal time as well as the time
>>> when guest was idle and this gets sent in to the guest through DTL. The
>>> guest accounts these entries as either steal time or idle time based on
>>> the last running task. Since the true guest idle status is not visible
>>> to the host, we can't accurately expose the guest steal time in the
>>> host.
>>>
>>> However, tracking the guest vcpu cede status can get us a reasonable
>>> (within 5% variation) vcpu steal time since guest vcpus cede the
>>> processor on entering the idle task. To do this, we introduce a new
>>> field ceded_st in kvm_vcpu_arch structure to accurately track the guest
>>> vcpu cede status (this is needed since the existing ceded field is
>>> modified before we can use it). During DTL entry creation, we check this
>>> flag and account the time as stolen if the guest vcpu had not ceded.
>>
>> I think this is more or less a question about the semantic:
>>
>> What would happen if you use  current->sched_info.run_delay like x86 also
>> on power? How far are the numbers away?
> 
> The numbers were quite off and didn't quite make sense.

Strange. I would expect to match at least the wall clock time between
runnable and running. Maybe its just a bug?


> 
>> My feeling is, that the semantics
>> of "steal time" inside the guest is somewhat different on each platform. 
>>
>> This brings me to a 2nd question:
>> Do you need to match the host view of guest steal time with the guest view
>> or do we want to have a host view that translates as "this is the time that
>> the guest was runnable but we were too busy to schedule him"?
> 
> Very good point. This is probably good enough for our purpose and I'd 
> like to think my current patchset does something similar for powerpc. We 
> don't report the exact steal time as seen from within the guest, but a 
> close approximation of it. We count all time that a vcpu was not-idle as 
> steal. This includes time we were doing something in the host on behalf 
> of the vcpu as well as time when we were just doing something else. I 
> don't know if we can separate these two or if that would be desirable.  
> The scheduler statistics don't seem to accurately reflect this on ppc.
> 
>> For the former x86 has the best solution, as the host tells the guest its
>> understanding of steal - so both match. For the latter we actually try to
>> give guest steal a meaning in the host context  - the overload.
>> Would /proc/<pid>/schedstat value 2 (time spent waiting on a runqueue)
>> meet your requirements from the cover-letter?
> 
> This looks to be the same as sched_info.run_delay, which doesn't seem to 
> reflect the wait on the runqueue. I will recheck this on ppc tomorrow.
> 
> As an aside, do you happen to know if /proc/<pid>/schedstat accurately 
> reports the "overload" on s390?

Things are usually even more complicated as we always have the LPAR hypervisor
below the KVM or z/VM hypervisor (KVM or z/VM guests are always nested so to
speak). Depending on the overcommit on LPAR level the wall clock times might 
indicate a problem in a "wrong" place. 

Now the steal time in a kvm guest is actually precise as the hardware will
step the guest cpu timer only when both LPAR and KVM have this CPU scheduled.
This will also cause "steal" when KVM emulates an instruction for the guest - 
unless we correct the guest view - which we dont right now.
The Linux in LPAR also sees the steal time it got stolen by LPAR.

I really have not looked closely at run_delay. My assumption is that
it boils down to "wall clock time between runnable and running". If the
admin does overcommit in KVM and LPAR is just slightly  overcommitted this
is probably good enough. If the overcommit happens at LPAR then the value
might be confusing. I would assume that people overcommit at the z/VM or KVM
level and the LPAR is managed with less overcommit - but thats not a given.

Christian
