Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F802F7AC5
	for <linux-s390@vger.kernel.org>; Mon, 20 Oct 2025 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004479; cv=none; b=AJy2+K/oYaHTAshue7wd2tYFyH915gktJmLdoyqpq/zdUmL6Q1PV95/STZBxQIrMA7n+qS75bCZSspvsJnJjTXKMg383xnLDTcBI0O0Zy1UrWF7iJdjNKX2ZFf1W4DDdpDYLTttu7GtARF+rEs7wnwQR3uakoTgt0XGw/TNudJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004479; c=relaxed/simple;
	bh=Z8yBcQJaMDVMDwGKP92PcEANBe9SMhtbIsxuU/XAv6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2Mxbexs31zyM6XSwz29YK+0+PQlThRb2PpjRFI1vNJPvBS9kasTdj7yx5UKY1puG46g4ZDNWCWIm2l8I2NOD3RGRthggD9zZ4AINUFP8NwXEgounUIUfH/WD+O6C8aebGHYekdDC9YaWA4fwxHhr2hJC/UT58Ii6Jnm85OOI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxEt3KwI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxEt3KwI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f343231fcso3333872b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 20 Oct 2025 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761004478; x=1761609278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkJQ2Wqv2WIkS8r8m2VU+kwyMn/g5LRAACPYO1/MIBg=;
        b=GxEt3KwIwHh8VkYt/6Hwuf/IhkydNHarL+dhQT2kaJB466b6T9JK8szeEOCs4QSIMw
         6jck9vs578B839o2yDz/jjSDVOwZIsaGSs48tq51uhRJHQQ07qKuRcll6k69IiMeJh3c
         0ArGk/AVQpP3ncKXUFzVNYAHnW/gWmnd6RKgTeQlrJq6jFoXkP65Dj45eCyFvgDP+E8k
         e3MY7HGsmMHi11PdYteg8sn3QKM2lvNqgmRRXuJFf9kuyUdsk3hjP1GMfspFEG9tRbvR
         mLi8mFQznpIbnT97helbZNp6vkVXYipBdyEW/Dfhu7Gv7alLkI5Aacux65mJ6w0Cc5Re
         nhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004478; x=1761609278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkJQ2Wqv2WIkS8r8m2VU+kwyMn/g5LRAACPYO1/MIBg=;
        b=hMUpa1VJom0aknYKsdeBhpak9kEzJ22Z6gnPRaOcwMkClcVUPKUsrhWgNYL/Wh6zpI
         1dxFErj1Nx8A0d42/tLDp6456evbXW1NYQviIic0Zivjd2xAgVZRWDOIQ6XEiwILPMd+
         Ys9n0hmGM0C/cWxchRnjUyjp1pnGYMHKf02LmisIF6WfjRf7qQe5Xb3HncLTlsFuewFZ
         PaGhoLYtRuBR7mTxrbA+3YfHyMU4sBmA9yHsIvL5GYezsYeaxId7WiRkvhV60Be0llS8
         fIXjZD6bZL/pG8m5qIxrWOLBZjiiRwE68RZALVHSRXdIrRBTk+SAJPiOHLTa+WwRcmMK
         J23w==
X-Forwarded-Encrypted: i=1; AJvYcCUBNsQs7k0qDWKtYqC2ElYglNOdq9CRQQwLKgsFMzBX3BMlVQXOdoDc94mYjcOck6D1eyBkRZoBUPTY@vger.kernel.org
X-Gm-Message-State: AOJu0YzD51adgsOwyG+i9GlpO8zqRk7VvfGfBhV5KqCHgdEYzcw42Owi
	cZZcilUcI2x7wRoF6l5wbQj4rd7EV9418SOaEgSBuM9QwGCVxiJ+xizn
X-Gm-Gg: ASbGncvxVkPsQ/lij/ZCOc55COY7d+b2oNFPYKen/1ZaIwdyYbtSsv61MjtV7FovqSK
	YDfkJ4fdlPnIp08h3uyZgHWngI/us53410sw0MnGx0/RStfnQ6F3jR8Zw9fVyQAOY663BDKY22H
	nYuFFeJflpfmAVABa/76fbKlLIdAJQqQHMtxgx1OPzEVL25P/k3NPudr0uXr89ZR1AhgpXsfCBH
	tIqCoeY6XAIhlXVzorKtBZKKJRkHaIqCzq7baeIFCU6Uw+jfoarA5xQ5OF+vJctZDhJmdzqDwj9
	nHCXFQAih46ylF9B31xi0nnVd4I98HNGz3FHdlB8LEl3n/y7OlpiZSOYcfRhlP2Cskcmb4XdMZY
	3Wpvsi3PxEyqEOyxF/o9CDx/lLnq8KfXdNXxU7jy9v9PGn49HhHe0N8Cn0ZJNJMFiIJ8B1Xqia+
	0wRAq5yh6VH5UPpB9L5uOLZg==
X-Google-Smtp-Source: AGHT+IEWbUvYFru0xgeOb8F6Gj2YJIGo2FfUgJ3zMwHaKzd+9qSePGSKb4FX+0Eekq3XescoXtalXQ==
X-Received: by 2002:a05:6a20:918f:b0:334:97dd:c5b4 with SMTP id adf61e73a8af0-334a856e67amr20900400637.27.1761004477385;
        Mon, 20 Oct 2025 16:54:37 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15b0csm9487310b3a.2.2025.10.20.16.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 16:54:36 -0700 (PDT)
Message-ID: <c42e042b-f1b1-453e-a350-dc5c99d38c75@gmail.com>
Date: Tue, 21 Oct 2025 06:54:32 +0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] lib/crypto: Add SHA3-224, SHA3-256, SHA3-384,
 SHA3-512, SHAKE128, SHAKE256
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>
References: <aPXfzd0KBNg-MjXi@archie.me>
 <20251020005038.661542-1-ebiggers@kernel.org>
 <20251020005038.661542-4-ebiggers@kernel.org>
 <1062376.1760956765@warthog.procyon.org.uk>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <1062376.1760956765@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 17:39, David Howells wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
>>> +If selectable algorithms are required then the crypto_hash API may be used
>>> +instead as this binds each algorithm to a specific C type.
>>
>> What is crypto_hash API then? I can't find any of its documentation beside
>> being mentioned here.
> 
> crypto_shash, then.

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara
