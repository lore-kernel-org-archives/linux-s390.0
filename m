Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] s390/virtio: mark headers as BSD licensed
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <1510160307-13235-1-git-send-email-mst@redhat.com>
 <9c2debae-5c00-75ad-bc4d-13af9c4f431d@de.ibm.com>
 <20171108191531.2d2f7210.cohuck@redhat.com>
 <7ab1b0f9-6db2-1d49-3bc6-320e95c71d5b@de.ibm.com>
Date: Wed, 8 Nov 2017 19:57:28 +0100
MIME-Version: 1.0
In-Reply-To: <7ab1b0f9-6db2-1d49-3bc6-320e95c71d5b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5ea37f22-920e-adc9-e7cf-f901faac92db@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

So what about the following

- leave kvm_virtio.h unchanged and we will delete this file via the s390 tree

- change virtio_ccw.h to BSD license. The content of this file is really really trivial
and it boils down to 2 defines, that can be easily reconstructed by looking at the virtio spec.
Not even sure if something like this can be copyrighted.


For reference the content of this file minus comments is

- snip -
#define KVM_VIRTIO_CCW_RING_ALIGN 4096
#define KVM_S390_VIRTIO_CCW_NOTIFY 3
- snip -


On 11/08/2017 07:33 PM, Christian Borntraeger wrote:
> 
> 
> On 11/08/2017 07:15 PM, Cornelia Huck wrote:
>> On Wed, 8 Nov 2017 19:12:25 +0100his
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 11/08/2017 05:59 PM, Michael S. Tsirkin wrote:
>>>> Virtio UAPI headers aren't just for UAPI, it's for guests/hypervisors as
>>>> well.  The s390 ones need to be BSD as well.
>>>>
>>>> Fixes: e2be04c7f995 ("License cleanup: add SPDX license identifier to uapi header files with a license")
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>> ---
>>>>
>>>> since v1:
>>>> 	drop an extra comment chunk, reported by Cornelia
>>>>
>>>>  arch/s390/include/uapi/asm/kvm_virtio.h | 26 +++++++++++++++++++++++++-  
>>>
>>> FWIW, this file will go away anyway. 
>>> Looks like the following commit in the s390 feature branch 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/drivers/s390/virtio/Makefile?h=features&id=7fb2b2d512448cf0e914c4647a1cf02b52263702
>>> missed this file.
>>
>> Can we simply rip this out?
>>
>>>
>>>
>>> Regarding the virtio-ccw.h headers it is probably something that happened by accident.
>>> Back then Rusty (as an IBMer) proposed to change all virtio headers to BSD licence.
>>
>> ISTR that the relicensing already went through... is that not the case?
> 
> The original kvm_virtio.h code was added in 2008
> 
> commit e976a2b997fc4ad70ccc53acfe62811c4aaec851
> Author: Christian Borntraeger <borntraeger@de.ibm.com>
> Date:   Tue Mar 25 18:47:46 2008 +0100
> 
>     s390: KVM guest: virtio device support, and kvm hypercalls
> 
> 
> 
> 
> The BSD re-licencing happened in 2008
> 
> commit 674bfc23c585b34c42263d73fb51710d49762a23
> Author: Rusty Russell <rusty@rustcorp.com.au>
> Date:   Fri Jul 25 12:06:03 2008 -0500
> 
>     virtio: clarify that ABI is usable by any implementations
>     
>     We want others to implement and use virtio, so it makes sense to BSD
>     license the non-__KERNEL__ parts of the headers to make this crystal
>     clear.
> 
> and it seems that it missed arch/include/uapi/asm/kvm_virtio.h
> 
> 
> 
> arch/include/uapi/asm/virtio_ccw.h probably just copied what
> kvm_virtio.h had in 2013.
> 
> So its somewhat fair to assume that both files should be BSD, but they are not
> according to the licence statement.
> 
> Gregs SPDX change just changed the GPL text in the header files to a SPDX
> statement. Now Michael wants to change this to BSD as it probably was intended
> but not written down. Sigh.
> 
>> I thought this was just a fixup to align with reality?
>>
>>>
>>>>  arch/s390/include/uapi/asm/virtio-ccw.h | 26 +++++++++++++++++++++++++-
>>>>  2 files changed, 50 insertions(+), 2 deletions(-)
>>
