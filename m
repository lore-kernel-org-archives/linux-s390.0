From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 07/19] KVM: s390: introduce AP matrix configuration
 interface
Date: Thu, 16 Nov 2017 10:41:10 -0500
Message-ID: <bca1419f-2b97-1de4-c8d1-87e0e4cff840@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-8-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171114141631.38e8e279.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171114141631.38e8e279.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 11/14/2017 08:16 AM, Cornelia Huck wrote:
> On Fri, 13 Oct 2017 13:38:52 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> This patch introduces a new compilation unit that will contain
>> all of the data structures and logic for configuring AP adapters,
>> usage domains and control domains for a KVM guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                       |    2 ++
>>   arch/s390/include/asm/ap-config.h |   12 ++++++++++++
>>   arch/s390/kvm/Makefile            |    2 +-
>>   arch/s390/kvm/ap-config.c         |    9 +++++++++
>>   4 files changed, 24 insertions(+), 1 deletions(-)
>>   create mode 100644 arch/s390/include/asm/ap-config.h
>>   create mode 100644 arch/s390/kvm/ap-config.c
> This is a bit useless on its own... merge this with the actual
> implementation?
I agree, I'm going to squash patches 7 and 8
>
