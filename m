Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F99332ED7
	for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671774; cv=none; b=IY3UIb6ggmVbLC+ao583EWwROhhSpUylUR9ArJCCH5aqIe5C3/2Mw3/Jcw+dsTkDniQXMCfqMI80T2O1D9vYBIVP1POSMRlk58/NTOJ+YrdllN/c3W8ZSoynbgDbrnCOltqfna5nL1a4nSZcsMwZ6uQux1BKk/MK1kQYhAa9Gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671774; c=relaxed/simple;
	bh=nS8+htJjqSEedj7KXDtv5XvZ98pBWn2X5YD5S56Ge9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jzb183PkNIs7nrH4ONKFX5PKk8Y8reBVBpWJKYoSaePhdlx4/4wM1VWPurlkArCFY+9ND5SFrvPFcVGKoD3Szx0pO1eFSLW77tW+Gqxf5WIpbsYUB52HN9bOSj/woo2qnlR1czqKsZF01VdH1dAg/83Dyu3rWjzM44pbGYHT+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvxoeYlq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvxoeYlq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761671771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZZJmYzbni2EVKfNXfjvDYvkFMG8WiEx1VqOApMIszw=;
	b=UvxoeYlqvP17HjxyG9qcd9VcG1r/VWvaTvVJK50f/TPBiYM5k9IJyT/a0y4PZ/qwAF8ORk
	ze2psaMtUf91bc7GU8K2ZoD725X0dYoPdHBNLuOEJn4uQ+7Og4dRSw+0NmWziioxdCPW89
	6NXVR+e7xkRgfg4sOy7l+njm9N5Ackc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-6gi8tv3WMBmR2mJeeH3LMQ-1; Tue, 28 Oct 2025 13:16:10 -0400
X-MC-Unique: 6gi8tv3WMBmR2mJeeH3LMQ-1
X-Mimecast-MFC-AGG-ID: 6gi8tv3WMBmR2mJeeH3LMQ_1761671769
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-79a3c16b276so125864396d6.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 10:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671769; x=1762276569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZZJmYzbni2EVKfNXfjvDYvkFMG8WiEx1VqOApMIszw=;
        b=KG2tYtgQ9QGrNcXbC3+8v6/qiFt9B+0dP7dWbQpZ2VTz+4wnQEGNgdK935gxt4RVf7
         UFFNChStX5E/d5DH/AZU1sSV2+XjBvn3BDwd/3c9EplzUEn9/0EwE0BxlnaY6I+pgvBb
         b4oe3klggtAXUeNYAhpwi79qL5LH9j8aQIQC3Ihb0Wvd5/tBGyrVKMDROCR+Jw3j9aEU
         A70Xeaw/Zzei8yVCNqgi6PccCvh+HFtAmrL6Nyj5PP+cIl6KKDFTUdiHHXjnPWVUSA17
         T05b5fzHsY5JDfNWKf8PnP9s0xsLHNxVkpkEUZQtoZfnUCwm8r5we7A2M0xKJcwCmC3p
         eTFg==
X-Forwarded-Encrypted: i=1; AJvYcCWLd095AFY/9H94sK2uNwDynqf18RNUiWouSjG1MI5hEROog0GgaHHL788RA4DbqY7W4+R68PO/HMzg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3J/U390+ye15cOIDFQvHcn0rzJCFfkaoD9e+GRaaeVHUlIr/g
	9u8VhbmEE+OBjEJQyuu+UxWa898ca3pKti8ifouAHoAV1Eu+08VzD7e3gwcl38GcvfSeTmsthzN
	AJCM61uLl7p+S9mQDRQER9ZRdDDDl9C8hwmmjDYKQdeYyuRJANJpRshh68ocOnxw=
X-Gm-Gg: ASbGncsbEX4gLEQQ8ufcaaW44zosiRmqbm6o+uBiC6w0BqkWcrGMZDYIQEeE0+NI7/c
	d7qWpCD1NRHn0X3fdWAkodgjhSXB8UX/DC8D/SV9cM9AbHn1c0O9HXaFjobkoN0zDbFAlfeAlcj
	dIWZPfUi1HbAHkh7Qt0IpzA8bH7WdICjG06HCLo82zbbSLDyog1f5HAT9PJZyT1LBjNw0weqmZt
	kRlbEzt3ML40UmYYLEhCBa7OE9hofM3B1bIDbtMj/7uVJ5DTUDa9u4zmNfUE9YwaoGH2Wr1pQWx
	7sxpw4jPp/1mo47XWxHNxBjkJAg/5lb4SM+jrH8Vt81rk98PjQvltSAY5+PTf0ZoeNOCbL5mbW/
	0ng==
X-Received: by 2002:a05:6214:20c4:b0:87c:20f1:359c with SMTP id 6a1803df08f44-88008764b84mr5742766d6.11.1761671769234;
        Tue, 28 Oct 2025 10:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJPAT5x1RqJKPB3Gg2m0808ux1QN3Uf5oB2BMADrFvGcoIldW5zFHxqfitjG7zUSDb9gzyhQ==
X-Received: by 2002:a05:6214:20c4:b0:87c:20f1:359c with SMTP id 6a1803df08f44-88008764b84mr5742396d6.11.1761671768836;
        Tue, 28 Oct 2025 10:16:08 -0700 (PDT)
Received: from [192.168.2.110] ([70.49.125.126])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48d91a2sm81157926d6.17.2025.10.28.10.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 10:16:08 -0700 (PDT)
Message-ID: <4f522b65-1ab8-4725-8da7-3f071e7919c1@redhat.com>
Date: Tue, 28 Oct 2025 13:15:57 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: fix HVO crash on s390
To: Heiko Carstens <hca@linux.ibm.com>,
 Joao Martins <joao.m.martins@oracle.com>
Cc: osalvador@suse.de, akpm@linux-foundation.org, david@redhat.com,
 aneesh.kumar@kernel.org, borntraeger@linux.ibm.com, mike.kravetz@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20251028153930.37107-1-luizcap@redhat.com>
 <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
 <20251028161426.35377Af6-hca@linux.ibm.com>
 <5c72e064-9298-490e-b05a-16be6b5590b7@oracle.com>
 <20251028170251.11688Aa3-hca@linux.ibm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251028170251.11688Aa3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-28 13:02, Heiko Carstens wrote:
> On Tue, Oct 28, 2025 at 04:48:57PM +0000, Joao Martins wrote:
>> On 28/10/2025 16:14, Heiko Carstens wrote:
>>> On Tue, Oct 28, 2025 at 04:05:45PM +0000, Joao Martins wrote:
>>>>> +static inline void vmemmap_flush_tlb_all(void)
>>>>> +{
>>>>> +#ifdef CONFIG_S390
>>>>> +	__tlb_flush_kernel();
>>>>> +#else
>>>>> +	flush_tlb_all();
>>>>> +#endif
>>>>> +}
>>>>> +
>>>>
>>>> Wouldn't a better fix be to implement flush_tlb_all() in
>>>> s390/include/asm/tlbflush.h since that aliases to __tlb_flush_kernel()?
>>>
>>> The question is rather what is flush_tlb_all() supposed to flush? Is
>>> it supposed to flush only tlb entries corresponding to the kernel
>>> address space, or should it flush just everything?
>>>
>> The latter i.e. everything
>>
>> At least as far as I understand
>>
>>> Within this context it looks like only tlb flushing for the kernel
>>> address space is required(?)
>>
>> That's correct. We are changing the vmemmap which is in the kernel address
>> space, so that's the intent.
>>
>> flush_tlb_all() however is the *closest* equivalent to this that's behind an
>> arch generic API i.e. flushing kernel address space on all CPUs TLBs. IIUC, x86
>> when doing flush_tlb_kernel_range with enough pages it switches to flush_tlb_all
>> (these days on modern AMDs it's even one instruction solely in the calling CPU).
> 
> Considering that flush_tlb_all() should be mapped to __tlb_flush_global()
> and not __tlb_flush_kernel() on s390.

You're right.

> However if there is only a need to flush tlb entries for the complete(?)
> kernel address space, then I'd rather propose a new tlb_flush_kernel()
> instead of a big hammer. If I'm not mistaken flush_tlb_kernel_range()
> exists for just avoiding that. And if architectures can avoid a global
> flush of _all_ tlb entries then that should be made possible.

Should we take a v2 doing your suggestion above for now and work on
the tlb_flush_kernel() idea as a follow up improvement? At least we
go from crashing to flushing more than we should...

