Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29691 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbgATNVd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 08:21:33 -0500
Subject: Re: [kvm-unit-tests PATCH v3 4/9] s390x: smp: Rework cpu start and
 active tracking
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-5-frankja@linux.ibm.com>
 <0f9984f0-9768-dba8-5e36-8e667bc05c88@redhat.com>
 <a370742d-8018-4a21-468a-4d35ab21db58@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b48cd8bb-f0d9-1f7f-ae4e-5b44bf5a0a3d@redhat.com>
Date: Mon, 20 Jan 2020 14:20:12 +0100
MIME-Version: 1.0
In-Reply-To: <a370742d-8018-4a21-468a-4d35ab21db58@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 20.01.20 14:16, Thomas Huth wrote:
> On 20/01/2020 13.06, David Hildenbrand wrote:
>> On 17.01.20 11:46, Janosch Frank wrote:
> [...]
>>> +
>>> +	if (!cpu)
>>> +		return -1;
>>
>> -EINVAL?
> 
> -ENOERRNOHEADERINKVMUNITTESTS ;-)
> 

-EDAMMIT :)

-- 
Thanks,

David / dhildenb
