Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF131A555;
	Mon,  3 Aug 2026 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757590; cv=none; b=nETISj16VgaoPHjQdPEIrsW17VJmy3o3YmCiXAscKAen316HMfU+3jUo9syuV7tGCOMiSGaoQf6Fpgc7mZl8XZvNxng9QBD2ZaLbN0bOvRvLJx32VYwqbDxu9Tk7SDsOofEEthDkAcSLedY85V5AMJLhyngoa6dn89eH8KATjJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757590; c=relaxed/simple;
	bh=npEhR4aPncytiMgDBGkm/NbGXXaLyXjsdgVb3U5Uc/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIMA2zyOQqio3wPfjvUPQeJoP5kXPfSLxKX9xh1R+/IhIW6WP+zBFyP5hdtpLZzjcRH/ABg/9QGlORzwU1u0JJ9OuozlEKsBLubevULBpM/Rzw2lPO0rK3bPEmmsxW0TkuARgh60ia6GJVafAVlqcLnSLC4x2aEgRT/dykaQiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S4TaCO2w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S4TaCO2w"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lld69159778;
	Mon, 3 Aug 2026 11:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o9BEpJ
	JPpMFADc7UwLEV5UtAvo362fUQ3AALbD2ya9o=; b=S4TaCO2w+ZSsyvI6Vdb2Ah
	eW+UoeGuuzxX3oUvU6SZtrANlTsflgYDjIQ/QWLFTT0uE1w02S7bvAVRvxee2X/E
	IRiP1yaXJcwaPtCjiJr5HC0FQA/FhZQjIr557xBwkxoAzYwfS5miS+HUrYffJ37Y
	yB9+EGZWlYzsSrOBJ7Jc2YcndXl/oGheNridwQk28QPu0MavzvOLRHLrUaV74dOj
	JhmeIRxPwIOpFn37UIPecGsW/pMtO9GvYPwbpVt6zHWOwGr7Ra1n5Qn++zFkUkt8
	1fio3wxmRJ9qGr2tvcffW5Hbl3ITCtpx+RvtLKj4kOANAW9zNnlw6Lc1sdCAoCYg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgfu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 11:46:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673Bfeiu005927;
	Mon, 3 Aug 2026 11:46:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtycx04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 11:46:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673BkNa830605950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 11:46:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0038820063;
	Mon,  3 Aug 2026 11:46:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D295F2005A;
	Mon,  3 Aug 2026 11:46:22 +0000 (GMT)
Received: from [9.224.94.95] (unknown [9.224.94.95])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 11:46:22 +0000 (GMT)
Message-ID: <0679d4e8-8ae7-4b1b-828f-e1e4428c142c@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:46:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dibs: initialise dibs->lock in dibs_dev_alloc()
To: sashiko-reviews@lists.linux.dev, Hidayath Khan <hidayath@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260730124227.167829-1-hidayath@linux.ibm.com>
 <20260731124243.9A2651F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260731124243.9A2651F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfXxiGklwzHWQrP
 nJsPlulksdZ0+JkEsp4td3rN0GQsVcVLAuDArjtOMFQ39zBGWF+SCctZFf73pTFOdIEZIY85Q3a
 1tjUAIs7EzKZ5iFNeYHTzQQ/btBvDFk=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a707f93 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nGfbw9Na56YB-_i-cVwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX0B5mYYGHfwHn
 jQ5zusAh9A6nUUY8B91iJ2pE0E8f7NIDc24lwo5VHv8jaX85MKorFsruX33+QnOdyN464R86h9G
 3woVSgZKx72zNwCcV5IMEuRT13QjXZdaX4Drk3GaFodIaquauWLyuan5mcTmUyhNSdPugCbDLYx
 CIfhmwXDPrHW9+XX3PNG6b3wxhpLL7CmEmnd3eTx8iw6Q/O9zqPbYu9bcZz6FI+wfoOUxzPx7Hi
 wOVdgnfBrwRHLf9U95SrPD0kkmgaXNoWuaNaoYj2aEs/yIvwrItna+HXgmtcz2OLBx3Ev9ONb0G
 unyl6VQNiMSo3xMYSeqz7lVm1Y26KPrfILmsjDSLvPoOqK5w1tAqwYeoCqSl0EUE6sxl/r/cFdi
 2nbRU54htb0qx126vukntAs4w0qqWgnE/WoRSaPw51LtQkdgqYrxJqWRtXEyNShO+KS+gqsiJW3
 8m/NWcTDq6ObCGz1rUQ==
X-Proofpoint-ORIG-GUID: yhtz3VLJxYsnUTQwFELz0peCGS94vegN
X-Proofpoint-GUID: yhtz3VLJxYsnUTQwFELz0peCGS94vegN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030101



On 31.07.26 14:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Early interrupt handling causes NULL pointer dereferences on `ism->sba` and `dibs->dmb_clientid_arr`.
> - [High] The interrupt handler is unregistered (`free_irq`) after the critical data structures it accesses are freed, leading to Use-After-Free or NULL pointer dereferences during teardown.
> - [High] Double free of `dibs->dmb_clientid_arr` when `dibs_dev_add` fails.
> --
> 
> --- Patch [1]: [PATCH net] dibs: initialise dibs->lock in dibs_dev_alloc() ---
> commit dbb6bc52f9b974f5e291d1236762d41302672810
> Author: Hidayath Khan <hidayath@linux.ibm.com>
> 
> dibs: initialise dibs->lock in dibs_dev_alloc()
> 
> dibs->lock is initialised by dibs_dev_add(), but a dibs device can already
> take interrupts before that call. This moves the lock initialization to
> dibs_dev_alloc() so it is valid as soon as the device can be published to
> its interrupt handler.
> 
>> dibs->lock is initialised by dibs_dev_add(), but a dibs device can
>> already take interrupts before that call: ism_probe() runs
>> ism_dev_init(), and hence request_irq(), before it calls
>> dibs_dev_add(). No client can have registered a dmb at that point, so
>> no dmb interrupt can occur, but a GID event interrupt can, and
>> ism_handle_irq() takes dibs->lock unconditionally on entry, before it
>> inspects anything else.
> 
> [Severity: High]
> This is a pre-existing issue, but while moving the lock initialization avoids a
> panic on the uninitialized spinlock, won't the handler still crash immediately
> after taking the lock?
> 
> Looking at drivers/s390/net/ism_drv.c, if a spurious interrupt fires right after
> request_irq() in ism_dev_init():
> 
> 	ret = request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, 0,
> 			  pci_name(pdev), ism);
> 	if (ret)
> 		goto free_vectors;
> 
> 	ret = register_sba(ism);
> 
> The interrupt handler ism_handle_irq() will execute and unconditionally
> dereference ism->sba, which hasn't been populated by register_sba() yet:
> 
> 	bv = (void *) &ism->sba->dmb_bits[ISM_DMB_WORD_OFFSET];
> 	end = sizeof(ism->sba->dmb_bits) * BITS_PER_BYTE - ISM_DMB_BIT_OFFSET;
> 
> 	spin_lock(&dibs->lock);
> 	ism->sba->s = 0;
> 
> Could this cause a NULL pointer dereference when accessing ism->sba?
> 
> [ ... ]

ISM devices will only deliver interrupts when sba AND ieq are registered.
I will add a comment.



> 
>> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
>> index 14c3e2d84902e..4c26fd06973f7 100644
>> --- a/drivers/dibs/dibs_main.c
>> +++ b/drivers/dibs/dibs_main.c
> 
> [ ... ]
> 
>> @@ -186,7 +187,6 @@ int dibs_dev_add(struct dibs_dev *dibs)
>>  	int i, ret;
>>  
>>  	max_dmbs = dibs->ops->max_dmbs();
>> -	spin_lock_init(&dibs->lock);
>>  	dibs->dmb_clientid_arr = kzalloc(max_dmbs, GFP_KERNEL);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this allocation lead to a
> double free on error paths?
> 
> If dibs_dev_add() fails later in the function, it legitimately frees this
> array:
> 
> drivers/dibs/dibs_main.c:dibs_dev_add() {
>     ...
> free_client_arr:
> 	kfree(dibs->dmb_clientid_arr);
> 	return ret;
> }
> 
> However, the loopback driver's probe function dibs_lo_dev_probe() also frees it
> on failure:
> 
> drivers/dibs/dibs_loopback.c:dibs_lo_dev_probe() {
>     ...
> err_reg:
> 	kfree(dibs->dmb_clientid_arr);
> 	/* pairs with dibs_dev_alloc() */
> 	put_device(&dibs->dev);
> }
> 
> Can this cause a double free of dibs->dmb_clientid_arr if device registration or
> sysfs group creation fails?


Hidayath has already sent a fix:
https://lore.kernel.org/netdev/20260730075624.114778-1-hidayath@linux.ibm.com/


> 
> [Severity: High]
> This is a pre-existing issue, but is there also a use-after-free risk during
> device teardown involving this array?
> 
> During device removal, ism_remove() executes teardown in an order that frees
> data structures while the interrupt handler is still active:
> 
> drivers/s390/net/ism_drv.c:ism_remove() {
> 	...
> 	dibs_dev_del(dibs);
> 	ism_dev_exit(ism);
> 	...
> }
> 
> dibs_dev_del() calls kfree(dibs->dmb_clientid_arr):
> 
> drivers/dibs/dibs_main.c:dibs_dev_del() {
> 	...
> 	device_del(&dibs->dev);
> 	kfree(dibs->dmb_clientid_arr);
> }
> 
> And then ism_dev_exit() unregisters and nullifies ism->sba before finally
> calling free_irq():
> 
> drivers/s390/net/ism_drv.c:ism_dev_exit() {
> 	...
> 	unregister_sba(ism);
> 	free_irq(pci_irq_vector(pdev, 0), ism);
> }
> 
> If an interrupt fires during this window, can the active IRQ handler access the
> freed dibs->dmb_clientid_arr or dereference the NULL ism->sba pointer?
> 
>>  	if (!dibs->dmb_clientid_arr)
>>  		return -ENOMEM;
> 

I will send fixes.




