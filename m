Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447C37C908;
	Thu, 17 Sep 2026 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611821; cv=none; b=lBRfD9uHHHbGuoXMCZFB3M96Of5AuUAPNp893jupl6CUmVP4poRph8Xb1cM6zFvuvNmvt6qBhx2nayAv0YrbaPZdTwaLuEwflynKRvr0URLVz7XrneSQtHQPXdY9NRah6j96WUu5aMS2S/qbK6qNh7GR0CtgTFSjYPgBpnfPHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611821; c=relaxed/simple;
	bh=oO1Q1mbf4WvhVhxjnd6Xou5VN+sWnBZR/35PkCeGzt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8BsIjC35zQXXaW9Ldp08IT986DmwR8GmS7kQJnlkLIgtt+XPU6KYMEIVkKX/txHEVnIoKxFn5meH+uI+I3vLJcwzPzoSbpJCdRSGVWj/VAQhn+tmJRP0TJBuG4bFbwL6FIgKmwKqa5+PS87bgcW8YyBYWI/jKtTvr13hTbX7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i/VpXWdQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i/VpXWdQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1cQo4057214;
	Thu, 17 Sep 2026 02:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uirmf+
	TWIQegheRPnswDodV1a7pMqWv3ipenF8uwTRg=; b=i/VpXWdQE60WzHO+jedRnx
	aAJbs7hgxsETcuC8fBAAWQfjRWCyk+hPcLVuOIgVxgtnoHk2wzaqRq5cv6QXgZP9
	uWvOCfxWe0x0XVqn1T66Rd9+NGxxCLQIIYySdXWG/vHbTZcHmMDb2043cmhWxBtQ
	hBWplw5fvrrLIWUQoxbripRBmDf/gzfkeXFs8yXjgt8AFkcCvqgE7Z72StCIxPfu
	mqMtqD+3ZzGjtNKKsFsyTpT7xC7LcskMbYgJHyLj3T0jPfJzqZO0kV8X6KEznJ7P
	JiGgote5ZiPkM1I4mwdgajoHa3xK894OaR9Xzhrsy39zxBOG/JYcU0FTYqmULlKQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hyu6p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 02:23:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN0Bm81625401;
	Thu, 17 Sep 2026 02:23:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxshffy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 02:23:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H2NZda17760884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 02:23:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0133858050;
	Thu, 17 Sep 2026 02:23:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88FB158045;
	Thu, 17 Sep 2026 02:23:33 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 02:23:33 +0000 (GMT)
Message-ID: <e2573de1-d3f6-476e-9a6f-a733f4c27b8a@linux.ibm.com>
Date: Wed, 16 Sep 2026 22:23:33 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] s390/pci: Fence FMB enable/disable via debugfs for
 passthrough devices
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-4-oelghoul@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260916213222.233-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAyNSBTYWx0ZWRfX9yox+ai1R+MM
 /+skpQtq+MZyT5UcrkUIKyKBfJMd5UbULc5DTMJsv0zyTOUUG+UfmKsw/Pi+LOmZyYJDD/1liBX
 hoow+ame2tfS110E2we0b2OZfclRIBIN30kktImp1Z9yAEm/09n5uxeYV275jqKo9JrUPH1aYhS
 dYoPVBEQKNscMMaThnUpwdPNtU9XBeQk+1blQjyC3AZmH8TuGs0EAn3APfoTeEIRiY32bdNFKcl
 LAqf4Z54Cnq9Cl3mpLrnmAovRaOCbxfv3hGY9qNGQ50/nkOTxBX+uSWFdzHii3sKi92EkznUTT6
 CmkbcmZLr0KvY9b0wn6PoU6Uhy/x/DBAaTs+Wx1E/3wR20wkLW28ZAD3K9++IdNclnMcPQooVfa
 cB7PzIQDYsNmWZgUUriKwnxg9rpcOzusQEcpEJxm6Prx3KBTWIL2jQfJ1u1LzoZ0XIWD+eDASi9
 r3t1D507hsXt6gqLfBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAyNSBTYWx0ZWRfX0ObCrYXqgcCL
 +trB20xnDqJWPr/WxR51uuh3pyTYB1IsnKX+PodqV0wkbsoGTMbz+fwbkzeonfv1L92IPVaDdHR
 U8gzY22jblIrKkaYw44v29eihL+7KqU=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aab4f28 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZFlax1m07u7ZzGQ5DBIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AEP-M6-l56XtAxMXekora4CmkBM-o6TU
X-Proofpoint-GUID: AEP-M6-l56XtAxMXekora4CmkBM-o6TU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170025

On 9/16/26 5:32 PM, Omar Elghoul wrote:
> Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
> device is associated with a KVM. This will prevent processes on the host
> from tampering with the FMB while the guest is still using it, which may
> cause partial counter resets and inconsistent reads which have no parallel
> in the architecture.
> 
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
> 
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/pci/pci_debug.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index 44f026ead414..afc52bd5271a 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -153,6 +153,12 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>  	if (rc)
>  		return rc;
>  
> +	mutex_lock(&zdev->kzdev_lock);
> +	if (zdev->kzdev) {
> +		rc = -EPERM;
> +		goto out_unlock_kzdev;
> +	}
> +
>  	mutex_lock(&zdev->fmb_lock);
>  	switch (val) {
>  	case 0:
> @@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>  		break;
>  	}
>  	mutex_unlock(&zdev->fmb_lock);
> +
> +out_unlock_kzdev:
> +	mutex_unlock(&zdev->kzdev_lock);
>  	return rc ? rc : count;
>  }
>  

