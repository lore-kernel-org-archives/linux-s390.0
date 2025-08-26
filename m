Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B12C0272
	for <linux-s390@vger.kernel.org>; Tue, 26 Aug 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210599; cv=none; b=rB3c5C/6UWN5ZUJK9oZ3h+v6dNxny5K43OcImtGd3zquT1tYDmubt/rcYbQBX9FnUHx6+DaVQYl90tY3M0qwOjnSeU7suh8fL84em4fTxJygVGgmV5ZLV9GEO4whRzjTwg3zQJnKDU1nOs97pEEjHrYs1ATgiFtS7B+FCrM9YOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210599; c=relaxed/simple;
	bh=/kBnjHicWLRIMWZ5D1z8Ghfc30Q8BGyIoEzgG5YmKrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj22BQgsiGZLMSFfiHrK5KbC13L9XzLZQRARZcQjlKDexw+xYUM9sL49bnUjHpfmDBHjG1k63ovyGdAY3SZvDpBW1TZzeBEw6NawptvHQVbgplCbHJXTSs/cTeSvsV4HgE5CBRuDbzzMoKlEjEJULkCUcuLzmC5AI1SfVZuvkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgUPSRj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgUPSRj3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756210596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=diVEa1Cfz6ig0T6TvL360ugfmN6YpEKzRLn9DgHizSM=;
	b=TgUPSRj3Mn3qrkr+jYz1C+joq5vreRSIHtW1dbhpLDka7I81jm2OXw5RSOYA896lcKtkmA
	StFYvWSs4Nf6MuTyEsBIcUsCQOUvz5wa8McdBm8yADi9mn216GAOs76qvvBFZsHs/ijSQx
	K0FJgRbawY6y7AQpkjQj77XRI4wR2Pk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-xOQyim-_P8CGXQVGGAlzBg-1; Tue, 26 Aug 2025 08:16:35 -0400
X-MC-Unique: xOQyim-_P8CGXQVGGAlzBg-1
X-Mimecast-MFC-AGG-ID: xOQyim-_P8CGXQVGGAlzBg_1756210594
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3c7d6923834so1895986f8f.2
        for <linux-s390@vger.kernel.org>; Tue, 26 Aug 2025 05:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210594; x=1756815394;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diVEa1Cfz6ig0T6TvL360ugfmN6YpEKzRLn9DgHizSM=;
        b=YWdVtxCZhxX3OLVr0ZICqSJfV5itHiKEqZ1cRJVfGHAwyAZgUj/yTPUkmj0M9xabyJ
         Yy9Ott+f15y10L3gR4Uhr0yHYJId9acEbI6h/v0iUY7SF94WQ64pzaGvHo1yaZWdQS1Y
         yDQc9kUold+KZz2m8h2fetSXiYDG0tztlr5p3tyV++GHxhX1UD7Ifq1xVyC2OVM0cPd9
         5Hnhtrqzf4fsfvdXBPnk/e+3EfAx3UBdwfZZBTOBUc2JkRYDX0UpYS6+Z1ZLfOIyqtej
         KSY+TmrbFuc8wEWiTtCxgv9d7TQgBaSo5ep84BPm/yLFFqYpUjS5YVFCPLs0vW/3y0rq
         +Ocw==
X-Forwarded-Encrypted: i=1; AJvYcCVayMvGmpjCKtnhrIVrtQwXMuyN7ZYNUcWLNC+e1IcgdZyUqDvWdq/XlExK/VMNVBeEwHa0VX/i8UKI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf08qR24tP7+ewVsJEBPiHxzm7jC5l5T/kfi4cNiWx8bFY76xF
	dHI5NFuLiy2w53npF5Rq8f19sKxgDIuoSkWqH3LOdIqdlq3fim65pDVSg1vTvEKLOuuHTX0gYMn
	ZTG8Mn99tW9IUs12g9rK06iMENRORICnpd0FvdQFTxjdxUR4tarE/rq/pMimaEXc=
X-Gm-Gg: ASbGncvRd2HPL1EOS9lb6lEmP112K01rhGbSWSJtSJy7S5+z7dORbqQEhViy1F7CpdS
	+nutQKYjn52tICnYRjUcA7KovefEXBBOYt71uVVhrRGuDFZXzRLMF0rzIgfbHHQpxq3GSdNaqi/
	w5N83zbukH4+96erdNA3kDpvkRm/c27ei89sRIgq2GzdPQVHl4JQb8LItq2rJzIfB3GLlkJklxg
	0G+VgJWofhexDAZwtGclNKnyPLWmulQjgGI2tprhwg5K6+w5rv+iSjJ9DF799B+nmUqFF8rktN2
	R5owax1iGIpVpYzBRWFm0LEbcNuDXLc+tk2mtOIh5bWm+9Cr4N25FhqZOo95DliPOKM9a8Ec+xh
	Ggz2P
X-Received: by 2002:a05:6000:24c2:b0:3ca:43ce:8a60 with SMTP id ffacd0b85a97d-3ca43ce8debmr4253734f8f.56.1756210594138;
        Tue, 26 Aug 2025 05:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1vwwLGJx7vZzx6yCM2iOBpq2l97oe5wYAIVyLlq0crxa3xO3y2zxEx14ezkHOG7wMX3UUCg==
X-Received: by 2002:a05:6000:24c2:b0:3ca:43ce:8a60 with SMTP id ffacd0b85a97d-3ca43ce8debmr4253693f8f.56.1756210593333;
        Tue, 26 Aug 2025 05:16:33 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-247.pools.arcor-ip.net. [47.64.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711d9f3a8sm15987904f8f.62.2025.08.26.05.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 05:16:32 -0700 (PDT)
Message-ID: <c9fe5d6e-c280-4480-a522-a99fa5ce7cb2@redhat.com>
Date: Tue, 26 Aug 2025 14:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: Fix access to unavailable adapter indicator
 pages during postcopy
To: Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821152309.847187-1-thuth@redhat.com>
 <d91ed0a4-16b2-417d-9b44-6e0d629f65d0@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d91ed0a4-16b2-417d-9b44-6e0d629f65d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2025 13.43, Janosch Frank wrote:
> On 8/21/25 5:23 PM, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> When you run a KVM guest with vhost-net and migrate that guest to
>> another host, and you immediately enable postcopy after starting the
>> migration, there is a big chance that the network connection of the
>> guest won't work anymore on the destination side after the migration.
> 
> Do we want to add this?
> 
> Fixes: f65470661f36 ("KVM: s390/interrupt: do not pin adapter interrupt pages")

Yes, that sounds like a good idea, please add it when picking up the patch!

  Thanks,
   Thomas

