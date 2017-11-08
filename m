From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/5] KVM: s390: vsie: use common code functions for
 pinning
Date: Wed, 8 Nov 2017 10:07:53 +0100
Message-ID: <20171108100753.7afc9368.cohuck@redhat.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
        <20171108084143.78654-4-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171108084143.78654-4-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Nov 2017 09:41:41 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: David Hildenbrand <david@redhat.com>
> 
> We will not see -ENOMEM (gfn_to_hva() will return KVM_ERR_PTR_BAD_PAGE
> for all errors). So we can also get rid of special handling in the
> callers of pin_guest_page() and always assume that it is a g2 error.
> 
> As also kvm_s390_inject_program_int() should never fail, we can
> simplify pin_scb(), too.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20170901151143.22714-1-david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/vsie.c     | 50 +++++++++++++++++-------------------------------
>  include/linux/kvm_host.h |  1 +
>  virt/kvm/kvm_main.c      |  4 ++--
>  3 files changed, 21 insertions(+), 34 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
