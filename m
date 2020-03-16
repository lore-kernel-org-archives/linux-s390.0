Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43536 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730970AbgCPMLj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Mar 2020 08:11:39 -0400
Subject: Re: [PATCH] KVM: s390: mark sie block as 512 byte aligned
References: <20200311083304.3725276-1-borntraeger@de.ibm.com>
 <20200316131009.381a8692@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3b70e28f-a7d8-adfb-8f0b-de838d9c3b65@redhat.com>
Date: Mon, 16 Mar 2020 13:11:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200316131009.381a8692@p-imbrenda>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

On 16.03.20 13:10, Claudio Imbrenda wrote:
> On Wed, 11 Mar 2020 09:33:04 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> The sie block must be aligned to 512 bytes. Mark it as such.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h
>> b/arch/s390/include/asm/kvm_host.h index 0ea82152d2f7..2d50f6c432e2
>> 100644 --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -344,7 +344,7 @@ struct kvm_s390_sie_block {
>>  	__u64	itdba;			/* 0x01e8 */
>>  	__u64   riccbd;			/* 0x01f0 */
>>  	__u64	gvrd;			/* 0x01f8 */
>> -} __attribute__((packed));
>> +} __packed __aligned(512);
>>  
>>  struct kvm_s390_itdb {
>>  	__u8	data[256];
> 
> I agree with the addition of aligned, but did you really have to remove
> packed? it makes me a little uncomfortable.

There is still "__packed".


-- 
Thanks,

David / dhildenb
