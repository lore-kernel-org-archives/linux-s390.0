From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 11/12] s390/sclp: expose the GISA format facility
Date: Fri, 26 Jan 2018 10:44:34 +0100
Message-ID: <20180126104434.73b83905.cohuck@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
        <20180125132848.175942-12-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-12-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 14:28:47 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The GISA format facility is required by the host to be able to process
> a format-1 GISA. If not available, the used GISA format will be format-0.
> All format-1 related extension will not be available in this case.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/sclp.h   | 1 +
>  drivers/s390/char/sclp_early.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
