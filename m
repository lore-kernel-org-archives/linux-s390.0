Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B773DD50F;
	Fri, 31 Jul 2026 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506700; cv=none; b=nedVxGkGf6Do/9emJjKt4psyUWGp5Mcpi/XTJNq91Wgqjf45S8s/8kf77faRM48nroQRYmgLXxbdNobnD0JeKP6HP9hUFbQ0qYc3N8lZedavucLKqKm5fAyInRATnQUW908n9Qu9auzZ+GKNhUiy10KYPTlb0cY35fIW9fMr1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506700; c=relaxed/simple;
	bh=hRBQwcPEV6S4I7fui8jAVA2TIgtf9DY9T/VdmQOExOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz5PUDIS8rXv75g5HEou0RSbp5gDcT8JCjF/2/xDxQf+XH3ANwGZUsCdTXQ0GQr0glw+ssC1jPAXXxfOaMF0nClZXONXeblRtUjgXm6/tqvu0RFsmEqgAYlH/udMLpWfZcB/Ry5hhel/c2bZe7BUwYvKeD8ZLDzcBaqP1N/rQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KT7WHM4g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KT7WHM4g"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm7bZ1671705;
	Fri, 31 Jul 2026 14:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zPRAxS
	VH5HHy2EZbBlnS7v1gJFjfzSog7k9xBk9Tbrc=; b=KT7WHM4gfT+IknUPQaxoQy
	43COvfHpiJQWQVU0TfpYXKQsiZjSJxWUn3M9kdLA/nnVnZ6fvlnKBbwJRgratc6g
	EfjlXbkK3XFK5/Jjqsc39fBbhZEe+a4ecaQX9MjFFHZo81jPC5YLMswZxWetVo5F
	Z7C3NIv2QltsgSkJYjvPR8RSUHdX5lx2oNyoQYu6bMQTL5b1NPayzgOL2PhDyxYz
	HI0vGv7klrdrN95jH7QAHZoDB0fTukDEMlYq17dnL7xrYtHkCkFyu5FL7NyZehgG
	b1MJ4fc6SwBCt+6lHuiERD0xaesqQV2a8LZuAQao3BFZpQ1uDO7MtLUxixkfhyXQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjmc5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 14:04:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VDuI84019139;
	Fri, 31 Jul 2026 14:04:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkg6ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 14:04:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VE4qne17826154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 14:04:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 632022004F;
	Fri, 31 Jul 2026 14:04:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2736020040;
	Fri, 31 Jul 2026 14:04:52 +0000 (GMT)
Received: from [9.111.165.102] (unknown [9.111.165.102])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 14:04:52 +0000 (GMT)
Message-ID: <e11204eb-0b25-408e-95fd-5676297da484@linux.ibm.com>
Date: Fri, 31 Jul 2026 16:04:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dibs: fix double free of dmb_clientid_arr
To: sashiko-reviews@lists.linux.dev, Hidayath Khan <hidayath@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260730075624.114778-1-hidayath@linux.ibm.com>
 <20260731075650.C2BA91F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260731075650.C2BA91F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwNSBTYWx0ZWRfXwNRBTKCQYHNI
 UrY8+7lIZWlRkjBcpNAsYHsbAxZiN1dTQjAazcOX9tUYWRVA9Hil88rU/l361MZCumktzyGsTcj
 Rb1fvHdtZTo4Z3muNHsHKeh4B1zqOvQ=
X-Proofpoint-GUID: GfaP9s2-becm8jpXJYDqODsFWQDjsddj
X-Proofpoint-ORIG-GUID: GfaP9s2-becm8jpXJYDqODsFWQDjsddj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwNSBTYWx0ZWRfX/s2WABmjfNBW
 A3knm1IojuPWC9mi+N6cp8XxT/5s8VWm9QrLimSNJRyYU+pd/RDb6yh+MiOaZiCoS8lJSFXICu5
 oYNC+bCF0WhFaKl6dMol4m1KpyGEOK7HZSYAGTdDUTRBD51VqqpWIzNnXr48IidASJldCpFAnQP
 zuZVsUrEjRfM4uzbQeO2ENW87+lT7VTgb2iHAnHDfyU5LE5H0ip5Jc8XrBOyXf/ijs9mFQBOUx5
 BU0+zPdOt42z0VyEXnGWrFAIlesTJGffg8F86L0iyZ02LKxGOtuE7KOEb7R3LjGeTVII9F5Ahgi
 QCe/bDUCw6lyTvhfGqCEjydDwbH291N3nLA1CB4yWtwV0EzD9ETwp6xyo59GE8UC/R9HQqOQlb5
 DcigPQo5btmLN4doUihVXztccct97fAzz2+JohP2ZB0u7VkDYVBjkZsdd9Vm6BUyVHun7zZXPZu
 dtoAPlWer8swHP0VfZQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6cab89 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lgRtJKbgxCKMiAZx1u0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310105



On 31.07.26 09:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The hardware interrupt handler `ism_handle_irq()` can execute out-of-order with respect to initialization and teardown of critical resources, leading to crashes (UAF, NULL deref, and uninitialized spinlock accesses).
> - [High] `dibs_unregister_client()` leaves the subsystem in an inconsistent partial state if it aborts midway through its device iteration.
> - [High] `dibs_lo_attach_dmb` drops the hash table read lock before incrementing the object's reference count, leading to a Use-After-Free.
> --
> 
> --- Patch [1]: [PATCH net] dibs: fix double free of dmb_clientid_arr ---
> commit 45565b8a1cec1239be540b3b54fad60822ae8b57
> Author: Hidayath Khan <hidayath@linux.ibm.com>
> 
> dibs: fix double free of dmb_clientid_arr
> 
> dibs_dev_add() frees dibs->dmb_clientid_arr on both of its failure
> paths, but does not clear the pointer. dibs_lo_dev_probe() then frees
> the same pointer again in its err_reg path, so a failing device_add()
> or sysfs_create_group() results in a double free.
> 
> Drop the kfree() from dibs_lo_dev_probe().
> 
> Cc: stable@vger.kernel.org
> 
>> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
>> index 0f2e093111526..aeb8787ea9816 100644
>> --- a/drivers/dibs/dibs_loopback.c
>> +++ b/drivers/dibs/dibs_loopback.c
>> @@ -334,7 +334,6 @@ static int dibs_lo_dev_probe(void)
>>  	return 0;
>>  
>>  err_reg:
>> -	kfree(dibs->dmb_clientid_arr);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does dibs_lo_attach_dmb() have
> a use-after-free if the reference count is incremented after dropping the hash
> table lock?
> 
> drivers/dibs/dibs_loopback.c:dibs_lo_attach_dmb() {
> ...
> 	read_unlock_bh(&ldev->dmb_ht_lock);
> 
> 	if (!refcount_inc_not_zero(&dmb_node->refcnt))
> ...
> }

Fixed by
a10ea943356b ("dibs: fix use-after-free of dmb_node in loopback attach/detach/unregister")
that got accepted to net yesterday.


> 
> If a concurrent thread executing dibs_lo_unregister_dmb() acquires the lock
> and drops the refcount to zero, could it free the node before the first thread
> resumes, causing refcount_inc_not_zero() to operate on freed memory?
> 
> [Severity: High]
> This is a pre-existing issue, but is there an initialization race with the
> hardware interrupt handler in ism_drv.c?
> 
> drivers/s390/net/ism_drv.c:ism_probe() {
> ...
> 	ret = dibs_dev_add(dibs);
> ...
> }
> 
> If the hardware interrupt is registered before dibs_dev_add() initializes
> resources, and a spurious interrupt fires, could ism_handle_irq() access an
> uninitialized spinlock or dereference a NULL pointer?
> 

Hidayath has already sent a fix for the lock initialization:
https://lore.kernel.org/netdev/20260730124227.167829-1-hidayath@linux.ibm.com/



> drivers/s390/net/ism_drv.c:ism_handle_irq() {
> ...
> 		client_id = dibs->dmb_clientid_arr[bit];
> ...
> }


No client can have registered a dmb at that point, so
no dmb interrupt can occur, so this NULL pointer dereference cannot happen irl.
I plan to restructure with a future cleanup patch.


> 
> Similarly, during teardown:
> 
> drivers/s390/net/ism_drv.c:ism_remove() {
> ...
> 	dibs_dev_del(dibs);
> 	ism_dev_exit(ism);
> ...
> }
> 
> Could freeing resources like dibs->dmb_clientid_arr via dibs_dev_del() before
> the active IRQ is unregistered create a use-after-free window?
> 


Yes, we will send a fix.


> [Severity: High]
> This is also a pre-existing issue, but does dibs_unregister_client() leave the
> subsystem in an inconsistent state if it aborts early?
> 
> drivers/dibs/dibs_main.c:dibs_unregister_client() {
> ...
> 				rc = -EBUSY;
> 				goto err_reg_dmb;
> ...
> }
> 
> If the loop successfully processes some devices but then encounters a device
> with active DMBs, it returns -EBUSY without rolling back the teardown on the
> previously processed devices. If the caller ignores this return value and
> proceeds to unload the module, could the detached devices later trigger an
> event and dereference freed ops function pointers?
> 
>>  	/* pairs with dibs_dev_alloc() */
>>  	put_device(&dibs->dev);
>>  	kfree(ldev);
> 


Does not happen with smc today.
But the guard is not clean, it should do a better and safer cleanup,
should such a situation arise with a future client.
I will work on an improvement.

