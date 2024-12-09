Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050021E093;
	Mon,  9 Dec 2024 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744209; cv=none; b=IH8ATcLKud1/9NcePhAI9rg86zltynVMDjP2I+/vjE8Px4+fHzImr01ab+LT2f+5Y5Y3R9reNGoonKrtLCjIifTaOdc9jgiBdVB+Edp/jyxM7v81TNdgKWGNPyMkoggRXf61LiCZPjpiooEhAhDHMvBj5eJMglq/4xL/MNh/eKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744209; c=relaxed/simple;
	bh=ZlKLqseD77SAZvOORQVUfrSOF8Pn6ADkryyopa+DG9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs5kz083tg248jDwuKZtJ5/5gQVE02oXP2J77QXlDLkp9tJAqTYi/oNB39cZ9ISCF1meJBkXjm0kE9oPyys1FrA4DWCrmpxnfDpK6KVWo2Sa8TUACe6ChcCTjWtY2MIe1H23Tt1kRL5TsamlXTHlQFPP6lrzVmwirc76zJc+pUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvssUjPr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvssUjPr"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa689a37dd4so150948766b.3;
        Mon, 09 Dec 2024 03:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733744206; x=1734349006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoqe9Whe3yMtlFet31USqO0Fn1cK27Vp8jD/bmMM6cY=;
        b=QvssUjPrIhX3l8vPHTv2opHGP5yC3SMr9D53qWl1wTbCV7oDGHGyu7jAqUa0K/YSNY
         sLUH2nUvydd0B+3x0gNvPKNba+F0WYUQbFk3c6VPAO9238SUr7X3tl2bRog5Db16JuG9
         yJLVjoLXm0e2mTNqifzqV1cPGPZLBTrxcKp4B++7XX/+452MX2CX2C/XKQFTQA8RczWQ
         152KjjfzncczTFT8lD+j5wSG5peA92XK7m6w6RzSCrHJBNJivTtsEPv1e3c/SRxVck1U
         H+SQx/cDj+rT08OewbXTSkmTXvsamY69czup0HLz8ARsXrlJhsB+RufBIhEnElzYgxo1
         yksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733744206; x=1734349006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoqe9Whe3yMtlFet31USqO0Fn1cK27Vp8jD/bmMM6cY=;
        b=I8Pmzx2a2pJkLDgXqI7pv07oX8L+vmh4Ge2lMFe8LczO9tBXCU9aljCrliqExTOesl
         DbJVwVLXN0bRYE7O+vFXrTNQtYcun9hZ1wQ6dnrTFO3ktUO9ZlnoSKZ7HD0b2StGVISq
         yzLsLetl4C0l/2Waf4XCD/jhYczgoWulIRAoTtQWEtpKoMzzdM20+z8hSTGOpiF3u8Wg
         0IkHuLFtHaoE5rFei5DpfEOp60XfIB5cVhGN1xl06Y5nWGjhCsjNKnQFtITzZLCOXcz+
         hy4DhjMP7Z3tAVz7Ntt2m7d4Oq64LLdZs3x7R5zOhkGCLXQoavoqSn7gcAQyIymCza9g
         ZqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN89e0MxdxmNe1pCcJfpC0IMgmvJh/rYGiKEUpmkVOp9qdDw9/REF3ddb7igd0cZhB265eB1n5@vger.kernel.org, AJvYcCWjsYcx2FLKRS4WT9Wtz9VEWum3ZUYci4jWExidTxhsEz5n4QmFTTk5wGbZGZ4xbgNbL3vkJxwen2D8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+w0tdhZZwGDIMvjn1+AbA16Z9+MDSY02SyHu1olcE7zfem6Ej
	NvFWRx5LS7t7gRTIBho0A9d/JpdjoM4oyT8VeTgcJloOHWNz4DHD
X-Gm-Gg: ASbGncv6rhhsKpKQR4eYWCTWQcw+FxnXbQ21npGJpJJUr9hTKNyk6uJB/oAw3osOuCc
	+a0Yuu9tKpjlt1vvbQV/gq3y48VHF3C2n1e9iGfkYAsqUgMZIHbYA5tUWx7ZWVHZeVkN8l+4c9A
	wk4BmU55llSbrQnAng7EQ5WNAd5N8WkMqALfRXAXK7JXQScf/xGWF5Qr2iu6x82Cquxi4g9ZJhB
	pesP9F+RzCRrGCn/sjUIDUiHLDJligIdi01UMPT1dBmbm+R5Rsu2h/AL+LUklMRZHg=
X-Google-Smtp-Source: AGHT+IFKdatPgMfDBN7Xfbk2j+VSacP3ycm6JKmMGa2vsAcwBzl/eTdZm6wsNrpZNUR5VVOsPl1YeA==
X-Received: by 2002:a17:907:9554:b0:aa6:6c08:dc79 with SMTP id a640c23a62f3a-aa66c08de57mr581772266b.35.1733744205646;
        Mon, 09 Dec 2024 03:36:45 -0800 (PST)
Received: from [10.80.1.87] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6800a99f4sm196237566b.31.2024.12.09.03.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:36:45 -0800 (PST)
Message-ID: <6ebe9fdf-ae3f-4e77-a2d4-82427e59f51b@gmail.com>
Date: Mon, 9 Dec 2024 13:36:29 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Alexandra Winter <wintera@linux.ibm.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
 <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/12/2024 17:20, Alexandra Winter wrote:
> 
> 
> On 04.12.24 15:32, Alexander Lobakin wrote:
>>> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>>>   {
>>>   	struct mlx5e_sq_stats *stats = sq->stats;
>>>   
>>> +	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
>>> +	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
>     +		skb_linearize(skb);
>> 1. What's with the direct DMA? I believe it would benefit, too?
> 
> 
> Removing the use_dma_iommu check is fine with us (s390). It is just a proposal to reduce the impact.
> Any opinions from the NVidia people?
> 
> 
>> 2. Why truesize, not something like
>>
>> 	if (skb->len <= some_sane_value_maybe_1k)
> 
> 
> With (skb->truesize <= PAGE_SIZE) the whole "head" buffer fits into 1 page.
> When we set the threshhold at a smaller value, skb->len makes more sense
> 
> 
>>
>> 3. As Eric mentioned, PAGE_SIZE can be up to 256 Kb, I don't think
>>     it's a good idea to rely on this.
>>     Some test-based hardcode would be enough (i.e. threshold on which
>>     DMA mapping starts performing better).
> 
> 
> A threshhold of 4k is absolutely fine with us (s390).
> A threshhold of 1k would definitvely improve our situation and bring back the performance for some important scenarios.
> 
> 
> NVidia people do you have any opinion on a good threshhold?
> 

Hi,

Many approaches in the past few years are going the opposite direction, 
trying to avoid copies ("zero-copy").

In many cases, copy up to PAGE_SIZE means copy everything.
For high NIC speeds this is not realistic.

Anyway, based on past experience, threshold should not exceed "max 
header size" (128/256b).


