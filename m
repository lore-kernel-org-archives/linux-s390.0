Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbgCHT7g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 8 Mar 2020 15:59:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 028Jt7wL035761
        for <linux-s390@vger.kernel.org>; Sun, 8 Mar 2020 15:59:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ym647nyyf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sun, 08 Mar 2020 15:59:34 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Sun, 8 Mar 2020 19:59:33 -0000
Subject: Re: [PATCH net] net/smc: cancel event worker during device removal
References: <20200306134518.84416-1-kgraul@linux.ibm.com>
 <20200308150107.GC11496@unreal>
From: Karsten Graul <kgraul@linux.ibm.com>
Date: Sun, 8 Mar 2020 20:59:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200308150107.GC11496@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0b5d992d-2447-1606-f8ce-73801643160a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On 08/03/2020 16:01, Leon Romanovsky wrote:
> On Fri, Mar 06, 2020 at 02:45:18PM +0100, Karsten Graul wrote:
>> During IB device removal, cancel the event worker before the device
>> structure is freed. In the worker, check if the device is being
>> terminated and do not proceed with the event work in that case.
>>
>> Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
>> Reported-by: syzbot+b297c6825752e7a07272@syzkaller.appspotmail.com
>> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
>> Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
>> ---
>>  net/smc/smc_ib.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>> index d6ba186f67e2..5e4e64a9aa4b 100644
>> --- a/net/smc/smc_ib.c
>> +++ b/net/smc/smc_ib.c
>> @@ -240,6 +240,9 @@ static void smc_ib_port_event_work(struct work_struct *work)
>>  		work, struct smc_ib_device, port_event_work);
>>  	u8 port_idx;
>>
>> +	if (list_empty(&smcibdev->list))
>> +		return;
>> +
> 
> How can it be true if you are not holding "smc_ib_devices.lock" during
> execution of smc_ib_port_event_work()?
> 

It is true when smc_ib_remove_dev() runs before the work actually started.
Other than that its only a shortcut to return earlier, when the item is 
removed from the list after the check then the processing just takes a 
little bit longer...its still save.

>>  	for_each_set_bit(port_idx, &smcibdev->port_event_mask, SMC_MAX_PORTS) {
>>  		smc_ib_remember_port_attr(smcibdev, port_idx + 1);
>>  		clear_bit(port_idx, &smcibdev->port_event_mask);
>> @@ -582,6 +585,7 @@ static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
>>  	smc_smcr_terminate_all(smcibdev);
>>  	smc_ib_cleanup_per_ibdev(smcibdev);
>>  	ib_unregister_event_handler(&smcibdev->event_handler);
>> +	cancel_work_sync(&smcibdev->port_event_work);
>>  	kfree(smcibdev);
>>  }
>>
>> --
>> 2.17.1
>>

-- 
Karsten

(I'm a dude)
