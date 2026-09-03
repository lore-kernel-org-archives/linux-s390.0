Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB947F2D0;
	Thu,  3 Sep 2026 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453630; cv=none; b=j03UknRIDE9rAebdze+1lpNo0EcHdJA62MWkvC6L3e1dukSNEkzOzcBi9e7LKwAguT8X9x+QcsgbTK7o1VudZY2I5b04VP+rUUzovnhlBYAUy51v52wKwqBeKu9liKnLRdl1uoo2MEdS3ksiNewVHovtrg/qhIh3mPEdicScXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453630; c=relaxed/simple;
	bh=LmVTrPGimbqZZai+7YwBqYGJcLfStVyVr19B0nB98EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORimBGJ2gVpq6SdkJtNmjVSSPkUvpjIcyoWlnG0M2wy1Q0U+M2BLx3qDq14M4cBhUGReZiWgHXMbckdQPqI4FwUMbYW3IO+RHpN7WKnSr/AQkMJMo1IbfZjXrGZfhGZ/vEsGNhV/r53/n6dJVi49/r2E5vPmUIKYq4+DFJThnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V/dzhvcI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V/dzhvcI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G30nt3305229;
	Thu, 3 Sep 2026 16:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=isZBjf
	0+kfWEbJBQZhNyx372giO2f45d5qy3iKisJwQ=; b=V/dzhvcIwJ9dtIsY9ISLeC
	RdciWuqOZ3MSo4elaCj9zSf6XW9cCSTe3sQZTPJv1NGNpx1sChq98mqHez/JtEVK
	JXejcMdUClui5sB7kCVR+qiWYcGguZpeylwbdS+fzLBnrN3v7Bb7HZIDNW5XQ4Tq
	5iqJdweDoRq/l+fSSvMaGy381pptG1/ItNiCQG3BTSi4U0ZGrmfgY+wCL6rXdxYk
	FXVACaq4JUdbOCkXpFugzwWwu2OM/tQ/5GhMTITPNaVxtoe9ynBJvM7kIz0aMN5j
	LdwxPk/8TMicMewryK+YHY+xkCaXSqTFoIHf1tMcX0jsP1lizHgSKHcWZtnrEktQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj5nse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 16:40:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GQHUA010761;
	Thu, 3 Sep 2026 16:40:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkggd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 16:40:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683GeMhO26608328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 16:40:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92AC020043;
	Thu,  3 Sep 2026 16:40:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56A542005A;
	Thu,  3 Sep 2026 16:40:22 +0000 (GMT)
Received: from [9.111.168.7] (unknown [9.111.168.7])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 16:40:22 +0000 (GMT)
Message-ID: <5c27d8f1-67bb-4845-b9ac-ea4bef34c7bc@linux.ibm.com>
Date: Thu, 3 Sep 2026 18:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/ism: folio_put() after error
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>
References: <20260902143733.433574-1-wintera@linux.ibm.com>
 <20260903143746.A5CC41F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260903143746.A5CC41F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pRzyBhuYV1MveixeXTecv3Nqva_u_W33
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfXxVGqLUfscwzk
 vZ/eH+JS+F+xOthnTNauckrdmScKpcUOQbv1UXd+zKctEvLzdDpf4n+5BbvVnK9ClotZP3mPGvK
 Hu2vjVivbtJPnGYe1wX/LYUkx4mgiZC2+MvpNKpdbep9OoPibX/lZP5pK2jZURDJQ3GL4d3SnZU
 b4filDlkZnkrKYaeSTPlD4XKCyEoQsAgUZsuZUH+N36CfJeonHkBaWq1RzpQ88DIQo5m5zqs4nn
 vlmhlReNjO55mXOtk+Uvp22dBIq1WfPToZCnke7lHF1AuqBcu/NqCFm7z7nj9Np0GAvAV0P6nkC
 4OkFwTZkwau28lXZ30fldovKETAML/mfERard1tG09ad5j9ZCAzDp0d8PeW4bEXyf5BtLo4/Trd
 uW9pugFmGO90fWuoP1dM+aUYsNis70uL4ymYodGMMGZKF7WKsizgBn/3i/o4BPtX7hNdNA6YrbM
 v9HfeBC9Oi/kcQnCl0w==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a99a2fb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LgXSM_GzpfVtDRCEaY4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfXz5/19UExfSBV
 p3VQsjY6qLAeAVF7Zvss6EmRtlbmTi8sZJh6i0HUdINE+SMe3VWiwKXGcxii6sktU5XiMzYMcc8
 VFr02z7zZhGQPbCrOvC7mgh3otu6GZU=
X-Proofpoint-ORIG-GUID: pRzyBhuYV1MveixeXTecv3Nqva_u_W33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030144



On 03.09.26 16:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Missing __GFP_ZERO in folio_alloc() causes uninitialized kernel memory to be exposed in the receive message buffer.
> --
> 
> commit d942ada155dde57df3b8bd6857db438603cbd218
> Author: Alexandra Winter <wintera@linux.ibm.com>
> 
> s390/ism: folio_put() after error
> 
> This commit uses folio_put() instead of kfree() in the error path of
> ism_alloc_dmb() to prevent slab allocator corruption. It also sets
> dmb->cpu_addr to NULL after freeing to prevent a potential use-after-free.
> 
> Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer allocation")
> 
>> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
>> index 242da20f27e0e..035b233abb4e9 100644
>> --- a/drivers/s390/net/ism_drv.c
>> +++ b/drivers/s390/net/ism_drv.c
> [ ... ]
>> @@ -274,7 +275,8 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct dibs_dmb *dmb)
>>  	return 0;
>>  
>>  out_free:
>> -	kfree(dmb->cpu_addr);
>> +	folio_put(folio);
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but the previous replacement
> of dma_alloc_coherent() with folio_alloc() removed the implicit
> zero-initialization of the Direct Message Buffer (DMB).
> 
> Looking at the allocation earlier in ism_alloc_dmb():
> 
> drivers/s390/net/ism_drv.c:ism_alloc_dmb() {
>         ...
>         folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
>                             __GFP_NORETRY, get_order(dmb->dmb_len));
>         ...
> }
> 
> Does this missing __GFP_ZERO leak uninitialized host kernel memory to an
> untrusted remote peer?
> 

This is actually already on my ToDo list.
See also my discussion with Julian on 12.08.2026 about
Re: [PATCH v2 1/6] dibs: remove __GFP_ZERO from loopback



> A remote, unprivileged peer partition can trigger an SMC connection
> establishment via smcd_new_buf_create() -> smc_ism_register_dmb(). This
> causes the local host to allocate and map the DMB memory without
> zero-filling it locally before the peer partition gains access to it,
> potentially exposing uninitialized memory across the virtual machine or
> LPAR boundary.
> 
>> +	dmb->cpu_addr = NULL;
>>  out_bit:
>>  	clear_bit(dmb->idx, ism->sba_bitmap);
>>  	return rc;
> 

