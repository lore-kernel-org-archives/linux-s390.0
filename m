Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E0C07E95
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0955F61A2B
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 11:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGGLtx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Jul 2021 07:49:53 -0400
Received: from foss.arm.com ([217.140.110.172]:35296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhGGLtx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 7 Jul 2021 07:49:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0300C1042;
        Wed,  7 Jul 2021 04:47:13 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EABE63F73B;
        Wed,  7 Jul 2021 04:47:11 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] dma-debug: fix check_for_illegal_area() in
 debug_dma_map_sg()
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <20210705185252.4074653-1-gerald.schaefer@linux.ibm.com>
 <20210705185252.4074653-2-gerald.schaefer@linux.ibm.com>
 <3bb87b4c-f646-20fe-7cc5-c7449432811e@arm.com>
 <20210706211207.48f15496@thinkpad>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ae61c67a-6735-ed72-adf3-56570c9b7251@arm.com>
Date:   Wed, 7 Jul 2021 12:47:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706211207.48f15496@thinkpad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2021-07-06 20:12, Gerald Schaefer wrote:
> On Tue, 6 Jul 2021 10:22:40 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 2021-07-05 19:52, Gerald Schaefer wrote:
>>> The following warning occurred sporadically on s390:
>>> DMA-API: nvme 0006:00:00.0: device driver maps memory from kernel text or rodata [addr=0000000048cc5e2f] [len=131072]
>>> WARNING: CPU: 4 PID: 825 at kernel/dma/debug.c:1083 check_for_illegal_area+0xa8/0x138
>>>
>>> It is a false-positive warning, due to a broken logic in debug_dma_map_sg().
>>> check_for_illegal_area() should check for overlay of sg elements with kernel
>>> text or rodata. It is called with sg_dma_len(s) instead of s->length as
>>> parameter. After the call to ->map_sg(), sg_dma_len() contains the length
>>> of possibly combined sg elements in the DMA address space, and not the
>>> individual sg element length, which would be s->length.
>>>
>>> The check will then use the kernel start address of an sg element, and add
>>> the DMA length for overlap check, which can result in the false-positive
>>> warning because the DMA length can be larger than the actual single sg
>>> element length in kernel address space.
>>>
>>> In addition, the call to check_for_illegal_area() happens in the iteration
>>> over mapped_ents, which will not include all individual sg elements if
>>> any of them were combined in ->map_sg().
>>>
>>> Fix this by using s->length instead of sg_dma_len(s). Also put the call to
>>> check_for_illegal_area() in a separate loop, iterating over all the
>>> individual sg elements ("nents" instead of "mapped_ents").
>>>
>>> Fixes: 884d05970bfb ("dma-debug: use sg_dma_len accessor")
>>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>>> ---
>>>    kernel/dma/debug.c | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>>> index 14de1271463f..d7d44b7fe7e2 100644
>>> --- a/kernel/dma/debug.c
>>> +++ b/kernel/dma/debug.c
>>> @@ -1299,6 +1299,12 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>    	if (unlikely(dma_debug_disabled()))
>>>    		return;
>>>    
>>> +	for_each_sg(sg, s, nents, i) {
>>> +		if (!PageHighMem(sg_page(s))) {
>>> +			check_for_illegal_area(dev, sg_virt(s), s->length);
>>> +		}
>>> +	}
>>> +
>>>    	for_each_sg(sg, s, mapped_ents, i) {
>>>    		entry = dma_entry_alloc();
>>>    		if (!entry)
>>> @@ -1316,10 +1322,6 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>    
>>>    		check_for_stack(dev, sg_page(s), s->offset);
>>
>> Strictly this should probably be moved to the new loop as well, as it is
>> similarly concerned with validating the source segments rather than the
>> DMA mappings - I think with virtually-mapped stacks it might technically
>> be possible for a stack page to be physically adjacent to a "valid" page
>> such that it could get merged and overlooked if it were near the end of
>> the list, although in fairness that would probably be indicative of
>> something having gone far more fundamentally wrong. Otherwise, the
>> overall reasoning looks sound to me.
> 
> I see, good point. I think I can add this to my patch, and a different
> subject like "dma-debug: fix sg checks in debug_dma_map_sg()".

TBH it's more of a conceptual cleanliness thing than a significant 
practical concern, but if we *are* breaking out a separate "validate the 
source elements" step then it does seem logical to capture everything 
relevant at once.

> However, I do not quite understand why check_for_stack() does not also
> consider s->length. It seems to check only the first page of an sg
> element.
> 
> So, shouldn't check_for_stack() behave similar to check_for_illegal_area(),
> i.e. check all source sg elements for overlap with the task stack area?

Realistically, creating a scatterlist segment pointing to the stack at 
all would already be quite an audacious feat of brokenness, but getting 
a random stack page in the middle of a segment would seem to imply 
something having gone so catastrophically wrong that it's destined to 
end very badly whether or not dma-debug squawks about it - not to 
mention getting lucky enough for said random stack page to actually 
belong to the current task stack in the first place :)

Robin.

> If yes, then this probably should be a separate patch, but I can try
> to come up with something and send a new RFC with two patches. Maybe
> check_for_stack() can also be integrated into check_for_illegal_area(),
> they are both called at the same places. And mapping memory from the
> stack also sounds rather illegal.
> 
