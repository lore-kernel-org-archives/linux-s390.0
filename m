Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7157314
	for <linux-s390@vger.kernel.org>; Fri,  9 Feb 2024 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467354; cv=none; b=D14UQ2sg9xO5kneyPo847/hivIPR/JGdIs33QcK20D0X3G57ZzuUTOP0EpPcqvN+62Ja6ew5rGRGtLdsgUNJP7Im0AKw13enQFi5yNmCvtgwdDR1zL1x67dZHY+z9tkQVbqA0ll7S9f3K+DMnHx9icnuEZBrqs5F9hhfGo9AAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467354; c=relaxed/simple;
	bh=ar3mqjsIdbZN/oexSyU52xoSyOoZGf+sKohPZbfTlAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NApOa3mqtY7971lLInaW7cPEsaBmttP0E3mSRRSofiO/p13TvjT5EZLvAcbXy6T9cyoEP9Ieeo7ZAAvDmAAuav5kgj7nJjRLs+FTeYv6i09yqZzzMipKyg28dKcfRhV5j/pgKJmaUfjbcGNTXzInbiGDnNQS4AjQ+KEcj4xQoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7C42zlq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7C42zlq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707467351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CYwym9bcvYVUdfgrQAx0w53qMrol8jdhzpg8cj+Mxlw=;
	b=A7C42zlqDL8JVekjfGK0YK8YtdW7a4sCmdfnfHpKLXZ5x/1CM/EhhaE9+1sJ6KSdiSyxww
	/OUX5mMKLs58MhGZC61evbZNfJcIQkD8NNOPm701hK7wXTD7PgqX9dVq50bIDzExMoh6oS
	DimGRw52o2FVjfpdo8UesXoX/cm1nII=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-aP_qRp55NhucyKfqQlKQnQ-1; Fri, 09 Feb 2024 03:29:10 -0500
X-MC-Unique: aP_qRp55NhucyKfqQlKQnQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5117504afc3so592373e87.0
        for <linux-s390@vger.kernel.org>; Fri, 09 Feb 2024 00:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467349; x=1708072149;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYwym9bcvYVUdfgrQAx0w53qMrol8jdhzpg8cj+Mxlw=;
        b=kbujXyAozTwQzS0JkfZjNGVnwXs8GWCm0VuEkrDAyrojwosYPN5OqAqf9G4IgEZ0YS
         0YIjyyO/h99tFM0y91uGofwpL07kyxQvFp0i1wot6jxzEHyc8vAN9gSlb2hNV+MwmVTy
         5vvIoFsEjnWkBcNcmRLF5YuJAV4juGde5/taCKMxKCrSooh+RJB9WEyZi+h5lHI7lRaH
         DOj4kvcAbLIridN1lZQ/Xr9SwOJW8/XBAmG6RRbbE7bPuXo/cUbwlKb6aSTOXYqNybGL
         QCd00FqE30MmSwDRoFEXaqjcNnpkhMlXlMGcFR78rAwIoBlrstbXsDaWC+HG3BpcPMvO
         FaVw==
X-Forwarded-Encrypted: i=1; AJvYcCXblEX0srny5PwvPrO56JAwSOOT52E9e8ciHvGOUwCcQv5rT+r9ldvQpFC6Gl4+c9Gph0gDIDFq0kh89ZsHHv0hpdQEcd1cN/L6aQ==
X-Gm-Message-State: AOJu0Yx1Op1J8HptZj/LPunI4cLhjSdyNb7tN8J0bU+Wuwc3Ka+IHwyK
	7VDfLWVAXM6P7sIzofakRoR69DaotB24Uh2ro60Nd8Fqdj2b6+K2HLZCwaNTntRun86Fe70Uyhq
	n4+AMR56bw/Wm4dzaYR4gGGGqeNAN2m2JzChqr5WsLfM6mHpaJfpqG4QA17E=
X-Received: by 2002:a05:6512:308e:b0:511:4a3c:bc67 with SMTP id z14-20020a056512308e00b005114a3cbc67mr667554lfd.9.1707467348812;
        Fri, 09 Feb 2024 00:29:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwQzReLeDNTCJB+qOG+onzJW+a/6xHFTd6Il5yE+rs5dotq6oI7ml/IRzP9nwb4WRCRf2AHg==
X-Received: by 2002:a05:6512:308e:b0:511:4a3c:bc67 with SMTP id z14-20020a056512308e00b005114a3cbc67mr667543lfd.9.1707467348491;
        Fri, 09 Feb 2024 00:29:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpQeKhZnUF9IF482WFoi5RSuK2K0dPm/viY5gZvvdBGW8PlAajaezs2kgDI06usWdUXLoRirtPMouC6vzNVLm1ebJIWnLWDLZ0GEN+Ijk5unz/HqQMvORGDIXXL3Dtf+prelx+pNyvYgYqYusGnquqaTXZA7QhS6HkQap6Y42pIVEN3/EQmJy7vAJs2JpmpxDIiPxkRPxrVbsmZSVnuPOwCDkwsek/pGDlArNd6Bhx7ExRfGSaMOQ2ipZnPHh4xKDAKmuDjNtcq0sQclTvVZDBpof/gkZtZFbDZHPz4rmJ1ciKFyS3O6Q898x0YkZAk2y+sY3IzMbJvaRgk+otdK75cu7gdEwEl57Q4sWFImYaPJDLS4LbMQtxErNNwect2IH8XoJ7esHEcOsAFRZwxa5aVSJRog7z8LtqPN/lXwq8u0iG8XVW+VdnuP/432M3PyFw2p8MGpGvbbSILN0vtIlZUve5ulCwIGBluVrh3YxuLzmOOdbG19SRLy0gaYXvLczv3TncY87RBF6BZarBaQ6IX1OF
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de. [109.43.177.145])
        by smtp.gmail.com with ESMTPSA id x21-20020ac24895000000b00511749fec62sm90472lfc.72.2024.02.09.00.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:29:07 -0800 (PST)
Message-ID: <92633259-1a46-4342-a709-7200c6d215ab@redhat.com>
Date: Fri, 9 Feb 2024 09:29:05 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 7/8] Add common/ directory for
 architecture-independent tests
Content-Language: en-US
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
 <20240209070141.421569-8-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240209070141.421569-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 08.01, Nicholas Piggin wrote:
> x86/sieve.c is used by s390x, arm, and riscv via symbolic link. Make a
> new directory common/ for architecture-independent tests and move
> sieve.c here.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arm/sieve.c    |  2 +-
>   common/sieve.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>   riscv/sieve.c  |  2 +-
>   s390x/sieve.c  |  2 +-
>   x86/sieve.c    | 52 +-------------------------------------------------
>   5 files changed, 55 insertions(+), 54 deletions(-)
>   create mode 100644 common/sieve.c
>   mode change 100644 => 120000 x86/sieve.c


Reviewed-by: Thomas Huth <thuth@redhat.com>

