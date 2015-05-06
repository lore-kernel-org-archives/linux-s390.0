From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] kvm/powerpc: report guest steal time in host
Date: Wed, 6 May 2015 22:12:15 +0530
Message-ID: <20150506164215.GB26540@naverao1-tp.in.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
 <c0db7eafdd13fcec26a0398e2ad0b7225c3998e9.1430913088.git.naveen.n.rao@linux.vnet.ibm.com>
 <554A0D0D.8090209@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <554A0D0D.8090209@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au, agraf@suse.de, mingo@redhat.com, ego@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2015/05/06 02:46PM, Christian Borntraeger wrote:
> Am 06.05.2015 um 13:56 schrieb Naveen N. Rao:
> > On powerpc, kvm tracks both the guest steal time as well as the time
> > when guest was idle and this gets sent in to the guest through DTL. The
> > guest accounts these entries as either steal time or idle time based on
> > the last running task. Since the true guest idle status is not visible
> > to the host, we can't accurately expose the guest steal time in the
> > host.
> > 
> > However, tracking the guest vcpu cede status can get us a reasonable
> > (within 5% variation) vcpu steal time since guest vcpus cede the
> > processor on entering the idle task. To do this, we introduce a new
> > field ceded_st in kvm_vcpu_arch structure to accurately track the guest
> > vcpu cede status (this is needed since the existing ceded field is
> > modified before we can use it). During DTL entry creation, we check this
> > flag and account the time as stolen if the guest vcpu had not ceded.
> 
> I think this is more or less a question about the semantic:
> 
> What would happen if you use  current->sched_info.run_delay like x86 also
> on power? How far are the numbers away?

The numbers were quite off and didn't quite make sense.

> My feeling is, that the semantics
> of "steal time" inside the guest is somewhat different on each platform. 
> 
> This brings me to a 2nd question:
> Do you need to match the host view of guest steal time with the guest view
> or do we want to have a host view that translates as "this is the time that
> the guest was runnable but we were too busy to schedule him"?

Very good point. This is probably good enough for our purpose and I'd 
like to think my current patchset does something similar for powerpc. We 
don't report the exact steal time as seen from within the guest, but a 
close approximation of it. We count all time that a vcpu was not-idle as 
steal. This includes time we were doing something in the host on behalf 
of the vcpu as well as time when we were just doing something else. I 
don't know if we can separate these two or if that would be desirable.  
The scheduler statistics don't seem to accurately reflect this on ppc.

> For the former x86 has the best solution, as the host tells the guest its
> understanding of steal - so both match. For the latter we actually try to
> give guest steal a meaning in the host context  - the overload.
> Would /proc/<pid>/schedstat value 2 (time spent waiting on a runqueue)
> meet your requirements from the cover-letter?

This looks to be the same as sched_info.run_delay, which doesn't seem to 
reflect the wait on the runqueue. I will recheck this on ppc tomorrow.

As an aside, do you happen to know if /proc/<pid>/schedstat accurately 
reports the "overload" on s390?


Thanks!
- Naveen
