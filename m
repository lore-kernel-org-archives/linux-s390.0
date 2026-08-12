Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800536D4FC;
	Wed, 12 Aug 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550757; cv=none; b=uU2x6P8KK9tqEjtGmF5MGlyjWUFtz7041Oe97xnhWgfdO2ekW3QLnMJdR/aIAinZRNmC4n1mCka8PKkYF7CNlssp1VAM/0VR3yuJ+rXPjzrxhhM5dVUZ7w/XJ7dLACgGT1GfGC0DsyibAG2FXochtq8EwkWOIRV4GtcoYZJVG04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550757; c=relaxed/simple;
	bh=cLknSUSl3yWG6hJTa0g7ystw2ATf+cZeemm4mRPrKfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+hmpls/HGh2TkWldBjCCWpKXwLGTkVdDZgbTGt9zIRCqZZRsX7lWMHkCcIXv4t7UBW4rn5Xm1/0JJldnZW28hpCxmQNcSC1sFN94/hURAjp8aZtrQWeAQwF4plWJUzDdU5rcJopjIAIrNFzwiUfag4ciQQA391W0J5h4GcNW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HliZvzJ8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HliZvzJ8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1lqI3717406;
	Wed, 12 Aug 2026 16:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hqHTma
	hy3f784QIY5eJzE0Y4p132QncQcr2ZjXJ20Qo=; b=HliZvzJ8bsb70dxFjwIxD+
	Lj7p5k3FmJfcPTwkf7AyKf6YUDVCDqjLmWXIcpBcDeDdu3Dq9pXsRjbQuYEhy8kv
	i+RINWVIlndBtBbDtPegsUDWOddRISx5zojE93yK3+uHHWD2YmEB04Ki2eFAr7ae
	VcNEYf2ayM2X3yTs8RtVX6mG5ArdB4yEGOnuvdIkb1ePKoZECWSKQ6Hx/Y1M9ebv
	sAshpibPe8l3FKmzu+9zUOkzbra58OyxJxYZOjKPdKXuGLXa73gZ3Go/1YgHYZoF
	lnkJ32O9DWtA+DzY00o2Bjbt/I2hMSTXO1nEn/JFzxHJs4d2OEWa21DgQ2wxXi2A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwajj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:05:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFuGb4019145;
	Wed, 12 Aug 2026 16:05:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq70kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:05:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CG5qij22741516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 16:05:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E7F658062;
	Wed, 12 Aug 2026 16:05:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B5945805A;
	Wed, 12 Aug 2026 16:05:51 +0000 (GMT)
Received: from [9.61.9.29] (unknown [9.61.9.29])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 16:05:51 +0000 (GMT)
Message-ID: <5fde23c4-3e31-4dd1-b63d-6cf6c26f3b6b@linux.ibm.com>
Date: Wed, 12 Aug 2026 12:05:50 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kvm
 without checking for NULL
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-3-akrowiak@linux.ibm.com>
 <20260812121219.0E0161F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260812121219.0E0161F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c99e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=eFc6ll9Oi7pUKGAjX2kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zK-oFZXdftiG49a1gDtXgSnNLMV4BSzE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX0ateAm1RrTol
 A23ZqgKw09W+nkF+YogOI+4twN7Kbc3LjsQ3QcnIPtGtqKOf4r49jc3JL7lSOHEqTwf9CNP02aS
 Tty6g3mG9aSVwoSYm2NGZJDrGxf4+6yvlxkL6qS/5GOBhVsHDBcta+OEFbtTdmFTkZa1Rb/3Xeh
 VTLiIm9lI42gfaajzw+W8dJva5YdCrt8DmnFAoT0VfwTrA+sJg829XJQ/0vigxAjSzApkjitfXR
 WpI9q7NGIBj8gHyCnWx3ctQISvqwZJcuhvxifhGRU0heuNGDrXmrovymWGnGaLDKJgga1j8J0+m
 54efjeY5ufuzOXIFEE/x/xtrUAXZ4DoTGBHlJ4kj+DAnKhY10hRaUmzFZQw4i53FVEzk+XdS7Xn
 I18wISbcvfxriyRlfWx63cE0arCmAUveO+zVFfUbsASCJVE+GoeQNhIRPjiP8GljdK67Xpf7zKw
 toCtzOwbDjymoWcDfgw==
X-Proofpoint-ORIG-GUID: zK-oFZXdftiG49a1gDtXgSnNLMV4BSzE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX6Gk1GMWWE9Lv
 0d3Sz9CmcdzBN0wuHVo1mM/rEMBM1L0rC219M2UBIC15trsaN91iL0LjzgViz6XEJMjCrvxX0Ht
 nq3pkLKv6aBsiyIqpNo8hkaz/XTdTR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120130



On 8/12/26 8:12 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Uninitialized stack-allocated bitmap (`apm_filtered`) is passed to `reset_queues_for_apids`.
> - [High] Missing matrix_dev->mdevs_lock acquisition in vfio_ap_mdev_cfg_add() causing data race on matrix_mdev fields.
> - [High] Unsafe iteration over matrix_dev->mdev_list without holding mdevs_lock.
> --
>
> --- Patch [2]: [PATCH v3 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL ---
> commit adee11494c3d56eaa0ce36b3c479c7382d103cad
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
>
> This commit adds NULL checks for matrix_mdev->kvm before attempting to
> acquire the matrix_mdev->kvm->lock mutex in the configuration change and
> scan complete callbacks. This prevents a potential NULL pointer dereference
> if the kvm pointer has not been initialized.
>
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2606,7 +2606,13 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
>>   	int do_remove;
>>   
>>   	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> [Severity: High]
> This isn't a bug introduced by this patch, but is it safe to iterate over
> mdev_list holding only matrix_dev->guests_lock here?
>
> Looking at vfio_ap_mdev_probe(), it appears new entries are added to
> this list holding only matrix_dev->mdevs_lock (without taking guests_lock).
>
> Could concurrent probing during an AP bus scan modify the list while we are
> traversing it locklessly here, leading to list corruption?

Will add a block comment here to point out that it is safe to iterate 
the list
because vfio_ap_on_cfg_changed() - which is called prior to this - holds the
guests_lock. Hopefully that stops this from being pointed out by LLMs. Will
also add a comment prior to adding a matrix_mdev in the vfio_ap_mdev_probe
function for the same reason.

>
>> -		mutex_lock(&matrix_mdev->kvm->lock);
>> +		/*
>> +		 * The mdevs_lock must be held to access fields within matrix_mdev,
>> +		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
>> +		 * ordering requirement and prevent a lockdep splat.
>> +		 */
>> +		if (matrix_mdev->kvm)
>> +			mutex_lock(&matrix_mdev->kvm->lock);
>>   		mutex_lock(&matrix_dev->mdevs_lock);
> [Severity: High]
> This is a pre-existing issue, but does vfio_ap_mdev_cfg_add() also need
> matrix_dev->mdevs_lock protection like this?
>
> vfio_ap_mdev_cfg_add() is called right after vfio_ap_mdev_cfg_remove() from
> vfio_ap_on_cfg_changed(), which only holds matrix_dev->guests_lock. It
> modifies matrix_mdev->apm_add, aqm_add, and adm_add, and reads
> matrix_mdev->matrix.
>
> Could concurrent modifications race without mdevs_lock being held and
> corrupt the guest AP configuration bitmaps in vfio_ap_mdev_cfg_add()?

Fixed in patch 4/9 of this series.

>
> [ ... ]
>> @@ -2821,9 +2828,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
>>   	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>>   	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
> [Severity: High]
> This is a pre-existing issue, but does apm_filtered need to be zeroed or
> initialized before use?
>
> If vfio_ap_on_scan_complete() is called with non-empty adm_add but empty
> apm_add and aqm_add, filter_adapters and filter_domains are set to false.
> This bypasses vfio_ap_mdev_filter_matrix(), which normally initializes
> apm_filtered.
>
> Then the uninitialized stack variable is passed down:
>
>      reset_queues_for_apids(matrix_mdev, apm_filtered);
>
> Could this cause reset_queues_for_apids() to iterate over random stack
> garbage bits and inadvertently reset arbitrary AP queues?

Fixed in patch 6/9 of this series.

>
> [ ... ]
>>   void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>> @@ -2854,15 +2855,29 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>>   	mutex_lock(&matrix_dev->guests_lock);
>>   
>>   	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> [Severity: High]
> This isn't a bug introduced by this patch, but similar to the loop in
> vfio_ap_mdev_cfg_remove() above, does this iteration also need
> matrix_dev->mdevs_lock to prevent list corruption against concurrent calls
> to vfio_ap_mdev_probe()?

No, the matrix_dev->guests_lock is needed to prevent list corruption.

>
> [ ... ]
>

