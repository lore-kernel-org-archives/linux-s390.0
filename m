From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 09/13] KVM: s390: add the GIB and its related
 life-cyle functions
Date: Mon, 28 Jan 2019 17:59:10 +0100
Message-ID: <20190128175910.5d9677e7@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-10-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-10-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:35 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> The Guest Information Block (GIB) links the GISA of all guests
> that have adapter interrupts pending. These interrupts cannot be
> delivered because all vcpus of these guests are currently in WAIT
> state or have masked the respective Innterruption Sub Class (ISC).
> If enabled, a GIB alert is issued on the host to schedule these
> guests to run suitable vcpus to consume the pending interruptions.
> 
> This mechanism allows to process adapter interrupts for currently
> not running guests.
> 
> The GIB is created during host initialization and associated with
> the Adapter Interruption Facility in case an Adapter Interruption
> Virtualization Facility is available.
> 
> The GIB initialization and thus the activation of the related code
> will be done in an upcoming patch of this series.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

I don't agree with the commit message to 100%, but I'd rather not start
a discussion.

Acked-by: Halil Pasic <pasic@linux.ibm.com>

[..]
