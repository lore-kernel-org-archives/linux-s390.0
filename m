From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4/5] KVM: s390: drop use of spin lock in
 __floating_irq_kick
Date: Wed, 20 Dec 2017 17:40:22 +0100
Message-ID: <20171220174022.1e8f7bb8.cohuck@redhat.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
        <20171220155300.102321-5-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-5-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 20 Dec 2017 16:52:59 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> It is not required to take to a lock to protect access to the cpuflags
> of the local interrupt structure of a vcpu as the performed operation
> is an atomic_or.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
