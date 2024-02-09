Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4D7F6
	for <linux-s390@vger.kernel.org>; Fri,  9 Feb 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467611; cv=none; b=nTRagiXcwkG0zUyfx0trqYkkdtS/UrVI43dk7YLj4Y2LN4ip105XfHJ9o0A0z9litpXcGKKI+36DMy7pDpGeo8Fehe0pLa15ZKW5wpyalXoBFUqIpLrwk57YQaR/A0QUbygl4FEcGSoGaQUx8MTNZQxGhyzAE4oJJt+85XzTAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467611; c=relaxed/simple;
	bh=3HreAf3C7WSTTW6o9UNHFC8JLdzrORRUrztXIvGrHdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T52azMbp0gFZUmZ4V5z9CJq3pP4k5VSKJv/oelwwoDEnoTeG3nH5dfFDSl81LDBKyZ/Kd8aJCRbFpIIKG0hRzHev06X7ZqmUQsw0P7+b7NDtHWBqhKKtEEt2cKQLlcvj23sQoFhCaLbjAq9V8Ni0FqfrPn1mRCYVDwJFKlBdDMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICwV+yvc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICwV+yvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707467609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lSIosa7H9Vqr6g6wkjLttbFme+deNKcmttLyp+MsKjU=;
	b=ICwV+yvcUZBWzcS1BCc640LhvKZXsSzI3UdqEUc/fBgRcS6uKg7RsXMR9GKer/Jvalx2WC
	ojRGFWioebYNrnjJXei4QN3m/0GbPdkFZioI6aw9/XC5j1sn25sdsmRnXipEOKE1keqJiZ
	h+w5geF9dqWbhS24h4isTSfV3AQgXIg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-1rQQAkCjM4iCtGqgJ4wUZQ-1; Fri, 09 Feb 2024 03:33:28 -0500
X-MC-Unique: 1rQQAkCjM4iCtGqgJ4wUZQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51149500aacso725612e87.0
        for <linux-s390@vger.kernel.org>; Fri, 09 Feb 2024 00:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467304; x=1708072104;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSIosa7H9Vqr6g6wkjLttbFme+deNKcmttLyp+MsKjU=;
        b=r9S92RY/syUcd3q5j7AM/IWS3OyQ1uCcrdIRSZZlXDh1bbpxeo9e9T/As+hQoQ4MfT
         Vk1z6V53CnqcuoDAA4tO72RwWSgOGWS5xBmKDgVqSLndVMvZ0bWC0bQ+Gz2tzckWCWRH
         WbW11za5uWiAOmYzrrGJaEKPfidyp3BFyIQNd3Qzk/aopBVd2h4ZABZa4ritveF8+F7L
         eFTU7N287VxhSmPC71ck/Hk1WVrhHTEUJ5WjpRRPKyJC4Xtifop6CPU8OychuJaWqMw2
         4zN+7TwSRhtUmp5OcwA23k5XiW/9iXNu6pP6mqPB7BUrI9ZtXTQLPKY1iqOXjV9okoJJ
         9RRg==
X-Gm-Message-State: AOJu0Yy9qtLVuTmJ2d3n4tRpoqrMpQhw8EUanM8kHQ4KaY87CXIuB7EA
	krdX+4hWkdwF3dmp8Hwi7XTN/YpzUPQx0RmCttg+WLhb8+79rP/r1wLBfkggbe3LTB3DI7VYUvK
	NHJeYKjFsDG1iKgs+NjcMecqmUcMOlWmyEjzWDe78lTL6rjvSSdcCGbgINlU=
X-Received: by 2002:a19:8c50:0:b0:511:5361:20df with SMTP id i16-20020a198c50000000b00511536120dfmr532241lfj.13.1707467304487;
        Fri, 09 Feb 2024 00:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4iC+FRipMyVJYsUFGfBqVSr7OvTucmAa52sfLjON5ya4vVilp+U93Cecd2K9MevakvwHq5Q==
X-Received: by 2002:a19:8c50:0:b0:511:5361:20df with SMTP id i16-20020a198c50000000b00511536120dfmr532225lfj.13.1707467304116;
        Fri, 09 Feb 2024 00:28:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVltiJ29BtpoUYrPf1SZB45utAeCwTbqwI56ds2Aa8EuZgPms0LwddB+C5/ltorHPajgsPjWHznwdj56pQ6nu24/cSU0eXH1BGFKlLpjR6rvBc3CaDz7fawO3HG0y/7Gj1kRsXQceUY8H9DTHj7+R44o5x/+wAiDlcMMgMVxyLdLPEAfjjAlfUUxE++n5R8EJIaBBcUd/sybg4tB7HpCx0xfR7A3QZtmcA4CGK+PO2aZ3a4C3MTk7GaNjIS70jqUB8QQi/QEZtTvXyQPH2SeBlVAk3amng9fA+1lWXwUoI8AxAXRBESY/XUYLDZ8hU2RQuaRJyEuWMq21JPhPOlKlAvy0qf8iePnq2dDkTWjkRgl9+vU2u0DhldVHMj2B3GnDXN84fFK6s9RaZwI3YbGQeghRctNDpy3xzctkbPneerKo1h0eN4mdodAM7NkNUCmR5Z9nBofp5yuUCaQgVQg4gzECnx0ypTC+kVRzZq9/hWL3AcB68IavYtB4tow7DLo1gLXWRDd9TcE1hYecDqA1g4uLor
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de. [109.43.177.145])
        by smtp.gmail.com with ESMTPSA id x21-20020ac24895000000b00511749fec62sm90472lfc.72.2024.02.09.00.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:28:23 -0800 (PST)
Message-ID: <cf01bf0c-ad31-4bb8-918f-98de47d40d7d@redhat.com>
Date: Fri, 9 Feb 2024 09:28:21 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 5/8] arch-run: rename migration
 variables
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nico Boehr <nrb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Marc Hartmayer
 <mhartmay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kvmarm@lists.linux.dev,
 kvm-riscv@lists.infradead.org
References: <20240209070141.421569-1-npiggin@gmail.com>
 <20240209070141.421569-6-npiggin@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240209070141.421569-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 08.01, Nicholas Piggin wrote:
> Using 1 and 2 for source and destination is confusing, particularly
> now with multiple migrations that flip between them. Do a rename
> pass to tidy things up.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   scripts/arch-run.bash | 115 +++++++++++++++++++++---------------------
>   1 file changed, 58 insertions(+), 57 deletions(-)


Acked-by: Thomas Huth <thuth@redhat.com>

