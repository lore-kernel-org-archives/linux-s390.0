Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397971B0F0C
	for <linux-s390@vger.kernel.org>; Thu, 21 Nov 2024 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180092; cv=none; b=qs9PB8HeY2P0K0IWgO0bBxVmOXpAXSdJglo//3FqaufuuDz6EvLTKv5k+TjBhnqDrS3jNHxl5u8WaWwgxuVYX3Idyoqs5KRCphH6pt7pE6TzeccV3oDiOAH77NExl9LLjmaAu1pp2E4R3Uar7y2p6aBV/XWaaTUF0+E77ssFdpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180092; c=relaxed/simple;
	bh=XfxHG7T9zdJ9nblrp6w+ekWfkJvYj/7d5Bu7Q0dX2Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9tINYdLT6PTvHsK9hwkEf0k9XzH4T4bifgXHhSkigdpyJcOVim3sZuIvXJaw06CxFZoRrW9PuHdXRVMXZeno55Ck3orgLwSo880Obn3wGBslEeLe23m/SAqmb+CiCJagXYQwems9K9D5Z3Th/v7r05aZ441BCJlueqMeQirK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXx63RYK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXx63RYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afC2fEWr0oOrXo3pVR/4wD4LruzaVFrljRmorsICJx4=;
	b=bXx63RYKEduDE99zNB0uqUxUMCieweSlzGRruOYGGkIbRDMxX8fT8xvHUoExKlUyiAiODY
	WtKpFZHrNvk2DYggAVwRhw9LgVN7notwV4Uh0yvukM2POHM5y/YpU97WvdOM65pTUIr4UH
	+IoupB2ucpUzUygqvO0CGhQCkbB7ds8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-632j0i7dM-qz2XQLWywnLA-1; Thu, 21 Nov 2024 04:08:08 -0500
X-MC-Unique: 632j0i7dM-qz2XQLWywnLA-1
X-Mimecast-MFC-AGG-ID: 632j0i7dM-qz2XQLWywnLA
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e38100afa78so1191929276.0
        for <linux-s390@vger.kernel.org>; Thu, 21 Nov 2024 01:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180088; x=1732784888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afC2fEWr0oOrXo3pVR/4wD4LruzaVFrljRmorsICJx4=;
        b=aDeSaC3XPgBRDYBpCuwzIZms5qfSxaWtvX26BuHUG02GWr7NRSq1eHkxTQGLeNvDgG
         K17b3thJXLNVJ9n8sQrI5TjdVU15xZ70/v+5kZWMXbNGX5UXC43Jo/hWu8/YeREonFWW
         P4Fg9E5RVf2JNEKLbUSblnQJYvJLH/BmibiYXP+t9nyPjt31uxLzvahjFHAAFA6IBpTX
         tJb7mC1vemUI6UpwUuBBwUW5mvWJW0g5yGQA0cdthSV2A+r7l+OUVl8iwDjjyJMA25zk
         2k9mK/9fzKcCQeEEruQmNF7PTUN44F6D9b4txkAonOYnarQHcXRnUO33gKU45sYOqaUd
         0VTA==
X-Forwarded-Encrypted: i=1; AJvYcCW7APZeVCsWLG94PPFQa48plipWmxW2ooy54ajZKDP405EEVRiL8Wm8D2N/BdXMdge+3ehNbsDLzqGn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9FaDpnG2HMh+Dq5KrVRkMlUxj4c5bT8gEsZqPdeue01Dbe4+q
	xlHxKCdAwDH5JMnDvAZXbage2o8Zy2/QHaB70/bKj6In00gAm2fQLl9F+jMI5+pr0RiefSishh9
	pABP/a0+A3PCyUTewP17sVRRPKlEdxRCwe/hfBN3kZcSV6qGHzEuFR4mjlV0=
X-Gm-Gg: ASbGncs92a2RiEG/3LoDl9YxDNBpAiIjNIXoqlHqZ4X5BIgSryLa6/J8h4ZRk4zvaTD
	BckKX9013eFrwJkcfRRbHGSqVJJMXU5jSIx0NBc+JrY3TndxO7/n7nHq9atG1zOpblliSsTmViT
	n/aALuJ0/Ya0LpsmFIWsGuqxwV/GMvKvqft6sDKOR9UbLlwJxo/FUbC7ZBOqdRTvDuPbjKswyGo
	y5grivjROnH/Fyeg/e4O7EtoHB0mhSQOTkG38l9G2spOo9vH0hPB959ZKMyz8sWdIwPeDM/yg==
X-Received: by 2002:a05:6902:1107:b0:e38:ae50:3360 with SMTP id 3f1490d57ef6-e38cb58cb69mr6096056276.27.1732180088127;
        Thu, 21 Nov 2024 01:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvcd2Tc+vOWhnMdPjejOD4B82sqJ4ONVE5q8tt3h7dnbHkb3vWE9q84qQ2i9DLtZwcC9d5Bg==
X-Received: by 2002:a05:6902:1107:b0:e38:ae50:3360 with SMTP id 3f1490d57ef6-e38cb58cb69mr6096030276.27.1732180087824;
        Thu, 21 Nov 2024 01:08:07 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ac1971fsm19452431cf.89.2024.11.21.01.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:08:07 -0800 (PST)
Message-ID: <ed3a24ba-ec2b-4261-a479-11625b04b44a@redhat.com>
Date: Thu, 21 Nov 2024 10:08:03 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: Remove unused function parameter in
 __smc_diag_dump
To: manas18244@iiitd.ac.in, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241120-fix-oops-__smc_diag_dump-v2-1-9703b18191e0@iiitd.ac.in>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120-fix-oops-__smc_diag_dump-v2-1-9703b18191e0@iiitd.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 16:01, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle






