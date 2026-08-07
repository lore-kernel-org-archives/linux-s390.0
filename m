Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8D390618;
	Fri,  7 Aug 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111689; cv=none; b=GKBks6kyCP01rU+oxOQHgEgnIbqvJrpgymkuOS7baRJAASKIXNCpEomGrYJD9B3uYmNow1GiG5XuHKdWsb00eGeObfmILDLOQohNyuQZLDNjcpD9Hel2y3jqAK5gkeulIHMSEWIuulfY8rB5iyTFXe3UGKfRT0u2zR16tZYlHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111689; c=relaxed/simple;
	bh=sBgHf49vQuwRZIapKRQug04mmsH+OyoArQ+d0NHZAVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxVy0ITtnRRiXDVAj0Ge8w91m57GFiR35h0IexzVptT7bv+nXrTWYjFM2RmX4nVkkOwdgZ4JOGETWPmA1loCVUnx7Ho7KLZknCX/8PDwQrLdbmtNzw0wfZn+4OkRgXf71yMUpNgFjYzy6PFhGBnqP2CI5qnvq2Xg7TPBZFkXM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tWu2OLAs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tWu2OLAs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ClgwV1419590;
	Fri, 7 Aug 2026 14:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cWoCqI
	qoi0UhoduRzW3/cbAn7/o84+ShPzQj/cnzgDI=; b=tWu2OLAstDvM7FJ0vsYitD
	EISJEX035XEVpgp52Zm5gERrUjvOnxZSo8gPV8B2Eb22W34fQhmzFOFlspkxhFub
	1opUUUEfdguhvHP/eBrNO4lKdKyxCU6EUQgfjJNHIKKf7W6haentXjciRfJKud9E
	M5ZIbdiNIrzD3K8OrHd4x7Lu1mLGuYzR/hE/dOtmeHaQjXt3mfB/o7CBk/Tmynoo
	8RkJRwMdymrf2L5OjMK66hj4dsgfK7jYID+OFZ2nZR3hYWc6pHuR8uDRnhr2puv1
	xby8yumjPcyQ9wD/Itfm5/3jZDfNGwSPSBDC+NdqyTnlfZCxu/btJYE7R2e33xTw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0243ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:07:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677DuiQx024185;
	Fri, 7 Aug 2026 14:07:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhqvx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:07:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677E7rWC33096062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:07:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC94520043;
	Fri,  7 Aug 2026 14:07:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7187C20040;
	Fri,  7 Aug 2026 14:07:53 +0000 (GMT)
Received: from [9.111.147.5] (unknown [9.111.147.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:07:53 +0000 (GMT)
Message-ID: <6464b794-ab0b-4294-b1cb-3de618f4b11e@linux.ibm.com>
Date: Fri, 7 Aug 2026 16:07:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after
 dibs_dev_del()
To: Jakub Kicinski <kuba@kernel.org>
Cc: hidayath@linux.ibm.com, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
        stable@vger.kernel.org
References: <20260804085848.3579518-1-wintera@linux.ibm.com>
 <20260806160602.2694608-1-kuba@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260806160602.2694608-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: tGcjwzDcnRvt8iEODw8mCHuDstCu4-ZF
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75e6bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=w_x_aPnZaW76GSbdfxEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: J0ssvwLpQsiWcakMLJR-4J5dpoQ6tpYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwOCBTYWx0ZWRfX9SkVuTKnb09A
 dBE6sM4yJNkBBPE4CyTa0DcONl1COW7UILpnMqm68UG+2N13lMHpxA1+QSH2RYxcJP9Hlsr8JD4
 yuUFH01f9K4cAtGupvbSeg1H7ZnU2l3OR1ldc38l/yzwqtGM87BvIXij2XCeeRPMM3f6OmajNbh
 w2QizTNnnNSR8VaEIo7UPtOVcM7j0dWeWMVZdmNJE5etncgpp1VO9xUOawrf7dqTwvSaY6UXPO1
 0TPFulefjpDc5KsDhOoL67oI1cF3YklRpeGxi673Qw5I5UixxWkNvO/rRMGachAJfMSQ+JcfCZr
 akpnrrbwmgvMpAfxNM/vEdaquMJpUR/lL7p0P307ajxIMrZa8xZ3D+6pvHGxpcdQ1Y8VXOPaoi9
 PT5VeTYj77wnYUZk2RMbaIY1z8zR7WKjiLMMgAdIy649a/+v2hn2JQjFoQkJab2d28HOelrH2Qy
 CO9HLm0sbvp5+oG3hWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwOCBTYWx0ZWRfX1EF63KlLmPqK
 blRyd0xhxVlmh6tgLl0S6mNfzlAs0u+ZrEtc8kenwYTNznmDTywcMN8ZK3EiM795hgyXlV2p8ll
 c5ZWZO1OFn9qky02Pq1/CTv/GL48Qh8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070108



On 06.08.26 18:06, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/dibs: Fix UAF of dmb_clientid_arr after dibs_dev_del()
> 
> This moves the kfree() of dibs->dmb_clientid_arr out of dibs_dev_del() and
> into dibs_dev_release(), so the array survives until the last device
> reference is dropped.  The error paths in dibs_dev_add() are converted from
> gotos to direct returns and no longer free the array.
> 
>> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
>> index 14c3e2d84902e..f059fefb09bf8 100644
>> --- a/drivers/dibs/dibs_main.c
>> +++ b/drivers/dibs/dibs_main.c
>> @@ -128,6 +128,7 @@ static void dibs_dev_release(struct device *dev)
>>  
>>  	dibs = container_of(dev, struct dibs_dev, dev);
>>  
>> +	kfree(dibs->dmb_clientid_arr);
>>  	kfree(dibs);
>>  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the new ownership rule
> here leave a double free of dibs->dmb_clientid_arr in the loopback probe
> path?
> 
[..]


[PATCH net v2] dibs: fix double free of dmb_clientid_arr
is in discussion on the netdev mailinglist already.


> 
> Since this is tagged for stable, would it be worth also stating the new
> caller contract in the changelog, i.e. that callers must only call
> put_device() when dibs_dev_add() fails?
> 

I don't understand the proposal.


>> @@ -194,12 +195,13 @@ int dibs_dev_add(struct dibs_dev *dibs)
>>  
>>  	ret = device_add(&dibs->dev);
>>  	if (ret)
>> -		goto free_client_arr;
>> +		return ret;
>>  
>>  	ret = sysfs_create_group(&dibs->dev.kobj, &dibs_dev_attr_group);
>>  	if (ret) {
>>  		dev_err(&dibs->dev, "sysfs_create_group failed for dibs_dev\n");
>> -		goto err_device_del;
>> +		device_del(&dibs->dev);
>> +		return ret;
>>  	}
> 
> [Severity: High]
> These are the two failure returns that reach the loopback err_reg path
> described above: device_add() returning an error (-ENOMEM, or a
> kobject_add()/duplicate-name failure) and sysfs_create_group() returning
> -ENOMEM.  In both cases dmb_clientid_arr is still allocated and not NULLed,
> so the caller-side kfree() and dibs_dev_release() both free it.  The
> kzalloc-failure case is fine because the pointer is still NULL.
> 

Same as above (?)

[PATCH net v2] dibs: fix double free of dmb_clientid_arr
is in discussion on the netdev mailinglist already.



> [Severity: Medium]
> This is a pre-existing issue and not introduced by the patch, but the
> changelog reasons about the placement of the allocation:
> 
>     Note that allocating in dibs_dev_add() instead of dibs_dev_alloc() is ok
>     for now, because no dmbs can be registered before dibs_dev_add().
> 
> Does that reasoning also cover dibs->lock, which is initialized in the same
> place?
> 
> drivers/dibs/dibs_main.c:dibs_dev_add() {
> 	max_dmbs = dibs->ops->max_dmbs();
> 	spin_lock_init(&dibs->lock);
> 	dibs->dmb_clientid_arr = kzalloc(max_dmbs, GFP_KERNEL);
> 	...
> }
> 
> ism_probe() enables interrupts before that, via ism_dev_init() doing
> request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, ...) plus
> register_sba()/register_ieq(), and only calls dibs_dev_add() afterwards.  In
> that window dibs comes from kzalloc, so dibs->lock has never been
> initialized and dmb_clientid_arr is NULL, yet the handler takes the lock and
> indexes the array before any check:
> 
> drivers/s390/net/ism_drv.c:ism_handle_irq() {
> 	spin_lock(&dibs->lock);
> 	ism->sba->s = 0;
> 	...
> 		client_id = dibs->dmb_clientid_arr[bit];
> 		if (unlikely(client_id == NO_DIBS_CLIENT ||
> 			     !dibs->subs[client_id]))
> 			continue;
> 	...
> }
> 
> The comment in ism_probe() says interrupts and events are ignored before
> dibs_dev_add() adds the device to any clients, but that check happens on
> dibs->subs[], after the lock acquisition and after the dmb_clientid_arr
> dereference.  With CONFIG_DEBUG_SPINLOCK or lockdep this window would give
> "spinlock bad magic" or "trying to register non-static key" from hardirq
> context, and spin_lock_init() in dibs_dev_add() re-zeroing the lock while
> the handler may hold it would void mutual exclusion.
> 
> Would moving spin_lock_init() and the allocation into dibs_dev_alloc() close
> this window?
> 

Recently fixed by:
c27e36054537 ("dibs: initialise dibs->lock in dibs_dev_alloc()")



>> @@ -214,13 +216,6 @@ int dibs_dev_add(struct dibs_dev *dibs)
>>  	mutex_unlock(&dibs_dev_list.mutex);
>>  
>>  	return 0;
>> -
>> -err_device_del:
>> -	device_del(&dibs->dev);
>> -free_client_arr:
>> -	kfree(dibs->dmb_clientid_arr);
>> -	return ret;
>> -
>>  }
>>  EXPORT_SYMBOL_GPL(dibs_dev_add);
> 
> [ ... ]

