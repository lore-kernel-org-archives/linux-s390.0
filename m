Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487D38B148;
	Thu,  6 Aug 2026 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044044; cv=none; b=Swn11DM57LEX+F82fi8XkXuuYCz80p0ZB6IUBg1nFb4w/f2owJjFozBAFxn9ua0NIsLYPTUolmyYCNDDRjhHFPJyB3SKMxLUx1vfpOXhNo7gQtHX/L2GbVw3DBoIGPEcuT/V+FPjJai1yNMAbk+Aj9LaGXJfS/Gu69g/xCCmYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044044; c=relaxed/simple;
	bh=XzpWK+54++jH/Hn91daGUA8raZsZZXmpTvUcgVNp0+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppqZThNPZHRmxGodN4RhyBoyfuuy2FyjyTrALKVP9YBHBT40PzHc+pkKDKoAQM7TB+IbH6FGhrjzEGF0ah4UX6rJPVx2xajO15q8sqD0eMPrQ/SXDK8rkWtB4y58yNULM3p20XksX+MBHJ1SlHQT9CuZSKkT48C0m49YXI/MPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PHWHLc4Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PHWHLc4Z"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHh8f3328432;
	Thu, 6 Aug 2026 19:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=903dPF
	hGzSSWDSTGFgCfauO8AxDFdO0mRUx8+CuMn68=; b=PHWHLc4ZLZ9T61z+1RXHHh
	NMwOjlBMGWAPNFzD627TOox2z9O8HTn2ig/ilizjfwJgFsDlIvuonx0O6YM1CkVo
	uuNojLaj2aj4/bCrAZ/murgkI5qTdtZEMWZR/FXOCh5XO7n6AlumLT0146J0Sz8Q
	/EzM+ortkB9UC88kATQblLaPiWkVgkAwkdg8C8f6ombU9WqT158rZYKUA9CVkBl8
	9l5eGHTvSzE1hiFhb+jcdNdeyytxzP/BMDSrDNf4CI40jUUU6bIHT7fd6afzglNK
	uP1Cx5E/bIOZNoOtPJzgeBsDDtvY3iTZx7/heWiwnCJPnYxBR5xCyqDHymPr+TnA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy020cru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 19:20:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676JBLI0025472;
	Thu, 6 Aug 2026 19:20:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhmj2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 19:20:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676JK1lG29622992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 19:20:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74C3258051;
	Thu,  6 Aug 2026 19:20:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A1B5805C;
	Thu,  6 Aug 2026 19:20:37 +0000 (GMT)
Received: from [9.61.80.66] (unknown [9.61.80.66])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 19:20:37 +0000 (GMT)
Message-ID: <b4f1436e-a1a4-4632-ac2c-6020a857d20d@linux.ibm.com>
Date: Thu, 6 Aug 2026 15:20:37 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260806173435.105044-1-akrowiak@linux.ibm.com>
 <20260806175651.C01F01F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260806175651.C01F01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xlQpqdsSjNB9CED-jtmSPHgVuEXKTwE8
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a74de88 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=RVB5ZjYeXRyjgiCplOgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xlQpqdsSjNB9CED-jtmSPHgVuEXKTwE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE1MSBTYWx0ZWRfX6wayXWIcgJls
 1ptK/Z5ii4bO3pVlTc80AYV0Hgq0gf7bSGjSlCQlPnGKr3NzIMhCsritaCgvxE7dxSPdw0eiLfg
 K3Taxxi1+L8YHpG5DOvBqKabDNZUfQ8GneDcZaI4Ha84i8h9/YfFBvDsLF+tPiBaxC7nigqjM5z
 AoYkU0PAnsxE4giU6NcgvOnNS/nZ6nDGyJW3sJZ2TOOOwDrntiKH9DPljU8CnJ27ejiALBIH7TG
 /12x3GLL8WswN30bpJOSV/XQEQtoT3kcz3cJ03YO3QwpgQr9gqetXYeTdzvjOjpR1gQANxBPnXg
 ZFqZStxQfZnZNUukO6Sa+jkDfrGPoDtC5ifV+XDbuywDj7XfKygweC+kWtnOYLYP2Sbj6FFDIo7
 S5dpaySEtbq5eu2KB88pYAS4w3AabIVJCA9F55A0O/zqlYnNHMXMOttVLm8MpK+9/4G+7pBBOGd
 hsHjxSwad5/ZRAGndBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE1MSBTYWx0ZWRfXwcynspDTsYJG
 /JA3EjK5iZ6gxh9eI/AR/pWd5TYlyFa9H7WvgawQi5MZvzdEkgCgFfPCDDk4S9xOGUWR/WHxbBz
 QtId9i5lhCrEUf8oF3+AgUa9THwNeKo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060151



On 8/6/26 1:56 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Unconditional dereference of `matrix_mdev->kvm` when handling host AP configuration changes.
> --
>
> --- Patch [1]: [PATCH v5] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm() ---
> commit ea70bf8efc92cb332a90ca640bf9deec142d0044
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
>
> This commit fixes a stale pointer use-after-free issue when another mdev is
> already attached to a KVM instance. It avoids iterating the mdev_list under
> the mdevs_lock by changing the rwsem lock order and checking if
> kvm->arch.crypto.pqap_hook is already set.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..99a0efd999ef9 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -1883,18 +1881,15 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>   	struct kvm *kvm = matrix_mdev->kvm;
>>   
>>   	if (kvm && kvm->arch.crypto.crycbd) {
>> -		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> -		kvm->arch.crypto.pqap_hook = NULL;
>> -		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> -
>>   		get_update_locks_for_kvm(kvm);
>> +		kvm->arch.crypto.pqap_hook = NULL;
>>   
>>   		kvm_arch_crypto_clear_masks(kvm);
>>   		vfio_ap_mdev_reset_queues(matrix_mdev);
>> -		kvm_put_kvm(kvm);
>>   		matrix_mdev->kvm = NULL;
> [Severity: High]
> This is a pre-existing issue, but can unattached mdevs cause a crash during
> host AP configuration changes?
>
> If an mdev is created but not attached to a guest (meaning matrix_mdev->kvm
> is NULL), and a host AP config change occurs, vfio_ap_on_cfg_changed()
> eventually triggers vfio_ap_mdev_cfg_remove():
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
>      ...
> 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> 		mutex_lock(&matrix_mdev->kvm->lock);
>      ...
> }
>
> Will this unconditionally dereference matrix_mdev->kvm and cause a panic
> since it isn't checked for NULL?  A similar path exists in
> vfio_ap_mdev_hot_plug_cfg() as well.

This was responded to for the same review comment in v4 of this patch.
A separate patch is forthcoming with a fix for this.

>
>>   
>>   		release_update_locks_for_kvm(kvm);
>> +		kvm_put_kvm(kvm);
>>   	}
>>   }

