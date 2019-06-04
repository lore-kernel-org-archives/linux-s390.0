Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 4 Jun 2019 16:56:13 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] vfio: ap: AP Queue Interrupt Control
In-Reply-To: <5b46f988-fa79-4d84-c81f-144daa0c4426@linux.ibm.com>
References: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
        <5b46f988-fa79-4d84-c81f-144daa0c4426@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190604165613.4d2803b4.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com

On Thu, 23 May 2019 11:36:12 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 5/21/19 11:34 AM, Pierre Morel wrote:
> > This patch series implements PQAP/AQIC interception in KVM.
> > 

[..]

> > 
> > Tony, I did not rebase this series above the dynamic configuration
> > patches because:
> > - This series do the work it needs to do without having to take
> >    care on the dynamic configuration.
> > - It is guarantied that interrupt will be shut off after removing
> >    the APQueue device
> > - The dynamic configuration series is not converging.  
> 
> Would you consider the following?
> 
> * Take dynconfig patch "s390: vfio-ap: wait for queue empty on queue

[..]

> 
> If you do the things above, then I can base the dynconfig series on
> the IRQ series without much of a merge issue. What say you?
> 
> Note: I've included review comments for patch 3/4 to match the
>        suggestions above.
> 
> > 
> > However Tony, the choice is your's, I won't be able to help
> > in a near future.

Since Pierre won't available for a while, and the patches look good
enough to me, I would like to pick these if nobody objects.

Any objection?

@Tony: Could you please have another look at patch 3? That is the only
one you haven't r-b yet...

Regards,
Halil
