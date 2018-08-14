From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 05/22] KVM: s390: vsie: simulate VCPU SIE entry/exit
Date: Tue, 14 Aug 2018 08:46:40 -0400
Message-ID: <1e8e107e-7880-ff38-4724-6bf185a68584@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180814105003.290cf5f1.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814105003.290cf5f1.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 08/14/2018 04:50 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:02 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: David Hildenbrand <david@redhat.com>
>>
>> VCPU requests and VCPU blocking right now don't take care of the vSIE
>> (as it was not necessary until now). But we want to have VCPU requests
>> that will also be handled before running the vSIE again.
>>
>> So let's simulate a SIE entry when entering the vSIE loop and check
>> for PROG_ flags. The existing infrastructure (e.g. exit_sie()) will then
>> detect that the SIE (in form of the vSIE execution loop) is running and
>> properly kick the vSIE CPU, resulting in it leaving the vSIE loop and
>> therefore the vSIE interception handler, allowing it to handle VCPU
>> requests.
>>
>> E.g. if we want to modify the crycb of the VCPU and make sure that any
>> masks also get applied to the VSIE crycb shadow (which uses masks from the
>> VCPU crycb), we will need a way to hinder the vSIE from running and make
>> sure to process the updated crycb before reentering the vSIE again.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c |    9 ++++++++-
>>   arch/s390/kvm/kvm-s390.h |    1 +
>>   arch/s390/kvm/vsie.c     |   20 ++++++++++++++++++--
>>   3 files changed, 27 insertions(+), 3 deletions(-)
> I think that is the RFC version of David's patch, not the v1? Again,
> not really relevant for reviewing, but I hope that you test the final
> version.

Will do.

>
