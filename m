From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 12/12] KVM: s390: introduce the format-1 GISA
Date: Fri, 26 Jan 2018 10:46:50 +0100
Message-ID: <20180126104650.0a57215c.cohuck@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
        <20180125132848.175942-13-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-13-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 14:28:48 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The patch modifies the previously defined GISA data structure to be
> able to store two GISA formats, format-0 and format-1. Additionally,
> it verifies the availability of the GISA format facility and enables
> the use of a format-1 GISA in the SIE control block accordingly.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 44 +++++++++++++++++++++++++++++++---------
>  arch/s390/kvm/kvm-s390.c         |  2 ++
>  2 files changed, 36 insertions(+), 10 deletions(-)

With the description changed as discussed previously,

Acked-by: Cornelia Huck <cohuck@redhat.com>
