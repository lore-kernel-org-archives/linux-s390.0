From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 03/13] KVM: s390: move bitmap idle_mask into arch
 struct top level
Date: Mon, 28 Jan 2019 16:30:59 +0100
Message-ID: <26edc2ed-f1d8-ad42-f913-486d080b0497@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
 <20190124125939.130763-4-mimu@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-4-mimu@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 24/01/2019 13:59, Michael Mueller wrote:
> The vcpu idle_mask state is used by but not specific
> to the emulated floating interruptions. The state is
> relevant to gisa related interruptions as well.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  2 +-
>   arch/s390/kvm/interrupt.c        | 11 +++++------
>   arch/s390/kvm/kvm-s390.h         |  2 +-
>   3 files changed, 7 insertions(+), 8 deletions(-)


Seems logical to me.

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
