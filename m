Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726135AbgBLMRH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 07:17:07 -0500
Subject: Re: [PATCH v2 RFC] KVM: s390/interrupt: do not pin adapter interrupt
 pages
References: <567B980B-BDA5-4EF3-A96E-1542D11F2BD4@redhat.com>
 <20200211092341.3965-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <01d1c188-38fb-e405-83d7-6184adccba5a@redhat.com>
Date: Wed, 12 Feb 2020 13:16:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200211092341.3965-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, cohuck@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com, "dgilbert@redhat.com" <dgilbert@redhat.com>


> +	/*
> +	 * We resolve the gpa to hva when setting the IRQ routing. If userspa=
ce
> +	 * decides to mess with the memslots it better also updates the irq
> +	 * routing. Otherwise we will write to the wrong userspace address.
> +	 */

I guess this is just as old handling, where a page was pinned. But
slightly better :) So the pages are definitely part of guest memory.

Fun stuff: If (a nasty) guest (in current code) zappes this page using
balloon inflation and the page is re-accessed (e.g., by the guest or by
the host), a new page will be faulted in, and there will be an
inconsistency between what the guest/user space sees and what this code
sees. Going via the user space address looks cleaner.

Now, with postcopy live migration, we will also zap all guest memory
before starting the guest, I do wonder if that produces a similar
inconsistency ... usually, when pages are pinned in the kernel, we
inhibit the balloon and implicitly also postcopy.

If so, this actually fixes an issue. But might depend on the order
things are initialized in user space. Or I am messing up things :)

[...]

>  static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __=
u64 addr)
>  {
> -	struct s390_io_adapter *adapter =3D get_io_adapter(kvm, id);
> -	struct s390_map_info *map, *tmp;
> -	int found =3D 0;
> -
> -	if (!adapter || !addr)
> -		return -EINVAL;
> -
> -	down_write(&adapter->maps_lock);
> -	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
> -		if (map->guest_addr =3D=3D addr) {
> -			found =3D 1;
> -			atomic_dec(&adapter->nr_maps);
> -			list_del(&map->list);
> -			put_page(map->page);
> -			kfree(map);
> -			break;
> -		}
> -	}
> -	up_write(&adapter->maps_lock);
> -
> -	return found ? 0 : -EINVAL;
> +	return 0;

Can we get rid of this function?

>  }

> +static struct page *get_map_page(struct kvm *kvm,
> +				 struct s390_io_adapter *adapter,
> +				 u64 uaddr)
>  {
> -	struct s390_map_info *map;
> +	struct page *page;
> +	int ret;
> =20
>  	if (!adapter)
>  		return NULL;
> -
> -	list_for_each_entry(map, &adapter->maps, list) {
> -		if (map->guest_addr =3D=3D addr)
> -			return map;
> -	}
> -	return NULL;
> +	page =3D NULL;

struct page *page =3D NULL;

> +	if (!uaddr)
> +		return NULL;
> +	down_read(&kvm->mm->mmap_sem);
> +	ret =3D get_user_pages_remote(NULL, kvm->mm, uaddr, 1, FOLL_WRITE,
> +				    &page, NULL, NULL);
> +	if (ret < 1)
> +		page =3D NULL;

Is that really necessary? According to the doc, pinned pages are stored
to the array.  ret < 1 means "no pages" were pinned, so nothing should
be stored.

--=20
Thanks,

David / dhildenb
