Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729661AbgBJMkO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 10 Feb 2020 07:40:14 -0500
Subject: Re: [PATCH 02/35] KVM: s390/interrupt: do not pin adapter interrupt
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dd844dcb-8972-4f77-7001-9d5de58de3e9@redhat.com>
Date: Mon, 10 Feb 2020 13:40:04 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

[...]

> +void kvm_s390_adapter_gmap_notifier(struct gmap *gmap, unsigned long start,
> +				    unsigned long end)
> +{
> +	struct kvm *kvm = gmap->private;
> +	struct s390_map_info *map, *tmp;
> +	int i;
> +
> +	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
> +		struct s390_io_adapter *adapter = kvm->arch.adapters[i];
> +
> +		if (!adapter)
> +			continue;
> +		spin_lock(&adapter->maps_lock);
> +		list_for_each_entry_safe(map, tmp, &adapter->maps, list) {

list_for_each_entry() is sufficient, we are not removing entries.

> +			if (start <= map->guest_addr && map->guest_addr < end) {
> +				if (IS_ERR(map->page))
> +					map->page = ERR_PTR(-EAGAIN);
> +				else
> +					map->page = NULL;
> +			}

-- 
Thanks,

David / dhildenb
