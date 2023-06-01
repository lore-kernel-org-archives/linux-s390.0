Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C93C77B7A
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jun 2023 19:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFATx7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jun 2023 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFATx6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jun 2023 15:53:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54D2E18F;
        Thu,  1 Jun 2023 12:53:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2051063;
        Thu,  1 Jun 2023 12:54:40 -0700 (PDT)
Received: from [10.57.84.85] (unknown [10.57.84.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2A163F7BD;
        Thu,  1 Jun 2023 12:53:48 -0700 (PDT)
Message-ID: <ef78fd49-4609-b947-b26d-f3f5ac66178f@arm.com>
Date:   Thu, 1 Jun 2023 20:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 09/25] iommu/fsl_pamu: Implement an IDENTITY domain
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linuxppc-dev@lists.ozlabs.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Steven Price <steven.price@arm.com>,
        Thierry Reding <treding@nvidia.com>
References: <9-v2-8d1dc464eac9+10f-iommu_all_defdom_jgg@nvidia.com>
 <84aa0f5e-f13d-40f5-abe6-e8ac231e2d95@arm.com> <ZHj1kXMMf5iqxXOV@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZHj1kXMMf5iqxXOV@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2023-06-01 20:46, Jason Gunthorpe wrote:
> On Thu, Jun 01, 2023 at 08:37:45PM +0100, Robin Murphy wrote:
>> On 2023-05-16 01:00, Jason Gunthorpe wrote:
>>> Robin was able to check the documentation and what fsl_pamu has
>>> historically called detach_dev() is really putting the IOMMU into an
>>> IDENTITY mode.
>>
>> Unfortunately it was the other way around - it's the call to
>> fsl_setup_liodns() from fsl_pamu_probe() which leaves everything in bypass
>> by default (the PAACE_ATM_NO_XLATE part, IIRC), whereas the detach_device()
>> call here ends up disabling the given device's LIODN altogether
> 
> Er, I see.. Let me think about it, you convinced me to change it from
> PLATFORM, so maybe we should go back to that if it is all wonky.

FWIW I was thinking more along the lines of a token nominal identity 
domain where attach does nothing at all...

>> There doesn't appear to have ever been any code anywhere for putting
>> things *back* into bypass after using a VFIO domain, so as-is these
>> default domains would probably break all DMA :(
> 
> Sounds like it just never worked right.
> 
> ie going to VFIO mode was always a one way trip and you can't go back
> to a kernel driver.

...on the assumption that doing so wouldn't really be any less broken 
than it always has been :)

Thanks,
Robin.

> I don't think this patch makes it worse because we call the identity
> attach_dev in all the same places we called detach_dev in the first
> place.
> 
> We add an extra call at the start of time, but that call is NOP'd
> by this:
> 
>>> 	if (domain == platform_domain || !domain)
>>> +		return 0;
>>> +
> 
> (bah, and the variable name needs updating too)
> 
> Honestly, I don't really want to fix FSL since it seems abandoned, so
> either this patch or going back to PLATFORM seems like the best option.
> 
> Jason
