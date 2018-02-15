From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 5/6] KVM: s390: no need to inititalize kvm->arch
 members to 0
Date: Thu, 15 Feb 2018 14:25:20 +0100
Message-ID: <20180215142520.63f117ad.cohuck@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
        <20180207114647.6220-6-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180207114647.6220-6-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  7 Feb 2018 12:46:46 +0100
David Hildenbrand <david@redhat.com> wrote:

> KVM is allocated with kzalloc(), so these members are already 0.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 8 --------
>  1 file changed, 8 deletions(-)

use_esca is also initialized to 0, but we'd lose the comment.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
