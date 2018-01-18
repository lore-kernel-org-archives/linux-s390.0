From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 03/12] s390/bitops: add test_and_clear_bit_inv()
Date: Thu, 18 Jan 2018 17:54:14 +0100
Message-ID: <20180118175414.0e711d57.cohuck@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
        <20180116200217.211897-4-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-4-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Jan 2018 21:02:08 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Jens Freimann <jfrei@linux.vnet.ibm.com>
> 
> This patch adds a MSB0 bit numbering version of test_and_clear_bit().
> 
> Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/bitops.h | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
