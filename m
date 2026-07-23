Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422D42AFA3;
	Thu, 23 Jul 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815945; cv=none; b=Wp3ljwBaz5vvAgj5ME5XfXed+4RIm1k6Rc3j6o5gbRGUkxLSZNB49dEn1KnAZurxcwbW1670XHsMFT7rNbJ5zMUKKnP2sISGh09pWxdkEtSzhljGRZ9fbefdjZNTesHHpRS6vKrLgCGd9GgT0Aiek0WkLd1rz/3V2AvcFnZlcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815945; c=relaxed/simple;
	bh=KFnpCeNZJchKC2hhB+llZy22Sv/bzS+xjk5dAZPfJkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBLUsmC3Ka7v0c+bboRB0qJauhTOcw98hSJQC9g0J5C9ZNk4D719RiaDkaicaa6j/gacSAYCUiodY+pfdpVm+5TSDQsUEoXvBu9SEAWnnVikUisQkj88xjfm3lrl8EoQqxKo5R1Gfu9xVJk7cUKj9vvBkEY5olyVOQjodfWEu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hCGb4j+R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hCGb4j+R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC48G3015697;
	Thu, 23 Jul 2026 14:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6PrLLC
	Ymbl+wXdXHgBy0BDG6AZ+//JFo3EhbaFX2gQM=; b=hCGb4j+RYVMsr2G0nUeAVA
	pPcHffBfZqOKQ8sVc2ZkCyzZVWdQBpxYVal3IYEiDKpFtTBB/fGAuHKBK0U2lZSw
	JvggusbpbBDGoGXfguLCOlpTqh3wbFR+Fb5BEePpwElc3181VJK09t6sQRw6aODr
	JeV8L9vlbY44wGqKHJKTdOGcNs4UTx+2eJZTrIl3zAoyTtnCDxGwO0isQcC1Coc/
	zbypwO5zOUqLuRsrjLU6dsGVdIP1dFUN/WXLDPodgT8OnyNbuN46EH/fxQStmV4B
	jKGQCLpg8JOClHcWRQYSp/7l7zL1pYgXAHuTXc2pFV4fIDiJ80AgSSkdH03kdAwA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kfcr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:12:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NE4cYk012006;
	Thu, 23 Jul 2026 14:12:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gmb7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:12:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NECA9J21365496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:12:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D29358053;
	Thu, 23 Jul 2026 14:12:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96FCD58043;
	Thu, 23 Jul 2026 14:12:09 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:12:09 +0000 (GMT)
Message-ID: <6f87bda7-8a8a-4f93-907c-6e0a442c8ceb@linux.ibm.com>
Date: Thu, 23 Jul 2026 10:12:09 -0400
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
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260722170621.1686-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a62213c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=E6e_nEtZC23g9tHm4cEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0MCBTYWx0ZWRfX65pxbA5Oxhk1
 z3vGoRoCa/pqhU6E6/EqYsvzy6HmmiQ1SWhLPgUdpdsT6E5YcvoWnl2e+opJwRUI1V1vjd8tYcj
 MVZdHdI7RIaiYA65aUkjY6qJozfh/LP1VwLhhslzdpYAE2bJTxxCq4lihdDaU6lggJX3YVVyMI8
 HDU61UaAeI6ERqW69lgxif38n2EiM4BKkcfnzZ7GPdxjOIgZdaYD12ncqBXl4wqCh7EfUDgmV8G
 W+u99md0MrLVsFm9Hm3o2Zo/Ys6dQ7/A/3GL0fUzVTwN4LrjB/Z6ZHXnJZwSKGUz/APHa9KykbD
 tHFdcPzZ2VSl7SxNEOO7bKMnGx8xOlwjzl/1uoW3rZ0IUSxJ+JvhRvsdc5W+IgN5FyFzZPJhwyf
 EPNOFKmrkHfD9ML/2+kQr83lw7E0ydU9rzTQHQVS4Sr63IZ+tbAfXpg5BTQaHQIvsZPz6S0cGzB
 zfyAmewlZLZCQybJgSw==
X-Proofpoint-ORIG-GUID: kic4btpkUmSsoJ8vxycy0guV2HeXS0AJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0MCBTYWx0ZWRfXxVNYoeaJP/5x
 4Lh5DwvLdPex9L3uPfPG6GrIJEkBXouF6Kaphua8IC0gwL/kQV7nN0ueWHPYTS2gL1G/API+RZQ
 oByy5DDlIzurv4ZgJqWp5qZQMubdE4k=
X-Proofpoint-GUID: kic4btpkUmSsoJ8vxycy0guV2HeXS0AJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230140

On 7/22/26 1:06 PM, Farhan Ali wrote:
> The account_mem() and unaccount_mem() functions call get_uid() which
> increments the reference count of struct user_struct on every invocation.
> But we don't decrement the count by calling free_uid(). It also
> accounted/unaccounted the pages against the current->mm. But its possible
> the unaccount_mem() can be called from a different process context than the
> one that originally pinned the pages.
> 
> Let's fix this by storing the pinning process user_struct and mm_struct
> when accounting for pinned pages, and subsequently free these resources
> when the pages are unpinned.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/kvm/pci.c | 38 ++++++++++++++++++++++++++++----------
>  arch/s390/kvm/pci.h |  2 ++
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index d2a11cdf6941..1b3114c7cfbb 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -190,33 +190,51 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zdev)
>  	return cc ? -EIO : 0;
>  }
>  
> -static inline void unaccount_mem(unsigned long nr_pages)
> +static inline void unaccount_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
>  {
> -	struct user_struct *user = get_uid(current_user());
> +	struct user_struct *user = kzdev->user_account;
> +	struct mm_struct *mm_account = kzdev->mm_account;
>  
> -	if (user)
> +	if (user) {
>  		atomic_long_sub(nr_pages, &user->locked_vm);
> -	if (current->mm)
> -		atomic64_sub(nr_pages, &current->mm->pinned_vm);

Previous code handled the case where current->mm could be NULL...

> +		free_uid(user);
> +		kzdev->user_account = NULL;
> +	}
> +
> +	if (mm_account) {

... And you check for kzdev->mm_account being NULL here...

> +		atomic64_sub(nr_pages, &mm_account->pinned_vm);
> +		mmdrop(mm_account);
> +		kzdev->mm_account = NULL;
> +	}
>  }
>  
> -static inline int account_mem(unsigned long nr_pages)
> +static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
>  {
>  	struct user_struct *user = get_uid(current_user());
>  	unsigned long page_limit, cur_pages, new_pages;
> +	int rc = 0;
>  
>  	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
>  	cur_pages = atomic_long_read(&user->locked_vm);
>  	do {
>  		new_pages = cur_pages + nr_pages;
> -		if (new_pages > page_limit)
> -			return -ENOMEM;
> +		if (new_pages > page_limit) {
> +			rc =  -ENOMEM;
> +			goto out;
> +		}
>  	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pages));
>  
> +	mmgrab(current->mm);

... But here you do not check if current->mm is NULL.  I'm not sure if
it will happen in practice, but we did guard against it before this
patch.  Just add if (!current->mm) around this mmgrab?

>  	atomic64_add(nr_pages, &current->mm->pinned_vm);
> +	kzdev->user_account = user;
> +	kzdev->mm_account = current->mm;

Then if it IS NULL, we will stash a NULL into kzdev->mm_account here and
handle it above as before with the if (mm_account) check.

>  
>  	return 0;
> +
> +out:
> +	free_uid(user);
> +	return rc;
>  }
>  
>  static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
> @@ -279,7 +297,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  	}
>  
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(pcount))
> +	if (account_mem(zdev->kzdev, pcount))
>  		goto unpin2;
>  
>  	/* AISB must be allocated before we can fill in GAITE */
> @@ -400,7 +418,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
>  		pcount++;
>  	}
>  	if (pcount > 0)
> -		unaccount_mem(pcount);
> +		unaccount_mem(kzdev, pcount);
>  out:
>  	mutex_unlock(&aift->aift_lock);
>  
> diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
> index ff0972dd5e71..544e6aa75e38 100644
> --- a/arch/s390/kvm/pci.h
> +++ b/arch/s390/kvm/pci.h
> @@ -21,6 +21,8 @@ struct kvm_zdev {
>  	struct zpci_dev *zdev;
>  	struct kvm *kvm;
>  	struct zpci_fib fib;
> +	struct user_struct *user_account;
> +	struct mm_struct *mm_account;
>  	struct list_head entry;
>  };
>  

