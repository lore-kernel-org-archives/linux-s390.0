Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F24EBAF7;
	Thu,  3 Sep 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453725; cv=none; b=eXlKLSgkc+6YU/PyvPNwpbNhosVJG4KYJCzH6sKQK0SAWJs7Eq77Mrorj4DbLXIx1PBeiAPJTdXoJYMyKATZ2/mClLHArJYhol/qBHdEdbqMSBnq1dlVPexd5ebgzt3zqxjPzP5/vazJWeN4Ysd8yYTW2L5QTdqJaWY7XKpf/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453725; c=relaxed/simple;
	bh=ytlV3l9qzuCx6mIHqdXN21NjELs0ePxQUdbj6oH7S2c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IH0OiceqQor9DWDjEVb6608O11vco65VccfrupdEqPpeXRbW3TCnmI/wJSe0LEceb9J43siino3o+tFm/botQKiBY7yDpvqzyNuR9vjx3WmXZWAOJ88i+av8c6MkutGJld33FDupXzzVyl1Uc8fr9ywxZABSRv/h42qzMkHKLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OdpBusLh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OdpBusLh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G2iEv3476001;
	Thu, 3 Sep 2026 16:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OnaZMf
	YP4UqWZhew+m6qkmZ/8cA/fPSogmwAF5muxzs=; b=OdpBusLhqKYNrwzA1P/zsE
	KCgYVN4ZSRnV7IkYpT/UgoKL7DUSl3PP3IxsQ7/MrcGTuKqPFSoonoGzFn181nAp
	LPlQ4mfDoU2Bv5W/qWOsYxAswSdEi63itehHOn1zYu/teoKaPTqHDICRkcoTPeSb
	fYMrLfMJlXNYdwTDKjFIfvR6X6e+Z+qihXAJ0Dr6IQFnab7V2nkrAgUZArOWkdQb
	4QaAn1e4aA3bMNeDAuOePS9GWzLIqIcijCPsUiP6+LDjpt1KUP+6xpHnFyBG7Iok
	4LLpZ9B9qCjBriLfXzzF/v3JkBQytc5IOH9WGBL0bomR4PA3lTipiqRz+Exz3oLg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tnay9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 16:42:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GfMqr028272;
	Thu, 3 Sep 2026 16:42:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkggh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 16:42:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683Gfwuk50856246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 16:41:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 712E120043;
	Thu,  3 Sep 2026 16:41:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35CA520040;
	Thu,  3 Sep 2026 16:41:58 +0000 (GMT)
Received: from [9.111.168.7] (unknown [9.111.168.7])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 16:41:58 +0000 (GMT)
Message-ID: <1f04c8b9-dba4-4c9b-9e5c-f90223f10675@linux.ibm.com>
Date: Thu, 3 Sep 2026 18:41:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/ism: folio_put() after error
From: Alexandra Winter <wintera@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Julian Ruess <julianr@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>
References: <20260902143733.433574-1-wintera@linux.ibm.com>
 <20260903143746.A5CC41F00A3A@smtp.kernel.org>
 <5c27d8f1-67bb-4845-b9ac-ea4bef34c7bc@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5c27d8f1-67bb-4845-b9ac-ea4bef34c7bc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a99a35b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_-ZCbSfgAkmKhJMzj3sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX9ByR+k5AmUpt
 m1Zi/k0CfAHzVIkiP7izFZo1UEsunj/+9x5A1xrfBH7gw0sRXX2qdKbLamwmHYVk19GgfRlx7YF
 f9jRjNfCfZFp0J1do7R563Ewr5NMBhI=
X-Proofpoint-ORIG-GUID: wSpPoQ-L8_aNsKry__UBtTJR3rrhUa1x
X-Proofpoint-GUID: wSpPoQ-L8_aNsKry__UBtTJR3rrhUa1x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX8dSwVyg1Q6hq
 EVgpljkEHZzDcwYQj6J1aGSurzJGASQrtTQWCEF8M9puq7l17x0oK3ySYQyA6a4x3v+TH2Zp19s
 gjTyg4xAaVsa16EemEay7hQG3j3RTXLR+AC2oxEtPHHVPzKoQptUQZulJCEnvF1+1FJHDFTf0T6
 ozy+zZZx96E0Al89+9Yu/cqBShYWfbwtg3weLKqYswrqEJbb99Pnfd6oIdQHqt5iE1Fxs/YUXXh
 gMdvbdDNx2upVpuWL+g+YvECocqc8plrCXRXkUXS7hBg7qNhk23qTg5WIItO6YdD2I5ISc+0aBO
 KxtZkgt7cLQ7LFK4TVq7kc25tAIwUxdcPHl6rqMsGgB2iqdLxHPfrN8BVCUIuQQsdw30JQnwSFg
 kX+8F/5u4JwwsQ38qEh5Bk/oq0WsuIazS0EcpMLCNMJPVu010XyUgv6Eb/iKCM4ayYL4ZperBp5
 G5r1Cbc1hV5Nj9UnAwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030144

Corrected To Julian

On 03.09.26 18:40, Alexandra Winter wrote:
> 
> 
> On 03.09.26 16:37, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [Critical] Missing __GFP_ZERO in folio_alloc() causes uninitialized kernel memory to be exposed in the receive message buffer.
>> --
>>
>> commit d942ada155dde57df3b8bd6857db438603cbd218
>> Author: Alexandra Winter <wintera@linux.ibm.com>
>>
>> s390/ism: folio_put() after error
>>
>> This commit uses folio_put() instead of kfree() in the error path of
>> ism_alloc_dmb() to prevent slab allocator corruption. It also sets
>> dmb->cpu_addr to NULL after freeing to prevent a potential use-after-free.
>>
>> Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer allocation")
>>
>>> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
>>> index 242da20f27e0e..035b233abb4e9 100644
>>> --- a/drivers/s390/net/ism_drv.c
>>> +++ b/drivers/s390/net/ism_drv.c
>> [ ... ]
>>> @@ -274,7 +275,8 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct dibs_dmb *dmb)
>>>  	return 0;
>>>  
>>>  out_free:
>>> -	kfree(dmb->cpu_addr);
>>> +	folio_put(folio);
>>
>> [Severity: Critical]
>> This isn't a bug introduced by this patch, but the previous replacement
>> of dma_alloc_coherent() with folio_alloc() removed the implicit
>> zero-initialization of the Direct Message Buffer (DMB).
>>
>> Looking at the allocation earlier in ism_alloc_dmb():
>>
>> drivers/s390/net/ism_drv.c:ism_alloc_dmb() {
>>         ...
>>         folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
>>                             __GFP_NORETRY, get_order(dmb->dmb_len));
>>         ...
>> }
>>
>> Does this missing __GFP_ZERO leak uninitialized host kernel memory to an
>> untrusted remote peer?
>>
> 
> This is actually already on my ToDo list.
> See also my discussion with Julian on 12.08.2026 about
> Re: [PATCH v2 1/6] dibs: remove __GFP_ZERO from loopback
> 
> 
> 
>> A remote, unprivileged peer partition can trigger an SMC connection
>> establishment via smcd_new_buf_create() -> smc_ism_register_dmb(). This
>> causes the local host to allocate and map the DMB memory without
>> zero-filling it locally before the peer partition gains access to it,
>> potentially exposing uninitialized memory across the virtual machine or
>> LPAR boundary.
>>
>>> +	dmb->cpu_addr = NULL;
>>>  out_bit:
>>>  	clear_bit(dmb->idx, ism->sba_bitmap);
>>>  	return rc;
>>
> 

