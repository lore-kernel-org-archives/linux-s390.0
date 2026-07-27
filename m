Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7F188713;
	Mon, 27 Jul 2026 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150975; cv=none; b=Ivmx3VDbj0ofqGXXA74D7ArhYUuut3a7PjR4HvY+aiIj2drdhGq9iCa+pzN/fJy81ttbp5Olsason/uq47aeyQseBF5poWfd7WbFhIdp+DQPx2ZZ5iLiycjQgFdIsxyZrE6CGsXfmrWVEqIkWPMLgAJ4XyElQSYIWC9J1jADI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150975; c=relaxed/simple;
	bh=/+itlBm7r0v4QqIDP9l1rzX4iGLSmwtHVsUq25eU1x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ny3qaGZDhxSdeUIpOr1bDd3RhLF74SHELA9FjT87Jnt5b51N8svHwtpPmKstVA/ULiWHxAhH7m8LJZan/YaM3qncHZQOt+lBBXyLo8pHN0rT7Pd1TDMDGYIwDXD3VhZZGeUDdh91OZZRPt/WlGQlX97F7oBttEZI4iNu+MMZgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qp0BHyey; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qp0BHyey"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAJIph1923915;
	Mon, 27 Jul 2026 11:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8S1cLg
	QcvXjYWpfjurcLn7t0WBOdgSCbMmbSNFjBi9I=; b=qp0BHyeym9EU/v97LxR/Hq
	KzWD3OGPrH+7BR1DkaZlsOn4kaXJR+55PKHhPXP+0ftDt0zmie6qV39s+SSNa9ii
	8SKSIVzyDzmlO6Jm5Zdl474zxMXsJnd4I3ebh1o74HXxV9WFWExsCp50vOMN+AGj
	Lw8k2QIubu+Ega2cGzI2xhCWBKx0n26OguMr4nMDsoInr1s8Erh9bZb4IcrItGHF
	ifDmbP8tluVK/ly2nFR7f7bzmLCBxCOSmQAOaKYXkyazr4/oGJDJsY5L7nr736Kn
	ThFa0n/t2p/xKkR2GemFzcEZ2a62WLzNZgc1PIqXe6Nx/0KdOyfzlDaMDTIyw2Uw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77ns8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 11:16:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RBBFSJ003475;
	Mon, 27 Jul 2026 11:16:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh51pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 11:16:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RBG7hw36897202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 11:16:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AF0720090;
	Mon, 27 Jul 2026 11:16:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DDA20093;
	Mon, 27 Jul 2026 11:16:07 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 11:16:07 +0000 (GMT)
Message-ID: <a59c038d-a735-4a8e-a76f-60ffbeb6992b@linux.ibm.com>
Date: Mon, 27 Jul 2026 13:15:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 2/7] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>, kvm@vger.kernel.org
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
 <20260727095720.9150-3-borntraeger@linux.ibm.com>
 <20260727101121.C86F61F00AC4@smtp.kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260727101121.C86F61F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jxCCxUMGY3Ic_i2w-VQNgY77Jjpu4MRx
X-Proofpoint-ORIG-GUID: jxCCxUMGY3Ic_i2w-VQNgY77Jjpu4MRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwNSBTYWx0ZWRfX1kzTMQ8KyOVn
 pz06+Yeou4JeSdwwMsY7yjMmNPZxHAITKIsFt5kq9MVKhKI7FP7JoWgYmuKcdAs2P+uCVsg98Nn
 NIR9sq11A0Fzief6rHynGUJkasoZ52DQujHUA4EqDM2SbK5tkecMoe2xKQWWFDSyB6882q2YE5i
 tiwMK7RwGXZmcYBTnY1404CT5frl4LEeJz1e+IZJqch9TB3sppZ9JHVyNZ/BIzhUwXrZNb2jeFU
 MHZC0P6qC78hE7JfOrdEdw4ZP+4s36+ngML2ts7nN/Ps6kUPZMzHu5+HzJzySIRaliMzs9xnxQt
 yCLbDNvHeTLgpUp6dtUKW1tu0XJDNwpSSJacAR0I3FEn9L7wtqW7EmJnYf3GPGmKeYPETHUoeeB
 W+rYJPFwSKId4dHDWYXdgUfbyoxuJxTzOwAGOhNnQMqNEC5fjFueukMmZZnEDHko5G8YD2/Cv7Q
 FLw3h5L0lwmtPLRBASA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a673dfc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=rpbQ5iLBezYDpLgtt8IA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwNSBTYWx0ZWRfX+PTddQKEGrZr
 0CFRhryvsZYR9Iie9BebPoZ3rcGlrBByoh7hekZVFpETUv5g0rQwNdAVzaxPLyY9/sBSYtGqV6y
 3c+Eea9JLcBDB6lIul//824auyBQ7XY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270105

Am 27.07.26 um 12:11 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] The patch introduces `mm_struct` and `user_struct` reference count leaks on the `airq_iv_alloc_bit()` error path.

For some reason sashiko failed to apply patch3, which fixes this exact problem.

> - [High] Calling the `KVM_S390_ZPCIOP_REG_AEN` ioctl multiple times sequentially overwrites `kzdev->mm_account` and `kzdev->user_account`, permanently leaking the previously acquired kernel object references.

same here. Looks like sashiko applied this series to a wrong tree.

All PCI fixes have been reviewed before here:

https://sashiko.dev/#/patchset/20260723221409.5874-1-alifm%40linux.ibm.com


> 
> Pre-existing issues:
> - [High] Missing NULL check for `airq_iv_create()` return value causes a guaranteed NULL pointer dereference.
> --
> 
> --- Patch [1]: [GIT PULL 2/7] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages ---
> commit c8a84dcb0557ca0ba1070398f64a0a7a9a08e82b
> Author: Farhan Ali <alifm@linux.ibm.com>
> Date:   Mon Jul 27 09:57:15 2026 +0000
> 
>      KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
> 
> This patch stores the pinning process user_struct and mm_struct when
> accounting for pinned pages. It subsequently frees these resources when the
> pages are unpinned to resolve context issues.
> 
>> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
>> index 5b075c38998e3..c2f5085a0f5f1 100644
>> --- a/arch/s390/kvm/pci.c
>> +++ b/arch/s390/kvm/pci.c
> [ ... ]
>> @@ -190,33 +190,54 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zdev)
> [ ... ]
>> -static inline int account_mem(unsigned long nr_pages)
>> +static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
>>   {
>>   	struct user_struct *user = get_uid(current_user());
>>   	unsigned long page_limit, cur_pages, new_pages;
>> +	int rc = 0;
>>   
>>   	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>   
>>   	cur_pages = atomic_long_read(&user->locked_vm);
>>   	do {
>>   		new_pages = cur_pages + nr_pages;
>> -		if (new_pages > page_limit)
>> -			return -ENOMEM;
>> +		if (new_pages > page_limit) {
>> +			rc = -ENOMEM;
>> +			goto out;
>> +		}
>>   	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pages));
>>   
>> -	atomic64_add(nr_pages, &current->mm->pinned_vm);
>> +	if (current->mm) {
>> +		mmgrab(current->mm);
>> +		atomic64_add(nr_pages, &current->mm->pinned_vm);
>> +	}
>> +
>> +	kzdev->user_account = user;
>> +	kzdev->mm_account = current->mm;
> 
> [Severity: High]
> If the KVM_S390_ZPCIOP_REG_AEN ioctl invokes kvm_s390_pci_aif_enable()
> multiple times sequentially, will this unconditionally overwrite
> kzdev->user_account and kzdev->mm_account?
> 
> It appears that if the device is already enabled, the previously acquired
> references would be permanently leaked since unaccount_mem() isn't called
> before assigning the new pointers here.
> 
>>   
>>   	return 0;
>> +
>> +out:
>> +	free_uid(user);
>> +	return rc;
>>   }
>>   
>>   static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>> @@ -275,7 +296,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>>   	}
>>   
>>   	/* Account for pinned pages, roll back on failure */
>> -	if (account_mem(pcount))
>> +	if (account_mem(zdev->kzdev, pcount))
>>   		goto unpin2;
>>   
>>   	/* AISB must be allocated before we can fill in GAITE */
> 
> [Severity: High]
> If airq_iv_alloc_bit() fails later in this function, the error path
> jumps to the unlock and unpin labels:
> 
> kvm_s390_pci_aif_enable() {
>          ...
>          bit = airq_iv_alloc_bit(aift->sbv);
>          if (bit == -1UL)
>                  goto unlock;
>          ...
> unlock:
>          mutex_unlock(&aift->aift_lock);
> unpin2:
>          if (fib->fmt0.sum == 1)
>                  unpin_user_page(aisb_page);
>          ...
> }
> 
> Does this error path need to call unaccount_mem() to prevent leaking the
> mm_struct and user_struct references acquired by account_mem() earlier?
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for airq_iv_create() to
> return NULL under memory pressure?
> 
> If it fails, zdev->aibv is assigned NULL a bit later in
> kvm_s390_pci_aif_enable():
> 
> kvm_s390_pci_aif_enable() {
>          ...
>          zdev->aibv = airq_iv_create(...);
>          ...
>          rc = kvm_zpci_set_airq(zdev);
>          ...
> }
> 
> Could this lead to a NULL pointer dereference when kvm_zpci_set_airq()
> attempts to access airq_iv_end(zdev->aibv)?
> 

