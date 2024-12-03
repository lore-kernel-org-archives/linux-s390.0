Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52E1E3DF7
	for <linux-s390@vger.kernel.org>; Tue,  3 Dec 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225623; cv=none; b=gciA8zT3aWqxg+qWMULuBQRDBZmJx8KwQScknyQ3crib9bPGQEyDOUmntVMdOvVRCZCjo4KYkpSJn6mI7MXOcrC3hk17mAfuP6LhG8Dcjcri1pPhQS+zaNv/amW7DvkNUaGzr7jrZYD98DpwaYCmt3ogaukmISBLCmvXNi4+HUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225623; c=relaxed/simple;
	bh=AHmmkPHjvu7RIKywEf+EAV3LQMeU6/vP4mpQ4B4VTxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dC9QwOMnVxf8065WWnD8jdoQGWaxmTYCZVMWFXyaLXcvE4a41eeLUXTJ1HY4IPPmkoLG+N27qQvA7gum5X/eXoj8wNoHBSNDkIVKuYiwNEzdia9N25V8ng0/azdfqPsniHMbT8bQ3q2Cb0JOHU30dXFktHx69YMk0zfRcLa4wBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+SvqIjz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+SvqIjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733225620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zREU+lwYhiaQLLeLq6O0V37r0ooXMYuGzQk3sQUa+FM=;
	b=i+SvqIjzV2IDFE7gf5NYW+dwAVGIoQxhQRkmiOxLXmKpm1CqlGSnbd84I+KNXSmzBafmwo
	Q7oOnHvKuugBPgvYkqwcQ0q/86IDvDPZ1g1NFEDWp//lsb/y4gc9zd4uXyFDfMu5/URYjN
	aIUQ9VuDNasnbaGo28UoCQkCn021JuQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-yyKiF_AwPPG1in7dq09d2g-1; Tue, 03 Dec 2024 06:33:37 -0500
X-MC-Unique: yyKiF_AwPPG1in7dq09d2g-1
X-Mimecast-MFC-AGG-ID: yyKiF_AwPPG1in7dq09d2g
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385f0829430so1442837f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 03 Dec 2024 03:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225616; x=1733830416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zREU+lwYhiaQLLeLq6O0V37r0ooXMYuGzQk3sQUa+FM=;
        b=UmTQ2brxHhyeyliFDhoRumxQ12jls505THg8aAX/VBZzOYfj4MF22bUmpQXRC5wl3B
         Xe/BG3mS4s2YVdN6dD6vpKM9gI9a0qjRGc73YDYtGPF3mCIzmuElM86tP+28WO/Jnf2T
         0vH5aaVp/4UAeyupgaN3gFcZWU+Log0OPYe7IOPradb9RizQtEArsfxcpO9L/UQ+t++g
         mYiB4ZNrMF3lQdV/gfqA6Il+oGws+dIbIu/s3/jamIZEsFWuC3y/KLtf4MnjdNSUbHMb
         FFLsKJvdJPBFtqarPiVcrAAUzZhzc8/T5fLwS3OvdIWMeLU/w/iCWEuko26O9awPzhj1
         9v+w==
X-Forwarded-Encrypted: i=1; AJvYcCXVQ+E7t7ko7mQ6el1qF6/VMmKpRZgSxvtRaVnimk2TLS4dM0iLY1zgNb3YDWpt+4+VF3wrwT2l2C3t@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQfAAn2gFEfmaUpS7B4F9CkkKTWi7wNzTWhVKsPulAuqwxwzM
	/01enVhe2ISILUaWIf3LBZ9iFmYCoVK9CieZ45ifV69yipxIVihqMduW0pXSi0yFhHbd0zyTloP
	gZgW1EnuVRwsoNTM1F4MXhpXOEx8lbHKk2HBOdtRy6T/oE9dcR4avIkYORuE=
X-Gm-Gg: ASbGncu+wvw/36tLwlHZLARWq7KgSbktxIJQZ/+r7tScZHyzI23Blkj/8wPP1spwOTm
	dhAR7fDTew23195q2JCgrxUnFerxTl42c/mlDAQOPG8qjB7/N/OGbb5iNFjVfc5KbJyntbD3xHD
	oa40EtCva2/MsRGjfafV9YOTDQECgX2CT3n3qylu0tQQWotw+6/JYtFz6IiEwN7E3e71nhi1Aeh
	Eb4QMxAQVoF6/V7Fruq/Ioze3YCFFhsT5Bv8iUfAYltJlFNEi06J1vWV6JXajRRSIuiWSpqf1im
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr2302338f8f.56.1733225616649;
        Tue, 03 Dec 2024 03:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhUjhzZs78Nz7CtLp5MQzYsLnMpSAwzkbqY7OFNZJSdUe3DRiH8XjGzF8cD+LMHI88SBHTyg==
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr2302316f8f.56.1733225616306;
        Tue, 03 Dec 2024 03:33:36 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fd599b31sm1570921f8f.21.2024.12.03.03.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:33:35 -0800 (PST)
Message-ID: <4c426297-6215-46a4-a9bc-371fb4efe2d1@redhat.com>
Date: Tue, 3 Dec 2024 12:33:34 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v2] net/smc: Remove unused function
 parameter in __smc_diag_dump
To: manas18244@iiitd.ac.in, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 11:10, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

The signed-off-by tag must include your full name, see:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/submitting-patches.rst#L440

Thanks,

Paolo

