Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6A1A9B48
	for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684916; cv=none; b=ZaM4P9RMtbtQlEwmB6jTZdcymbE2TivzGcs4ewRywoQTUYUC8oIOPvgdQFgql28VlrsM+2GSww/VlE04o1Lf5xSIaB+rrXzJ/YJ+ViJUIqbrjeQLz/iurjWHc7HlDe+OZt7jPvirdf2jR3BurJchbjXxF6OLVjXR6DMFc47jHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684916; c=relaxed/simple;
	bh=dABJz/UQNx58PRUbTo1zLRzIEOPbFjg93KUvSd8ttYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw16JCtnHXHrm9pItmqjVkzdhPdBIKIIhICVsgnIM4M+CSkWXhAVrxutm0hYJLfLboSikCw4CGMYKmCXqfqiTbhVRPf6Uf1HSQROzRzkDl8L8YRlZWAKPl1wkBN0yF0tYT4JrLn7neFatIZw7BSM74ZKrixAvv1r7jQP9hoCi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K+fAOzWZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K+fAOzWZ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728f28744c5so1666672b3a.1
        for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734684914; x=1735289714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQfNyWmZKsPDEukQcf0PNeutIzKaofgYiuVwM4cz6bQ=;
        b=K+fAOzWZ0QTN8WQYAYSjSxi+oXuJO7z7zwLpW6U1lBms+Fe/Ue9vZyJQvyA2SH9Qvx
         kXatEamBjJ4ThoUsByG7rHSoUJOTilgcPf3iO+J1KiNjQGHsQXqfMOWOQ8ku7u9tvPHw
         mpXCI2xGAwPG4SAxsSiVZJq+1TWgkcyJDmAIAkvNu8XitGhuxWreq/q44o2++fVRCb3L
         5AFknOR4WmmPLL7dTTre2gFWrwUUasBV92+JKFYogU1K5Xolhb3vAuLzrTnqNob8+gVg
         3ip1gx+SqDKVT1BBaVIOPZilXhVqGB3E+DFEnoMfgczDFgtsWQouco7KwqIEy61Y6KIY
         XEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734684914; x=1735289714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQfNyWmZKsPDEukQcf0PNeutIzKaofgYiuVwM4cz6bQ=;
        b=ux9bL8gxTT335E7UJsocH7sc4doaV8Sj68sDaCKFJFTufPmaxiOTRsumd1n+Qmn6+A
         XRomtBy7FH8NeGcmcwBLU9vOz/aMHr63t2KMAwhS3SerhTixwx3sQ5DM+j468yd1nCke
         h6ezMzmH0nvm6SonKRu5EJKGvbkUur43Y/9Su3wLS5k7kP4p+b/NRLy1blcO119rnJBx
         vNsDi8xHSk7gzkPMgPnMNPrKNkIM3r/TM9KwJqxk11ygHwCm68GefwkkIqXPvmCjzTx9
         HVc8pK5gq0HnZq8RTn8iCWflXs+WwGFNgR4dY70irAr7zjqZUIDLs/EDVYL9JKVMcIc0
         odzg==
X-Forwarded-Encrypted: i=1; AJvYcCXZAD7K39lOwb/p6xGZGrbLHvXUyYbVFFqsQxDzFr+1GGmcAbDCiar/FUjYmRCFMY5iZALJaVjAwesB@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRJIIREGAd0Bt5gjv67c9W2DefX5iZYhGj5yOo+ijTDlJvR2u
	IaEb0rzIyjOfu7hSbi4K8Q2nRLxlJ8NhHLkczMrNcyd8OfCeEBSTjboakujznRM=
X-Gm-Gg: ASbGncuFzcxsDF/FuUGF8MOb37jm6bJsVxfDGsZlL7aLMKIBQ5PQpb32VyL7ZthkAHW
	cQSNzzWnvsL7ThcaBm0acyLd/1+OZNeD8MrCWwat/gCxaaKx83aU7Lu0QTvYIpoHdX5iHVtY1Rv
	L9dS4A2hJbO0E+lTpDv/rcPVEsIBXHzyzspTuE0F2W8dzubnuwKO/WtFhWE6ZOOU5+uhmJz+uzw
	mg/NJsP4lAZQQhQBV/dEdZKj1WHGcq+wOW2NIfOu4MypXbfTGUrrpcEK0lhMbFGe2lFTCNgR71P
	UMDi3A==
X-Google-Smtp-Source: AGHT+IFhsQwykE06H+WRP/74qyUyJawa/zavas7Qj2VdqxkKt93Yr6pU7Xanlr8qwKqxirNXDKAwCw==
X-Received: by 2002:a05:6a20:7f99:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e5e0470226mr3586592637.16.1734684914494;
        Fri, 20 Dec 2024 00:55:14 -0800 (PST)
Received: from [10.4.194.102] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b85f00f9sm2424275a12.43.2024.12.20.00.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 00:55:13 -0800 (PST)
Message-ID: <5d339eec-bb93-49ab-890f-07c77ce040d8@bytedance.com>
Date: Fri, 20 Dec 2024 16:55:05 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] s390: pgtable: also move pagetable_dtor() of PxD
 to __tlb_remove_table()
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, tglx@linutronix.de, david@redhat.com,
 jannh@google.com, hughd@google.com, yuzhao@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <cover.1734526570.git.zhengqi.arch@bytedance.com>
 <0a6caf8305409173b5d41dccb6ecd46460cf9c1c.1734526570.git.zhengqi.arch@bytedance.com>
 <Z2Ut225pJFBq2wad@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z2Ut225pJFBq2wad@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/20 16:42, Alexander Gordeev wrote:
> On Wed, Dec 18, 2024 at 09:04:46PM +0800, Qi Zheng wrote:
>> In s390, the pagetable_dtor() of PTE has long been moved to
>> __tlb_remove_table().
> 
> Well, not pagetable_dtor(), but rather pagetable_pte_dtor() and
> not to __tlb_remove_table(), but to pagetable_pte_dtor_free() ;)
> 
>> So similarly, also move the pagetable_dtor() of
>> PMD|PUD|P4D to __tlb_remove_table(). This prevents the use-after-free
>> problem where the ptlock is freed immediately but the page table pages
>> is freed later via RCU.
>>
>> By the way, rename pagetable_pte_dtor_free() to pagetable_dtor_free().
> 
> This is not just a random rename, but rather a result of unifying
> PxD and PTE TLB free paths.
> 
> Could you please come up with a better wording concerning the above?

Sorry about that. Will modify it as you said above.

> 
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>   arch/s390/include/asm/tlb.h |  3 ---
>>   arch/s390/mm/pgalloc.c      | 14 ++++----------
>>   2 files changed, 4 insertions(+), 13 deletions(-)
> 
> You also did not CC linux-s390@vger.kernel.org for other patches
> that affect s390 sources. Just CC the whole series, please.

Got it, will CC linux-s390@vger.kernel.org for the whole series in
v3.

Thanks!

> 
> Thanks!
