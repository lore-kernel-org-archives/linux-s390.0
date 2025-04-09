Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5E268FE7;
	Wed,  9 Apr 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210633; cv=none; b=XO+iXoshCPL4wuLI9I0vD45eVD9q86c8YxODaWvRG4mpl4HinaVpSN3ekMYDCeHhEIKiBRSjX7T4tLme7c17rXekX0zrMZ1D3LceMC1IL55A9uMVre3mxAKYYSti5bewdWZzez39SgfWWKxOk7Gi7REnP/juc7pBDtUPSZakHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210633; c=relaxed/simple;
	bh=ADNGUNPjht6pF0bZgUe8BuYoaHN32NWDtMTTxruXVD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l37MTtjHZ2v0bkWrM61EP+SxMHT1a5awUuYYVk/63qML4xzXeqcdK04E4GP6UmNpPjv70SgTQwojWMCqhLR9VP8if13rmKB4+P/WM2ZOqioFL7iBlpDOKwF52/rl9gZfsSCDCCugRiDWuc78iPzqToHyhhOuOWApI3lbsL4wqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZeqCwJg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZeqCwJg"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf8f3fbd6so7626851fa.2;
        Wed, 09 Apr 2025 07:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210630; x=1744815430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTxp3qW+KPuzf+zXWuGUYa2ldWHd+1dpKttsCAAJnR4=;
        b=eZeqCwJgTbS5AM6/SUnly4j1VmICDewXKwZQoCl5BQt2jc4KyR06uxYC0ZcYBBwLo8
         EXhRZaFBn9NlIFcwEo7miiNaozhgRz7HD+Wg718CUT6QnlhowxQjt8+lNNj/lX4V8IZL
         ckPTuIMZHlY9VSf0jkTQNIG5g8hhZwxHI2K7r8oWmaTSg8p4dZs7eBKsGjy/OHnzC1L+
         VtkNNn+rV8AhCSFRIe1h6JgdB+qpC4SiwVaUjib8xGU1dV6geF8wwVeZg7DZEYrdhGl6
         kBK2urHK4ucHnSb+cnsMTPtSDRm8PhpEmXLuRF3qAR2+DSl9bcJO9RJasFe/Rc1z3m8V
         2KYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210630; x=1744815430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTxp3qW+KPuzf+zXWuGUYa2ldWHd+1dpKttsCAAJnR4=;
        b=nZlfv7ZQEr//dhqLH6WF9DWZ7u03yXdJyJFKvuHSap/kxUx4nprYxVQrVph4VM04Df
         yZZDr4r9h3HuH4XI94TyPHgTyOiGR1yURxC5gPaghegSr08gxwIHJGjRrWhhBEPqO2eb
         stK34X0gv5tdVvIuzcudgsn9YPERfcVlI7rwQusMK71JvJMkK1GNwYDCX7CL5x+ALHTI
         8TwyrLTSGD1hLshnM8HwWS+6yonKiuExbAcbG+VSRKBVEUEmfwToXeAQE+aK33S+6BMk
         0DaoDtL+shmIy3jolXW2QMJ6DHmqwpJmgJR6kVXyhji5UsqlYOBUL1FHi0XwIxEbun4w
         coLA==
X-Forwarded-Encrypted: i=1; AJvYcCVFX8QzIMSXVI+CgvUU7pPa0v0AR7lsWYyTuX4FIY+L9WOXSVsy3calB7ZWurL3Q376ARgvbkv8MT9tqA==@vger.kernel.org, AJvYcCWYQGJC5GsLGApCVJWagnf+p1oL7miZ4H9SFvfxhvNQasewdwNv9aLX1tX4+RB1FmAV3lLUYayd@vger.kernel.org, AJvYcCWz08ISi45ig7p41fdcVaK7iDfwYaMRuWWOJ+CKSJ7UaU/yZCuzOgwKC0XmlZPyRgOajtat1XIfZ6MJajM=@vger.kernel.org, AJvYcCX/V9DPdGCJPdjWZrJg2jiamquDXqZ2Pb45hYFjEq3KD7FNQBiv8ESfo8pk6O1VoyyiS/zfMehoaH5Abw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8WwaEjUGmW4L5YKM2lJJqN4tLfWERz2QDm4jduPt3XTJxdzY
	gB6g07QOtkFR/Vyk30zkkG0OBUXDhnLJrQViQfDhb4OyTbX5nRpy
X-Gm-Gg: ASbGnctBNw9viPsr3mSFcabmVEFcGRUm/KOA9eWuV/YqabS74uWwDYDVwnPdL8vDUSp
	WXl7oJ346mvIZq80AlRLx1kzy/b20ToWZUL60ptStVogxfdOSe+12rCHQC7/V4BqQ/7LLLWOu+4
	aUnhG+EPlcx2kE7EKWEiduQi05v+8I/A8uCaMPkKGTmbXsWv2cMviZcM28tftLYDLz/dQcyc+mf
	GMBk5CIrR9PLUaTgHNDcAxLmUTZPOTYPwVDi+YrysZBYxW1DBmD9Ifx864lJf+tUL0KBIlSpDaj
	0HX3UmycvA6odJ9SRAwqdBPgurGxMqZFOMK3uhWzr1AOGTTvvIipkczwgyquzXp79UBlEQ==
X-Google-Smtp-Source: AGHT+IG7fk9emZaqKs/kKGowvaUASd2CDo9SSBq5dR2zvDPKxRK4W1C4hr7cqLTnQPNN0OUJNfi0kg==
X-Received: by 2002:a05:651c:221a:b0:30d:62c1:3bfc with SMTP id 38308e7fff4ca-30f4387ba49mr2911011fa.7.1744210629436;
        Wed, 09 Apr 2025 07:57:09 -0700 (PDT)
Received: from [172.27.52.232] (auburn-lo423.yndx.net. [93.158.190.104])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d61csm1929521fa.7.2025.04.09.07.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 07:57:09 -0700 (PDT)
Message-ID: <02d570de-001b-4622-b4c4-cfedf1b599a1@gmail.com>
Date: Wed, 9 Apr 2025 16:56:29 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] kasan: Avoid sleepable page allocation from atomic
 context
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Nicholas Piggin <npiggin@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>,
 Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, stable@vger.kernel.org
References: <cover.1744128123.git.agordeev@linux.ibm.com>
 <2d9f4ac4528701b59d511a379a60107fa608ad30.1744128123.git.agordeev@linux.ibm.com>
 <3e245617-81a5-4ea3-843f-b86261cf8599@gmail.com>
 <Z/aDckdBFPfg2h/P@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <Z/aDckdBFPfg2h/P@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/25 4:25 PM, Alexander Gordeev wrote:
> On Wed, Apr 09, 2025 at 04:10:58PM +0200, Andrey Ryabinin wrote:
> 
> Hi Andrey,
> 
>>> @@ -301,7 +301,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>>>  	if (likely(!pte_none(ptep_get(ptep))))
>>>  		return 0;
>>>  
>>> -	page = __get_free_page(GFP_KERNEL);
>>> +	page = __get_free_page(GFP_ATOMIC);
>>>  	if (!page)
>>>  		return -ENOMEM;
>>>  
>>
>> I think a better way to fix this would be moving out allocation from atomic context. Allocate page prior
>> to apply_to_page_range() call and pass it down to kasan_populate_vmalloc_pte().
> 
> I think the page address could be passed as the parameter to kasan_populate_vmalloc_pte().

We'll need to pass it as 'struct page **page' or maybe as pointer to some struct, e.g.:
struct page_data {
 struct page *page;
};


So, the kasan_populate_vmalloc_pte() would do something like this:

kasan_populate_vmalloc_pte() {
	if (!pte_none)
		return 0;
	if (!page_data->page)
		return -EAGAIN;

	//use page to set pte

        //NULLify pointer so that next kasan_populate_vmalloc_pte() will bail
	// out to allocate new page
	page_data->page = NULL; 
}

And it might be good idea to add 'last_addr' to page_data, so that we know where we stopped
so that the next apply_to_page_range() call could continue, instead of starting from the beginning. 


> 
>> Whenever kasan_populate_vmalloc_pte() will require additional page we could bail out with -EAGAIN,
>> and allocate another one.
> 
> When would it be needed? kasan_populate_vmalloc_pte() handles just one page.
> 

apply_to_page_range() goes over range of addresses and calls kasan_populate_vmalloc_pte()
multiple times (each time with different 'addr' but the same '*unused' arg). Things will go wrong
if you'll use same page multiple times for different addresses.


> Thanks!

