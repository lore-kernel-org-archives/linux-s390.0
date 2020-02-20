Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727285AbgBTM0P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Feb 2020 07:26:15 -0500
Subject: Re: [PATCH v3 05/37] s390/mm: provide memory management functions for
 protected KVM guests
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-6-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <43ac75f6-e6fd-e928-10cb-8232413c2494@redhat.com>
Date: Thu, 20 Feb 2020 13:25:57 +0100
MIME-Version: 1.0
In-Reply-To: <20200220104020.5343-6-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org

On 20.02.20 11:39, Christian Borntraeger wrote:
> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> This provides the basic ultravisor calls and page table handling to cope
> with secure guests:
> - provide arch_make_page_accessible
> - make pages accessible after unmapping of secure guests
> - provide the ultravisor commands convert to/from secure
> - provide the ultravisor commands pin/unpin shared
> - provide callbacks to make pages secure (inacccessible)
>  - we check for the expected pin count to only make pages secure if the
>    host is not accessing them
>  - we fence hugetlbfs for secure pages
> 
> Co-developed-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
