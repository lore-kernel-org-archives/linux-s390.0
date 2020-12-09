Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728980AbgLIJU5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 04:20:57 -0500
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: Move to GPL 2 and SPDX license
 identifiers
From: David Hildenbrand <david@redhat.com>
References: <20201208150902.32383-1-frankja@linux.ibm.com>
 <20201208150902.32383-2-frankja@linux.ibm.com>
 <d0e8582e-8734-739b-d279-1e8004f379a3@redhat.com>
Message-ID: <5d484586-b984-4b7a-1b50-e6f3314645dc@redhat.com>
Date: Wed, 9 Dec 2020 10:19:26 +0100
MIME-Version: 1.0
In-Reply-To: <d0e8582e-8734-739b-d279-1e8004f379a3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 09.12.20 10:12, David Hildenbrand wrote:
> On 08.12.20 16:09, Janosch Frank wrote:
>> In the past we had some issues when developers wanted to use code
>> snippets or constants from the kernel in a test or in the library. To
>> remedy that the s390x maintainers decided to move all files to GPL
>> 2 (if possible).
>>
>> At the same time let's move to SPDX identifiers as they are much nicer
>> to read.
>>
> 
> If I am not wrong, your patch only replaces existing license text by
> SPDX identifiers. So I find this commit message rather confusing. The
> "at the same time" is actually the only thing that is being done - or am
> I missing something important?
> 
> I wonder of we can just convert everything to GPL-2.0-or-later, the list
> of people that contributed to most files is rather limited, so getting
> most acks should be easy.
> 

Aehm, I missed the "Library" part :D

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
