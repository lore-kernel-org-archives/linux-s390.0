Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A3346E4A
	for <linux-s390@vger.kernel.org>; Tue, 13 Jan 2026 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300850; cv=none; b=tH0GkIHP9XitBoJRrFw1mDqXhJ1gndjZeRFjxO4uDZilbWQyoIdqYTRU7D2kf8jso4iErBi0q/E9cNBqt8S/KmO9h3XFlDTthmGg6EKIJtPhNUG3HtxKjJyEam6sQcLNeKVD0yAPbcq5Afh9NLslj5LtvRFhWOxncdoOuQAjrrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300850; c=relaxed/simple;
	bh=39NtxAeqpXvhawaLycQSgS8a7QXmm9U/xmb9EyW+PGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pzYOdMrZ56a+5DB/8f5Ozdc/qVXkZX3F3zurPkPlILkcaCdlsE31HoHoCkljdUG6RxnPTDMn99UqVdo+SKnIyWJ8M8u0w/uL3Ew3qen4ggGb+mnx9ET9w6JtnlrH3kmJqqHzfKwvITQldWG5OU20/Ad4phH65Dg7m8PYou+CBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6B0t7vV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6B0t7vV"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so4221546e87.3
        for <linux-s390@vger.kernel.org>; Tue, 13 Jan 2026 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768300847; x=1768905647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=K6B0t7vVWi+IPqkNxrE0Q+lM2nEUOT1nMFKeHSGvCpmYJu3FIjvgouEYlHMV/8tOqv
         ijwCSSGCu5MdCLP+GPLmevsG/BhKvYXzFgSyAkRFx+9bkfDktZaN53EzFWgcLNQ+hOWl
         uiPTM2cm6hAkQjGW1VMmjd7yhuUBhZtbNaTdhGcYiUGVEOofz6W6OZPypEwJVEN7HeWl
         Xyon31eFIJGpmPmi9po/+wVcXGGieDHjwIAY+4bQvboECMHs33xs7WSgBtiFgWOx3Wqs
         Nypm8Ur15yw78mbkfL+I2sIneO0tTKnxOHwYrGoqjqdPB3ht2oDLH/7TSnizNL4hkpxa
         1MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300847; x=1768905647;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=HU/A7lJGulB0PHUVsGuoQG1SsaFyDC2up/XdWYHX4Yc9O5y5NM6fQe9JouZJfx7wWw
         eLcDCAGkH5J8AOm8Ll3IBBAZg8h+0clw49MHumZu5X555xSfr2eUg6MlAdIfwVqXC5O0
         kXy9F+st9srZc8Z2ARc3tva1nPqH/OWAL7WIjOXEfbuQZMgiB/f2kbdB9lkPaGd31sP3
         sotWibhw8KUWF7Nj5K9OiiSjHkuZ0SGgg4wZCk+OMB5ZhxNejdgfzdiS3a0jxQq56pFy
         vPgSWDlleBlZh6fxTHBHY9c2sdNdApHwGi8aZ+1NadP3h/vfjHqXBet/+h1m2LK0A4QK
         de4A==
X-Forwarded-Encrypted: i=1; AJvYcCXYlhIZNGUqWTpDdGTaj9ASFGWRI5VxziDqsQlHP3gRlY0kgHOOEoNINDlF56vP5P/meIl7kdPkKu5p@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYLbwdHn+9TVlHbzj/Ncwt8O84VsjghhgfrICKtECg1z8+iVc
	plgWRT3YnK/ZE7kUHFMv/XrGbXZ9ZDyk2nBz5LLY76rnSXuX6Sc6MKEt/CFPKQ==
X-Gm-Gg: AY/fxX6LHb/gQDKgBb6rEwnauTtQnDQVueFykOKdhwogit0jBUsA/k1OWiv8Wtxyx9/
	FeaKh385PruoKvGHicJLTJ1dfzANOzEjad4snl3PvpkWBZDdhrDPoNcv1VKlaqnYQ5G30qqqvQa
	fHYipHFTRf93sK6+WctUBlO7Wnd5mdR9knq0XFUmVVd7taWCw2YK7VqT+paLJQglBoxsqM1o7ux
	i1+Al4A7iC8LsG7eGVIvlMuiNhwvEqpMntKjZAQMbHnnvZcXf+he5xd+EqeJRRZAP3YH/eZCQDI
	yxc1DtWTPv9JtvauJ4heMOKsrX+nC1h+P3dFICgXZjrg+JDiVeymLZyfpK6JvjyPPDJExk9oD20
	iNrBvuPTGH/A97dvEZvleKJC180QsE9F33PbgUtB5sbexytCen6YRkWD0SZMhRTEV++6gDdmOwk
	Iby9BfsB56DO+HgnRFphR3G+8GLADbLNorqhiIft89q7zWKzNMlVj1IW3dsA==
X-Google-Smtp-Source: AGHT+IEOoK2sWcGzQ5k4NJjsFR/RmdeWAB9vvZrFfNJ0u+S6dsEFK74/fdYnqiqEV2XmHMt6sJ390w==
X-Received: by 2002:a05:6512:138b:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59b6ef05760mr8236951e87.11.1768293628066;
        Tue, 13 Jan 2026 00:40:28 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72f3ae82sm4416299e87.71.2026.01.13.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:27 -0800 (PST)
Message-ID: <f861a1c6-7ec7-477c-bc42-f9aaf6724bed@gmail.com>
Date: Tue, 13 Jan 2026 10:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
From: Kalle Niemi <kaleposti@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
 <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Language: en-US
In-Reply-To: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/26 08:50, Kalle Niemi wrote:
> On 1/13/26 00:23, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>>
>>> v3 changes:
>>> * fix empty_zero_page initialization on arm
>>> * fix ZONE_DMA limit calculation on powerpc
>>> * add Acks
>>
>> updated, thanks.  I'll suppress the ensuing email flood.
>>
>> Kalle, can you please retest sometime, see if the BeagleBone Black boot
>> failure was fixed?
>>
>> Seems we haven't heard back from rmk regarding
>> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.
> 
> Hello!
> 
> I will test this v3 patch ASAP and reply results here.
> Collective sorry for the delay; I have been busy!
> 
> BR
> Kalle

Hello!

I tried this patch by cloning 
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=hugetlb-init/v3

Boots succesfully on BeagleBone Black!

BR
Kalle
