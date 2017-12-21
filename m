From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] KVM: s390: prevent buffer overrun on memory hotplug
 during migration
Date: Thu, 21 Dec 2017 10:36:30 +0100
Message-ID: <20171221103630.235c4ed5.cohuck@redhat.com>
References: <20171221090416.17351-1-borntraeger@de.ibm.com>
        <20171221090416.17351-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171221090416.17351-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Dec 2017 10:04:16 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> We must not go beyond the pre-allocated buffer. This can happen when
> a new memory slot is added during migration.
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: stable@vger.kernel.org # 4.13+
> Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation, migration mode)
> ---
>  arch/s390/kvm/priv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index c954ac49eee4..3211bf58d838 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -1002,7 +1002,7 @@ static inline int do_essa(struct kvm_vcpu *vcpu, const int orc)
>  		cbrlo[entries] = gfn << PAGE_SHIFT;
>  	}
>  
> -	if (orc) {
> +	if (orc && gfn < ms->bitmap_size) {
>  		/* increment only if we are really flipping the bit to 1 */
>  		if (!test_and_set_bit(gfn, ms->pgste_bitmap))
>  			atomic64_inc(&ms->dirty_pages);

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
