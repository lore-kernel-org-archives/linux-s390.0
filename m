From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 03/13] KVM: s390: move bitmap idle_mask into arch
 struct top level
Date: Tue, 29 Jan 2019 14:56:31 +0100
Message-ID: <20190129145631.4e258057.cohuck@redhat.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-4-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-4-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:29 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> The vcpu idle_mask state is used by but not specific
> to the emulated floating interruptions. The state is
> relevant to gisa related interruptions as well.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  2 +-
>  arch/s390/kvm/interrupt.c        | 11 +++++------
>  arch/s390/kvm/kvm-s390.h         |  2 +-
>  3 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
