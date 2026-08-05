Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDA3FE35D;
	Wed,  5 Aug 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932091; cv=none; b=Yv9Os0wA6uY4RkB2ts7ejLfafduor9Is8CbNoqv2ojMV4S5Qxi/FX6dlGFp9D75VbuArGMcS6O5S0NwYBS34bV6venNAoOBuy8WuHw2QVz/5FwD2aaU82qQD9sLca13Jhtjkbvzljb2ywsmf7/Tk8+57yVPZXOz71xLmgd7EC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932091; c=relaxed/simple;
	bh=uV0adA1YvWKyLN1bxIOVWxPyk/0v5SGKgcUpTEXe1Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HG73L4he0NLJ8qTXO1retPWfLunmZ/GIBwoAkuB72XGK7z9y0H2EV+KcUQH9J2ffovTLUOxMgOQQ1ZmSJwbe2MZhI0sodpoDg0PgkglGN+VJUzJ7vLAv+V8RFvTCY4KWaKWgqpdIyZaXk30nUqrRpfID/J36OnGfzd0oYabHWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bXu9Haiz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bXu9Haiz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lqL31503380;
	Wed, 5 Aug 2026 12:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZovJsL
	W57e2xieRkO4dArF2E7CV7Klu9Z7DtJJohqM8=; b=bXu9HaizxNRIVKpZIMBuga
	xdkTYheN05jnjxj0r0cgfr+sGMyE/e3EmfV26iDWd8bbju7pGJDl1+KQHcl2dyfO
	usTb+snSTlMYcHEcWz1UA+rMyspyV5zENnSoi7lgNzvpUfLd/KdjgkOQU4CQhgc1
	m0EYZAtGEIFA/yW1zjRy3ZlDtMxjR6rid0dgUmBBc0GYFMQrknkai2Bc8BOYCs58
	IxFbzof3dnQkQtiVf7g5YVEo9G0E0eqcJk9r5UXdYQVz2BtnxHusTUzpZOEUpMFB
	hNI/VSJD1FJFn0IYZg1XFVcfZN3nf38BxRjC1mOqgCTmWnw/h2ljh3u21xZu5Rng
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqttq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:14:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675CBDxI018790;
	Wed, 5 Aug 2026 12:14:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyp75r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:14:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675CEi5c25952692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 12:14:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B88120040;
	Wed,  5 Aug 2026 12:14:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DBBF2004D;
	Wed,  5 Aug 2026 12:14:44 +0000 (GMT)
Received: from [9.111.207.139] (unknown [9.111.207.139])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 12:14:44 +0000 (GMT)
Message-ID: <0c2907fe-956a-4e5e-babd-fcb4a7553674@linux.ibm.com>
Date: Wed, 5 Aug 2026 14:14:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after
 dibs_dev_del()
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20260804085848.3579518-1-wintera@linux.ibm.com>
 <20260805085911.4F10A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260805085911.4F10A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NIlGL0UWmOTWGbFoCaQlpSgBhPB74r8q
X-Proofpoint-ORIG-GUID: NIlGL0UWmOTWGbFoCaQlpSgBhPB74r8q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX6yewbu03mKcH
 rQIKaPIGMNw9UoJXjjX3WZvkHn0ABLp02gSqoYxUidhqYEF97KUeaI8QNKJqDFOe71YZwn2ULUv
 AA//ujzDek7g+4aRdRsq2nOPCZRWHYw=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a732939 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=AxOp7Wdt2wiajIyk4cEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX7Z4m+LiYcYBX
 hjG/QxisbicVSZC8X3l88cnFUtQm7289SGmw9PVxtXmJ4QlCtVR7uH/aT/rTF2AsGb+p+B2yccp
 T4ZkHYXl4fBx9U0xgZ/83NZ6y5Rydoy3jC7OB1QrbzqQRNzi5VinI+llOkhtJfzOlVqm6ALM520
 MVslly3ndTvYvECQS1KzuwbyTmnRbWkoK3JNaVq6Z2al0EoijyoXPmA3gnaMDKxk4YaYyhyR2aX
 48cXA5PofBbE41SJiYmxB+ESAyDhl8FWDnHQkxX3C0190azTnVP6Ylj7RzY8KK692+u+ReliP6V
 ckzn1eFaiv1Gu24TaziPcHF4eTbe62QOq7MF8qOA8wnp/F1cX2Q3KUdLRcX8nDEgPU8CKmprr0K
 Xw1anvjFUfdm4qDS/I0YWKevEUPrv2IZwknuV08P6voDhDsCP3y9neUPvSOWxreTVR26a1rZWrr
 Nx7wOirgcBOA44wzNeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050094



On 05.08.26 10:59, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Double free of `dmb_clientid_arr` in the error path of `dibs_lo_dev_probe()`.
> - [Critical] The interrupt handler `ism_handle_irq()` can dereference NULL pointers and acquire an uninitialized lock due to early interrupt enablement.
> - [Critical] Use-after-free of `ism->sba` and `ism->ieq` during teardown due to improper ordering with `free_irq()`.
> - [High] Partial rollback failure leaves client in a broken state in `dibs_unregister_client()`.
> --
> 
> --- Patch [1]: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after dibs_dev_del() ---
> commit 40d2232069f48423978af98bbecb5075fb611ca0
> Author: Alexandra Winter <wintera@linux.ibm.com>
> 
> net/dibs: Fix UAF of dmb_clientid_arr after dibs_dev_del()
>     
> A dibs device interrupt handler can be active after dibs_dev_del() and
> may still access dmb_clientid_arr. Free dmb_clientid_arr in
> dibs_dev_release() after last reference is gone.
> 
> Fixes: cc21191b584c ("dibs: Move data path to dibs layer")
> Cc: stable@vger.kernel.org
> Co-developed-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> 
>> --- a/drivers/dibs/dibs_main.c
>> +++ b/drivers/dibs/dibs_main.c
>> @@ -128,6 +128,7 @@ static void dibs_dev_release(struct device *dev)
>>  
>>  	dibs = container_of(dev, struct dibs_dev, dev);
>>  
>> +	kfree(dibs->dmb_clientid_arr);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this lead to a double free in the
> error path of dibs_lo_dev_probe()?
> 
> If device registration fails during loopback probe, the error path explicitly
> frees the array and then puts the device:
> 
> drivers/dibs/dibs_loopback.c:dibs_lo_dev_probe() {
>     ...
> err_reg:
> 	kfree(dibs->dmb_clientid_arr);
> 	/* pairs with dibs_dev_alloc() */
> 	put_device(&dibs->dev);
>     ...
> }
> 
> Since put_device() now unconditionally calls dibs_dev_release() and frees
> the array again, will this corrupt memory?
> 
> [ ... ]
> 

[PATCH net] dibs: fix double free of dmb_clientid_arr
is in discussion on the netdev mailinglist already.


>> @@ -194,12 +195,13 @@ int dibs_dev_add(struct dibs_dev *dibs)
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but can the interrupt handler
> access uninitialized structures if an early interrupt occurs?
> 
> In ism_dev_init(), interrupts are requested and enabled before the device
> is fully registered:
> 
> drivers/s390/net/ism_drv.c:ism_dev_init() {
>     ...
> 	ret = request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, 0,
> 			  pci_name(pdev), ism);
> 	if (ret)
> 		goto free_vectors;
> 
> 	ret = register_sba(ism);
>     ...
> }
> 
> If a hardware interrupt arrives immediately after request_irq(),
> ism_handle_irq() will execute and unconditionally access the uninitialized
> ism->sba and acquire dibs->lock, before register_sba() or dibs_dev_add()
> have initialized them. Can this lead to a NULL pointer dereference or
> uninitialized lock access?
> 
> [ ... ]

Cannot happen.
ism hardware will not generate interrupts before SBA AND IEQ are registered.
A cleanup patch is planned.


> 
> [Severity: High]
> This is a pre-existing issue, but does dibs_unregister_client() fail to
> roll back its state if a client is busy?
> 
> If a client attempts to unregister while still having active DMBs on
> multiple devices, the loop aborts and returns -EBUSY:
> 
> drivers/dibs/dibs_main.c:dibs_unregister_client() {
>     ...
> 				rc = -EBUSY;
> 				goto err_reg_dmb;
> 			}
> 		}
> 		/* Stop forwarding IRQs and events */
> 		dibs->subs[client->id] = NULL;
> 		spin_unlock_irqrestore(&dibs->lock, flags);
> 		clients[client->id]->ops->del_dev(dibs);
>     ...
> }
> 
> Since it does not undo the modifications made to the preceding devices in
> the list (such as clearing dibs->subs[client->id]), will this leave the
> client in a broken state?
> 

There is no such codepath with today's SMC client.
I have it on my ToDo list, to make this more robust.


> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but can a device interrupt cause
> a use-after-free during driver removal?
> 
> In ism_dev_exit(), the data structures are destroyed before the interrupt
> handler is quiesced:
> 
> drivers/s390/net/ism_drv.c:ism_dev_exit() {
> 	struct pci_dev *pdev = ism->pdev;
> 
> 	unregister_ieq(ism);
> 	unregister_sba(ism);
> 	free_irq(pci_irq_vector(pdev, 0), ism);
>     ...
> }
> 
> If an interrupt arrives after unregister_sba() but before free_irq(),
> ism_handle_irq() will access the freed ism->sba. Should free_irq() be
> called before tearing down the data structures?
> 

I have a fix, that I will send today.
