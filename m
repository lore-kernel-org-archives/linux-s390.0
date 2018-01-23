From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 1/2] KVM: s390 vsie: use READ_ONCE to access some
 SCB fields
Date: Tue, 23 Jan 2018 13:26:58 +0100
Message-ID: <20180123132658.458271fc.cohuck@redhat.com>
References: <20180116171526.12343-1-david@redhat.com>
        <20180116171526.12343-2-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116171526.12343-2-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Jan 2018 18:15:25 +0100
David Hildenbrand <david@redhat.com> wrote:

> Another VCPU might try to modify the SCB while we are creating the
> shadow SCB. In general this is no problem - unless the compiler decides
> to not load values once, but e.g. twice.
> 
> For us, this is only relevant when checking/working with such values.
> E.g. the prefix value, the mso, state of transactional execution and
> addresses of satellite blocks.
> 
> E.g. if we blindly forwards values (e.g. general purpose registers or

s/forwards/forward/

> execution controls after masking), we don't care.
> 
> Leaving unpin_blocks() untouched for now, will handle it separatly.
> 
> The worst thing right now that I can see would be a missed prefix
> un/remap (mso, prefix, tx) or using wrong guest addresses. Nothing
> critical, but let's try to avoid unpredictable behavior.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 50 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 5d6ae0326d9e..79ea444a0534 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -28,7 +28,11 @@ struct vsie_page {
>  	 * the same offset as that in struct sie_page!
>  	 */
>  	struct mcck_volatile_info mcck_info;    /* 0x0200 */
> -	/* the pinned originial scb */
> +	/*
> +	 * The pinned originial scb. Be aware that other VCPUs can modify

s/originial/original/

(as that line is touched anyway)

> +	 * it while we read from it. Values that are used for conditions or
> +	 * are reused conditionally, should be accessed via READ_ONCE.
> +	 */
>  	struct kvm_s390_sie_block *scb_o;	/* 0x0218 */
>  	/* the shadow gmap in use by the vsie_page */
>  	struct gmap *gmap;			/* 0x0220 */

Acked-by: Cornelia Huck <cohuck@redhat.com>
