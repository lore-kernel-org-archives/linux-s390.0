From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] KVM: s390: do not set intervention requests for
 GISA interrupts
Date: Tue, 13 Feb 2018 16:48:19 +0100
Message-ID: <20180213164819.392cf891.cohuck@redhat.com>
References: <20180213122858.74748-1-borntraeger@de.ibm.com>
        <20180213122858.74748-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180213122858.74748-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 13 Feb 2018 12:28:58 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> If GISA is available, we do not have to kick CPUs out of SIE to deliver
> interrupts. The hardware can deliver such interrupts while running.
> 
> Cc: Michael Mueller <mimu@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
