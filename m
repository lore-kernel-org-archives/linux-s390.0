From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 01/13] KVM: s390: Interface to test whether APXA
 installed
Date: Wed, 16 May 2018 06:45:38 -0400
Message-ID: <20e26cf4-84fe-b681-15e9-59bc113a3828@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180516122116.4c3b10a1.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516122116.4c3b10a1.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 05/16/2018 06:21 AM, Cornelia Huck wrote:
> On Mon,  7 May 2018 11:11:40 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Relocates an existing static function that tests whether
>> the AP extended addressing facility (APXA) is installed on
>> the linux host. The primary reason for relocating this
>> function is because a new compilation unit (arch/s390/kvm/kvm-ap.c)
>> is being created to contain all of the interfaces and logic
>> for configuring an AP matrix for a KVM guest. Some of its
>> functions will also need to determine whether APXA is installed,
>> so, let's go ahead and relocate this static function as a
>> public interface in kvm-ap.c.
>>
>> Notes:
>> ----
>> 1. The interface to determine whether APXA is installed on the linux
>>     host the information returned from the AP Query Configuration
>>     Information (QCI) function. This function will not be available
>>     if the AP instructions are not installed on the linux host, so a check
>>     will be included to verify that.
>>
>> 2. Currently, the AP bus interfaces accessing the AP instructions will
>>     not be accessible if CONFIG_ZCRYPT=n, so the relevant code will be
>>     temporarily contained in the new arch/s390/kvm/kvm-ap.c file until
>>     the patch(es) to statically build the required AP bus interfaces are
>>     available.
> Any ETA for those interfaces? Would be nice if we could avoid
> introducing temporary interfaces (but I'm certainly not opposing this
> patch).

I'll check with the developer.

>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                    |    1 +
>>   arch/s390/include/asm/kvm-ap.h |   60 +++++++++++++++++++++++++++++
>>   arch/s390/kvm/Makefile         |    2 +-
>>   arch/s390/kvm/kvm-ap.c         |   83 ++++++++++++++++++++++++++++++++++++++++
>>   arch/s390/kvm/kvm-s390.c       |   42 +-------------------
>>   5 files changed, 147 insertions(+), 41 deletions(-)
>>   create mode 100644 arch/s390/include/asm/kvm-ap.h
>>   create mode 100644 arch/s390/kvm/kvm-ap.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index eab763f..224e97b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7792,6 +7792,7 @@ M:	Christian Borntraeger <borntraeger@de.ibm.com>
>>   M:	Janosch Frank <frankja@linux.ibm.com>
>>   R:	David Hildenbrand <david@redhat.com>
>>   R:	Cornelia Huck <cohuck@redhat.com>
>> +R:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> Don't you want to drop the 'vnet' from your address, as the vnet-less
> form seems to be the one that will continue working from what I've
> heard?
>
>>   L:	linux-s390@vger.kernel.org
>>   W:	http://www.ibm.com/developerworks/linux/linux390/
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
> No objection against this patch, although I still hope it will not be
> needed :)
>
