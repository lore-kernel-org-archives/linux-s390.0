Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A663411F82;
	Wed, 29 Jul 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318760; cv=none; b=djUC3gZiVH0C8vUX0FiAokUwNGW6QzdwV+F1L8io4E/X/qnZDpOSirNXlL13yXMcEB1kDJ+++0CdR0oNfOtNXRsldCAjKAgY+aXyxih6LB8U8lZI0Mo+pVsPC30YZ8cLOaaIDauyiyGodX8Lp59twrFgO8ULAe+Cv9u1mqm4QAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318760; c=relaxed/simple;
	bh=Bob2JxnygWzwQ89bYs/Dmnyge5v1EzKKBhSvsq/g8CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpO7n4p8tl0mU67WsQArfEZHdy/NuuZtHHLPNUhCQzmL8GedzjrC23EUjRGljX/NZ0lMRBnlqhr70VmNN97JUO6xkyPpPBvGyPpa9V6CH1Q/lplLSIE61hTiTDU5aUU0pga4gTLq29uEdWghd4WJTSTckrI1xCxG3bYpG7JTCRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nc673izy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nc673izy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7nqPC3637205;
	Wed, 29 Jul 2026 09:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e38CGn
	AMEp0658iQGWFoUm8dD8+MyreHW3OPlFjg03I=; b=nc673izypbj/CIefnDVqk9
	KllbL2N951z6WunWn3X8fUn2tJQtTgYttfG8YoQlE71QXtsyA2o4n655hCoASFgr
	2ug3vGYrezA7MNlcO6WP+jgPll93ZOZbKUF3BKI3J4oU5rwB9sVFKCjV1t7k+z8R
	ibbqnmr1fA9ukaPz4SBkgL04c0wcxG2MaF5yT+vEDPkpJvUUGpxGzUfHKeZoVdpX
	e4af0ejXvi1ZQtHemp+t0ABRFzizB9LVo2cRFo1TqNdLCkW50ihgG7Q59AV5pYCQ
	J8bIpOhIcwliuJJ61x8DDqRRTo6GRwCbRHhzTs4rU8ASVePllSzIBf34kmfdD9TA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd19b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 09:52:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9fP0E011053;
	Wed, 29 Jul 2026 09:52:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhe1uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 09:52:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T9qZD934013852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:52:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A03975804B;
	Wed, 29 Jul 2026 09:52:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41CCF58065;
	Wed, 29 Jul 2026 09:52:32 +0000 (GMT)
Received: from [9.124.223.153] (unknown [9.124.223.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 09:52:30 +0000 (GMT)
Message-ID: <946d6009-dab5-4581-8ad7-baff337f1d15@linux.ibm.com>
Date: Wed, 29 Jul 2026 15:22:29 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dibs: fix use-after-free of dmb_node in loopback
 attach/detach/unregister
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260727093530.968834-1-hidayath@linux.ibm.com>
 <20260728093547.8AEA41F01561@smtp.kernel.org>
Content-Language: en-GB
From: Hidayathulla Khan I <hidayath@linux.ibm.com>
In-Reply-To: <20260728093547.8AEA41F01561@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UGobaOME6i73RTQS7lY0YS5_6R2SztgJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX67n4gTVVWpuj
 wFqB64GFQ6ZcXGpMen7JgF5rbs/IOZ4CcNyuEsWts7y92twlh78g2hGM3JtvsHfKPtCtLux/gBx
 Cuu8tFonkssA7zSH60caoBpG1ZkOdhM=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a69cd65 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yzPgnIC9g52e3d9k8P0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfXzdQMU/2YGZp8
 REy2FxWs8u0VSlxz//VykAZu6mTo9ja70LlUTmdIjAZcwaaYUY1RNr2kxGSp5zK+Qwb0Ox9bGv5
 OzeYrjR0KC9Ri5c5zcRKdScuj2jMmwUmw3/8vSyVJ7DsOf+hgyoK32mPVuCHs5+wIw01MIZ5FR4
 ZKl4UCaz4goISfyYRtrgKmSr2dkzmB4yZptWuG6KLeWzVKiAsKgoIJvUcuS1KwRsVgnsvUY2OAV
 rEi9YiKuIdkPPI/8kuFr9B0zsKSpIgBuEXpBKBsD37NidrR/3WSNy/rB+B4y7JKKbimIWvB+1tG
 8bjoVYK+jQ0rL+p9BvlS61mFT3kdsnOmjrcn6SEZbHBwdzDwP954Hlf1JVcPpA0TCnbSP/8gAWO
 T/w/jWoPUVSjlEZQ3d3oUesMcwry+e3SmRq9yVCIrgyNsT/4wOtcTqAdtWZ0Y0Vgmsf0PjCWOM1
 lyk4KJLAs9TZC9iVRoA==
X-Proofpoint-GUID: UGobaOME6i73RTQS7lY0YS5_6R2SztgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290080

Thanks for the Sashiko AI review.

On 28/07/26 3:05 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] dibs_lo_detach_dmb() fails to clear dibs->dmb_clientid_arr when dropping the final reference, leading to permanent client resource leaks.
> - [High] Double free of dibs->dmb_clientid_arr in dibs_lo_dev_probe() error path.
Confirmed as a real double-free. The patch for this is already in the 
internal review.
> - [High] Race condition in dibs_lo_move_data() routes spurious interrupts to wrong clients.
> --
>
> --- Patch [1]: [PATCH net] dibs: fix use-after-free of dmb_node in loopback attach/detach/unregister ---
> commit 90d8ce044f1442abf2a546d5baabbf36276d4b45
> Author: Hidayath Khan <hidayath@linux.ibm.com>
>
> dibs: fix use-after-free of dmb_node in loopback attach/detach/unregister
>
> This commit fixes a use-after-free race condition in the DMB loopback
> operations. It closes the race by making the hash table membership and refcount
> transitions atomic with respect to each other under the write lock. Freeing the
> node is now handled safely after the lock is dropped.
>
>> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
>> index 0f2e093111526..fd5caf1e19a8f 100644
>> --- a/drivers/dibs/dibs_loopback.c
>> +++ b/drivers/dibs/dibs_loopback.c
> [ ... ]
>> @@ -209,11 +205,12 @@ static int dibs_lo_detach_dmb(struct dibs_dev *dibs, u64 token)
>>   {
> [ ... ]
>> +	last = refcount_dec_and_test(&dmb_node->refcnt);
>> +	if (last)
>> +		hash_del(&dmb_node->list);
>> +	write_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +	if (last)
>> +		dibs_lo_free_dmb(ldev, dmb_node);
> [Severity: High]
> This isn't a bug introduced by this patch, but does this code fail to clear
> the client ID array when dropping the final reference?
>
> When an owner unregisters a DMB that still has active attachers (refcount > 1),
> dibs_lo_unregister_dmb() does not clear the array because last == false.
>
> When the final attacher detaches, dibs_lo_detach_dmb() drops the refcount to 0,
> frees the node and the sba_idx, but structurally fails to clear
> dibs->dmb_clientid_arr[sba_idx].
>
> Could this leave a stale client ID in dmb_clientid_arr indefinitely, causing
> future unregistration to fail with -EBUSY and permanently leaking the client
> resource?
>
>>   
>> -	if (refcount_dec_and_test(&dmb_node->refcnt))
>> -		__dibs_lo_unregister_dmb(ldev, dmb_node);
>>   	return 0;
>>   }
> [Severity: High]
> This is a pre-existing issue, but is there a double free of
> dibs->dmb_clientid_arr in the dibs_lo_dev_probe() error path?
>
> If dibs_dev_add() fails internally, it frees the array without nullifying it:
>
> drivers/dibs/dibs_main.c:dibs_dev_add() {
>      ...
> free_client_arr:
> 	kfree(dibs->dmb_clientid_arr);
> 	return ret;
> }
>
> The caller receives the error and unconditionally frees the already-freed array
> again:
>
> drivers/dibs/dibs_loopback.c:dibs_lo_dev_probe() {
>      ...
> err_reg:
> 	kfree(dibs->dmb_clientid_arr);
>      ...
> }
>
> Could this double-free cause slab allocator corruption?
>
> [Severity: High]
> This is a pre-existing issue, but is there a race condition in
> dibs_lo_move_data() that routes spurious interrupts to wrong clients?
>
> The target sba_idx is cached and the protection lock is dropped:
>
> drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
>      ...
> 	sba_idx = rmb_node->sba_idx;
> 	read_unlock_bh(&ldev->dmb_ht_lock);
>      ...
> }
>
> Before it acquires the lock to trigger the IRQ, another CPU could drop the
> final reference to the DMB, free the node, and clear its sba_idx.
>
> If a completely different client then immediately registers a new DMB and
> reallocates the same sba_idx, will the IRQ be routed to the wrong client when
> the code continues?
>
> drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
>      ...
> 	spin_lock(&dibs->lock);
> 	client_id = dibs->dmb_clientid_arr[sba_idx];
> 	s_mask = ror16(0x1000, idx);
> 	if (likely(client_id != NO_DIBS_CLIENT && dibs->subs[client_id]))
> 		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
>      ...
> }
>
