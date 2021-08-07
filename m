Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05169C4338F
	for <linux-s390@archiver.kernel.org>; Sat,  7 Aug 2021 01:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF15161159
	for <linux-s390@archiver.kernel.org>; Sat,  7 Aug 2021 01:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhHGBja (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 21:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhHGBj3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Aug 2021 21:39:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F299BC0613CF;
        Fri,  6 Aug 2021 18:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=J0f4OaPE35/KHAcoMTr1PIVu/Y71deIk870EQYRu6rk=; b=cmZIF4js4K08N9YSEq+3fK7gVm
        z+DNGeSHPeiHfVD6QY2BHj54TEH4ZSmWgxrN4iDtrAExQ0rF2l0w+lzff2T73glIlNbgkT+NDARky
        wvASdGEfpaEeuOObkAii8KUAxPE50Vk+9uBNO1W3KHErCb1sBcgeQWxFZEExkTop2yPScxd9foSgD
        NwyIAymzSRishXlwe+7keFbpnDGqq18nrurcm/Yx/hWkClHKaooi4LIVenjyFH3SjJtbabU3P64kU
        zPR9pFsQy+hx6sGjPL07kUvd16skW6p4g4gyWnjGOt7450Y0QKjp140UvnjXncR+HbrdaGB0UEfKG
        h4El8dxg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCBIJ-008lqv-MV; Sat, 07 Aug 2021 01:38:45 +0000
Subject: Re: [PATCH] s390/crypto: fix all kernel-doc warnings in vfio_ap_ops.c
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Cc:     kernel test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20210806050149.9614-1-rdunlap@infradead.org>
 <d8f1b065-f7b2-a0f3-f87a-ffdd2f7f2781@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1ad57c8d-c0d1-88d9-bcce-3d3501455d8e@infradead.org>
Date:   Fri, 6 Aug 2021 18:38:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d8f1b065-f7b2-a0f3-f87a-ffdd2f7f2781@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 8/6/21 6:26 AM, Tony Krowiak wrote:
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Pardon my ignorance, but this is the first I've seen of kernel-doc warnings.
> Is there a flag I can set when I build to get kernel-doc warnings? Is there a tool I can run?
> Where is the kernel-doc format documented? I'd like to avoid this in the future.

Hi,

Here is the 0day bot report:
https://lore.kernel.org/lkml/202108010650.DLRzJOtm-lkp@intel.com/
(not sent to any of your group, sadly).

kernel-doc format is documented in Documentation/doc-guide/kernel-doc.rst.

The 0day bot lists the reproduction steps. It used clang but I used
gcc. Shouldn't matter in this case. The main point from the 0day bot
is that "this is a W=1 build".  Using W=1 causes checks for extra
C compiler warnings and also it causes checks for documentation build
errors/warnings.

In your build environment, using "make W=1 ARCH=s390 allmodconfig all"
will produce lots of output (both compiler and kernel-doc output).
I suppose that is the expected way to do it.

AFAIK there is no support for something like "make W=1 htmldocs"
to just check for kernel-doc errors/warnings in source files, so what
I do when I am targeting only one source file is something like what
is documented in the file referenced above:

"Running the ``kernel-doc`` tool with increased verbosity and without actual
output generation may be used to verify proper formatting of the
documentation comments. For example::

	scripts/kernel-doc -v -none drivers/foo/bar.c
"
and then I script that for ease of use.
Using the latter command reports lots more kernel-doc warnings than
the 0day bot reported, so I fixed all of them that it found.


HTH.


> On 8/6/21 1:01 AM, Randy Dunlap wrote:
>> The 0day bot reported some kernel-doc warnings in this file so clean up
>> all of the kernel-doc and use proper kernel-doc formatting.
>> There are no more kernel-doc errors or warnings reported in this file.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Jason Herne <jjherne@linux.ibm.com>
>> Cc: Harald Freudenberger <freude@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |  116 ++++++++++++----------------
>>   1 file changed, 52 insertions(+), 64 deletions(-)


-- 
~Randy

