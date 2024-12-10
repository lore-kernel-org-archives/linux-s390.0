Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675723DEAD;
	Tue, 10 Dec 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848013; cv=none; b=njyxI9TmwDLVGV9viRTF5522rDU47/OxbDgwGTrEMlaHwozsjr8Vzn7jwPazs8My+WHVYg8j1AUkpaTnu1sFwEN9qj35bKC0+bXA0GT6FA4PWUfOeq9gMrDsoHPwiP581w8SnXLy3JsEK3MoPmNxsmO0Wh+ErsbCfH+fbcsGcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848013; c=relaxed/simple;
	bh=7ne9y2HZeK03QnmWb6ITXdMTZJ//s1gJwlxN0xRzesM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+m50r+c6nQTYbBs1N/a+ozfl6Gl9rlkbR9NX/cmhPBKOE7rodiXdS7WHbgtjvzQMvsO/VlrnNbfebupgHRLLIxUDjYGa/nNgOWKHOwSEc9I2IEM3zR9s0D1Wkg1DjQ5WZFU0aVsDUiY2ZbIDxppnaTes6ptdVWFeYMxBTJ40lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yt5yqWRw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yt5yqWRw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADrYYg005962;
	Tue, 10 Dec 2024 16:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=64ybYp
	w/DtLTVNR6whj0o6KYiqsmVjRoQcI4XyXZFvk=; b=Yt5yqWRwazbWZ5tvmZF+L/
	nsLm18iDUSwTnAiYG0yt9p4/FuAF1376G8Eo8pvUujpvLo98ojDo5qvrQ/RSR9wd
	3OzYq5LkXurwMv2d0vglg/kvihwTOuJK3mntTOcWuhcAn0gJL2To/Tp/IDAf8X1Q
	4dbzPo5Q5onbr7O07VPT/v7MqIkEnPTbE3uiSC0mgHiaFYtzkwOkx1ETXWa3NrrO
	yKFmw/qwJKUg71eFOvJu/lOWAcNNmX2U9kSWHHs/9Di73gVCFM6kCQyAswBMjVDx
	7oVIqi49zXsfzhKiiArv5nJJeND0Duy7yF4VVWe/23X22P1imQyOTQd2s/9gNyrQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vr5u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:26:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAG82DM032555;
	Tue, 10 Dec 2024 16:26:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn4caa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:26:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAGQTc933096418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 16:26:30 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A936C58059;
	Tue, 10 Dec 2024 16:26:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2EA35804B;
	Tue, 10 Dec 2024 16:26:27 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 16:26:27 +0000 (GMT)
Message-ID: <0e80948b-7593-4b59-bb77-2f78f00ad2c3@linux.ibm.com>
Date: Tue, 10 Dec 2024 11:26:27 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iommu: document missing def_domain_type return
To: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
 <20241209192403.107090-6-mjrosato@linux.ibm.com>
 <3db6f346-0cb4-41f7-b532-91bcb0265849@linux.intel.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <3db6f346-0cb4-41f7-b532-91bcb0265849@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _GxKAIjVMnsRhL5VwBL0Ut3Bw19op3fQ
X-Proofpoint-ORIG-GUID: _GxKAIjVMnsRhL5VwBL0Ut3Bw19op3fQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100119

On 12/9/24 9:57 PM, Baolu Lu wrote:
> On 12/10/24 03:24, Matthew Rosato wrote:
>> In addition to IOMMU_DOMAIN_DMA, def_domain_type can also return
>> IOMMU_DOMAIN_DMA_FQ when applicable, else flush queues will never be
>> used.
>>
>> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
>> ---
>>   include/linux/iommu.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 05279109c732..d0da1918d2de 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -585,6 +585,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>>    * @def_domain_type: device default domain type, return value:
>>    *        - IOMMU_DOMAIN_IDENTITY: must use an identity domain
>>    *        - IOMMU_DOMAIN_DMA: must use a dma domain
>> + *              - IOMMU_DOMAIN_DMA_FQ: dma domain with batch invalidation
> 
> In which case must an iommu driver return IOMMU_DOMAIN_DMA_FQ?
> 
> The flush queue is a policy of "when and how to synchronize the IOTLB"
> in dma-iommu.c. The iommu driver actually has no need to understand such
> policy.

If you look ahead to the next patch where I implement def_domain_type for s390, I found that if I only ever return IOMMU_DOMAIN_DMA from ops->def_domain_type then when go through iommu_dma_init_domain() we will never call iommu_dma_init_fq() regardless of IOMMU_CAP_DEFERRED_FLUSH because of the if (domain->type == IOMMU_DOMAIN_DMA_FQ) check.  So something isn't right here.

It looks to me like the following is happening:

We first have the iommu_def_domain_type set in iommu_subsys_init or via one of the set_default routines, e.g.:
	if (!iommu_default_passthrough() && !iommu_dma_strict)
		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;

But when we arrive at iommu_group_alloc_default_domain()...

if we have no ops->def_domain_type() defined we will call __iommu_group_alloc_default_domain using what is in iommu_def_domain_type, which could be IOMMU_DOMAIN_DMA, IOMMU_DOMAIN_DMA_FQ or IOMMU_DOMAIN_IDENTITY based on strict/passthrough settings.  Testing an s390 scenario today without this series applied, we will call __iommu_group_alloc_default_domain with IOMMU_DOMAIN_DMA_FQ, as long as iommu.strict/passthrough is not specified, so then later in dma-iommu:iommu_dma_init_domain() we can use FQ based on IOMMU_CAP_DEFERRED_FLUSH.

but once we add ops->def_domain_type() then we end up calling iommu_group_alloc_default_domain() with a req_type == the return value from ops->def_domain_type(), which by the current definition can only be IOMMU_DOMAIN_DMA or IOMMU_DOMAIN_IDENTITY.  We will then call __iommu_group_alloc_default_domain with that req_type; so without this patch + the DMA_FQ path in patch 6 we would always end up allocating IOMMU_DOMAIN_DMA instead of IOMMU_DOMAIN_DMA_FQ by default, so when we arrive at dma:iommu_dma_init_domain() we won't check for IOMMU_CAP_DEFERRED_FLUSH because of the type.

So unless I'm missing something I think either we have to
1) be more flexible in what ops->default_domain_type() is allowed to return as this patch does 
or 
2) iommu core needs to look at the return from ops->default_domain_type() and decide whether it's OK to convert IOMMU_DOMAIN_DMA->IOMMU_DOMAIN_DMA_FQ based on strict setting.  This removes the decision from the individual drivers and dma-iommu can later decide whether or not to use it or not based on IOMMU_CAP_DEFERRED_FLUSH?  But would also affect other users of def_domain_type() today that perhaps did not want DMA_FQ?  Unsure.  What I mean is something like (untested):

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6bdede4177ff..275daa7f819d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1744,9 +1744,11 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
                 */
                type = ops->default_domain->type;
        } else {
-               if (ops->def_domain_type)
+               if (ops->def_domain_type) {
                        type = ops->def_domain_type(dev);
-               else
+                       if (type == IOMMU_DOMAIN_DMA && !iommu_dma_strict)
+                               type = IOMMU_DOMAIN_DMA_FQ;
+               } else
                        return cur_type;
        }
        if (!type || cur_type == type)


