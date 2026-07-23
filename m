Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA82F8E90;
	Thu, 23 Jul 2026 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827907; cv=none; b=letLxa4ycaU1SrPs+sZOIf+9EXTl/kSMQFCYSJf0mlDDIJe9OGV714EfDsnoauU7waSZnqjnBslKcD8AKWS/OJDx51xqIWqRB0QVNEh68STsEehZ1jU2lv/hSTNo3zHM2ZKsHcqrDal2YOM3xT7KJQ8Iyv+z6pTs6m76TYSIe34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827907; c=relaxed/simple;
	bh=6LOcYfOJGh0+ldrtmPFlWLuW+Zjp77rXM/MRmp1qTHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3r9UmfkrnFyv6OOv3CgF0qFNneN189xvia6kdbbjuIZkNLiOFDzAfctXG0qCrhlja7ykMI2Lo/20FX5GlpeugZ5Dln+F1aFws9AvvoV47XV6INOA0rh7uJDd0FzlNlgzuhQi6c1Xqey9lE0QlMf+rLtY193n+D9K5oTyaUcYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLR1C39q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLR1C39q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBp8N3094842;
	Thu, 23 Jul 2026 17:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kkPa/x
	oJfiOxFkHrZA7tstgC7v4/EyIKAP1hZ4Yi9xU=; b=WLR1C39qB3Cwzv909DoL2o
	chlGQYsGx8QnpyGaBhK07AbX1Vg4eSK0OhTXk7l4b/UZFCNseh7+nCpuU7HzVApt
	KZO4GOpfxnSy5t3mi6BnYmIc6zkmHDd6cNGvCnAcI2ziHun24YDbR1STJwTjSvXl
	xPTYq0iz2xGm2Zi9vKPqaun2OjKVBRMJm9KxlC56f12Nd4ThrHrDp57hBHFFC+6V
	YV8Ga99Ab7y9sbDY8bjYLkqSXm6hAIQnYBPk9Hsy3Zbzqn8ogEKmJO0MdDZpWqph
	Bbmom91yp9jsnXuN9FtlZiJBOul++Zm/IyDe3//139CHU2dOESK5KoLTxGLOIDhA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahg6xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:31:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NH4jEW022204;
	Thu, 23 Jul 2026 17:31:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk59gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:31:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHVgY629164274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:31:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4796258059;
	Thu, 23 Jul 2026 17:31:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85EB95805D;
	Thu, 23 Jul 2026 17:31:41 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 17:31:41 +0000 (GMT)
Message-ID: <66a15560-87ba-4167-934d-cf43916c37e3@linux.ibm.com>
Date: Thu, 23 Jul 2026 13:31:41 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-3-alifm@linux.ibm.com>
 <6f87bda7-8a8a-4f93-907c-6e0a442c8ceb@linux.ibm.com>
 <3950a0e4-3074-44af-a1d1-d38ee3391c0f@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <3950a0e4-3074-44af-a1d1-d38ee3391c0f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qltQratDnYiXzd5j9Qf4B4KzOisGmctP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2OCBTYWx0ZWRfXxv8jICA3nGLi
 he3h/ghKd2X9EZYgVuCIGrxDyBp5OO0HqNMzY7DKWyGCaZom08Rx4ZTQucrxQqDyx7MvGVQrG7h
 hMl/zy2xwsLD1KoGY+giutpSqv0/uoYz9bXlU30To8qomPnlGu3661VR2GT8bCrQHKQfJM6P5F8
 a3+NC2gCpCxbz7e3U1ydcJYfVgvfwZ6NOl5b+zzs51BMZRaZuvGEW5NsumGmnZBEP64shKnBzRK
 yocTRzBdRC2qVQqdCCrIoGhYhebT1jcw9RjoLadIBhDyoKsVv8Y2frGdFVGM6KjwzUUVFUXz49Q
 t33wYnm5UHH0z994UMfgF4if16VE/Kjpqg62qqQ8lfAoPb3tZE6PW/7etiFF0ty7p/KmCulkkvc
 /a77p2bWKTiMEz15chkYTukS6kolkyCEiq6NRhx9WEt3PoHhO9k9FoMchmySmG+T8nd5U6S8vhm
 ILxg569nygdclSzbk4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2OCBTYWx0ZWRfX1yIEsMB3JBH6
 QE32zXk7knj4ojecaKKvHrAZvSEhXj93Vl3fG32jU6la3tR9FGDcglu4x/K6WfbYfdf+V/+XEIJ
 3MhKnbvT6D0uJeCp7lcDPofK4eTGys0=
X-Proofpoint-GUID: qltQratDnYiXzd5j9Qf4B4KzOisGmctP
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a625000 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8 a=jbpgf7bDCpGlyQxb25MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230168

On 7/23/26 1:08 PM, Farhan Ali wrote:
> 
> On 7/23/2026 7:12 AM, Matthew Rosato wrote:
>> On 7/22/26 1:06 PM, Farhan Ali wrote:
>>> The account_mem() and unaccount_mem() functions call get_uid() which
>>> increments the reference count of struct user_struct on every
>>> invocation.
>>> But we don't decrement the count by calling free_uid(). It also
>>> accounted/unaccounted the pages against the current->mm. But its
>>> possible
>>> the unaccount_mem() can be called from a different process context
>>> than the
>>> one that originally pinned the pages.
>>>
>>> Let's fix this by storing the pinning process user_struct and mm_struct
>>> when accounting for pinned pages, and subsequently free these resources
>>> when the pages are unpinned.
>>>
>>> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/
>>> disabling interrupt forwarding")
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   arch/s390/kvm/pci.c | 38 ++++++++++++++++++++++++++++----------
>>>   arch/s390/kvm/pci.h |  2 ++
>>>   2 files changed, 30 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
>>> index d2a11cdf6941..1b3114c7cfbb 100644
>>> --- a/arch/s390/kvm/pci.c
>>> +++ b/arch/s390/kvm/pci.c
>>> @@ -190,33 +190,51 @@ static int kvm_zpci_clear_airq(struct zpci_dev
>>> *zdev)
>>>       return cc ? -EIO : 0;
>>>   }
>>>   -static inline void unaccount_mem(unsigned long nr_pages)
>>> +static inline void unaccount_mem(struct kvm_zdev *kzdev, unsigned
>>> long nr_pages)
>>>   {
>>> -    struct user_struct *user = get_uid(current_user());
>>> +    struct user_struct *user = kzdev->user_account;
>>> +    struct mm_struct *mm_account = kzdev->mm_account;
>>>   -    if (user)
>>> +    if (user) {
>>>           atomic_long_sub(nr_pages, &user->locked_vm);
>>> -    if (current->mm)
>>> -        atomic64_sub(nr_pages, &current->mm->pinned_vm);
>> Previous code handled the case where current->mm could be NULL...
>>
>>> +        free_uid(user);
>>> +        kzdev->user_account = NULL;
>>> +    }
>>> +
>>> +    if (mm_account) {
>> ... And you check for kzdev->mm_account being NULL here...
>>
>>> +        atomic64_sub(nr_pages, &mm_account->pinned_vm);
>>> +        mmdrop(mm_account);
>>> +        kzdev->mm_account = NULL;
>>> +    }
>>>   }
>>>   -static inline int account_mem(unsigned long nr_pages)
>>> +static inline int account_mem(struct kvm_zdev *kzdev, unsigned long
>>> nr_pages)
>>>   {
>>>       struct user_struct *user = get_uid(current_user());
>>>       unsigned long page_limit, cur_pages, new_pages;
>>> +    int rc = 0;
>>>         page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>>         cur_pages = atomic_long_read(&user->locked_vm);
>>>       do {
>>>           new_pages = cur_pages + nr_pages;
>>> -        if (new_pages > page_limit)
>>> -            return -ENOMEM;
>>> +        if (new_pages > page_limit) {
>>> +            rc =  -ENOMEM;
>>> +            goto out;
>>> +        }
>>>       } while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages,
>>> new_pages));
>>>   +    mmgrab(current->mm);
>> ... But here you do not check if current->mm is NULL.  I'm not sure if
>> it will happen in practice, but we did guard against it before this
>> patch.  Just add if (!current->mm) around this mmgrab?
> 
> But wouldn't the atomic64_add just below this also need to be in the
> check? FWIW looking at some of the other references to mmgrab, I didn't

Yep good point - my intent was to not mess with a structure pointing at
address 0, so you'd want to skip that too.

As for other references to mmgrab, I don't know, but
https://www.kernel.org/doc/Documentation/mm/active_mm.rst
Specifically says to check
if (!current->mm)
to ensure we have user context.

Now, here's the thing:  I believe in practice today all of our calls to
account_mem will have a user context because they are done in response
to an ioctl.  And it is likely that the examples you looked at are also
guaranteed to be in user context.

The problem would be if we were to ever call this accounting function
later from a kernel thread where current->mm was indeed NULL.  I suspect
it was either a review comment on the initial implementation or a case
of 'easy enough to protect against it'

> see explicit checks for the current->mm [1] [2]
> 
> [1] https://elixir.bootlin.com/linux/v7.2-rc4/source/io_uring/
> io_uring.c#L3047
> 
> [2] https://elixir.bootlin.com/linux/v7.2-rc4/source/drivers/vfio/
> vfio_iommu_type1.c#L1675
> 
> Thanks
> 
> Farhan
> 
> 
>>
>>>       atomic64_add(nr_pages, &current->mm->pinned_vm);
>>> +    kzdev->user_account = user;
>>> +    kzdev->mm_account = current->mm;
>> Then if it IS NULL, we will stash a NULL into kzdev->mm_account here and
>> handle it above as before with the if (mm_account) check.
>>
>>>         return 0;
>>> +
>>> +out:
>>> +    free_uid(user);
>>> +    return rc;
>>>   }
>>>     static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct
>>> zpci_fib *fib,
>>> @@ -279,7 +297,7 @@ static int kvm_s390_pci_aif_enable(struct
>>> zpci_dev *zdev, struct zpci_fib *fib,
>>>       }
>>>         /* Account for pinned pages, roll back on failure */
>>> -    if (account_mem(pcount))
>>> +    if (account_mem(zdev->kzdev, pcount))
>>>           goto unpin2;
>>>         /* AISB must be allocated before we can fill in GAITE */
>>> @@ -400,7 +418,7 @@ static int kvm_s390_pci_aif_disable(struct
>>> zpci_dev *zdev, bool force)
>>>           pcount++;
>>>       }
>>>       if (pcount > 0)
>>> -        unaccount_mem(pcount);
>>> +        unaccount_mem(kzdev, pcount);
>>>   out:
>>>       mutex_unlock(&aift->aift_lock);
>>>   diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
>>> index ff0972dd5e71..544e6aa75e38 100644
>>> --- a/arch/s390/kvm/pci.h
>>> +++ b/arch/s390/kvm/pci.h
>>> @@ -21,6 +21,8 @@ struct kvm_zdev {
>>>       struct zpci_dev *zdev;
>>>       struct kvm *kvm;
>>>       struct zpci_fib fib;
>>> +    struct user_struct *user_account;
>>> +    struct mm_struct *mm_account;
>>>       struct list_head entry;
>>>   };
>>>   

