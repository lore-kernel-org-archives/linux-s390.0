Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D23009CB
	for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733608; cv=none; b=HsdGLEUUJ/fzNfdSvJxCm6Za2o3mZP2rujiGINP3z6YXquHIT3N0jB8UkjP8OAepFCEUIrCfEAWQbXOo2VtvurCzJcDAfOAY86xK2ACPtRxNl25agmB7FLkpDEK6+d68y7+9iFms4Hlx5AzqdXxZgiMgsYqR13WTKlT5qejeAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733608; c=relaxed/simple;
	bh=zkE0vyis83Qnd4j3qFtBbD4uxT5fDgXxEKk32YXAR1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMP52+mkiVeYZ10804GuwZgaspPxZCWeOoljaSShoF2S8OHQoJy8r7alHB1TmD2ITzFkj37PdacvwfHQobtRQwHIgXPJWddVa3mg7vHO90L5P+Zci794MtGWVVx3BqiLTixxKtj1n3Ma6wHmYIZgPIkheKck91SwBBgGRg3xIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnncW+AO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnncW+AO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761733606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/l/eBTg6PDk2gq24yxrQmlGvSlksP+1NRV8KnJwBP8E=;
	b=cnncW+AON+djwLkCGRV01SWIpFPM/uefZqgxtKSyfKIdwhdN2cEMX5WYCgx9cWmbY//jV0
	aPxQfs0D+r5sOG5glob+B5YMFQLOI6VfJZw/5nsCWh3cW2TILgfBEDWjLQrBC3S0cq1RoZ
	2mDCh4qfsQy9PIfuMEbjTEw8m8Mq/hE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-FSYbmvMpOuSLIURo1ISciA-1; Wed, 29 Oct 2025 06:26:45 -0400
X-MC-Unique: FSYbmvMpOuSLIURo1ISciA-1
X-Mimecast-MFC-AGG-ID: FSYbmvMpOuSLIURo1ISciA_1761733604
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475da25c4c4so24165445e9.0
        for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 03:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733604; x=1762338404;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/l/eBTg6PDk2gq24yxrQmlGvSlksP+1NRV8KnJwBP8E=;
        b=oQsrqFRyZVezRa+RiLyr6EW1cbQCJvw+Ie8ZIM3nU17sh7i1xel4dx8rSyPunM+nFr
         b7mFAUTMPP5rTJZioZXoEvOe/5h4WEQ/mrS5QlykC8F4o3AR17qTu/59oFpcFag0ifcM
         Db2U07PNCWB8znBa7hjh2GjEPNOxU9o9hLNKMiiwHGZ/tA6xS86+5TWNVI1a37iX8xZx
         HJ6BV7zl2iHYu5q2fsWK6d5deDKxi6dmRmYX/KCft+pXrFd0FMFi5AWRCw6m/1LI9pL1
         q0cQgLuHodXQHkETEQUbJCh2wvffXxT/3LHknCzy05jDaAVPI6EWK4b5649zWmOyO53w
         gpAA==
X-Forwarded-Encrypted: i=1; AJvYcCUz05ENLyCIxR753qIshOhYopb2vhgEDK/kKn4fdfaOkk2ULf+yPN/9f4B3RxVHbpltzp1osMJo0nbI@vger.kernel.org
X-Gm-Message-State: AOJu0YxknWy9bQlBvucX7agA/2mxm+1YaYUnWICrmFC2laOk/68CosTQ
	fHBNbrQLexhTePV6mwu8mIZ8iZOVURnx8rVVJzD6NYWs50j/ia9EP9L3xMaIC/MTEzBxIUOy9Pv
	iNzNVz4/ko1ZfRmAXqvI3AsxY9+sLLvziLWpg+zShcurVb3eJgyivSYYYtY0LE6w=
X-Gm-Gg: ASbGncu/E5O5iAGc/zMbDsldu6zLde9vua/2UFHv5JpfhBQZ7srAiTePw09wlkKDmPQ
	+zaKZQWIAuSKwwtpGXPIlP4ztKJ2+CamuFkn38MK7+u1q3R0arA8QMa1eBtea+iCzljTopj+3Vw
	nZStBe6YbhKgCGjGKyhtdah+6c/6rL3FO/T5yYu/onvS5MVQ1h5DgvtUftn5nBfkZFaqSqY6YD5
	rnAHetWZAvVrKryLWMH5oHcU/BfppxGYB6sOleCseV6Z+jTFyn0lXaj2DjNHZccoDceYUg6H+bL
	8AQyOTG6nJzzoFJ1ZMrt+VtP/nxXo4MR/WhgssijEbjeznAzsJPGJ83/Ngexf+16PAMj3aM1ych
	PNEskKGUQ6K50B9Ky1B1K9A==
X-Received: by 2002:a05:600c:4591:b0:471:115e:624b with SMTP id 5b1f17b1804b1-4771e18cc1fmr23359075e9.17.1761733603664;
        Wed, 29 Oct 2025 03:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtQTrCoapOr6bX5uVmtmRqcuUC4lYBRzIXvtaTPDducTLRlHN+f7pxZPgextJafstOMsxSuw==
X-Received: by 2002:a05:600c:4591:b0:471:115e:624b with SMTP id 5b1f17b1804b1-4771e18cc1fmr23358735e9.17.1761733603198;
        Wed, 29 Oct 2025 03:26:43 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e202093sm43202745e9.11.2025.10.29.03.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:26:41 -0700 (PDT)
Message-ID: <c6f8871a-5118-4947-9801-43b2a7a42993@redhat.com>
Date: Wed, 29 Oct 2025 11:26:39 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Optimize code generation during context
To: Xie Yuanbin <qq570070308@gmail.com>, riel@surriel.com,
 linux@armlinux.org.uk, mathieu.desnoyers@efficios.com, paulmck@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
 andreas@gaisler.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, anna-maria@linutronix.de,
 frederic@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, thuth@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 segher@kernel.crashing.org, ryan.roberts@arm.com, max.kellermann@ionos.com,
 urezki@gmail.com, nysal@linux.ibm.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, will@kernel.org
References: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
 <20251025173700.754-1-qq570070308@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251025173700.754-1-qq570070308@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.10.25 19:37, Xie Yuanbin wrote:
> On Fri, 24 Oct 2025 17:36:06 -0400, Rik van Riel wrote:
>> Also, what kind of performance improvement
>> have you measured with these changes?
> 
> When I debugged performance issues before, I used the company's equipment.
> I could only observe the macro business performance data, but not the
> specific scheduling time. Today I did some testing using my devices,
> and the testing logic is as follows:
> ```
> -	return finish_task_switch(prev);
> +	start_time = rdtsc();
> +	barrier();
> +	rq = finish_task_switch(prev);
> +	barrier();
> +	end_time = rdtsc;
> +	return rq;
> ```
> 
> The test data is as follows:
> 1. mitigations Off, without patches: 13.5 - 13.7
> 2. mitigations Off, with patches: 13.5 - 13.7
> 3. mitigations On, without patches: 23.3 - 23.6
> 4. mitigations On, with patches: 16.6 - 16.8

Such numbers absolutely have to be part of the relevant patches / cover 
letter to show that the compiler is not actually smart enough to make a 
good decision.

Having that said, sometimes it helps to understand "why" the compiler 
does a bad job, and try to tackle that instead.

For example, compilers will not inline functions that might be too big 
(there is a compiler tunable), factoring out slow-paths etc could help 
to convince the compiler to do the right thing.

Of course, it's not always possible, and sometimes we just now that we 
always want to inline.

-- 
Cheers

David / dhildenb

