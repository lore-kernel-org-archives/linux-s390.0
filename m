Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgBRPSU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 10:18:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IFFAUh023458
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 10:18:20 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1hrta5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 10:18:18 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Tue, 18 Feb 2020 15:18:16 -0000
References: <20200217165525.5187-1-krzk@kernel.org>
 <20200218121713.GA3956@osiris>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH] s390: Cleanup removed IOSCHED_DEADLINE
Date: Tue, 18 Feb 2020 16:18:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200218121713.GA3956@osiris>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Message-Id: <60998205-90ba-c343-b3f3-c9c25ee6fef1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jan Hoeppner <hoeppner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Am 18.02.20 um 13:17 schrieb Heiko Carstens:
> On Mon, Feb 17, 2020 at 05:55:25PM +0100, Krzysztof Kozlowski wrote:
>> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
>> remove legacy IO schedulers").
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Thanks! I'll leave it up to Stefan and Jan to decide what to do with this.

I will apply the patch. Thanks.

>
>> ---
>>  drivers/s390/block/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
>> index a8682f69effc..1f06b19cb290 100644
>> --- a/drivers/s390/block/Kconfig
>> +++ b/drivers/s390/block/Kconfig
>> @@ -26,7 +26,7 @@ config DASD
>>  	def_tristate y
>>  	prompt "Support for DASD devices"
>>  	depends on CCW && BLOCK
>> -	select IOSCHED_DEADLINE
>> +	select MQ_IOSCHED_DEADLINE
>>  	help
>>  	  Enable this option if you want to access DASDs directly utilizing
>>  	  S/390s channel subsystem commands. This is necessary for running
>> -- 
>> 2.17.1
>>
