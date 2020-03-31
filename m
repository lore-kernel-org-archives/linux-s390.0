Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730149AbgCaQXN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Mar 2020 12:23:13 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VG3JOq057587
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2020 12:23:12 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30206ye906-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2020 12:23:11 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Tue, 31 Mar 2020 17:22:57 +0100
Subject: Re: [RFC PATCH v1 27/50] drivers/s390/scsi/zcsp_fc.c: Use
 prandom_u32_max() for backoff
References: <202003281643.02SGhHN7015213@sdf.org>
 <20200331161321.GB17507@t480-pf1aa2c2>
From: Steffen Maier <maier@linux.ibm.com>
Date: Tue, 31 Mar 2020 18:23:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200331161321.GB17507@t480-pf1aa2c2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bf41ae18-aba4-5315-e22b-67a6873eb459@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>, George Spelvin <lkml@sdf.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org

On 3/31/20 6:13 PM, Benjamin Block wrote:
> On Fri, Nov 29, 2019 at 03:39:41PM -0500, George Spelvin wrote:
>> We don't need crypto-grade random numbers for randomized backoffs.
>>
>> (We could skip the if() if we wanted to rely on the undocumented fact
>> that prandom_u32_max(0) always returns 0.  That would be a net time
>> saving it port_scan_backoff == 0 is rare; if it's common, the if()
>> is false often enough to pay for itself. Not sure which applies here.)
>>
>> Signed-off-by: George Spelvin <lkml@sdf.org>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>   drivers/s390/scsi/zfcp_fc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hello George,
> 
> it would be nice, if you could address the mails to the
> driver-maintainers (`scripts/get_maintainer.pl drivers/s390/scsi/zfcp_fc.c`
> will tell you that this is me and Steffen); I'd certainly have noticed
> it earlier then :-).
> 
>>
>> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
>> index b018b61bd168e..d24cafe02708f 100644
>> --- a/drivers/s390/scsi/zfcp_fc.c
>> +++ b/drivers/s390/scsi/zfcp_fc.c
>> @@ -48,7 +48,7 @@ unsigned int zfcp_fc_port_scan_backoff(void)
>>   {
>>   	if (!port_scan_backoff)
>>   		return 0;
>> -	return get_random_int() % port_scan_backoff;
>> +	return prandom_u32_max(port_scan_backoff);

Reviewed-by: Steffen Maier <maier@linux.ibm.com>

> 
> I think the change is fine. You are right, we don't need a crypto nonce
> here.
> 
> I think I'd let the zero-check stand as is, because the internal
> behaviour of prandom_u32_max() is, as you say, undocumented. This is not
> a performance critical code-path for us anyway.

yes, let's keep the extra check as it's intentional and documented user 
interface for zfcp, so better be explicit

> 
>>   }
>>   
>>   static void zfcp_fc_port_scan_time(struct zfcp_adapter *adapter)
>> -- 
>> 2.26.0
>>
> 
> Steffen, do you have any objections? Otherwise I can queue this up -
> minus the somewhat mangled subject - for when we send something next time.
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
