Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC7189B91
	for <linux-s390@vger.kernel.org>; Thu,  8 Aug 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107303; cv=none; b=Jb0JOLWWBBXW6fi1ErxTa8os+lnGC/ghUMKNyUW3DXdSdKMU0/lV/EqAIaXIj4XpJQYrIsgX9/lgkQE4Kvh1lbjU/zIi9fF0G9rTayPEhHgFOpQyh7+oIxZvbKsXVWkbMe2tC1s4qVsgfdrl7VGgOS8JdN3RgEbCx02m+NdssPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107303; c=relaxed/simple;
	bh=Pxahy6iUvY7n/CLezrw1W09oQqwmaHW5JLJ4oogkeVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQ2Wmftps3SmQJ/GEsRMAftVlrWHV3YGsfnmkEyEmjnXqlwkTOt1+Y1idiQ6Bcf8snBC4hzS2JLlg0tkbuXrlGLD16t2PksdOayRy1jCOk/BKWKRxsmPr1euxxDgWyL+UPsBB7vyUAtaFrXPJGP8RPB4MdGhxgKXEkPJ0mAmF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bu9hCZMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bu9hCZMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723107301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TO+jRK5eg1OWh9P0K5lVYVBuVfKPLI3714nfLwy4wUM=;
	b=bu9hCZMHJ1IstV/wvbFcTPPDoDHerrrIP3T48wrGwIaPf9Ev2QPnZl8yW7j/Efc4VmEa9x
	yEfO/TKrWhvxWhD1rWHA27KtrRjpYLaBosBkBh++Ab9u2dsw/qD5JGr+4E7NFZpa74hL1J
	p0DgqEvKFsBJwPKmsx/aoFQZDCIych8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-nhxCNGipOKesle1AvcbDIQ-1; Thu, 08 Aug 2024 04:54:59 -0400
X-MC-Unique: nhxCNGipOKesle1AvcbDIQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f01bd7ad5eso7486761fa.2
        for <linux-s390@vger.kernel.org>; Thu, 08 Aug 2024 01:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723107298; x=1723712098;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TO+jRK5eg1OWh9P0K5lVYVBuVfKPLI3714nfLwy4wUM=;
        b=NewzCCcoFzlhaN0MY84/zEpsdgsmLLG407bJTcCR111vSQxZEONDGcKAISxP+X5Kpo
         G+stF+V10UfdmB8h0SZSYdWsojuAqw6rVdKsPdxH1CvfiFMvealFhpsBKOBsWuv+nAap
         WPVG7/CzQBb08yQ5h8zGPUOsCih4YAlek+dHPZTFKJlAivGGZ8Mmhi+frRwfG+wX0Cc0
         3dQJMQLQ6O1zAw/SWWF767W1s8CGdVbb4sVBUX8BqSxEKbMeqIxY6K1ghTAywym4zSZu
         eFkIwb47fpCxHAaTLP8zfV5Zt9T/wPEe6BsqodaL0PiIAZT7J5IrUyZmSvAUBnHQgL0l
         XIVg==
X-Gm-Message-State: AOJu0YzZ2SSUtdypf7K/62H5+IA+KNKG1ha1HN7cBDdOSNEt7i23LVQh
	MkE3hQnQk964alinIE4kmT2OtzbMaYkXWHbfmHSDgAV3bIPhO5jVT1vjkytylVMwR0KTUlhEJPI
	64gCKtoY9E7ZxCoV1sJq0BMS9XP1vAVDjK5jxxB15ptIMW78R2xe9l52X5Gk=
X-Received: by 2002:a05:651c:507:b0:2f1:5c89:c893 with SMTP id 38308e7fff4ca-2f19de1f9cemr9704191fa.8.1723107297890;
        Thu, 08 Aug 2024 01:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4GAw5rwtZdnh63x1TzyVv+ysO4WvgpNlzmxUtVXMoR6S1Gs/hccdSnGEyfpPDZSLdX0vL2w==
X-Received: by 2002:a05:651c:507:b0:2f1:5c89:c893 with SMTP id 38308e7fff4ca-2f19de1f9cemr9703971fa.8.1723107297359;
        Thu, 08 Aug 2024 01:54:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a1b3dsm12083785e9.40.2024.08.08.01.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:54:56 -0700 (PDT)
Message-ID: <9de985bb-31e0-4169-b851-ca9ca552dab6@redhat.com>
Date: Thu, 8 Aug 2024 10:54:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] s390/mm: get estimated free pages by memblock api
To: Wei Yang <richard.weiyang@gmail.com>, agordeev@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, rppt@kernel.org,
 akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240808001415.6298-1-richard.weiyang@gmail.com>
 <20240808001415.6298-3-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808001415.6298-3-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 02:14, Wei Yang wrote:
> Instead of getting estimated free pages from memblock directly, we have
> introduced an API, memblock_estimated_nr_free_pages(), which is more
> friendly for users.
> 
> Just replace it with new API, no functional change.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mike Rapoport (IBM) <rppt@kernel.org>
> CC: David Hildenbrand <david@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

