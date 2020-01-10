Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42252 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727698AbgAJOhk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 09:37:40 -0500
Subject: Re: [PATCH] KVM: s390: Cleanup initial cpu reset
References: <b01c38bf-5887-25d8-b787-271e5c2292e2@redhat.com>
 <20200110134824.37963-1-frankja@linux.ibm.com>
 <20200110150158.36ded698.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1fe3974f-3853-b670-fbaa-04299a86d170@redhat.com>
Date: Fri, 10 Jan 2020 15:37:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200110150158.36ded698.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org

On 10.01.20 15:01, Cornelia Huck wrote:
> On Fri, 10 Jan 2020 08:48:24 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> The code seems to be quite old and uses lots of unneeded spaces for
>> alignment, which doesn't really help with readability.
>>
>> Let's:
>> * Get rid of the extra spaces
>> * Remove the ULs as they are not needed on 0s
>> * Define constants for the CR 0 and 14 initial values
>> * Use the sizeof of the gcr array to memset it to 0
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>
>> Something like this?
> 
> +1, like.
> 
>> Did I forget something?
>>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  5 +++++
>>  arch/s390/kvm/kvm-s390.c         | 18 +++++++-----------
>>  2 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 02f4c21c57f6..37747db884bd 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -122,6 +122,11 @@ struct mcck_volatile_info {
>>  	__u32 reserved;
>>  };
>>  
>> +#define CR0_INITIAL (CR0_UNUSED_56 | CR0_INTERRUPT_KEY_SUBMASK | \
>> +		     CR0_MEASUREMENT_ALERT_SUBMASK)
>> +#define CR14_INITIAL (CR14_UNUSED_32 | CR14_UNUSED_33 | \
>> +		      CR14_EXTERNAL_DAMAGE_SUBMASK)
> 
> Maybe CR<n>_INITIAL_MASK?

+1

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb
