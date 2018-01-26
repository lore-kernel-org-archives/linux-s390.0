From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 08/12] KVM: s390: add GISA interrupts to FLIC ioctl
 interface
Date: Fri, 26 Jan 2018 10:18:36 +0100
Message-ID: <20180126101836.1b0615e0.cohuck@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
        <20180125132848.175942-9-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-9-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 14:28:44 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> Pending interrupts marked in the GISA IPM are required to
> become part of the answer of ioctl KVM_DEV_FLIC_GET_ALL_IRQS.
> 
> The ioctl KVM_DEV_FLIC_ENQUEUE is already capable to enqueue
> adapter interrupts when a GISA is present.
> 
> With ioctl KVM_DEV_FLIC_CLEAR_IRQS the GISA IPM wil be cleared
> now as well.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
