Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF304734C5;
	Thu, 23 Jul 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826516; cv=none; b=Qb/Ict+tOyOssI5pXJzD8g9H/D4FTeISTlQbP5bzyKrHjNiaP/OFxVJ6gZVUpUCDiPqEWILzSVylU6lHc6ZEehKkM2mb3edH3BvQRpJFaJ2W3ne9jCO+cA/NFAvMtRj0TmrIF5obTERcBcT5gpg4X3scwGjEgurujMiiG83rKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826516; c=relaxed/simple;
	bh=dUEaW8W/I6lFsqVbQooA22UoSHplbQ/G39DHIHvLzT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0V14++PWXyI/MCyY5F5sXg97t7cWn36dOsXf1PzRe09jSaB97gGSZjVdHJ4U86IwzctPqIX9Nvcy6Xb8+af/D3gg6bVTiWxsjdE2CFU6Z3kry54kTcWI2gyY1TKLF9LOSl0HRWAHp7yuU1aPaMq5nqPM7Z5sCKB7VJgU1isAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yna/pYh+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yna/pYh+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC2S33015582;
	Thu, 23 Jul 2026 17:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2NfAV/
	u4b+IoWFkn7yKzWuRr4MkBW+pOP6m5YwXO/7Q=; b=Yna/pYh+OBnIqlUrcNR3Q7
	GigkqUxc+pn0LDyOmB/SacsmCUF3pkuqFSpPVgd2i/M6vAC9HG5Zzfrn1u1LB/6I
	Aow2RPGu5tQhAfKqtOUmfathbN0qj4bCQJ5gvvWo3W1oMYyVqmgnR5Qw1VhWzPSd
	h7s9kpH1txkeztG28XnZzco+Gbc3LpqTXLvxvKQjR6pZx1M+SBYtOu45tI8DAxEf
	CJHS3x7xx8Anvjjf/wwoiN3tNLe1Ma4/ES32RkOdX2vXtBgOxhSpuoWv+m4PrtDq
	4/szw+6r3JtrYp2yLxd5IMqP6BuuwWDvedSV9upKMQm7VCoGtIBC/oc282VwOhjQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kg5b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:08:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NH4bVO022369;
	Thu, 23 Jul 2026 17:08:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqdbta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:08:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NH8Wnq64553322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:08:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 097F258055;
	Thu, 23 Jul 2026 17:08:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F66A58043;
	Thu, 23 Jul 2026 17:08:31 +0000 (GMT)
Received: from [9.61.254.118] (unknown [9.61.254.118])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 17:08:31 +0000 (GMT)
Message-ID: <3950a0e4-3074-44af-a1d1-d38ee3391c0f@linux.ibm.com>
Date: Thu, 23 Jul 2026 10:08:31 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-3-alifm@linux.ibm.com>
 <6f87bda7-8a8a-4f93-907c-6e0a442c8ceb@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <6f87bda7-8a8a-4f93-907c-6e0a442c8ceb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a624a91 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=P-IC7800AAAA:8
 a=VnNF1IyMAAAA:8 a=s7El_Fc1KRag8uzhLH4A:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX8HpV4aw/3yqc
 ys0AurZsmfsDJ9Sdi8d9BBHRcuh8kjpHXmafeCDJITfQBTeM18MGXVqn7ydhYZkUnjg66D166b+
 0N0Hre47x4b3ZJJ5O9kXYTjY1Psjhh6Pc85jv1EsMQ3jkBin9lkDnvOAkeIX0IJfCReYA7Nj3Dm
 UtdmIPyEWh62uq+UtrOIgjynBu45YCaAoh1nYYHLSBBm1RFTUKUKYktBKdSRHYZ+2v5Cw0V/1dP
 L7aBEtqCKpSD0Ru8Ni1Da1c0ny5HVNDG0/8cdYyQtFY0KJrTkVG0UH4xuD12xg+VTadCZ6mpdeF
 rD4W7ctspzZmJ4wuTgH1VPdXAXcRON8BITHPP6gyrxz/tAfOfmayln/g64xo42gfzBH2RROmVF3
 FC1fKJcXxxRTY0P0bQZVr8/f/wTR+cSC2W2uur8oSQjCTyp4I9t3XsIzdR1hJ1sBCHGaP9GljJ2
 iVnpstkCKMpVxsAELTQ==
X-Proofpoint-ORIG-GUID: mYzJOf2jTR9g3O65q95fapnacYBRzPFH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX0d1hCameuqLD
 +nq/d8/efL0c8BweO4aN0ytiwM/DVDsYSNJV1gN4lEVEhBLO++YgPIL7rv2m0CYNMT4EYGYYkWx
 4PczJayX6ArbYhnCmtZsUyUuwN9sCng=
X-Proofpoint-GUID: mYzJOf2jTR9g3O65q95fapnacYBRzPFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230164


On 7/23/2026 7:12 AM, Matthew Rosato wrote:
> On 7/22/26 1:06 PM, Farhan Ali wrote:
>> The account_mem() and unaccount_mem() functions call get_uid() which
>> increments the reference count of struct user_struct on every invocation.
>> But we don't decrement the count by calling free_uid(). It also
>> accounted/unaccounted the pages against the current->mm. But its possible
>> the unaccount_mem() can be called from a different process context than the
>> one that originally pinned the pages.
>>
>> Let's fix this by storing the pinning process user_struct and mm_struct
>> when accounting for pinned pages, and subsequently free these resources
>> when the pages are unpinned.
>>
>> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   arch/s390/kvm/pci.c | 38 ++++++++++++++++++++++++++++----------
>>   arch/s390/kvm/pci.h |  2 ++
>>   2 files changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
>> index d2a11cdf6941..1b3114c7cfbb 100644
>> --- a/arch/s390/kvm/pci.c
>> +++ b/arch/s390/kvm/pci.c
>> @@ -190,33 +190,51 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zdev)
>>   	return cc ? -EIO : 0;
>>   }
>>   
>> -static inline void unaccount_mem(unsigned long nr_pages)
>> +static inline void unaccount_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
>>   {
>> -	struct user_struct *user = get_uid(current_user());
>> +	struct user_struct *user = kzdev->user_account;
>> +	struct mm_struct *mm_account = kzdev->mm_account;
>>   
>> -	if (user)
>> +	if (user) {
>>   		atomic_long_sub(nr_pages, &user->locked_vm);
>> -	if (current->mm)
>> -		atomic64_sub(nr_pages, &current->mm->pinned_vm);
> Previous code handled the case where current->mm could be NULL...
>
>> +		free_uid(user);
>> +		kzdev->user_account = NULL;
>> +	}
>> +
>> +	if (mm_account) {
> ... And you check for kzdev->mm_account being NULL here...
>
>> +		atomic64_sub(nr_pages, &mm_account->pinned_vm);
>> +		mmdrop(mm_account);
>> +		kzdev->mm_account = NULL;
>> +	}
>>   }
>>   
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
>> +			rc =  -ENOMEM;
>> +			goto out;
>> +		}
>>   	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pages));
>>   
>> +	mmgrab(current->mm);
> ... But here you do not check if current->mm is NULL.  I'm not sure if
> it will happen in practice, but we did guard against it before this
> patch.  Just add if (!current->mm) around this mmgrab?

But wouldn't the atomic64_add just below this also need to be in the 
check? FWIW looking at some of the other references to mmgrab, I didn't 
see explicit checks for the current->mm [1] [2]

[1] 
https://elixir.bootlin.com/linux/v7.2-rc4/source/io_uring/io_uring.c#L3047

[2] 
https://elixir.bootlin.com/linux/v7.2-rc4/source/drivers/vfio/vfio_iommu_type1.c#L1675

Thanks

Farhan


>
>>   	atomic64_add(nr_pages, &current->mm->pinned_vm);
>> +	kzdev->user_account = user;
>> +	kzdev->mm_account = current->mm;
> Then if it IS NULL, we will stash a NULL into kzdev->mm_account here and
> handle it above as before with the if (mm_account) check.
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
>> @@ -279,7 +297,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>>   	}
>>   
>>   	/* Account for pinned pages, roll back on failure */
>> -	if (account_mem(pcount))
>> +	if (account_mem(zdev->kzdev, pcount))
>>   		goto unpin2;
>>   
>>   	/* AISB must be allocated before we can fill in GAITE */
>> @@ -400,7 +418,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
>>   		pcount++;
>>   	}
>>   	if (pcount > 0)
>> -		unaccount_mem(pcount);
>> +		unaccount_mem(kzdev, pcount);
>>   out:
>>   	mutex_unlock(&aift->aift_lock);
>>   
>> diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
>> index ff0972dd5e71..544e6aa75e38 100644
>> --- a/arch/s390/kvm/pci.h
>> +++ b/arch/s390/kvm/pci.h
>> @@ -21,6 +21,8 @@ struct kvm_zdev {
>>   	struct zpci_dev *zdev;
>>   	struct kvm *kvm;
>>   	struct zpci_fib fib;
>> +	struct user_struct *user_account;
>> +	struct mm_struct *mm_account;
>>   	struct list_head entry;
>>   };
>>   
