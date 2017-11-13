From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: add virtio-ccw.h to virtio/s390 section
Date: Mon, 13 Nov 2017 14:35:16 +0100
Message-ID: <b7061d97-6c70-2a80-9822-96a7e512175d@linux.vnet.ibm.com>
References: <20171110145611.15306-1-cohuck@redhat.com>
 <20171110181558.GB3028@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171110181558.GB3028@osiris>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/10/2017 07:15 PM, Heiko Carstens wrote:
> On Fri, Nov 10, 2017 at 03:56:11PM +0100, Cornelia Huck wrote:
>> The file arch/s390/include/uapi/asm/virtio-ccw.h belongs to the
>> s390 virtio drivers as well.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

>> ---
>>
>> Martin, Heiko: It's probably best to take this through your tree.
>>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6671f375f7fc..48c6f1179b9b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14312,6 +14312,7 @@ L:	virtualization@lists.linux-foundation.org
>>  L:	kvm@vger.kernel.org
>>  S:	Supported
>>  F:	drivers/s390/virtio/
>> +F:	arch/s390/include/uapi/asm/virtio-ccw.h
> 
> Applied, thanks.
> 
