Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0310C15E5BB
	for <linux-s390@vger.kernel.org>; Mon, 30 Dec 2024 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534908; cv=none; b=o022zFWZvRXoy44ILAkH31Is0HFIOOoKB41ywWxfUe8DGaUW3iELfCkkV28PInNflv6DKZLsezvcPQpJS+IPaqKiBm7NP2au/rxvMXxLuixxfcoE48bJGbZ42phax6Nxx8nktH4lbLjlyRgSgRBmYTP/1ZiPH5KMBPsiZCNwGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534908; c=relaxed/simple;
	bh=piyHCVVAMwS1wQEyd4KrwKqNTu7KlhnDsmo79+H7v/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mA8y5wpVW01zNDKueuaSoSWA33ibUqc3ZDe9CArtCsCEYlDzxhc3n/pifQiMWkMzRWZUWeRJQgesS0jDcjlMQ25Qm9UGZxgSBdwqfKFJ9c+DwcKacyETznqIWKrEAryn5tm56Pbb9WdTYwDp4w0lBJdHiIB6BlIw7VZrGdrLPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AVwYCuks; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AVwYCuks"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21644aca3a0so14771015ad.3
        for <linux-s390@vger.kernel.org>; Sun, 29 Dec 2024 21:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735534904; x=1736139704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=;
        b=AVwYCuksyL4MWKNaOrcPqCsZHjP15dUO7Ft7whW/+MGucPq2CCF41ayT8HETt/nEMO
         INyXiKOGq8dtgD/nwAjk5Uvbn/UNo6jLG8qZLyqXrnJTAdRzC7Kamk4u5TtkyRp8o3/A
         +1Rvh7mPtO96ubOzkKZmD+51Gvtwp7vYJNHB3SEvUmi7l+9dL+Z3crf/xHOccAuBwsfd
         k1c3oolBT037qU5KPaOm4MllAPqW3k8jlJDhTFXsAr7VPyZz5sI+gBdqLOmCO810bvI/
         2VnuL99Nd7JF3vQY+V7vuf4tXweQBDZ0VLv7S4ip/DrVWjK5G//bmm3zSbnYRAqLIFvz
         XWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735534904; x=1736139704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=;
        b=Po/YlL603zgEuip+gMxcMiXzlM2i2UM3Mp283jD+H/LfshXqxMtImCqn1vgCeQpJ0Y
         mE427aYDkWF6Co0ID77uxNbQd3PSGfykSkee9392PtRwCpGNWBLdnFutRt7EcqWAmvVV
         7FvrCN6+oV1ONBk8CLQ6kHPaI7s0v4LVc7eZ2CkrmW9j4PRb+2ofOKT2N5GLlYsXhXce
         HC1DW3qQhz6J4HgaYdgtDL1AZgesWhaCUoXjLM0Neq2ky/AxE8cF9Bqa1buMuILe3c1i
         YyIqJmG/MQjcAnqfE7lM6Q1MvajgCg3nUlUCwNVqhNbfR3HCEVMjD1IB+KTTySaAYA8y
         ofhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL7/vtfpSZUkn0v5pZg7A65io8SZ5lQCndh+uug5285tYpqplQfqoJp+vs9Z2/RSyOd6G4wag1SMTt@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyNVLmfRmH8YMMnJDD3YuxVTaWsWTWjdcDtz+kscd/T6/kWyM
	FVdsn8oXlxZ1QgWZygtTFCt2EjIAdX3sKuLiPAqD3wRAdsdwCSerp8WNx9GW0RY=
X-Gm-Gg: ASbGncvlRO2InAbcF0UbgduRWD34T9X1oJonpCc0x8s4vEqQHM1Zitxb4Bq3mqLQamh
	TpZwG298jRRjZsjbkbWYS+27lwo3QsBzKdNryfmeIX4ke6ipW71E8MlPXej9z2wm9li1zkx2a+u
	4YEqBMB7IbZengxojku1b6QclyrA8GWExRSw+P7i8e++YVPND/0bm/4VP1tPSuiy8Cot8HbOyHs
	geSt7AsyLFeWMDf+wgDrCEtCtJ2fiYp7F/pRfYGIa/pKiYYUG+AgaZEht2VaTs69GkyrNtp1i4i
	mZMIzg==
X-Google-Smtp-Source: AGHT+IGNJA4bVLowcqsTNcTKWXSt9C1oo/1EXH42Qr0z5K3kcPv3AzGfuER3K4niOaxH4y3G0nd6hA==
X-Received: by 2002:a17:902:ce86:b0:215:a57e:88e7 with SMTP id d9443c01a7336-219e6e89215mr362710865ad.3.1735534904325;
        Sun, 29 Dec 2024 21:01:44 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba7325csm16914771a12.7.2024.12.29.21.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 21:01:43 -0800 (PST)
Message-ID: <efd81018-f637-4925-9104-c9586fef688c@bytedance.com>
Date: Mon, 30 Dec 2024 13:01:29 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, kevin.brodsky@arm.com,
 peterz@infradead.org, agordeev@linux.ibm.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
 <Z2_EPmOTUHhcBegW@kernel.org>
 <9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
 <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2024/12/30 12:55, Andrew Morton wrote:
> On Mon, 30 Dec 2024 11:12:00 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>> For now struct ptdesc overlaps struct page, but the goal is to have them
>>> separate and always operate on struct ptdesc when working with page tables.
>>
>> OK, so tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are somewhat
>> intermediate products of the project.
>>
>> Hi Andrew, can you help remove [PATCH v3 15/17], [PATCH v3 16/17] and
>> [PATCH v3 17/17] from the mm-unstable branch?
>>
>> For [PATCH v3 17/17], I can send it separately later, or Kevin Brodsky
>> can help do this in his patch series. ;)
> 
> I think it would be best if you were to send a v4 series.  Please
> ensure that the changelogs are appropriately updated to reflect these
> (and any other) changes.

Got it. Will send a v4 ASAP (remove [PATCH v3 15/17] and
[PATCH v3 16/17], keep [PATCH v3 17/17]).

Thanks!

> 
