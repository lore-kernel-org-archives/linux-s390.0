Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727347AbgBJM1H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:27:07 -0500
Subject: Re: [PATCH 02/35] KVM: s390/interrupt: do not pin adapter interrupt
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2cf62b84-8eb6-18d5-437b-7e86401b9c45@redhat.com>
Date: Mon, 10 Feb 2020 13:26:54 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

On 07.02.20 12:39, Christian Borntraeger wrote:
> From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>=20
> The adapter interrupt page containing the indicator bits is currently
> pinned. That means that a guest with many devices can pin a lot of
> memory pages in the host. This also complicates the reference tracking
> which is needed for memory management handling of protected virtual
> machines.
> We can reuse the pte notifiers to "cache" the page without pinning it.
>=20
> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---

So, instead of pinning explicitly, look up the page address, cache it,
and glue its lifetime to the gmap table entry. When that entry is
changed, invalidate the cached page. On re-access, look up the page
again and register the gmap notifier for the table entry again.

[...]

>  #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index c06c89d370a7..4bfb2f8fe57c 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -28,6 +28,7 @@
>  #include <asm/switch_to.h>
>  #include <asm/nmi.h>
>  #include <asm/airq.h>
> +#include <linux/pagemap.h>
>  #include "kvm-s390.h"
>  #include "gaccess.h"
>  #include "trace-s390.h"
> @@ -2328,8 +2329,8 @@ static int register_io_adapter(struct kvm_device =
*dev,
>  		return -ENOMEM;
> =20
>  	INIT_LIST_HEAD(&adapter->maps);
> -	init_rwsem(&adapter->maps_lock);
> -	atomic_set(&adapter->nr_maps, 0);
> +	spin_lock_init(&adapter->maps_lock);
> +	adapter->nr_maps =3D 0;
>  	adapter->id =3D adapter_info.id;
>  	adapter->isc =3D adapter_info.isc;
>  	adapter->maskable =3D adapter_info.maskable;
> @@ -2375,19 +2376,15 @@ static int kvm_s390_adapter_map(struct kvm *kvm=
, unsigned int id, __u64 addr)
>  		ret =3D -EFAULT;
>  		goto out;
>  	}
> -	ret =3D get_user_pages_fast(map->addr, 1, FOLL_WRITE, &map->page);
> -	if (ret < 0)
> -		goto out;
> -	BUG_ON(ret !=3D 1);
> -	down_write(&adapter->maps_lock);
> -	if (atomic_inc_return(&adapter->nr_maps) < MAX_S390_ADAPTER_MAPS) {
> +	spin_lock(&adapter->maps_lock);
> +	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
> +		adapter->nr_maps++;
>  		list_add_tail(&map->list, &adapter->maps);

I do wonder if we should check for duplicates. The unmap path will only
remove exactly one entry. But maybe this can never happen or is already
handled on a a higher layer.

>  }
> @@ -2430,7 +2426,6 @@ void kvm_s390_destroy_adapters(struct kvm *kvm)
>  		list_for_each_entry_safe(map, tmp,
>  					 &kvm->arch.adapters[i]->maps, list) {
>  			list_del(&map->list);
> -			put_page(map->page);
>  			kfree(map);
>  		}
>  		kfree(kvm->arch.adapters[i]);

Between the gmap being removed in kvm_arch_vcpu_destroy() and
kvm_s390_destroy_adapters(), the entries would no longer properly get
invalidated. AFAIK, removing/freeing the gmap will not trigger any
notifiers.

Not sure if that's an issue (IOW, if we can have some very weird race).
But I guess we would have similar races already :)

> @@ -2690,6 +2685,31 @@ struct kvm_device_ops kvm_flic_ops =3D {
>  	.destroy =3D flic_destroy,
>  };
> =20
> +void kvm_s390_adapter_gmap_notifier(struct gmap *gmap, unsigned long s=
tart,
> +				    unsigned long end)
> +{
> +	struct kvm *kvm =3D gmap->private;
> +	struct s390_map_info *map, *tmp;
> +	int i;
> +
> +	for (i =3D 0; i < MAX_S390_IO_ADAPTERS; i++) {
> +		struct s390_io_adapter *adapter =3D kvm->arch.adapters[i];
> +
> +		if (!adapter)
> +			continue;

I have to ask very dumb: How is kvm->arch.adapters[] protected?

I don't see any explicit locking e.g., on
flic_set_attr()->register_io_adapter().


[...]> +static struct page *get_map_page(struct kvm *kvm,
> +				 struct s390_io_adapter *adapter,
> +				 u64 addr)
>  {
>  	struct s390_map_info *map;
> +	unsigned long uaddr;
> +	struct page *page;
> +	bool need_retry;
> +	int ret;
> =20
>  	if (!adapter)
>  		return NULL;
> +retry:
> +	page =3D NULL;
> +	uaddr =3D 0;
> +	spin_lock(&adapter->maps_lock);
> +	list_for_each_entry(map, &adapter->maps, list)
> +		if (map->guest_addr =3D=3D addr) {

Could it happen, that we don't have a fitting entry in the list?

> +			uaddr =3D map->addr;
> +			page =3D map->page;
> +			if (!page)
> +				map->page =3D ERR_PTR(-EBUSY);
> +			else if (IS_ERR(page) || !page_cache_get_speculative(page)) {
> +				spin_unlock(&adapter->maps_lock);
> +				goto retry;
> +			}
> +			break;
> +		}

Can we please factor out looking up the list entry to a separate
function, to be called under lock? (and e.g., use it below as well)

spin_lock(&adapter->maps_lock);
entry =3D fancy_new_function();
if (!entry)
	return NULL;
uaddr =3D entry->addr;
page =3D entry->page;
if (!page)
	...
spin_unlock(&adapter->maps_lock);


> +	spin_unlock(&adapter->maps_lock);
> +
> +	if (page)
> +		return page;
> +	if (!uaddr)
> +		return NULL;
> =20
> -	list_for_each_entry(map, &adapter->maps, list) {
> -		if (map->guest_addr =3D=3D addr)
> -			return map;
> +	down_read(&kvm->mm->mmap_sem);
> +	ret =3D set_pgste_bits(kvm->mm, uaddr, PGSTE_IN_BIT, PGSTE_IN_BIT);
> +	if (ret)
> +		goto fail;
> +	ret =3D get_user_pages_remote(NULL, kvm->mm, uaddr, 1, FOLL_WRITE,
> +				    &page, NULL, NULL);
> +	if (ret < 1)
> +		page =3D NULL;
> +fail:
> +	up_read(&kvm->mm->mmap_sem);
> +	need_retry =3D true;
> +	spin_lock(&adapter->maps_lock);
> +	list_for_each_entry(map, &adapter->maps, list)
> +		if (map->guest_addr =3D=3D addr) {

Could it happen that our entry is suddenly no longer in the list?

> +			if (map->page =3D=3D ERR_PTR(-EBUSY)) {
> +				map->page =3D page;
> +				need_retry =3D false;
> +			} else if (IS_ERR(map->page)) {

else if (map->page =3D=3D ERR_PTR(-EINVAL)

or simpy "else" (every other value would be a BUG_ON, right?)

/* race with a notifier - don't store the entry and retry */

> +				map->page =3D NULL;> +			}



> +			break;
> +		}
> +	spin_unlock(&adapter->maps_lock);
> +	if (need_retry) {
> +		if (page)
> +			put_page(page);
> +		goto retry;
>  	}
> -	return NULL;
> +
> +	return page;

Wow, this function is ... special. Took me way to long to figure out
what is going on here. We certainly need comments in there.

I can see that

- ERR_PTR(-EBUSY) is used when somebody is about to do the
  get_user_pages_remote(). others have to loop until that is resolved.
- ERR_PTR(-EINVAL) is used when the entry gets invalidated by the
  notifier while somebody is about to set it (while still
  ERR_PTR(-EBUSY)). The one currently processing the entry will
  eventually set it back to NULL.

I think we should make this clearer by only setting ERR_PTR(-EINVAL) in
the notifier if already ERR_PTR(-EBUSY), along with a comment.

Can we document the values for map->page and how they are to be handled
right in the struct?

--=20
Thanks,

David / dhildenb
