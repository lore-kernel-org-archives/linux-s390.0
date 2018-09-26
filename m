From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 10/26] KVM: s390: interfaces to clear CRYCB masks
Date: Wed, 26 Sep 2018 15:21:19 +0200
Message-ID: <20180926152119.7d41da0a.cohuck@redhat.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-11-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-11-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Sep 2018 19:16:25 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces a new KVM function to clear the APCB0 and APCB1 in the guest's
> CRYCB. This effectively clears all bits of the APM, AQM and ADM masks
> configured for the guest. The VCPUs are taken out of SIE to ensure the
> VCPUs do not get out of sync.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  2 ++
>  arch/s390/kvm/kvm-s390.c         | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)

In the patch title: s/interfaces/interface/

(also trivial to fix up while applying)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
