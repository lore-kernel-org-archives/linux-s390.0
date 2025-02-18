Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC2236A6B
	for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2025 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874736; cv=none; b=pPJDeO1tlikDxAtP5Sw+MKckre7vymeVw/5KaVg8Y44AFfapHX035q3cBORno2skSqxnNnQzRo9Kk+l5TCXxSDg4lpjU7KwZw+jXGZLBmdbUqVaVDRw+skCEoDjdnpPYeY0xfcif+QKjBo1PuoKp9S60mReFz7x/I329yJsWLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874736; c=relaxed/simple;
	bh=xTTAepB4hSls510JUC4iYlnWF+VYDHsdbUHpJ3Xebks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QboR6I+NekjzIPymTgR4Y8JAnpo+gJUBJNpMbeco8kOjqmz8r7Y+rsyii09iYCwkG0cCvjsOqAz2hE9tN9+rvsp/dehmOGy+OQom25n4KSI3Z3OD5Nm28Kat1fmVifmU02uSuSRVhKbignIy9LlLbD5VVUeuqm2pQs4FiizS858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gf5oTWV/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gf5oTWV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6qQSUzHgCyxJavo98b2ypHiPRZXpN9/8Rj9BOTux8BQ=;
	b=Gf5oTWV/KTLrXTa7ISFFgtx6XCokoKOupi8BIFKBtl57mVBYjuMTCzrguEJOaAHFlyzfBN
	3PDCFV9oh26uv2z8Tr54daaroeJP+1LFLWvaGQj30GVuUIMxRa9r9Jc0W8zgTTROGflNm1
	MmQpOUUYxIBechHMJQz0QQrIrkTk+9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-T_2ADL0FM_6TYi2mkzLvlA-1; Tue, 18 Feb 2025 05:32:11 -0500
X-MC-Unique: T_2ADL0FM_6TYi2mkzLvlA-1
X-Mimecast-MFC-AGG-ID: T_2ADL0FM_6TYi2mkzLvlA_1739874730
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f36fcf4b3so1854538f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2025 02:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874730; x=1740479530;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6qQSUzHgCyxJavo98b2ypHiPRZXpN9/8Rj9BOTux8BQ=;
        b=ZNsWQaFNWeX6nEG0QflfrwrXdF+ghFojRbPt4LQCmWTHPEyOeJvL7bvJ3n724VH2ft
         EMHsS5J7spHOtHsu6//ywVWET4jc+p4mQmyFUR7px72VvH19+G/TGYFRoz4R7MxHwQSm
         OqqbiUcLyCzYolfmj0yO0+5yPVMRzJKKlR+/b4YZhIWs2HP48kHTm4ZXgomSx4s16HW9
         vS3euYnPfa038FkfdGusGWUGEx50z3t/G2U5SbLOa35RX7dqr8qRMdgKkbjkrQlVJiBB
         3SCR0N5F7pBU/YRz7Ks7ylfdOxPfhjOCvyj2tAvKZ0EINS6XZpr1Krb7XwZoRxZ5ZH4k
         MTyA==
X-Forwarded-Encrypted: i=1; AJvYcCUDESyI0oSw8njT9vSvzF7ycem4W/c6sVxY2+IGZ/A+gSDN6uJwm6jFoXkIs659BMvhFe+LkuSMXWZV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/IeO8HC1kgUD5qdoh5/C5DEjVi/DyHLXOLIoeaBHsR+xsMac
	b9dnSKmy2t6hSq5/su9/Ba4f62Ky/a6F0yaOsm44BiF0IMA+os4tDAAZ3Vo3VFDu1ZADvkTTSqK
	FcFjpLO6bjCGTlD5ekCG0y26vMbD9BDZO1s3U12Il/irufII86OJdKeXMpMw=
X-Gm-Gg: ASbGncs1LqhwgCilYrZyEodOu9bbAY5C31j0qLRSjKbbVWQcK7KX3Vi06IySeUlR2Hx
	dun+4s7LWsxU5SzthaUUGhWEKdvw+wUTbpC8kk5/BVTzTAw9xd8SFkdCAfWwcftbULIqwztYb7X
	bDq4fkTUFf7EKXpx9NQVVWgxnaW795VJpDhfqW98jM1o7wDspQUIFdZDEmEFZUeMCq14QVBquJG
	VrcHp8n0Z6UzvyWyFr+FsjcoYAObcC62PLevhfgb7f3NchWuzeYRifKwsXsKFYxlARD1MyAAnbl
	19y24rGR8YVYloD6sOvOMX77UdtiuDyQ0Nc4VTHrdJb4fJJd8jygX8jABHeT8Ebi7ojeJzLlcGK
	fbF84805+h3dku917vcyvRBu0788XrxpJ
X-Received: by 2002:a5d:5888:0:b0:38f:287a:43e2 with SMTP id ffacd0b85a97d-38f33f11a6amr10019564f8f.11.1739874729868;
        Tue, 18 Feb 2025 02:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHcoLtTGItTBQVw2jJchMRekN6vG0iQZFBlCtfZJTgat4RtCXNKhMX84MbQAT4tMgdFIp+iA==
X-Received: by 2002:a5d:5888:0:b0:38f:287a:43e2 with SMTP id ffacd0b85a97d-38f33f11a6amr10019525f8f.11.1739874729381;
        Tue, 18 Feb 2025 02:32:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d94acsm14844177f8f.75.2025.02.18.02.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:32:09 -0800 (PST)
Message-ID: <d3f1692f-3e80-495e-a39d-fc665732e0d6@redhat.com>
Date: Tue, 18 Feb 2025 11:32:07 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: Introduce a common definition of mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-3-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217190836.435039-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 20:08, Matthew Wilcox (Oracle) wrote:
> Most architectures simply call pfn_pte().  Centralise that as the normal
> definition and remove the definition of mk_pte() from the architectures
> which have either that exact definition or something similar.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

