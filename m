Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAC1C9B9B;
	Tue, 13 May 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154644; cv=none; b=l1/yfySzWZnwzrB9DVmHZgE45jW8Zvn/qkdQ+GiwF2IKmgN0UgHu4tONpqH8YWLMsGKlLgTZoKNqInRRumI0K9mty2ShwcQjH4JBwju48pNWur/mtorc8542SjPKtXnrN4hFWatth+eXuSeJIJgrKDeGBUe68LXDhu2c7KKI5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154644; c=relaxed/simple;
	bh=XL8qu73G3NGvUHj6ADq7BcnT6u+oxB7gWtMQeQF5ayQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obL1z9FvsEdvA6KgGAF2YE15NXir90Sb3jvtYk1TWqDqYjfaMANIaDx1b5Na7pTgcKhlWpYVZhFgEDCl54Jgjf2IdCU6vh4uCxi6YO33vdKrGgMHGiyCq6pBN/10XppeSm3QKVVoVSREb5JfnOELMQhVM1PxBfJqTy4/GV6vLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIQaGR8U; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIQaGR8U"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf89f81c5so5141355e9.2;
        Tue, 13 May 2025 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747154641; x=1747759441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/kRqYaGohmL+rCJZtloL3u0VjOq+d/hFBIY4Q6MI5o=;
        b=XIQaGR8URWtpBDw2e4X667RKfLfpoFjO6lT+4LH1F+7HuUNSHuTbYP7uq7HPqktj3o
         m8/iTVpnJgDwpUfgWUT0m5r7485qnfVakif6XA3Yru43GUMLiMj4x6AgcEq+yRXqBHxi
         /TCiRJmwx7jle4UDM8h3W+R5KoHKtXd+v3Q75yHmPul2nvFb9oj07ZGjAazkEokOVEcn
         qD0+7cDr8l0x52jnPsN4nuOUMzVFUA8wuqWyAaiFIgeTQ9heoA+Ry5V5Idz2VWKqp/Jb
         tiWhTTs9bplM51iP1wK+iVUf3G+kNwaZL50sRHXsC9kZb1e3MECshVm1NxhhDONRlfWt
         /Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747154641; x=1747759441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/kRqYaGohmL+rCJZtloL3u0VjOq+d/hFBIY4Q6MI5o=;
        b=JtHPLIFQbPw2hnCix6kCMixPyHSZSvOyY3HOtWmNHVVqb40UBZLYOTyhj31zA3yLyx
         NebzrAlOo+l0e4htEZ3fhj+eZXPePC8PVfm+SsXI0/zfkcX+LQ/q/EMr0NdQD9bXxejL
         fvqaUsPok/y7XLintd+hBvflZqHoZWGMwaAxPB/HoSr8D/EvvmvT+QTekipTXZv28XxW
         Q/AsbspLtgF1h/QMdO1HMWurEuQk1duhXq1zK9Jln4rFPsM48NYw+qS0NW4VPBmCON6a
         8yfKbbJqmy2cFHIo1gkceXHbs4VHl2urB02QmMk+w/zcmpHJ2FYI1l5j09jIQpBpxFXF
         JwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYNPMT2MjdEjGuWJy1lJpriIJ7E1vVGb8tWC3ycrXKsabUV1fU0U2RD2yGh0BM99ktvttEbRwU+9qW@vger.kernel.org, AJvYcCXEX9iQcgZN9Rymjm9xJ/7XnvacG4gTU40JxWkUILM+Oz3WxEXpqhpwjXK5/W5bvvFLIly98GiC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2DqAoIFkP/+IWMg7kwlftEGLsmFsWUoU8fzT7f8kTEnl+W3j
	tvK4wAWJb0+cbxMLYmidGIFyoDITOQrK26XsJo/rVOh/7+RKxUvQ
X-Gm-Gg: ASbGnctn6bml7l503qTi/oHVW37PqzoSr8seAjFzWjUIdt/5yP8v3fwv24HmEt+z6+R
	RxuiMGbW1iJpMPSk4/IdY67yJrUOJUqlXK9xQv6ulNT0VZnLvCVaPni+vl5PL4tpsjMGJcqSxBi
	CB0fylXoP9j2olNgKxYZPZzompugGrgW4NRJCKJdplt0ZBDC+wAmlX/2ogEefJwW3u9rNM1McUN
	782e4sqlCbKmf5ykmpT01W6m8ynTUsRIpu0nSKpMlqM/6aLrq+xKXM035kRp9HXItdbpndu1mwm
	g91PQQMkpwm6hJhgj0wC7T/byy4swi/OZ3yG87wSAIIVb6UxqjZVG56Gl7FrFmpBJnjDwygMeey
	PSVmhMqYno3q5nfUwqaI=
X-Google-Smtp-Source: AGHT+IFMWq4dGQNjFikqi9SiU5l4zVjghlCpgyAzg2C2XLU1zbw34nP91iiVFBwACRU/PcSac4Jp8w==
X-Received: by 2002:a05:600c:358f:b0:439:9a5a:d3bb with SMTP id 5b1f17b1804b1-442f20bae5amr175275e9.2.1747154640856;
        Tue, 13 May 2025 09:44:00 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-140-39.dynamic.sbb.rs. [94.189.140.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c7bsm176462675e9.4.2025.05.13.09.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 09:43:59 -0700 (PDT)
Message-ID: <53a86990-0aa5-4816-a252-43287f3451b8@gmail.com>
Date: Tue, 13 May 2025 18:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/1] kasan: Avoid sleepable page allocation from atomic
 context
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Daniel Axtens <dja@axtens.net>,
 Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1747149155.git.agordeev@linux.ibm.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <cover.1747149155.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/25 5:21 PM, Alexander Gordeev wrote:
> Hi All,
> 
> Chages since v7:
> - drop "unnecessary free pages" optimization
> - fix error path page leak
> 
> Chages since v6:
> - do not unnecessary free pages across iterations
> 


Have you looked at boot failure report from kernel test robot ?
https://lkml.kernel.org/r/202505121313.806a632c-lkp@intel.com

I think the report is for v6 version, but I don't see evidence that it was
addressed, so the v8 is probably affected as well?


> Chages since v5:
> - full error message included into commit description
> 
> Chages since v4:
> - unused pages leak is avoided
> 
> Chages since v3:
> - pfn_to_virt() changed to page_to_virt() due to compile error
> 
> Chages since v2:
> - page allocation moved out of the atomic context
> 
> Chages since v1:
> - Fixes: and -stable tags added to the patch description
> 
> Thanks!
> 
> Alexander Gordeev (1):
>   kasan: Avoid sleepable page allocation from atomic context
> 
>  mm/kasan/shadow.c | 77 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 63 insertions(+), 14 deletions(-)
> 

