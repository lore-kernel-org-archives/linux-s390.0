From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 03/26] KVM: s390: refactor crypto initialization
Date: Wed, 26 Sep 2018 15:07:32 +0200
Message-ID: <20180926150732.05b932f8.cohuck@redhat.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-4-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-4-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Sep 2018 19:16:18 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> This patch refactors the code that initializes and sets up the
> crypto configuration for a guest. The following changes are
> implemented via this patch:
> 
> 1. Introduces a flag indicating AP instructions executed on
>    the guest shall be interpreted by the firmware. This flag
>    is used to set a bit in the guest's state description
>    indicating AP instructions are to be interpreted.
> 
> 2. Replace code implementing AP interfaces with code supplied
>    by the AP bus to query the AP configuration.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  3 ++
>  arch/s390/kvm/kvm-s390.c         | 70 +++++++++++++++-----------------
>  2 files changed, 36 insertions(+), 37 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
