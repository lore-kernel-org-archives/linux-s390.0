Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694943E4BA;
	Wed, 29 Jul 2026 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325498; cv=none; b=E33XWjBQJ9y4IbhstFndL6ADFcCEQzgXyyprKTyMYUtcmfDjV7tvU4MEgQGNYnttzdCM6TkiUREGLCbV5nubgFd3FUYS1ZxqfWY4lJu0JWpZdVgV4Sl4qiFou7r7bJYlKJ39HMX76IkHxM/aQcKxK6MRj+ptLOFkNVU3qhYx+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325498; c=relaxed/simple;
	bh=G41UO4bhexRK78yXFilwPjL0ztBw4BpvV6o8OfFtotk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjsuRpyi3i/SpeMuLcE7qHE2g8bQFaW3O3PQHKzBNmwUyMAxZVC8S+xdGJlAzKwh1va7HSdZ93SCvfh9nmFLzoKaa07BZKLdaNBAMtLOczYCTNdaYQcoqmNigQqD07j57osecd14La07B4LZqci6C9ajlcSbm/t01Nc837KMXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kG1Bfg5I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kG1Bfg5I"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBI8vU3953712;
	Wed, 29 Jul 2026 11:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=19vJIY
	sPAiyyE6LMC8jplHctT+k90A5rVw/R7+FUjZM=; b=kG1Bfg5IUOClpWZlZR61xS
	IYdxrxX3lXp4/ppKVWZ4En4UDyzvzsK2Awb3Jq+kABXzIXquP1xHo4kx/H2qsTAy
	7y28q7P1I1iSWVHYteHkKmMU/ImCxnnKT3pk3DH442/j4t8gCd+DCDLyrKSCj6vz
	THkW1SaoPM7YsnNvPcy1nJHgQr+nnldrObotn2u3S/TsLa3yFDXPMthTCiZYjjI3
	ajHVA2K6SVOkEbTdMMBRsU+8eYi6iICO//RT8RCyI+XC2bLU2ZFRQ1jkO6slsHNK
	xcTktG0zoj0fohPly0fRnch6wM/Se5KcbgTOYYKkBh55+kE13zuvPg0DtqQT/fmQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj9n1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:44:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBfX0r022842;
	Wed, 29 Jul 2026 11:44:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y67hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:44:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBioYX33882594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:44:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5C0020043;
	Wed, 29 Jul 2026 11:44:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FE2620040;
	Wed, 29 Jul 2026 11:44:50 +0000 (GMT)
Received: from [9.224.94.95] (unknown [9.224.94.95])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 11:44:50 +0000 (GMT)
Message-ID: <423ac283-7200-482e-8307-0a85ba07eb7b@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:44:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dibs: fix use-after-free of dmb_node in loopback
 attach/detach/unregister
To: sashiko-reviews@lists.linux.dev, Hidayath Khan <hidayath@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260727093530.968834-1-hidayath@linux.ibm.com>
 <20260728093547.8AEA41F01561@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260728093547.8AEA41F01561@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX9h3TpxdWUc+N
 EnlABsBSMoQUb81KL+BVDdMXFDqegJDA4H7zzI/Q/PxkwMp00QXV59Ns956cGFNW9LuMofh38xj
 OU6/Ii5dJ7dt64PMCgPyXVld+kbR5fE=
X-Proofpoint-GUID: SwTos7K0j08H42UBEQF0wZXyCeYOwzQy
X-Proofpoint-ORIG-GUID: SwTos7K0j08H42UBEQF0wZXyCeYOwzQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfXytsSVJUHrpsY
 YsDs9xG1+31QA8+X1f/i8KnpttcjHnLRthnTuP/C7OlaW7ON9YMGRp1h6mLcrEWSHfDXNbX4+wk
 /m/iHZlKGZu8uy1Rp3tkTVal6d/lHanDUfc8QvrfsDHuFZGkWAY9qfzNLCZtKjMriCcn7Ub1oXC
 HkIBs6/xQLc/Kva/HfuSKSirAx091dTsfQJnbYZ4lBUqV6aQToqIF+wIPdF3yeeu2omeSUp4U2m
 gzos9z2HTJAdPJ1hJsTbYl6fZiwN3dSD5uOYPL5HJqmQzI+d2P7InJIQ48jMalRY2uysMMKG+xH
 qnQKQaQ9IMidtPTIGUT1DKgZGgjGHo7s6ZojHA8ZSM/7PpM6iB1LXf74auhTeSBja/EM5tLcEQx
 NmHaXee9cK02cBKVpSLOCqtOMf8ay4/18lXsCn6dazhuELKYI+fCD38C/Pt4tZ9OVM7UpPQnmaV
 pZy+zARoRgj3lnKf9LQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69e7b7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yzPgnIC9g52e3d9k8P0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290093



On 28.07.26 11:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] dibs_lo_detach_dmb() fails to clear dibs->dmb_clientid_arr when dropping the final reference, leading to permanent client resource leaks.
> - [High] Double free of dibs->dmb_clientid_arr in dibs_lo_dev_probe() error path.
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
>>  {
> [ ... ]
>> +	last = refcount_dec_and_test(&dmb_node->refcnt);
>> +	if (last)
>> +		hash_del(&dmb_node->list);
>> +	write_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +	if (last)
>> +		dibs_lo_free_dmb(ldev, dmb_node);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this code fail to clear
> the client ID array when dropping the final reference?
> 
> When an owner unregisters a DMB that still has active attachers (refcount > 1),
> dibs_lo_unregister_dmb() does not clear the array because last == false.
> 


This is a true statement for future dibs clients (=dmb owners), but the current only
dibs client smc does not do that. All dibs-loopback dmbs are detached before they
are unregistered. -> not an issue today.

I will follow up to make this more future-proof.


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
>>  	return 0;
>>  }
> 
> [Severity: High]
> This is a pre-existing issue, but is there a double free of
> dibs->dmb_clientid_arr in the dibs_lo_dev_probe() error path?

Ack. Hidayath will send a fix soon.

> 
> If dibs_dev_add() fails internally, it frees the array without nullifying it:
> 
> drivers/dibs/dibs_main.c:dibs_dev_add() {
>     ...
> free_client_arr:
> 	kfree(dibs->dmb_clientid_arr);
> 	return ret;
> }
> 
> The caller receives the error and unconditionally frees the already-freed array
> again:
> 
> drivers/dibs/dibs_loopback.c:dibs_lo_dev_probe() {
>     ...
> err_reg:
> 	kfree(dibs->dmb_clientid_arr);
>     ...
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
>     ...
> 	sba_idx = rmb_node->sba_idx;
> 	read_unlock_bh(&ldev->dmb_ht_lock);
>     ...
> }
> 
> Before it acquires the lock to trigger the IRQ, another CPU could drop the
> final reference to the DMB, free the node, and clear its sba_idx.
> 
> If a completely different client then immediately registers a new DMB and
> reallocates the same sba_idx, will the IRQ be routed to the wrong client when
> the code continues?
> 

Not an issue today, because smc is the only dibs-client.
But definitively needs improvement. I will follow up.


> drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
>     ...
> 	spin_lock(&dibs->lock);
> 	client_id = dibs->dmb_clientid_arr[sba_idx];
> 	s_mask = ror16(0x1000, idx);
> 	if (likely(client_id != NO_DIBS_CLIENT && dibs->subs[client_id]))
> 		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
>     ...
> }
> 

