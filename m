Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1D1EE4996
	for <linux-s390@archiver.kernel.org>; Mon, 21 Aug 2023 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjHUNtF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Aug 2023 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjHUNtE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Aug 2023 09:49:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B4BE2
        for <linux-s390@vger.kernel.org>; Mon, 21 Aug 2023 06:49:02 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTv1J3WRdzrSVk;
        Mon, 21 Aug 2023 21:47:32 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 21:48:59 +0800
Message-ID: <b5123c01-4380-1ca0-280f-b196db723cc1@huawei.com>
Date:   Mon, 21 Aug 2023 21:48:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] s390/pci: Use builtin_misc_device macro to simplify
 the code
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        <gerald.schaefer@linux.ibm.com>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>
References: <20230815080833.1103609-1-lizetao1@huawei.com>
 <52efd1aa02861c4683eefa1f1c15e8cac0b835c8.camel@linux.ibm.com>
From:   Li Zetao <lizetao1@huawei.com>
In-Reply-To: <52efd1aa02861c4683eefa1f1c15e8cac0b835c8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.176]
X-ClientProxiedBy: dggpeml500002.china.huawei.com (7.185.36.158) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Niklas,

On 2023/8/21 21:32, Niklas Schnelle wrote:
> On Tue, 2023-08-15 at 16:08 +0800, Li Zetao wrote:
>> Use the builtin_misc_device macro to simplify the code, which is the same
>> as declaring with device_initcall().
>>
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   arch/s390/pci/pci_clp.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
>> index ee367798e388..ee90a91ed888 100644
>> --- a/arch/s390/pci/pci_clp.c
>> +++ b/arch/s390/pci/pci_clp.c
>> @@ -666,9 +666,4 @@ static struct miscdevice clp_misc_device = {
>>   	.fops = &clp_misc_fops,
>>   };
>>   
>> -static int __init clp_misc_init(void)
>> -{
>> -	return misc_register(&clp_misc_device);
>> -}
>> -
>> -device_initcall(clp_misc_init);
>> +builtin_misc_device(clp_misc_device);
> 
> Sorry forgot to ask do you want me to take this via the s390 tree?
Yes,thank you.

With Best Regards,
Li Zetao
