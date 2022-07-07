Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1240BC43334
	for <linux-s390@archiver.kernel.org>; Thu,  7 Jul 2022 09:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiGGJiX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Jul 2022 05:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiGGJiX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Jul 2022 05:38:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D771D45054;
        Thu,  7 Jul 2022 02:38:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBFCA1063;
        Thu,  7 Jul 2022 02:38:19 -0700 (PDT)
Received: from [10.57.85.108] (unknown [10.57.85.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 507723F792;
        Thu,  7 Jul 2022 02:38:17 -0700 (PDT)
Message-ID: <a59c92ff-fb82-6e7f-4d2a-846b3d9e1356@arm.com>
Date:   Thu, 7 Jul 2022 10:38:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/15] iommu: Always register bus notifiers
Content-Language: en-GB
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Cc:     "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
 <1fab4c8a-7bc5-9a50-d48a-0dc590cac7a6@linux.intel.com>
 <3d613192-f673-852e-9c52-b8a913d25616@arm.com>
 <28a58a21-a866-b49c-9977-c8d05b320fbd@linux.intel.com>
 <BN9PR11MB527610973C947DBA6B2EA8348C839@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB527610973C947DBA6B2EA8348C839@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2022-07-07 07:34, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, July 7, 2022 8:21 AM
>>
>> On 2022/7/6 21:43, Robin Murphy wrote:
>>> On 2022-07-06 02:53, Baolu Lu wrote:
>>>> On 2022/7/6 01:08, Robin Murphy wrote:
>>>>>    /*
>>>>>     * Use a function instead of an array here because the domain-type
>>>>> is a
>>>>>     * bit-field, so an array would waste memory.
>>>>> @@ -152,6 +172,10 @@ static int __init iommu_subsys_init(void)
>>>>>                (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>>>>>                    "(set via kernel command line)" : "");
>>>>> +    /* If the system is so broken that this fails, it will WARN
>>>>> anyway */
>>>>
>>>> Can you please elaborate a bit on this? iommu_bus_init() still return
>>>> errors.
>>>
>>> Indeed, it's commenting on the fact that we don't try to clean up or
>>> propagate an error value further even if it did ever manage to return
>>> one. I feared that if I strip the error handling out of iommu_bus_init()
>>> itself on the same reasoning, we'll just get constant patches from the
>>> static checker brigade trying to add it back, so it seemed like the
>>> neatest compromise to keep that decision where it's obviously in an
>>> early initcall, rather than in the helper function which can be viewed
>>> out of context. However, I'm happy to either expand this comment or go
>>> the whole way and make iommu_bus_init() return void if you think it's
>>> worthwhile.
>>
>> Thanks for the explanation. It would be helpful if the comment could be
>> expanded. In this case, after a long time, people will not consider it
>> an oversight. :-)
>>
> 
> I'd prefer to making iommu_bus_init() return void plus expanding
> the comment otherwise the question arises that if the only caller
> is not interested in the return value then why bother returning it
> in the first place. 😊

OK, that's fair enough, will do.

Thanks,
Robin.
