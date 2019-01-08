From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 13/15] KVM: s390: add function
 process_gib_alert_list()
Date: Tue, 8 Jan 2019 19:34:46 +0100
Message-ID: <20190108193446.1d547106@oc2783563651>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-14-mimu@linux.ibm.com>
        <20190108135919.18048dd4@oc2783563651>
        <7e4a5077-00f0-3a0f-e21a-5bbc2fa14b70@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7e4a5077-00f0-3a0f-e21a-5bbc2fa14b70@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 8 Jan 2019 16:21:17 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> >> +			gisa->next_alert = origin;
> >> +			kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
> >> +			/* Kick suitable vcpus */
> >> +			__floating_airqs_kick(kvm);  
> > 
> > We may finish handling the alerted gisa with iam not set e.g.
> > via some vcpus kicked but ipm still dirty and some vcpus still in wait,
> > or?  
> 
> My above mentioned change to the routine identifying the vcpus to kick
> will select one vcpu for each ISC pending if possible (depends on the
> number of idle vcpus and their respective interruption masks and the
> pending ISCs).
> 
> That does not exclude the principle scenario that maybe only one vcpu
> is kicked and multiple ISCs are pending (ipm still dirty) although
> have never observed this with a Linux guest.
> 

IMHO we have to differentiate between the general case and between what
can happen with current or historical Linux guests.

Regarding Linux guests, I'm under the impression each version was quite
there. I says so, also because I have a reasonable amount of confidence
in your testing.

> What I was trying to avoid was a kind of busy loop running in addition
> to the kicked vcpus monitoring the IPM state for resource utilization
> reasons.
> 

Got it. I think we need a clean switch-over (between our
code makes sure the no pending interrupts are going to get stalled in
spite of waiting vcpus that could take them, and between we are good now
and if we are not good any more we will get an alert) nevertheless. 

> > 
> >  From the comments it seems we speculate on being in a safe state, as
> > these are supposed to return to wait or stop soon-ish, and we will set
> > iam then (See <MARK A>). I don't quite understand.  
> 
> 
> Yes, the next vcpu going idle shall restore the IAM or process the
> top ISC pending if the iomask (GCR) allows. vcpus are not allowed to go 
> in disabled wait (IO int disabled by PSW). If all vcpus always (for
> some time) mask a specific ISC the guest does not want to get 
> interrupted for that ISC but will as soon a running vcpu will open
> the mask again.
> 

My understanding on the guarantees we can provide based on the fact that
we kicked some vcpus is still lacking. Maybe let us discuss this offline.

> > 
> > According to my current understanding we might end up loosing initiative
> > in this scenario. Or am I wrong?  
> 
> I currently don't have proof for you being wrong but have not observed
> the situation yet.


See above. Proving that no irq's can get substantially delayed
needlessly (where needlessly means, there is a vcpu in wait state that
could take the irq) would be a proof enough that I'm wrong. Let's
make this discussion more efficient by utilizing co-location to cut
down the RTT.

Regards,
Halil
