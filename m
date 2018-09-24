From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 03/26] KVM: s390: refactor crypto initialization
Date: Mon, 24 Sep 2018 12:34:02 +0200
Message-ID: <20180924123402.51e231a7.cohuck@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-4-git-send-email-akrowiak@linux.vnet.ibm.com>
        <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 21 Sep 2018 19:18:57 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 09/12/2018 03:42 PM, Tony Krowiak wrote:
> > From: Tony Krowiak <akrowiak@linux.ibm.com>
> > 
> > This patch refactors the code that initializes and sets up the
> > crypto configuration for a guest. The following changes are
> > implemented via this patch:
> > 
> > 1. Prior to the introduction of AP device virtualization, it
> >     was not necessary to provide guest access to the CRYCB
> >     unless the MSA extension 3 (MSAX3) facility was installed
> >     on the host system. With the introduction of AP device
> >     virtualization, the CRYCB must be made accessible to the
> >     guest if the AP instructions are installed on the host
> >     and are to be provided to the guest.
> > 
> > 2. Introduces a flag indicating AP instructions executed on
> >     the guest shall be interpreted by the firmware. It is
> >     initialized to indicate AP instructions are to be
> >     to be interpreted and is used to set the SIE bit for
> >     each vcpu during vcpu setup.
> > 
> > Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Acked-by: Janosch Frank <frankja@linux.ibm.com>
> > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> > Tested-by: Farhan Ali <alifm@linux.ibm.com>
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >   arch/s390/include/asm/kvm_host.h |    2 +
> >   arch/s390/include/uapi/asm/kvm.h |    1 +
> >   arch/s390/kvm/kvm-s390.c         |   71 ++++++++++++++++++--------------------
> >   3 files changed, 37 insertions(+), 37 deletions(-)

(...)

> The fixup! patch below modifies this patch (03/26) to illustrate how
> 
> David's recommendation will be implemented for v11 of the series. It
> 
> is one of three fixup! patches (the other two are in responses to
> 11/26
>   and 25/26) included to generate discussion in v10 rather than
> 
> waiting until v11 for comments.

(...)

Looks good to me.
