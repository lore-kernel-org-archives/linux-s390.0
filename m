Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F18265CCB;
	Thu, 28 Aug 2025 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756410304; cv=none; b=cWFHoUWz43qp385FPOaItCRrfJFNNyicqS13MvVmBkCG77+mERN4B1gXv8LvszynAfBDML/HNTtS89zVx7/NY4g8qiuECBVwyKDUQzJtvXiZo9Dz7ZvU03zil+OYzuOHm3dblzjCByGjmATJjfHCHMCwUUWrfogoHrPtyMJx89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756410304; c=relaxed/simple;
	bh=0PdLRhEGp/BJY8apVbceyvNUC1MN2QWPYOrvwE9ICVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfFYbY31CbYaafmkR6RDtkdluGFjIfa332kcFNCzS2Q2Ma2rhgBcOD3MTQalYfCJ7nCFEpaMDUJu5I1loFEQJSHafwDu8cjOOLSq5Rka2a+Sx0+LJgmkFf+zm4zhC/2WfJ1QDyMR1X/SV4DILJ4KnnaGBlGeFFk+fgGgcu6Dyzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=te2d1GQu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="te2d1GQu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEs41C030154;
	Thu, 28 Aug 2025 19:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xvHaRZ
	GnRDT47xrEBAa0x7Z//bifD7vBQbgFUqUy7Aw=; b=te2d1GQuTj/ruukaxbvdh8
	QJmPotaiM3tjt5I9HLvMDMYsJTNMGpwqnetdDEejxM/J2SHKk+m3xiJZ0gKeXHFu
	DxYemrIepoR3w95aUgLPfpkT+F3ewXvkms13Zz6VUaEq9vKaDZtZbuR9wPPxQm5E
	s/jMjl9N6ppbDygXxoUSrI08XuxCl+tIt9B+axmMB6+Cb8Hzboc0GYKQJG/r591C
	uv++AjCYzTuT8HCdH95CpX0rP6R8c/mYON5uPj27XIcXGh/agkqtV5pmKV6LRg6B
	vh558yYJLADDWSI/eyAK64wisEKfX8o30L1c1b9UHiMt/D1yDzoNypMINoLxnunQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rw6yp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 19:44:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHinkA029982;
	Thu, 28 Aug 2025 19:44:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfmxh4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 19:44:54 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57SJirIZ28967514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 19:44:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32FE458054;
	Thu, 28 Aug 2025 19:44:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1AB95805A;
	Thu, 28 Aug 2025 19:44:51 +0000 (GMT)
Received: from [9.61.240.118] (unknown [9.61.240.118])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 19:44:51 +0000 (GMT)
Message-ID: <2b7f73a9-4683-421e-b8f6-5835711cecf3@linux.ibm.com>
Date: Thu, 28 Aug 2025 12:44:50 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/s390: Fix memory corruption when using identity
 domain
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org,
        schnelle@linux.ibm.com
Cc: will@kernel.org, robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
        jgg@ziepe.ca, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, stable@vger.kernel.org,
        Cam Miller <cam@linux.ibm.com>
References: <20250827210828.274527-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250827210828.274527-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AV-mHGV0hVcYWCe_DvOlapjxFbJMfbrb
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68b0b1b7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=aNs30nL-xdb_lp8ugGoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AV-mHGV0hVcYWCe_DvOlapjxFbJMfbrb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfX6nFxbwFK3FxK
 dNiEe+iAmeg3ZlaLSVqrBsBwCDox4psf+AV4ySLCXxWJ0c4L5FbX8ukr1W4mOO2w2ApahCpBR0t
 +JZjzrWBEr4ArlPzuKnTKXNiurX0vYHIZT9EJ+fHPRNy+QjDc0pD+T1q7/1NAxNYCcpYRoS7tik
 HpRmf3S98LR5mQ48+GwBF3/4jx7sWR2fQ0UKPeeW3gZmH9TcfR4WlFpcoUCWc86e2igetGZwACX
 /UTR+KWMvpt7N30io0EKhpQznzpfNJGbLEAgwE1agaA63sWdQwlCQjpkz+utQ6xpCnl5HEB9w01
 oEO8LjJn/UlB7NgZLn/KBsoiM4Xph23tQlLM0LZb86nzcBrJ082tlc9X+3+ATkG9qyLDFzJ8uz7
 GUqIhdWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055

On 8/27/2025 2:08 PM, Matthew Rosato wrote:

> zpci_get_iommu_ctrs() returns counter information to be reported as part
> of device statistics; these counters are stored as part of the s390_domain.
> The problem, however, is that the identity domain is not backed by an
> s390_domain and so the conversion via to_s390_domain() yields a bad address
> that is zero'd initially and read on-demand later via a sysfs read.
> These counters aren't necessary for the identity domain; just return NULL
> in this case.
>
> This issue was discovered via KASAN with reports that look like:
> BUG: KASAN: global-out-of-bounds in zpci_fmb_enable_device
> when using the identity domain for a device on s390.
>
> Cc: stable@vger.kernel.org
> Fixes: 64af12c6ec3a ("iommu/s390: implement iommu passthrough via identity domain")
> Reported-by: Cam Miller <cam@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   drivers/iommu/s390-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 9c80d61deb2c..d7370347c910 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -1032,7 +1032,8 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
>   
>   	lockdep_assert_held(&zdev->dom_lock);
>   
> -	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED)
> +	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED ||
> +	    zdev->s390_domain->type == IOMMU_DOMAIN_IDENTITY)
>   		return NULL;
>   
>   	s390_domain = to_s390_domain(zdev->s390_domain);
>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
