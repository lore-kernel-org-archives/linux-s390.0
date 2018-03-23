From: David Hildenbrand <david@redhat.com>
Date: Fri, 23 Mar 2018 07:57:46 +0000
Subject: Re: [PATCH 1/1] KVM: s390: provide counters for all interrupt injects/delivery
Message-Id: <15b16234-9992-f939-dc82-34e5fc0356dc@redhat.com>
In-Reply-To: <cfa749e7-aca6-3799-6062-ebbc07a8cf67@de.ibm.com>
References: <cfa749e7-aca6-3799-6062-ebbc07a8cf67@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08.03.2018 14:30, Christian Borntraeger wrote:
> For testing the exitless interrupt support it turned out useful to
> have separate counters for inject and delivery of I/O interrupt.
> While at it do the same for all interrupt types. For timer
> related interrupts (clock comparator and cpu timer) we even had
> no delivery counters. Fix this as well. On this way some counters
> are being renamed to have a similar name.

Indeed, also the machine check part could be interesting for debugging.

Reviewed-by: David Hildenbrand <david@redhat.com>




-- 

Thanks,

David / dhildenb
