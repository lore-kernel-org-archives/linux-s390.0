From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 09/12] KVM: s390: make kvm_s390_get_io_int() aware of
 GISA
Date: Fri, 26 Jan 2018 10:57:32 +0100
Message-ID: <ed2239e9-be7e-19ba-d4bf-b65284ccb2b7@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-10-borntraeger@de.ibm.com>
 <20180126104151.7cdfb156.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126104151.7cdfb156.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/26/2018 10:41 AM, Cornelia Huck wrote:
> On Thu, 25 Jan 2018 14:28:45 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Michael Mueller <mimu@linux.vnet.ibm.com>
>>
>> The function returns a pending I/O interrupt with the highest
>> priority defined by its ISC.
>>
>> Together with AIV activation, pending adapter interrupts are
>> managed by the GISA IPM. Thus kvm_s390_get_io_int() needs to
>> inspect the IPM as well when the interrupt with the highest
>> priority has to be identified.
>>
>> In case classic and adapter interrupts with the same ISC are
>> pending, the classic interrupt will be returned first.
> 
> Can this lead to starving? Consider a guest that never enables itself
> for I/O interrupts, but collects pending interrupts via tpi. It will
> always get the intis for an isc, but not the ai, wouldn't it?

Only if it handles the interrupts slower than new ones arrive, in that case
you have a problem anyway. When looking at sane configuration, this priority
makes sense as the classic interrupts are used for configuration type ccw,
while adapter interrupts are for data. You want to get the control changes
quickly. In a sane environment nobody would probably put devices with adapter
interrupts on the same isc as different devices with only classic interrupts.

But looking at your theoretical "tpi only" case. If your statement is correct
then you would also starve interrupts with lets say isc 4 when also interrupts
with isc3 are pending, since isc3 will always be preferred. And it did not
seem to be an issue in the real world. Or did I miss your point?

> 
>>
>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/interrupt.c | 71 +++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 65 insertions(+), 6 deletions(-)
> 
