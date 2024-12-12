Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9181714D7
	for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007779; cv=none; b=JzWgGGXU6rXzd26IfpR47HjDvbKYqIFTjFo6TkEDTymbCoW4JAn3AyuFOlkuft2llSpXBoIW1PXuZ9Z8ivB9y+SWm99gNy14+KlbR8VdPBpDmA9XLhL+ipPMGIaFnVQ7bODy0BU2P6Nhz5hlnF1YcCO+Zm3wpL33UjCqx++tPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007779; c=relaxed/simple;
	bh=YyEpl48QgjEe2bn12JUr/hGhuZXIyNMzlFs8mERZ05k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbx79tdIVDR+hb9seB7AXXInsfVD76/tXneOCbovp6Zjcj+F1yNdToXeE8N/GnJo2+UyQ8RUWj2Nd0Ul6tVV4agyLmkQcJd8/HG/2N5Yla/jKPjsVBWzeoToBZJZIfl7dqbyy9Sy1NagaTYBCCXg5nj3cx691tCOqzxjNrprxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpTmeg/j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpTmeg/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734007776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itGE2V8xhlh187Ac7QymDWhnP6f5RsijIHH7cFJeYf8=;
	b=OpTmeg/j7JlzxqzC4ZWAGloMEfjbPlbtLqrppy0KozEnPKLgDJdwYvphsKSdcfFvNMQi8P
	aEsjMH1cTseOVEef0bxvg5oX9jY6VwE2uN965ggms8D7qTWtRxGej56sjhF0A+COHp8A3p
	jSHNy/XBSYkRSz/Cdda6eNkQHQy/DPY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-kDRLRuzMOBWNNTKmGFYUAw-1; Thu, 12 Dec 2024 07:49:35 -0500
X-MC-Unique: kDRLRuzMOBWNNTKmGFYUAw-1
X-Mimecast-MFC-AGG-ID: kDRLRuzMOBWNNTKmGFYUAw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e9fb0436so183214185a.0
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2024 04:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007775; x=1734612575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itGE2V8xhlh187Ac7QymDWhnP6f5RsijIHH7cFJeYf8=;
        b=foU9ScHsTZ8de5+zCKzXbDNmHkF/Em+dhA5C7iRzIhg2jJMDcOmVJZVovBcr+yCRxC
         Tpr8aZuLxhk9PNzTI73E1vggDfOAEQBzMiqVWpH2dHRuG6iz5XiI9NcDF8vCyM6QVJbj
         r/oWq2kVh9/6yK7cTJ/VVT979N8bmOu1+E9s/kTbqc6WI0Qu+r0+PxQq0q1CxhMyxaOc
         2kpI5sfEEA9BnUaXudaT5MInQDD6WTT5PxBHlIo14CmMJDovkSB5TjmzT0/qKaMsFfeM
         StNUg56X31IbimTPywaTGfRF3UOcisq4jA/5dpu+AdpPRy86AMPfHrxqMg7+s0TvkMY7
         hTTw==
X-Forwarded-Encrypted: i=1; AJvYcCVJNQoTMhZxPqAj0c2tabOL5zh4D8hLktEAcK58/FG7LcCSZIJy09dkhakdZoYk6ai+Qzjh1fFP51TX@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTfxIr4F/UuGh6bLLf3v+F0j7sFKmIdrgnXgqRJg6C8YPAdKU
	jY/7Ew8fInLBZ0cZIq+uu7e0+srLTVeB/Oj756/R7vQBpsONhXTSKbNticg+iCUfVCXvkwGsqhJ
	nJFPAktPOQrH+33nPQiPaq4hSzcb2FeG6S0aeuxRHPeFQkI3WtH9WamzkqNo=
X-Gm-Gg: ASbGncs9QXVjgvG7SlRmObKwv485NUyDzstoyv0kdSxluTXEPI6jFuWuedA5tPdrfOJ
	Xgh2vg5MFsMR15A2NHZBhh27jSbsjSRiuox1pF9L6UhpjPjzcKGtcP0xMhh7KOC5+17i5yiL/CW
	+lansY9pRRd6vx3RVNEcoFb/rvux1LZ+gEWURsOEQ7U8QDXHYZEg751oOsC9C3YdFORTjy7zQGX
	Q9sWDKOefkfVKWv19mUM8DIwRYeF/5k0zPzJfPpK5U1hS3bvvCT6352xBC93FUNHy5BSxhM8+4j
	/cuY7k0=
X-Received: by 2002:a05:620a:1a03:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b6f88c85b4mr44457785a.12.1734007774835;
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Ag6lWJ9NB6/EzRTpVTPEefZcnvZ6mnIYDz3+GXqvWUtfKmm+Nj3KJ0262kDPgAuHx0vVcw==
X-Received: by 2002:a05:620a:1a03:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b6f88c85b4mr44455085a.12.1734007774551;
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6db04175bsm327709085a.52.2024.12.12.04.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
Message-ID: <c67f6f4d-2291-41c8-8a89-aa0ae8f2ecd9@redhat.com>
Date: Thu, 12 Dec 2024 13:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v3 2/2] net/smc: support ipv4 mapped ipv6
 addr client for smc-r v2
To: Halil Pasic <pasic@linux.ibm.com>,
 Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
 <20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
 <20241211195440.54b37a79.pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211195440.54b37a79.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 19:54, Halil Pasic wrote:
> On Wed, 11 Dec 2024 10:30:55 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>> AF_INET6 is not supported for smc-r v2 client before, even if the
>> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
>> will fallback to tcp, especially for java applications running smc-r.
>> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
>> using real global ipv6 addr is still not supported yet.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> 
> Sorry for the late remark, but does this need a Fixes tag? I mean
> my gut feeling is that this is a bugfix -- i.e. should have been
> working from the get go -- and not a mere enhancement. No strong
> opinions here.

FTR: my take is this is really a new feature, as the ipv6 support for
missing from the smc-r v2 introduction and sub-system maintainers
already implicitly agreed on that via RB tags.

Cheers,

/P

