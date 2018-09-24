From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 00/26] guest dedicated crypto adapters
Date: Mon, 24 Sep 2018 12:45:38 -0400
Message-ID: <b44f1714-dc01-441c-67c3-1700c468b69f@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924134931.6c67a3d2.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924134931.6c67a3d2.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/24/2018 07:49 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:42:50 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> Abstract:
>> ========
>>
>> On s390, we have cryptographic coprocessor cards, which are modeled on
>> Linux as devices on the AP bus. Each card can be partitioned into domains
>> which can be thought of as a set of hardware registers for processing
>> crypto commands. Crypto commands are sent to a specific domain within a
>> card is via a queue which is identified as a (card,domain) tuple. We model
>> this something like the following (assuming we have access to cards 3 and
>> 4 and domains 1 and 2):
>>
>> AP -> card3 -> queue (3,1)
>>              -> queue (3,2)
>>     -> card4 -> queue (4,1)
>>              -> queue (4,2)
>>
>> If we want to virtualize this, we can use a feature provided by the
>> hardware. We basically attach a satellite control block to our main
>> hardware virtualization control block and the hardware takes care of
>> most of the rest.
>>
>> For this control block, we don't specify explicit tuples, but a list of
>> cards and a list of domains. The guest will get access to the cross
>> product.
>>
>> Because of this, we need to take care that the lists provided to
>> different guests don't overlap; i.e., we need to enforce sane
>> configurations. Otherwise, one guest may get access to things like
>> secret keys for another guest.
>>
>> The idea of this patch set is to introduce a new device, the matrix
>> device. This matrix device hangs off a different root and acts as the
>> parent node for mdev devices.
>>
>> If you now want to give the tuples (4,1) and (4,2), you need to do the
>> following:
>>
>> - Make sure the queues (4,1) and (4,2) belong to vfio_ap (see patches
>>    #5 and #6)
>> - Create the mediated device.
>> - Assign card 4 and domains 1 and 2 to the mediated device
>> - Optionally activate the mediated device.
>>
>> QEMU will now simply consume the mediated device and things should work.
>>
>> For a complete description of the architecture and concepts underlying
>> the design, see the Documentation/s390/vfio-ap.txt file included with this
>> patch set.
> 
> I did not spot anything major, and if v11 addresses the issues raised
> by various reviewers I don't see why it should not be merged (interface
> looks sane). I skipped looking at the vsie stuff, though ;)

I think David has that covered.

> 
