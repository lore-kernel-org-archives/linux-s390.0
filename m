From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v7 13/15] KVM: s390: add gib_alert_irq_handler()
Date: Tue, 5 Feb 2019 12:38:28 +0100
Message-ID: <50f05038-f414-50f5-dbe7-e2bcca0b8433@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
 <20190131085247.13826-14-mimu@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-14-mimu@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 31/01/2019 09:52, Michael Mueller wrote:
> The patch implements a handler for GIB alert interruptions
> on the host. Its task is to alert guests that interrupts are
> pending for them.
> 
> A GIB alert interrupt statistic counter is added as well:
> 
> $ cat /proc/interrupts
>            CPU0       CPU1
>    ...
>    GAL:      23         37   [I/O] GIB Alert
>    ...
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> ---

The only thing that bother me is the short timer's expiration value.
But it is optimization and it is working for me so.

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
