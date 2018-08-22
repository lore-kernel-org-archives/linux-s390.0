From: Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
Date: Wed, 22 Aug 2018 09:04:13 +0200
Message-ID: <856de167-478f-f6e0-c706-1f9b87bed7f5@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820180359.38cc4af3.cohuck@redhat.com>
 <6b83b4da-00eb-c690-e965-a4398dadd0e5@linux.ibm.com>
 <20180821175309.55b774ca.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821175309.55b774ca.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 21.08.2018 17:53, Cornelia Huck wrote:
> On Tue, 21 Aug 2018 11:00:00 +0200
> Harald Freudenberger <freude@linux.ibm.com> wrote:
>
>> On 20.08.2018 18:03, Cornelia Huck wrote:
>>> On Mon, 13 Aug 2018 17:48:19 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> +* AP Instructions:
>>>> +
>>>> +  There are three AP instructions:
>>>> +
>>>> +  * NQAP: to enqueue an AP command-request message to a queue
>>>> +  * DQAP: to dequeue an AP command-reply message from a queue
>>>> +  * PQAP: to administer the queues  
>>> So, NQAP/DQAP need usage domains, while PQAP needs a control domain? Or
>>> is it that all of them need usage domains, but PQAP can target a control
>>> domain as well?
>>>
>>> [I don't want to dive deeply into the AP architecture here, just far
>>> enough to really understand the design implications.]  
>> Well, to be honest, nobody ever tried this under Linux. Theoretically
>> one should be able to send a CPRB to a usage domain where inside
>> the CPRB another domain (the control domain) is addressed. However,
>> as of now I am only aware of applications controlling the same usage
>> domain. I don't know any application which is able to address another
>> control domain and I am not sure if the zcrypt device driver would
>> handle such a CPRB correctly. NQAP, DQAP and PQAP always address
>> a usage domain. But the CPRB send down the pipe via NQAP may
>> address some control thing on another domain. I am not sure which
>> code and where do the sorting out here. There are two candidates:
>> the firmware layer in the CEC and the crypto card code.
> OK, so it's possible as by the architecture, but at least Linux does
> not (currently) do it?
>
> Perhaps we should simply not overthink that whole control domain
> thingy :) It's mostly yet another knob, and as long as the design does
> not go against the general architecture, it's probably fine, I guess.
Well, sooner or later this has to work. Yesterday we tested the control
domain thing with trying to pull some simple data from a 'controlled' domain
to the TKE - doesn't work with a Linux LPAR. I will investigate the details in the
next weeks. However, long-term it should be possible to run scenarios
like having one KVM guest control all the domains used by other KVM guests.
With respect to the KVM vfio driver, currently there should be just the
rule that for a guest the control domain mask should be equal or a superset
of the usage domain mask. This is by convention as the architecture is
not so clear here, but this is enforced on every place which deals with
usage and control domains (SE, TKE).

regards Harald Freudenberger
