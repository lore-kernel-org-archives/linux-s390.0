Return-Path: <SRS0=Ul9H=TA=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v7 3/4] s390: ap: implement PAPQ AQIC interception in
 kernel
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
 <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
 <20190429185002.6041eecc.pasic@linux.ibm.com>
 <14453f04-f13f-f63c-fd8a-d9d8834182e0@linux.ibm.com>
 <efa8840b-35b1-2823-697f-ab56d4898854@linux.ibm.com>
 <20190430113718.426392f0.pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 30 Apr 2019 13:00:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190430113718.426392f0.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <e000d0b8-c5fa-bdc1-10f3-2bebae7ccdfe@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 30/04/2019 11:37, Halil Pasic wrote:
> On Tue, 30 Apr 2019 10:32:52 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>>> +    aqic_gisa.gisa = gisa->next_alert >> 4;
>>>>
>>>> Why gisa->next_alert? Isn't this supposed to get set to gisa origin
>>>> (without some bits on the left)?
> 
> s/left/right/
> 
>>>
>>> Someone already asked this question.
> 
> It must have been in some previous iteration... Can you give me a
> pointer?
> 
>>> The answer is: look at the ap_qirq_ctrl structure, you will see that the
>>> gisa field is 27 bits wide.
> 
> My question was not about the width, but about gisa->next_alert being
> used.
> 
> Regards,
> Halil
> 

Ah, OK, I understand.
it is inherited from the time I allocated the GISA myself, before the 
Mimu GISA/GIB patches.

So now indeed I must use the GISA origin for the case next_alert is used 
by GIB alert queue.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
