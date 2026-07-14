Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF826CE11
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002809; cv=none; b=Vxh01D4L4wwnM4HrDI/W1jiXTks1fdbokl1ysWHlgfWrQQjDLhk3tUmYbmMvpGEEmw+DdZX4N6wwq+dakN2yytWDUBZUYxWazSqj+tI0RvGaHLKwMlhxdsI9K2LdpdkBFL2ZKbAhQf8v9rmbmUADDCpON05vrPyDd7kKcaLWQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002809; c=relaxed/simple;
	bh=XM7NEXOYbLEOlVK7b+ErnVKUAU0qhKE/jPtFLL0SHYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar4WKFgEbWg9iE+uKdACfE5oY94PoGvW0AccFwUfdHKBUNeIU5xP+su5Bzssgs2i08AgUcGQINMj2QYCcKjDoICzjVEihLvtoFKnDBA/6oB1dmdKna5791deDS5gvD71m2XZsWC0fk/Mwx94SBOVtgC24I3Q+edzpu6vjv+BSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFRniAjb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyvLq3GP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFRniAjb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyvLq3GP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784002807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1HupOzpJp3e8c0sikfAglH5/ggvC1reaC6Xy3JGlOtc=;
	b=gFRniAjblkwFMnoAgzKDIEDWv0W8cI27jN2MHYJjWeXXRPs9rW9ytXykRLebaVWGZUmuIv
	56C42kA3UCvUrhBesEjgsYdfwEsuA+1wDNAq7dKUk8eCg+cLZSXUVXrlP+/35XpWgtiQPL
	vxeScp/UtrR9TKoRNNWZJbkI/fXfxac=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-4mzAWEnKMomnkVx6xYF9UQ-1; Tue, 14 Jul 2026 00:20:05 -0400
X-MC-Unique: 4mzAWEnKMomnkVx6xYF9UQ-1
X-Mimecast-MFC-AGG-ID: 4mzAWEnKMomnkVx6xYF9UQ_1784002804
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso29282785e9.2
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784002804; x=1784607604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1HupOzpJp3e8c0sikfAglH5/ggvC1reaC6Xy3JGlOtc=;
        b=JyvLq3GPtLlHWnEiDBR/z5cZLIdPHYhJWPnhQmiKRexAV20u7ZOxhYlHX2b/O4YUZ4
         NAHx6jP9zMjEqH+GhmLwsJ7qLY51UaZrHSzzBN3wH0xHPimZVXdINWpuuKfCYCs4QMcx
         yhjQ2KBRFX99SIQqiuthrlPZKvzADGmFc6t5bZncssUFInSp4Pee5ISUgRq1DYP21JNU
         RgZ4rltxnJrqdj7EHU9ttHkwzqcTg+VhyoUR7BsT3/S2UOkFycy9RKINJCspuIIOnoZ+
         FjTah1jwXQBFMatBubfb6GAPUJJpg8Xw8rMTzMXUdQ0+9V28h+JDgDZImAdX2MA2StOv
         du7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784002804; x=1784607604;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1HupOzpJp3e8c0sikfAglH5/ggvC1reaC6Xy3JGlOtc=;
        b=S5Z4EYwQtbmgQp3knSfW6XLY6vYlGzQ+537GV1KWDxYFLoZCGWoXT1kMgkG4skdz3B
         f5KCJ4H8vQ/E4axPzKUyqMND/KhB7BGfHwjNp6H2vV2QWwlh/hNj+53fzkw7/Oz6I1KS
         d7ty7P+ZYF7tQt6/1ZAeAJ5tLDnjjUjbFDpqGmbOVMSHAyZOTHZ5x2gJwVeuq8Ps5mMw
         Kk1P2lx/eFF3JlZEIBddEAMcsNpsLQX809vuEGtPSAwtdo4bnv9Ig1u1uPkSUt7+8con
         ++Pr/pgDWvtCEoLsPw1IH4zWzp0Hzt2Gb8Rq8aJuoIRZ7pqBSOSpEJ07SkkA+4UZW3C0
         +TXw==
X-Forwarded-Encrypted: i=1; AHgh+Rodw4Jn6MZK03L6X5WTR9B2GbOybU0nQQCkWVWJlE5Nkhiv6k+SuxU4epimbIGh0QP0/OeDq5ibEWMC@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2Jag4UtNDDnyL2Zperui5EC1ACZpZffhoqh87Ppciw2zcPvJ
	ce5EYLkV2TnQ69NwgWKpf25Bj7byye8Ie3BORJSMq1pFJ34+zHrWktszKYS5BeYZoq8WVpattRb
	IuSqJyCct5Cv4ektNWx2b/qkFfOXxI/sS1s9w2RgLO+iKVxs3r9Lfe+v5o7iCLB0=
X-Gm-Gg: AfdE7cmsDRmF6ol3vvW9RDuTRkrk9QtiJiy5LkPX8fwMS426sOLOXKus3hO5nr2tXRR
	FPiiWgEIfhIrY0Y+VzxeEx0q5M3azbWNv18ZkDZeMGxOZWj+FUOVz3H0joKPlwfCE4+g+HnuT25
	uUSrSkl1hjWfUJ37DIopKNUz47bipSP1WeHvRgc39puPGqOEuMPmOvmtHq3Mrggh+k1Irkjo63V
	cqsOFk9ED8DhKHAcGx9dYbArf+uXgGdK7Szv9i7ogkNxnaHmSCyMIj1ADIzVXQ4bt2qfhTnaOoQ
	1dohOZEd0Ba4gf07zPaoKSo7or6ZxG6exOTFj8SyOfvI/UoHJ5fFaFFA93K3qZuk70nnvrz6vE+
	6SUCi+oaN
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493f883157bmr120878785e9.26.1784002804071;
        Mon, 13 Jul 2026 21:20:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493f883157bmr120878625e9.26.1784002803737;
        Mon, 13 Jul 2026 21:20:03 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871cbd6sm52708055e9.3.2026.07.13.21.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 21:20:03 -0700 (PDT)
Message-ID: <c4796562-699c-4ac2-87ea-290708ff577a@redhat.com>
Date: Tue, 14 Jul 2026 06:20:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: pcrypt - Remove pcrypt
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 linux-s390 <linux-s390@vger.kernel.org>
References: <20260713223234.24812-1-ebiggers@kernel.org>
 <20260713223234.24812-2-ebiggers@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260713223234.24812-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2026 00.32, Eric Biggers wrote:
> pcrypt was originally intended to improve IPsec performance.  However,
> it's no longer useful for that.  Reports from the rare cases that anyone
> has actually tried to use it over the years indicate that it actually
> reduces IPsec performance, e.g.:
> 
> * https://github.com/libreswan/libreswan/wiki/Internals:-Cryptographic-Acceleration#obsoleted-ipsec-accelerations
> * https://users.strongswan.narkive.com/liqTaTq8/strongswan-problem-with-pcrypt
> * https://unix.stackexchange.com/questions/594336/ipsec-multithreading-via-pcrypt-worse-than-single-thread
> 
> It's also undocumented and quite difficult to actually use.  Its design
> is also broken, in that any unprivileged program can enable pcrypt
> systemwide at any time (by instantiating it using AF_ALG).
> 
> Meanwhile, pcrypt has been a regular source of bugs, including at least
> four that have received CVEs.
> 
> Let's just remove it.  No one seems to care about it anymore other than
> people looking for vulnerabilities.
> 
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   MAINTAINERS                                 |   7 -
>   arch/loongarch/configs/loongson32_defconfig |   1 -
>   arch/loongarch/configs/loongson64_defconfig |   1 -
>   arch/s390/configs/debug_defconfig           |   1 -
>   arch/s390/configs/defconfig                 |   1 -
>   crypto/Kconfig                              |  10 -
>   crypto/Makefile                             |   1 -
>   crypto/pcrypt.c                             | 394 --------------------
>   include/crypto/pcrypt.h                     |  39 --
>   tools/crypto/tcrypt/tcrypt_speed_compare.py |   7 +-
>   10 files changed, 2 insertions(+), 460 deletions(-)
>   delete mode 100644 crypto/pcrypt.c
>   delete mode 100644 include/crypto/pcrypt.h

Thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>

