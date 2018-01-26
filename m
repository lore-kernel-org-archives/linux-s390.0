From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 02/12] KVM: s390: define GISA format-0 data structure
Date: Fri, 26 Jan 2018 10:03:44 +0100
Message-ID: <20180126100344.29f42513.cohuck@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
        <20180125132848.175942-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 14:28:38 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> In preperation to support pass-through adapter interrupts, the Guest
> Interruption State Area (GISA) and the Adapter Interruption Virtualization
> (AIV) features will be introduced here.
> 
> This patch introduces format-0 GISA (that is defines the struct describing
> the GISA, allocates storage for it, and introduces fields for the
> GISA address in kvm_s390_sie_block and kvm_s390_vsie).
> 
> As the GISA requires storage below 2GB, it is put in sie_page2, which is
> already allocated in ZONE_DMA. In addition, The GISA requires alignment to
> its integral boundary. This is already naturally aligned via the
> padding in the sie_page2.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 23 +++++++++++++++++++----
>  arch/s390/kvm/kvm-s390.c         |  1 +
>  2 files changed, 20 insertions(+), 4 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
