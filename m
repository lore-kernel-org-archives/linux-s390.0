Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809231F9A6;
	Thu, 23 Jul 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816162; cv=none; b=hcFe8sSeKN00YkdBXSU3RSPwkebQTTVMJ7BL1bblTste46lzcG7H5Gn5eMdtEMzeXmpUsrQfUKZ+CWgOwtVAe61eVS9LwSjhLcrNX+fzUDAcs7MSaJlqvrIi15mcdz9jM0ZBePcD3iTDwfvjCf4gTlBPTzR/t/aiAN04qpWPJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816162; c=relaxed/simple;
	bh=ycHTgRnfodxFntTWRr09mNJua/CWHEwh0Yr2uEr5sNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ymc/wuL4IH4g572bRfCOVI1PAySgW7eNJAKriMs0Wy9O1dnBMBguucSc91tPP8J5rebHJ04nSpWgEDh3Xq4y7wAGW+kr9tmnEZQhoY+G3fUKWUBLG1I7l67Sh5YpvMwmCf3VrBUW1p+PF+ax1jDJtgRUMjQPdrFQ1CSNDzf3j4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TnkNVOux; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TnkNVOux"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDCLwh1211946;
	Thu, 23 Jul 2026 14:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X1zevz
	Cmk3qRGwiAzvhfy5r7dUFHGzz6Dwan2wco76k=; b=TnkNVOuxFMlbt9JnCQQrcF
	8oIb+bMzgFh2fXtNHQNcT3RUzjk2QBwPmECkuLvQWnRdpC6OYuGVjHLWKwVzPDb+
	Qet3hA3p399xeS5oe4qajSpjL5wW/na7Mfy3ibuU9J1epth6UgNC2JmvFtvRhuQF
	ta3HYcni/HYuCAyswM8mwvxFmJxLpaWlSizamGXhPO6//7nJb77y2z86/tUzhQY3
	Bo6c0BJjjbrnDqFYpw6qEr83rcz2Tc7LyKF9wpxmuZY8Tkqk41s0QONl6vgu4cUj
	6m0VV5RMYt9sLkl12c9jvMTTj3UCgXLEn9H4Gy4QCxqAyVqOC6uPESXaGZMAVGQw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aqy2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:15:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NE4cSe025116;
	Thu, 23 Jul 2026 14:15:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcg24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:15:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NEFjZA31392324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:15:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE6545805D;
	Thu, 23 Jul 2026 14:15:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 184BC58053;
	Thu, 23 Jul 2026 14:15:45 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:15:44 +0000 (GMT)
Message-ID: <4a3d08fb-c3cc-433b-b44c-c2f2e51468f7@linux.ibm.com>
Date: Thu, 23 Jul 2026 10:15:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] KVM: s390: pci: Fix missing error codes and memory
 unaccounting
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-4-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260722170621.1686-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pVRAoVjiYr-v7c0mzokWALFmHBkYtdKC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0MCBTYWx0ZWRfX3ZND8VzifsW7
 tWwqyyTAMYBNHJ4LYJ7E+eaYDqo+ZoTya8IHiPM4t3XQxHQs/sU9/cVQL2ajY22VCLn36UApx53
 /4uqyxF4lVhHrQn6iGnX/LNpoJzSMgU=
X-Proofpoint-GUID: pVRAoVjiYr-v7c0mzokWALFmHBkYtdKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0MCBTYWx0ZWRfXxW8K53PulVGF
 1LTb5EhGVye+QUA5wHqrzyozUcVWZkM23okZgDt0rnf9arRh4OeKSDnN1DbzGazxri+lbqfBfIg
 wb1QADliU0hS7PiUUV/jVu8BlaeiQK//CoLoQsm/0NoYoX+sBsLoK3Zb3yotBNI8f4ciYYrg/7m
 iAHUljM3KDFyokHjlpMMtmcyQiI1wqtKjrOjod6b1RJ8XizgDWLHWgTFyImm4IuEmgbk5czNutE
 /GQoqIKSNKt7deg782cOlzNfU6gxS6LUgDp7bL1QIURnveJzyzh7FUTbcVURyJCncvn5Pc3d02h
 mK5uH232jBHhrAQG/a72SbhxQFpX+CHEJKXBegGXwODsQcDiAgrSt3wPd4hPEL8rin1Fc7DnqS2
 QBVQb1iMZwvnG7OrOrrTVLnluWOGZdfYaIyF9jOtd9SoknyCjGLy9r39+wWA5esGuni0MY3IB2l
 WZuFvs/lnxCHLpFXatQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a622214 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=AJ4VnbqJACYr0d-LWtUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230140

On 7/22/26 1:06 PM, Farhan Ali wrote:
> In kvm_s390_pci_aif_enable() two error paths failed to set error code,

nit: set 'an' error code

> causing the function to return 0 on failure. It also failed to rollback
> memory accounting on failure. Fix both by propagating error code on

'an' error code

> failure and calling unaccount_mem() in the cleanup path.

With or without those changes:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/kvm/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 1b3114c7cfbb..33abc15aa685 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -297,14 +297,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  	}
>  
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(zdev->kzdev, pcount))
> +	rc = account_mem(zdev->kzdev, pcount);
> +	if (rc)
>  		goto unpin2;
>  
>  	/* AISB must be allocated before we can fill in GAITE */
>  	mutex_lock(&aift->aift_lock);
>  	bit = airq_iv_alloc_bit(aift->sbv);
> -	if (bit == -1UL)
> +	if (bit == -1UL) {
> +		rc = -ENOMEM;
>  		goto unlock;
> +	}
>  	zdev->aisb = bit; /* store the summary bit number */
>  	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA |
>  				    AIRQ_IV_BITLOCK |
> @@ -348,6 +351,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  	return rc;
>  
>  unlock:
> +	if (pcount > 0)
> +		unaccount_mem(zdev->kzdev, pcount);
>  	mutex_unlock(&aift->aift_lock);
>  unpin2:
>  	if (fib->fmt0.sum == 1)

