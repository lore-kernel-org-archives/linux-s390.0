From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
Date: Thu, 24 Jan 2019 16:06:37 +0100
Message-ID: <20190124160637.0f8b47a7.cohuck@redhat.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-8-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-8-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:33 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Use this struct analog to the kvm interruption structs
> for kvm emulated floating and local interruptions.

I guess that makes sense.

> Further fields will be added with this series as
> required.

A reference to "this series" will look a bit strange if you look at the
committed patch later. What about:

"GIB handling will add further fields to this structure as required."

?

> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  6 ++++-
>  arch/s390/kvm/interrupt.c        | 52 +++++++++++++++++++++++-----------------
>  arch/s390/kvm/kvm-s390.c         |  2 +-
>  3 files changed, 36 insertions(+), 24 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
