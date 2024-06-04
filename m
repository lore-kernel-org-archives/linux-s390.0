Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB41419A0
	for <linux-s390@vger.kernel.org>; Tue,  4 Jun 2024 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487646; cv=none; b=cNAGjwthgNh6g8wnlEt6vei5JzB8lzsuhplN4O5kNG5DFMRWipokfGVb+wYGkWrog/RPTdcna9lirgftqnAXl4jn0KV/iwS0CrQ/l2by54/1A0C7bflNrmylD62oLVYZrGWD1SPkHqDhCiUTD4yYILhkj9eoFrmRnAZbJS6jpss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487646; c=relaxed/simple;
	bh=Mn8Xo/wTKP2ugCgYK+UKLIJqA94nE6aPZb+pX+GxmxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhegOnnmWVrxIIYtIbjBRM5+8pn2mkZmmvooXasJ8hiEU/kvjGIOfnYBCVEf80nQ31Y8XmnYHPIfucy5NyOY7EohUlOR8uL5wkpSFzfrF8d8Mh526qz9S/pqv3ZiAdUU58jKQfYPzSKVT1Wj4v03+JaLnbqsxOyZ85JFaVoVRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmG5esUc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmG5esUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717487643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vjx0ykS4nJ+697RVcEhJUXV4++oM9wmiHnBblhEdRT0=;
	b=PmG5esUcagtKQm0vD+D/7hXOoPz+V8HeMfI3qyw5Nb/tWQrNCPWxfAY6Mf2dJN8c3y7OjT
	vjLQcyfeuKReBkxI06QigabCVXKOKTqkwaDqJgKjLS4Ifbp8epd5MZ6dfkAYbZVml4syn2
	bxREtgLDQ0PriVfJKqaWsvLHYGOGgYs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-CXl-zA7VOjimaXmZifDv2A-1; Tue, 04 Jun 2024 03:53:49 -0400
X-MC-Unique: CXl-zA7VOjimaXmZifDv2A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35858762c31so1856016f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2024 00:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717487628; x=1718092428;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjx0ykS4nJ+697RVcEhJUXV4++oM9wmiHnBblhEdRT0=;
        b=gcDwdatEfLnUOvqNAcUIr7CaIzdbrlvVTofcP/fTqQP3xj3363exUdnMPm2/VkLzJT
         f+kiGYLIVVIGeEMZzZVShic0trG/dxSCV3j5iu2sk66YeivPv+HJVnSQoOOMHQ+2yuxT
         0twqGVDMkbT7AK4L6ryJrYGMWL12vcOylqi74IgPoh3ldIxhn7feYvcH3RkjcX7Oi824
         ZE5Jh1tH5T551PoAdXKAO2nA30qCFmUIKZaZWzfkuMh7yYFQrCo6MmUMJzwLRBEI75S2
         P2n4T8iELcXDTGCWKQULFpnI5c0vYxWqFRNg/PGIG95/ikludZ9S1oLPaogBLqTQHVa6
         uRrg==
X-Forwarded-Encrypted: i=1; AJvYcCVAbM8YjCO+Rg1CKA6ICIF/tYQMOlGyRyc0f36EFVOFnnw0sm4+axKXonLB0J2/yLaZF9CfQyIvW4zWsiYm2/XkCg0M51kvNmqBLA==
X-Gm-Message-State: AOJu0YxQebvhoojzPI4iwIc0D6FmaIpx/qM/mHSb2hJYC7gapErH940L
	QztpxN9ag0DNe06Qig8HwZUFuLf2LtW7+tM65xV8Ugx+NuXP9G1MFvQ5jd8z1ww5vCgGpD4kHDB
	gPuLP+I5vIpkTn7dubpW65j+sIVpw91jgYjPYU9SwwKs+9clh2Net7b3qhfc=
X-Received: by 2002:a5d:69cd:0:b0:357:16f6:71dc with SMTP id ffacd0b85a97d-35e7c52d9e1mr1553254f8f.13.1717487628720;
        Tue, 04 Jun 2024 00:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/buMjqh/S6XIE3/Gj7KXIbP8ZU5F/ofjLANGt6dwHgExj1IaPc6eVwgDYsQUxonlxF7aukg==
X-Received: by 2002:a5d:69cd:0:b0:357:16f6:71dc with SMTP id ffacd0b85a97d-35e7c52d9e1mr1553224f8f.13.1717487628397;
        Tue, 04 Jun 2024 00:53:48 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-97.web.vodafone.de. [109.43.178.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5e3d1902sm3814122f8f.32.2024.06.04.00.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 00:53:48 -0700 (PDT)
Message-ID: <a9e7ea2d-2737-4f4c-ab38-59349e325dfa@redhat.com>
Date: Tue, 4 Jun 2024 09:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v9 23/31] common/sieve: Use vmalloc.h for
 setup_mmu definition
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Andrew Jones
 <andrew.jones@linux.dev>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, =?UTF-8?Q?Nico_B=C3=B6hr?=
 <nrb@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 linux-s390@vger.kernel.org
References: <20240504122841.1177683-1-npiggin@gmail.com>
 <20240504122841.1177683-24-npiggin@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240504122841.1177683-24-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/05/2024 14.28, Nicholas Piggin wrote:
> There is no good reason to put setup_vm in libcflat.h when it's
> defined in vmalloc.h.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Nico Böhr <nrb@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Acked-by: Andrew Jones <andrew.jones@linux.dev>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---


Reviewed-by: Thomas Huth <thuth@redhat.com>

