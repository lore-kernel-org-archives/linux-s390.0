From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4/5] KVM: s390: abstract conversion between isc and enum
 irq_types
Date: Wed, 8 Nov 2017 10:11:00 +0100
Message-ID: <20171108101100.4f28a1d3.cohuck@redhat.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
        <20171108084143.78654-5-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171108084143.78654-5-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Nov 2017 09:41:42 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The abstraction of the conversion between an isc value and an irq_type
> by means of functions isc_to_irq_type() and irq_type_to_isc() allows
> to clarify the respective operations where used.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
