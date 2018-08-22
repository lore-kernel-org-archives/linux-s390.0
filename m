From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
Date: Wed, 22 Aug 2018 17:11:55 +0200
Message-ID: <e36abc22-9daf-e0f4-c6b3-7adbb28db4c3@de.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
 <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
 <20180821172548.57a6c758.cohuck@redhat.com>
 <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
 <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
 <20180822114250.59a250aa.cohuck@redhat.com>
 <8bc5f207-f913-825c-f9fc-0a2c7fd280aa@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8bc5f207-f913-825c-f9fc-0a2c7fd280aa@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 08/22/2018 01:03 PM, Pierre Morel wrote:
>> That's interesting.
>>
>>> IMHO this quote is quite a half-full half-empty cup one:
>>> * it mandates the set of usage domains is a subset of the set
>>> of the control domains, but
>>> * it speaks of independent controls, namely about the 'usage domain index'
>>> and the 'control domain index list' and makes the enforcement of the rule
>>> a job of the administrator (instead of codifying it in the controls).
>> I'm wondering if a configuration with a usage domain that is not also a
>> control domain is rejected outright? Anybody tried that? :)
> 
> Yes, and no it is not.
> We can use a queue (usage domain) to a AP card for SHA-512 or RSA without
> having to define the queue as a control domain.

Huh? My HMC allows to add a domain as
- control only domain
- control and usage domain.

But I am not able to configure a usage-only domain for my LPAR. That seems to match
the current code, no?
