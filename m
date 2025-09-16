Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E152641FB
	for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008934; cv=none; b=X6l/LaIM/2tMrMehnYPiIp0E3OIbyoqUM68i9/aPt8d7S/HtMxH/jUy4qE61mE8tiHsn7UXSuEF1vQCwsnhCpcfA3VzfXrJr5QGf9Yl+yIY11xVFeHb+GXUfbZHrpKc1piyiVaIPuedZDboZYTCFyexjA/NsUiAXZv8ma4Nk6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008934; c=relaxed/simple;
	bh=7SHV3jCyT405G3CY4vB7yAVjSGoBgTp2zKolMAlPbOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlqnoJ6OoHnF0r21UT24/Jgx4vQJL6Pnw4vfG9Llrp1G98CoXYXD1uc16ROzf9kVm66ECMqlmFWkmsWs1X+vsc3PeBm6HL4NCKmuTCZkGDt5GUe9jgOfMnYNUZERm9IIXcvi8EB61iJulAmdw9qRXyg9JjWJsPOuqtrqFL9hcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XV3Y/2ct; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XV3Y/2ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758008931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjeY1PcOXMyOovo+WVNpcVTDlDd9blbv4pX7GoSf+q8=;
	b=XV3Y/2ct1ghQL9OQ7d3+hpx7i05xC5BeZl50UavyurgPv5OLDgpIUU8gg7hCnaT/mhQmlp
	1TqqMmaQ6eN4BLo7CFv62dyeOdMfXwP0SKoz20hBA3478Jb2XdJ0WBJZepCl9RCBgp5cjn
	O0V649Z62qgU4KFggbdEYoTdiHj7m+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-8p3GcQjnMCCaAbJ0JWLShg-1; Tue, 16 Sep 2025 03:48:50 -0400
X-MC-Unique: 8p3GcQjnMCCaAbJ0JWLShg-1
X-Mimecast-MFC-AGG-ID: 8p3GcQjnMCCaAbJ0JWLShg_1758008929
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e7c2273e69so1531380f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 00:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008929; x=1758613729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjeY1PcOXMyOovo+WVNpcVTDlDd9blbv4pX7GoSf+q8=;
        b=WoWc1s1Vp/G6f6cBCRgQ+046PNXKNEUATMpVlnJWbElz5J5AqBnBBn4EZxA3DSgrnb
         8BaatDRnf2OmpHPvJg/CaCtDBZxeR6Kq7XPiwip/hzVI0o2QIy2A4E/GBYi8kYoQVaQm
         32/kOBKXpzypf8xkWV70tA+9oE8FHjFPXjH6a9bB/4t+NfJZKpg7AJvUB+Gpkuv3AaAi
         B+zHha461UplA7e6J79uBUQnWXoGmEq5EORXMzEg4+VTU3CSygZO8ZxpyNg/4x5kguQC
         HQBMZjjhYZPIOx0B51HIUWyH42vd1vef9U9nCb/Nhp7yGcy4v/no/BANnoIdSUD/x6bR
         n0dg==
X-Forwarded-Encrypted: i=1; AJvYcCWCHxG/gObXqa+iR1PdMOjnmo09lRnOTuCzVssy5aBu3NRE6r97lkbkE5LBrD7I14gPcZLNvE7S7hba@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2c16BN1ePgofDBYOfTUe4h///wcAwourY+nu2ugJzpD2VT8Z
	1f7STHbYfYgSZn4EyvNyOl9T1l0MFgHg1JQjos3HiFDmLbouoO3PFpZc8vvb9CW2P2+gSk8k4GE
	WiOT2O34yEFjCiO+MzKM6Enck9UNaAT/81UuCOgmOUPkjpilijqrJLgpzV8e30dE=
X-Gm-Gg: ASbGncvSzYrAoBTobxi/VQ3i6oZVF0uYFj8B60YMAIz7VTDerg8wpG1zmQTqZ1PoM6u
	Gh7F5+riI3i+GmoDfUfisAEjdJtTPHX6l1tP0JCHmnpIwiC0dca9JefEQ13NForAEiVezyL8T5W
	ESf0UUA+oOZlmZ9QTPyaQQp/sBPDWMiyharVZ+FsWtDhYXn1Gr4O8iA030xZx6cMXFRpDfSTqIs
	HHg4wYhiMd0AJrraJlytnna5NETklqbARgNz1g0gmnpTfxm/84FKmUu+JtoyEoniS7PsxPCKBML
	vcP0mbAO9Y1roeEx4EsOKtivbnrDjXfldqToby9UsLzM889wvgbtfUKflCLXbVDwisGpLx7stWC
	OCNwHdrEydq2P
X-Received: by 2002:a05:6000:1841:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ea6680924dmr5605805f8f.2.1758008928842;
        Tue, 16 Sep 2025 00:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVnUKCp6fBmJpCDpTscXGYwqYkke2xti3MVIaeuGunlb5OGmsVBlB0Es1Ojij7wpr4gLKLYw==
X-Received: by 2002:a05:6000:1841:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ea6680924dmr5605763f8f.2.1758008928399;
        Tue, 16 Sep 2025 00:48:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c4490sm210698005e9.19.2025.09.16.00.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:48:47 -0700 (PDT)
Message-ID: <451ec7d0-d4a8-4318-bac7-0a344d969cac@redhat.com>
Date: Tue, 16 Sep 2025 09:48:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] dibs: Register ism as dibs device
To: Alexandra Winter <wintera@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
 Aswin Karuvally <aswin@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
 <20250911194827.844125-6-wintera@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911194827.844125-6-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 9:48 PM, Alexandra Winter wrote:
> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> index 2b43f6f28362..92985f595d59 100644
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -81,7 +81,7 @@ config CCWGROUP
>  
>  config ISM
>  	tristate "Support for ISM vPCI Adapter"
> -	depends on PCI
> +	depends on PCI && DIBS
>  	imply SMC
>  	default n
>  	help


Similar consideration here... don't we need an additional

	depends on m || DIBS != m

?

