Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBF27FB3C
	for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836104; cv=none; b=ps8f4hcWbrx1BtomXv9FhS6sljmx+IDAa2bhBo9pGTPMW+G5KwNDpB8dtRSFXvjf1AzSSiKT8SLlV70GcYL3tflfkPxbK8cVYE+u/7s8Vq07RtZ+TNOne6q8ONIi3LJD5p6nmU244u9746wswv7vUjNlo+4zBXnV/mItCvSlfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836104; c=relaxed/simple;
	bh=6lxVUIxaRRatI3B3ucLOQH6Kg/459cGXOT+RzzrcHYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CelMRBwCqxkCsbOKydqrE7Ha9a18B5aTX5OtYG5RrI1LXN8idCaSaGZ5+NTDn6rHFfwc4f98uE2KHkYKoQPs2gVDWIKs7ut1TJ6l4d8AxtM3eRVJtbJJ1rUXYEP4+XEYg9ZOFvmeqjHMMCM1znuh984GlsuqS55xXliUHJKdQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDtade+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDtade+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761836101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2W3chW7pcnMqJOQDxC26D0D4sbrWuL2m2Kca3x2i3PY=;
	b=eDtade+B/E64nMgCvXxsrcwB16yBsINB0LnGgWpYnK9zyeoyTEd5v18RzJCfM/a+CNE877
	KjusIIl5kdHWOud71q3n541Ndk7m8S9B4psby13eK70/PwD2SXcLQYytAiwJZdqFd2wMpi
	CTg4PnE2q4HO+JFZLo9eKnticU116aU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-4Y9ZgA4oP1WVWLzngyZ2Ig-1; Thu, 30 Oct 2025 10:55:00 -0400
X-MC-Unique: 4Y9ZgA4oP1WVWLzngyZ2Ig-1
X-Mimecast-MFC-AGG-ID: 4Y9ZgA4oP1WVWLzngyZ2Ig_1761836100
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf1b7686cso61069881cf.0
        for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 07:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836100; x=1762440900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W3chW7pcnMqJOQDxC26D0D4sbrWuL2m2Kca3x2i3PY=;
        b=Km6UBb04SDfY2BY3xxdgWgQ+HionW3QhgKNlyfUNZqtJyS3e8w9IPwVo+o2doR4q7t
         L/lMexD5M0JuDdJiW37BJwgj4fwYCFEhXb2WGRDTaOiIjfECWEuH6kUUJcet/9/kPKtO
         OabqcbeRf9It7xS+mezoXQXj//7dp/lXTasgiq/lolhaDRtIg4lbRsY+NbOvXWkp9qyD
         X0u2wLUvYqyFhcUiJfnPvArk2B0ail2DrZCy1cpQfbwUhw6QOi456XrY9HrF2APDImB+
         ipRBziFm2KSEKelJzibRemFHYh/mufPmSS5YotEqBf+BPYtNKis3oIVwDJpGSto6FMjk
         O4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqQ9rPYecoYplz7Zm3keBjMq7DdN+e0s14ouKiWiD0FSnD2t6Gzr117HWTMbRas82ztvXg94FG/uuS@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMmFpgZNcaJisP/L4KJ9tbmjNBfS9VWKGfCAbQmmjDRTZyzqa
	/7Y53SN/fU/ONrqWFdcMDVtK4Ft1/Cq3SL8KDiZ8AFKwPGhuKETuzk6wHnEb9dnTBFnrNkzlG9z
	Plmh8XYUFMMKY+JXfGA4E+4tOLvEFZPQwR1J6qFBFaOm+92uzCHeMigcpPrLQJN8=
X-Gm-Gg: ASbGncsojVEVE+xomowMqMQLZ9KoaU6SUYCBjACmEWvY0wxcHOpuAebc5zZ0CBIcC+b
	wFKrvkvKAGLK5COMmwKOsnuOJ2eJ+Q84H8xe6hHBu9UbHzfKAJhjduHEBbNOSYeTL0o4N9BYxP2
	mvqlX8OT/VkQEbNYlCDxAQ4MeiqgptrXx7rhz9B586wFeIcy9RV3n957GVf1xcIzdOEEepErrbf
	3hVKIBTXAUQZjAhlYBcCCRxdN1n/a423dbeckHYY4SCrTxuze8nv5Uq6m9nQC7HuXnBYX/KIdMI
	ft61EH0wYA6nW+RV8Rxp7YUsN1BBVOGk8lt5qcxPAl+2yqIaRQ7WnCk5/x8cYu/MUkOANXZUajY
	6Rg==
X-Received: by 2002:a05:622a:155:b0:4eb:a094:9711 with SMTP id d75a77b69052e-4ed30329abbmr840271cf.29.1761836099649;
        Thu, 30 Oct 2025 07:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDZb2Jtln8mUUIX/hROLSOtY5G4JrM/X3Ba6JkpA3dXWxKYmihpqbJsP81IQR1GIA8Uox8Og==
X-Received: by 2002:a05:622a:155:b0:4eb:a094:9711 with SMTP id d75a77b69052e-4ed30329abbmr839911cf.29.1761836099092;
        Thu, 30 Oct 2025 07:54:59 -0700 (PDT)
Received: from [192.168.2.110] ([70.49.125.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba386b695sm110232221cf.34.2025.10.30.07.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 07:54:58 -0700 (PDT)
Message-ID: <bdd4ea3a-f326-4eb8-866a-52b1ea2bdc5a@redhat.com>
Date: Thu, 30 Oct 2025 10:54:47 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, borntraeger@linux.ibm.com,
 joao.m.martins@oracle.com, mike.kravetz@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
 osalvador@suse.de, akpm@linux-foundation.org, aneesh.kumar@kernel.org
References: <20251028211533.47694-1-luizcap@redhat.com>
 <6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
 <20251029104457.8393B96-hca@linux.ibm.com>
 <9a8254b9-92f8-4530-88e8-fca3b7465908@redhat.com>
 <20251029124953.8393Cc7-hca@linux.ibm.com>
 <20251030153807.0a835fee@thinkpad-T15>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251030153807.0a835fee@thinkpad-T15>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-30 10:38, Gerald Schaefer wrote:
> On Wed, 29 Oct 2025 13:49:53 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
>> On Wed, Oct 29, 2025 at 01:15:44PM +0100, David Hildenbrand wrote:
>>> BTW, I'm staring at s390x's flush_tlb() function and wonder why that one is
>>> defined. I'm sure there is a good reason ;)
>>
>> Yes, I stumbled across that yesterday evening as well. I think its only
>> purpose is that it wants to be deleted :). I just didn't do it yet since I
>> don't want to see a merge conflict with this patch.
>>
>> I also need to check if the only usage of flush_tlb_page(), which is also a
>> no-op for s390, in mm/memory.c is not indicating a problem too.
>>
>>>> Changing active entries without the detour over an invalid entry or using
>>>> proper instructions like crdte or cspg is not allowed on s390. This was solved
>>>> for other parts that change active entries of the kernel mapping in an
>>>> architecture compliant way for s390 (see arch/s390/mm/pageattr.c).
>>>
>>> Good point. I recall ARM64 has similar break-before-make requirements
>>> because they cannot tolerate two different TLB entries (small vs. large) for
>>> the same virtual address.
>>>
>>> And if I rememebr correctly, that's the reason why arm64 does not enable
>>> ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP just yet.
>>
>> Ok, let's wait for Gerald. Maybe there is a non-obvious reason why this works
>> anyway.
> 
> No, using pmd_populate_kernel() on an active/valid PMD in vmemmap_split_pmd()
> should violate the architecture, as you described. So this would not work
> with current code, and also should not have worked when I did the change,
> or only by chance.
> 
> Therefore, we should disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, for
> now. Doing it right would most likely require common code changes and
> CRDTE / CSPG usage on s390. Not sure if this feature is really worth the
> hassle, reading all the drawbacks that I mentioned in my commit 00a34d5a99c0
> ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP").

OK, let's do the right thing. Do you plan to post a patch? I can do it
if you would like.

