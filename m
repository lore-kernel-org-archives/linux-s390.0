Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727027AbgBUKoF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Feb 2020 05:44:05 -0500
Subject: Re: [PATCH v3 26/37] KVM: s390: protvirt: Only sync fmt4 registers
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-27-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <30e0805d-c7b5-a4c3-7a71-5300d2bd3057@redhat.com>
Date: Fri, 21 Feb 2020 11:43:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200220104020.5343-27-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 20.02.20 11:40, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> A lot of the registers are controlled by the Ultravisor and never
> visible to KVM. Also some registers are overlayed, like gbea is with
> sidad, which might leak data to userspace.
> 
> Hence we sync a minimal set of registers for both SIE formats and then
> check and sync format 2 registers if necessary.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
