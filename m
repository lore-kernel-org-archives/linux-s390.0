Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
 <1594801869-13365-3-git-send-email-pmorel@linux.ibm.com>
 <20200715054807-mutt-send-email-mst@kernel.org>
 <bc5e09ad-faaf-8b38-83e0-5f4a4b1daeb0@redhat.com>
 <20200715074917-mutt-send-email-mst@kernel.org>
 <e41d039c-5fe2-b9db-093b-c0dddcc2ad4f@linux.ibm.com>
Message-ID: <ef819e0e-85c3-0b14-4f8e-0d2a6c452355@linux.ibm.com>
Date: Thu, 6 Aug 2020 16:19:23 +0200
MIME-Version: 1.0
In-Reply-To: <e41d039c-5fe2-b9db-093b-c0dddcc2ad4f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 2020-07-30 13:31, Pierre Morel wrote:
...snip...
>>>> What bothers me here is that arch code depends on virtio now.
>>>> It works even with a modular virtio when functions are inline,
>>>> but it seems fragile: e.g. it breaks virtio as an out of tree module,
>>>> since layout of struct virtio_device can change.
>>>
>>>
>>> The code was only called from virtio.c so it should be fine.
>>>
>>> And my understanding is that we don't need to care about the kABI issue
>>> during upstream development?
>>>
>>> Thanks
>>
>> No, but so far it has been convenient at least for me, for development,
>> to just be able to unload all of virtio and load a different version.
>>
>>
>>>
>>>>
>>>> I'm not sure what to do with this yet, will try to think about it
>>>> over the weekend. Thanks!

After reflection, I am not sure that this problem must be treated on the 
architecture level or inside the VIRTIO transport.
Consequently, I will propose another patch series based on CCW transport.
This also should be more convenient for core development.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
