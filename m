Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7B31E888
	for <linux-s390@vger.kernel.org>; Tue, 23 Sep 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618574; cv=none; b=u/cV9aKr+X+VHNenEVuuj8CGys4YP2mE+yfMqwd4Rx8jGZkcmbMwrLhC8aGC/v8IKsKhBv7HBsAo6OqZSFrosTbCOGNEAT8QSbOQiSPhXdZj5d0YJCoBxvkEm1DBCzpY4Rf+dejxzrV4qPzRLJIJ0jMp71myygEvddwizawxaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618574; c=relaxed/simple;
	bh=wLVoGbMjHEEU5mMoyG82PjioU0/lNcciOqJIt/sYfog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TavlEO2XoI41Ro3Hu7VA31M+gF+C8NM4IdSRJ4jjQyakab0Rw9rMUj2AhCfFQnOjlseFJdm9g0P/XR2XbAArCgQQetOBcDMF2WI8lJUmpNUyXBEv9APdjNPSWk3T6c8heM8WR0qIMBMXZopzwYIz6IlsM4QbgY//nXTXlQb57wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ys92Rp9v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys92Rp9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758618570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvjnjFcm0RtjMmGMf5UkMcwY2Aol25xIkMv4rlwpYQI=;
	b=Ys92Rp9vbQmzPxHhaeE40Q/8DxG7cHcjE/1fNnBlAlGGpEqPhGID1T1OLZ4pc1n9/Bdkx+
	J3AAuB74b4rRukQUc3JHNj2zcnJEcePitCl1gyfCSkOSCPLPaIPZcTKytsRXcR70lfYkur
	bzF9DRilBK1UvOckWsvptcUpWmPYmHI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-1zdyofCkNXGAjVVYpvAjpA-1; Tue, 23 Sep 2025 05:09:28 -0400
X-MC-Unique: 1zdyofCkNXGAjVVYpvAjpA-1
X-Mimecast-MFC-AGG-ID: 1zdyofCkNXGAjVVYpvAjpA_1758618568
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so1629536f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 23 Sep 2025 02:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618567; x=1759223367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvjnjFcm0RtjMmGMf5UkMcwY2Aol25xIkMv4rlwpYQI=;
        b=Dv5AUIYJ7cvkfcKeW9gnnbtlDoMYyEXM0lKn1m9YD9gpnOo7QaDmsTOKp15AKQp5j+
         a12ARGbeybVnjNUR2FjX75aZf1uPx9w2ioNyPMKX7FOTTk6otOUFj6rCH9j9XLIGXwrl
         r0cG0LhpWqkrVoa9c8DwJyKGrmZi5QFfWS/q6XuCo4NUrA8c/nu8pEMlk6zhMK5Wer1Q
         W5svAk0Ksm5iYaV2ggG/tA543pR2ap/JMoF1dzqTWvPyokW89Avl/OPabAHosT1DRIgZ
         5Eo5T+jl+9YdJk28//wpvJwB9S2LisfbDNTaLXU/nMJ4ARCsz5ru9K4RWmXbKd6PegLG
         8Umg==
X-Forwarded-Encrypted: i=1; AJvYcCW86CAVYG6n0CZztFPfQqAxeaj38IGdNFBAVu53Exv/hoAFYOWwtZBtEwF6U/Fx7ogFhz41Lamf/Otv@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9rQhoPRzyJnhtPZPbGyE5FrfJ+6z9sDlTQ8U5nhWbXXSfno5
	TzHgkIDgDXxI9sptDAVfPTYr3UfseDYFdyC8FhfnmX+TQ57QFmFsGJn3ommWrRJgB5frtJZvVfK
	54F0jwshxcgKJE8jn29hicpWf7KlMwfvvIATUNQfIY+ejyb5oY1g1jwJ4LHTyyNI=
X-Gm-Gg: ASbGnctUdTTxcD5s1a/BeYdaXwxlpX5L7KUpiT64v3dTTo44gotaAbweKQS0C0juq/j
	a6zV/l3GX1W3McOlMUmYnqVOFmmxOgRTNh9XDsJgCmTV2D7D/9juiUJ4XLG/+n4gZGXdjNzr3tP
	B61a/uqFDDpAs38M3wfk8gJfawLHTvmMURd/9K4zHkXeX+4iEaLIgs7ec2722VHiQLitFoJtz5L
	MVbqZMXqCJy0wTbSiI3y93fKBZP7y/V2VKVPw6LeHO5VDAU7lHW4NEhvoL7FuNpNpN2iy0dV513
	XppvXijKjCLAdjTiU+S6sZ5508Pz8wo3JIuJpVXqDHEKOoK1VGd1IUgQWANuQ0veXnStM2ymkPu
	L2Jc3iBNS0Ixu
X-Received: by 2002:a05:6000:1a85:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-405cc33ac0cmr1415182f8f.13.1758618567514;
        Tue, 23 Sep 2025 02:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw0fShgkZVnRNXqun3DQnacnjRxnLgbPH5kDta0TCodIeo80eSQ2lM+5j5xgO2Pt7lz4Uk3w==
X-Received: by 2002:a05:6000:1a85:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-405cc33ac0cmr1415138f8f.13.1758618566921;
        Tue, 23 Sep 2025 02:09:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1dc48378sm8665135e9.8.2025.09.23.02.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:09:26 -0700 (PDT)
Message-ID: <94bfc71a-178d-435d-b54a-117e8265f532@redhat.com>
Date: Tue, 23 Sep 2025 11:09:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/14] dibs: Register smc as dibs_client
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
 <20250911194827.844125-5-wintera@linux.ibm.com>
 <eda2c052-a917-4d02-becf-2608242d1644@redhat.com>
 <f785ff05-acfd-4544-84b8-39f0c2d8e5ee@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f785ff05-acfd-4544-84b8-39f0c2d8e5ee@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:37 AM, Alexandra Winter wrote:
> On 16.09.25 09:40, Paolo Abeni wrote:
>> On 9/11/25 9:48 PM, Alexandra Winter wrote:
>>> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
>>> index ba5e6a2dd2fd..40dd60c1d23f 100644
>>> --- a/net/smc/Kconfig
>>> +++ b/net/smc/Kconfig
>>> @@ -1,7 +1,7 @@
>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>  config SMC
>>>  	tristate "SMC socket protocol family"
>>> -	depends on INET && INFINIBAND
>>> +	depends on INET && INFINIBAND && DIBS
>>>  	depends on m || ISM != m
>>>  	help
>>>  	  SMC-R provides a "sockets over RDMA" solution making use of
>>
>> DIBS is tristate, and it looks like SMC build will fail with SMC=y and
>> DIBS=m. I *think* you additionally need something alike:
>>
>> 	depends on m || DIBS != m
>> 	
>> /P
>>
> 
> 
> My understanding of 'SMC depends on DIBS' is that DIBS has to have
> a higher or equal state than SMC (with y > m > n).

You are right, I got lost in dependency hell, sorry.

LGTM!

/P

