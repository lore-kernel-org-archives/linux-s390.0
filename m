Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8890355F46;
	Thu, 23 Jul 2026 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794730; cv=none; b=OKhviRj8fxBQcDQi81gRvdT4E49lGRt6bIhDHN/v7L8FAxXUPxSlTSLDf9l/x82bkH6aYU4lS2F2WMOieGmnxccMDr/tBJQ3BTRUfa1M8yInrtOFj0rp8HpeTyzTDZ+71eVl5L6+vIyqeybyhO2ieyzq40KxV5/GOZWL4nExGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794730; c=relaxed/simple;
	bh=esGUJ1Prcbq4ifDiOBfNsGn1RecFqTL3u3/WyqgWi8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLgcfJh+eTSLxkISr4u/i5qkymZ+TORzQuXTcICAdW0Nyg+ezMMfCAg7YVY2NsyM7K1uLTnhE3gzm/btiQQqSNpo3JW1OW/znKmVgIWKpHiPKz8BunUndJA9guhT+kq2oh1W+NIcwl45xx7SVI/Y3Kg7lehwoQKUBW8S2eVUMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H7To+J6a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H7To+J6a"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N5BdcP2082163;
	Thu, 23 Jul 2026 08:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1fF2TS
	BiDI/mW13E75Rb6zTUpRGEDsILSgcjbEtx4tU=; b=H7To+J6aDmieeyjWHMK357
	2uiX+wbJ6yzK83dZZkjdOQeeFu9nnUDrhec4rI0C+hS+Mcp2CnIa0Vkc+1vCfyMk
	cDaksCF3yyqpMEV2y8VzJxDldVrAtABrUG6zZyE4gbpZNekFmTZsql6+k6ByTI2C
	GjuEJItRsl8gluUbrP6UPAInkaEd2oq+wvtnzWmx9kS6Y2kKRtGtHxDRqCxWPJxq
	/V7xN9y7jQhU6d3RQY+N3uc7nWwJUTKiVGA07AtIM8sToS1AYTlo0UhEojSay55c
	WVWvCgRrcXciyJHUIJcK20sEMz7YZmx6CrrQTe9lR82o08x+3AOsnSfyJFWN7HWw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7916hbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 08:18:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N84ipQ014058;
	Thu, 23 Jul 2026 08:18:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahb6ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 08:18:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N8IgUu48234850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 08:18:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E91C20101;
	Thu, 23 Jul 2026 08:18:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DC6F200FF;
	Thu, 23 Jul 2026 08:18:42 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 08:18:42 +0000 (GMT)
Message-ID: <08e3312d-1f84-47ce-8e97-c151646f7a73@linux.ibm.com>
Date: Thu, 23 Jul 2026 10:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] KVM: s390: pci: Fix NULL dereference on AIBV
 allocation failure
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-5-alifm@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260722170621.1686-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NgPUObI6mqahPT27UaP42u-4A2uHc9U3
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a61ce68 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=wahUZReCXgIwzAPQiRMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4MSBTYWx0ZWRfXyffymXaVFuFC
 rzj2A/Fkyfg7ap4yrRpW7AOGJRhLzjcLv+fFBOheJWnQCcIWNxlUtPleUv7LtPVOCHqwMS81Z0E
 aTk8zRdMlp2IJyf2jWudv5TDwAN2r5M=
X-Proofpoint-GUID: NgPUObI6mqahPT27UaP42u-4A2uHc9U3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4MSBTYWx0ZWRfXyvQPQoDj2Qhe
 SwajE4NWDRRLrzvfnTP1k17xMb+17ZG7Arbc4LgacQ/I6DYVeKNQB9eBJqy64RtkNSz4Q5KFFnS
 1I/1egMPuT7Dh4AYf2+05cZapgVuJRz2O8CAj0Kv/GcZZqTzFONjM8y8K8x0sYHrzYyTe5sDJDB
 aH297htJBqB6rDtjB6ljdKawuL6v46jCeqfbuRbnhCusMPsXhXz6gZAlB8SLhmA/87chMaswY9x
 U5dg5bapbFFNwNrLd1z2kDmJMyiRxpcm50/L7KekkOaDDHvV/UvEeeL5xcWeAh5XCh55WHTppfU
 jiID06HnPcabpPZK6W4fl7/Up86aE92oTvOcQgguDBxTkxVwwFcZ6nvjg+T2uQMTSGT+pT5F5BK
 9NaSG1vSm3BbNmLhS6QvDIltlQXBu4u/RRvz8upp6UaLokJNRWCp7pllVfbpXVG8j1LyD8i/yaK
 BwGNIQOOcnELHh5ugZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230081



Am 22.07.26 um 19:06 schrieb Farhan Ali:
> The airq_iv_create() can return NULL on failure, but the return value was
> never checked. If it fails, zdev->aibv will be NULL and fail when
> derefenced in kvm_zpci_set_airq(). Add a NULL check and free the previously
> allocated AISB bit and zdev->aisb on failure.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   arch/s390/kvm/pci.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 33abc15aa685..231a4236fc3c 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -314,6 +314,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   				    AIRQ_IV_GUESTVEC,
>   				    phys_to_virt(fib->fmt0.aibv));
>   
> +	if (!zdev->aibv) {
> +		rc = -ENOMEM;
> +		goto free_aisb;
> +	}
> +
>   	spin_lock_irq(&aift->gait_lock);
>   	gaite = aift->gait + zdev->aisb;
>   
> @@ -350,6 +355,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   	rc = kvm_zpci_set_airq(zdev);
>   	return rc;
>   
> +free_aisb:
> +	airq_iv_free_bit(aift->sbv, zdev->aisb);
> +	zdev->aisb = 0;
>   unlock:
>   	if (pcount > 0)
>   		unaccount_mem(zdev->kzdev, pcount);

