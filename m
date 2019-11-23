Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:63148
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfKWPjR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 23 Nov 2019 10:39:17 -0500
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
 <20191122140827.0ead345c.pasic@linux.ibm.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
Date: Sat, 23 Nov 2019 09:39:08 -0600
In-Reply-To: <20191122140827.0ead345c.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, "Kalra, Ashish" <Ashish.Kalra@amd.com>

On 11/22/19 7:08 AM, Halil Pasic wrote:
> Thanks Michael!
> 
> Actually I also hoped to start a discussion on virtio with encrypted
> memory.
> 
> I assume the AMD folks have the most experience with this, and I very
> much like to understand how do they master the challenges we are all
> facing.
> 
> My understanding of IO in the context of AMD SEV is that the user
> is responsible for choosing the swiotlb command line parameter of the
> guest kernel so, that the guest never runs out of swiotlb. And that
> not doing so may have fatal consequences with regards to the guest. [1]
> 
> The swiotlb being a guest global resource, to choose such a size, one
> would fist need to know the maximal swiotlb footprint of each device,
> and then apply some heuristics regarding fragmentation.
> 
> Honestly, if somebody asked me how to calculate the max swiotlb
> footprint of the most common virtio devices, I would feel very
> uncomfortable.
> 
> But maybe I got it all wrong. @Tom can you help me understand how this
> works?

Yes, SWIOTLB sizing is hard. It really depends on the workload and the
associated I/O load that the guest will be performing. We've been looking
at a simple patch to increase the default SWIOTLB size if SEV is active.
But what size do you choose? Do you base it on the overall guest size? And
you're limited because it must reside low in memory.

Ideally, having a pool of shared pages for DMA, outside of standard
SWIOTLB, might be a good thing.  On x86, SWIOTLB really seems geared
towards devices that don't support 64-bit DMA. If a device supports 64-bit
DMA then it can use shared pages that reside anywhere to perform the DMA
and bounce buffering. I wonder if the SWIOTLB support can be enhanced to
support something like this, using today's low SWIOTLB buffers if the DMA
mask necessitates it, otherwise using a dynamically sized pool of shared
pages that can live anywhere.

Thanks,
Tom

> 
> In any case, we s390 protected virtualization folks are concerned about
> the things laid out above. The goal of this patch is to make the swiotlb
> full condition less grave, but it is by no means a full solution.
> 
> I would like to work on improving on this situation. Obviously we have
> done some thinking about what can be done, but I would very much like to
> collect the opinions, of the people in the community that AFAICT face
> same problem. One of the ideas is to try to prevent it from happening by
> making swiotlb sizing dynamic. Another idea is to make the system deal
> with the failures gracefully. Both ideas come with a bag of problems of
> their own (AFAICT).
> 
> According to my research the people I need to talk to are Tom (AMD), and
> Ram and Thiago (Power) and of course the respective maintainers. Have I
> missed anybody?
> 
> Regards,
> Halil
> 
> --
> 
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FAMDESE%2FAMDSEV%23faq-4&amp;data=02%7C01%7CThomas.Lendacky%40amd.com%7Cd733eab74c7346b72fb608d76f4d175d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637100249200530156&amp;sdata=mUISWUHYJfLE3c1cYoqC%2B3uzM8RtpnffyMlrX84oGug%3D&amp;reserved=0
> 
> On Tue, 19 Nov 2019 08:04:29 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> Will be in the next pull request.
>>
>> On Tue, Nov 19, 2019 at 12:10:22PM +0100, Halil Pasic wrote:
>>> ping
>>>
>>> On Thu, 14 Nov 2019 13:46:46 +0100
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>
>>>> Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
>>>> virtqueue_add() return -EIO when we fail to map our I/O buffers. This is
>>>> a very realistic scenario for guests with encrypted memory, as swiotlb
>>>> may run out of space, depending on it's size and the I/O load.
>>>>
>>>> The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
>>>> error, despite the fact that swiotlb full is in absence of bugs a
>>>> recoverable condition.
>>>>
>>>> Let us change the return code to -ENOMEM, and make the block layer
>>>> recover form these failures when virtio-blk encounters the condition
>>>> described above.
>>>>
>>>> Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
>>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>>> ---
>>>>
> [..]
> 
