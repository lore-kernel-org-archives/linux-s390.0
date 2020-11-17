Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729288AbgKQPXI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:23:08 -0500
Subject: Re: [PATCH 0/2] KVM: s390: memcg awareness
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d22fb5b1-af1e-3970-c4cc-b38f93d0d6e5@redhat.com>
Date: Tue, 17 Nov 2020 16:23:03 +0100
MIME-Version: 1.0
In-Reply-To: <20201117151023.424575-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

On 17.11.20 16:10, Christian Borntraeger wrote:
> This got somehow lost.  (so this is kind of a v2)
> KVM does have memcg awareness. Lets implement this also for s390kvm
> and gmap.

Looks sane to me.


-- 
Thanks,

David / dhildenb
