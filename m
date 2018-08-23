From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
Date: Thu, 23 Aug 2018 09:48:48 +0200
Message-ID: <38b87fc4-9344-70d8-4602-bf8e114769ef@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <8f3f3f41-a052-1975-69e2-49e1a662ecab@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8f3f3f41-a052-1975-69e2-49e1a662ecab@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

>>>
>> I really wonder if we should also export the APXA facility.
> 
> Given this comment is made within the context of the
> FACILITIES_KVM_CPUMODEL I might point out that APXA is not
> indicated by a facilities bit. It is indicated by a bit in
> the QCI control block returned from the PQAP(QCI)
> instruction to indicate that APXA is installed on all CPUs.
> 
>> We can probe and allow that CPU feature. However, we cannot disable it
>> (as of now).
> 
> Given this patch series implements passthrough devices,
> the output of the PQAP(QCI) will always be from a real
> device - i.e., there will be no way to disable it.
> 

see below

>>
>> We have other CPU features where it is the same case (basically all
>> subfunctions). See kvm_s390_get_processor_subfunc(). We probe them and
>> export them, but support to disable them has never been implemented.
>>
>> On a high level, we could then e.g. deny to start a QEMU guest if APXA
>> is available but has been disabled. (until we know that disabling it
>> actually works - if ever).
>>
>> This helps to catch nasty migration bugs (e.g. APXA suddenly
>> disappearing). Although unlikely, definitely possible.
> 
> Migration of AP devices is not supported by this patch series, so this 
> should
> not be an issue.

Might not be a problem now, but could be later. As I said in a different
reply, the CPU model in QEMU does not care about KVM.

I want the QEMU CPU model and the KVM interfaces to be clean and future
proof. That's why my opinion is to handle PQAP(QCI) just like all the
other "feature blocks" we already have.

-- 

Thanks,

David / dhildenb
