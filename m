From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 01/15] KVM: s390: unregister debug feature on failing
 arch init
Date: Thu, 20 Dec 2018 08:49:32 +0100
Message-ID: <4ce0210a-e054-16e6-3089-278ecb3ef5ea@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-2-mimu@linux.ibm.com>
 <20181219210934.2f370eb7.cohuck@redhat.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219210934.2f370eb7.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 19.12.18 21:10, Cornelia Huck wrote:
> On Wed, 19 Dec 2018 20:17:42 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> Make sure the debug feature and its allocated resources get
>> released upon unsuccessful architecture initialization.
>>
>> A related indication of the issue will be reported as kernel
>> message.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Message-Id: <20181130143215.69496-2-mimu@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   Documentation/kmsg/s390/kvm | 12 ++++++++++++
>>   arch/s390/kvm/kvm-s390.c    | 17 ++++++++++++++---
>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/kmsg/s390/kvm
>>
>> diff --git a/Documentation/kmsg/s390/kvm b/Documentation/kmsg/s390/kvm
>> new file mode 100644
>> index 000000000000..76ffe2012254
>> --- /dev/null
>> +++ b/Documentation/kmsg/s390/kvm
>> @@ -0,0 +1,12 @@
>> +/*?
>> + * Text: "Failed to register FLIC rc=%d\n"
>> + * Severity: Error
>> + * Parameter:
>> + *   @1: return code of the FLIC registration call
>> + * Description:
>> + * The registration of the FLIC (Floating Interrupt Controller Interface)
>> + * was not successful.
>> + * User action:
>> + * If this problem persists after a reload of the kvm kernel module, gather
>> + * Linux debug data and contact your support organization.
>> + */
> 
> Hm, it seems that the kmsg stuff crept in there again...
> 

picked from wrong branch, sorry...
