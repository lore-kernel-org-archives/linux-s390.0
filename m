From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 03/19] s390/zcrypt: new AP matrix bus
Date: Tue, 14 Nov 2017 10:54:40 -0500
Message-ID: <c83a41b9-4297-eac3-0a8f-44010db2c209@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-4-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171114125845.30d46087.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171114125845.30d46087.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 11/14/2017 06:58 AM, Cornelia Huck wrote:
> On Fri, 13 Oct 2017 13:38:48 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Introduces an AP matrix bus. The sysfs location of the
>> AP matrix bus is:
>>
>> /sys/bus/ap_matrix
>>
>> The AP matrix bus will create an AP matrix device that will
>> hold the AP queues reserved for use by KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                         |    8 +++++
>>   drivers/s390/crypto/Makefile        |    4 +-
>>   drivers/s390/crypto/ap_matrix_bus.c |   52 +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/ap_matrix_bus.h |   15 ++++++++++
>>   4 files changed, 77 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/s390/crypto/ap_matrix_bus.c
>>   create mode 100644 drivers/s390/crypto/ap_matrix_bus.h
>>
>> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
>> index be36f10..87646ca 100644
>> --- a/drivers/s390/crypto/Makefile
>> +++ b/drivers/s390/crypto/Makefile
>> @@ -2,7 +2,7 @@
>>   # S/390 crypto devices
>>   #
>>   
>> -ap-objs := ap_bus.o ap_card.o ap_queue.o
>> +ap-objs := ap_bus.o ap_card.o ap_queue.o ap_matrix_bus.o
>>   obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o
>>   # zcrypt_api.o and zcrypt_msgtype*.o depend on ap.o
>>   zcrypt-objs := zcrypt_api.o zcrypt_card.o zcrypt_queue.o
>> @@ -13,4 +13,4 @@ obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
>>   
>>   # pkey kernel module
>>   pkey-objs := pkey_api.o
>> -obj-$(CONFIG_PKEY) += pkey.o
>> +obj-$(CONFIG_PKEY) += pkey.o
> Unrelated change.
will fix
>
>> \ No newline at end of file
