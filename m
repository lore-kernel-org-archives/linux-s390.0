From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v7 15/15] KVM: s390: fix possible null pointer
 dereference in pending_irqs()
Date: Thu, 31 Jan 2019 18:47:12 +0100
Message-ID: <20190131184712.3fcd8c36.cohuck@redhat.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
        <20190131085247.13826-16-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-16-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 31 Jan 2019 09:52:46 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Assure a GISA is in use before accessing the IPM to avoid a
> null pointer dereference issue.

This series can hopefully make it into the next merge window;
otherwise, queuing a patch fixing up the original code would be good.

> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
