Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07192BA33
	for <linux-s390@vger.kernel.org>; Mon,  4 Mar 2024 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709532330; cv=none; b=XCvSq3biTWqEbAfCmKZrgOWQuoZxqkNcEUZdDE3UH0sZMPb/w6EjlK1lmqrL5SP0RHm5Qr8n6poHtmzXc9EQSI24opx5sscfeimOlPuUs337HFvF9cqytSf+5M+8WImzKdr5NL8FSZii+23Q+rX2LnIqKcCghgrvog2kQxt7zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709532330; c=relaxed/simple;
	bh=lwShS7M9Ogsv+wfJxRjwYWF0U12ntExPTzJj/bUiBn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1BJfwx0aDFJ27HM8wBWi8yRxI0t4eraTT0dZqDvICrYAs387BxwhPwDOUYWlLYsbPduJoyJpaIM90Yg0g6TEED7eOcSMCHtvroEoZirp2oPB2pHbz2OYSUP5bKUG3RI9Tg/Sc5WsP3yKvBiL4a+Pe5waqzPR8zsjy9WmAPbRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXMnP6yQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXMnP6yQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709532327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ndJY8dWzbT06z69xyHOXNh+XJez9WypZnR8xAUNlmMg=;
	b=AXMnP6yQWWAKaSqjj4HfM9hKyavFlRkYBQmHZ3IU9NTariNb6Dny3odGy8CWVVlKuTfvUk
	dIzrO5n6p4VO1F5RPLt9PYX9w/93SztHsBvvQEA2pg9Mps+WvqwcuHCIl3JwxkBL33LC07
	gIkGKUfEFisyEhXbNlOmPz+B1tbg8t8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-26A27rrfMvCPJvFD6PvRtQ-1; Mon, 04 Mar 2024 01:05:26 -0500
X-MC-Unique: 26A27rrfMvCPJvFD6PvRtQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-608dc99b401so70570947b3.0
        for <linux-s390@vger.kernel.org>; Sun, 03 Mar 2024 22:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709532326; x=1710137126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndJY8dWzbT06z69xyHOXNh+XJez9WypZnR8xAUNlmMg=;
        b=S3lwFHTCvaS+kcGfnlhCtd9m+vAQrK/JLKKWDsba/Mjg1yUELil6q4YONvhsyevAI4
         0TbajR333+q9LEriRco05cW36b467rWIDkIOk8e0V2A8W/Rl5/y5dN7TOdebDtJtTibv
         FF9GbpMrNdGczhBoJO3W9T+XUmd+CzGqlRI9GTNDzj4eAzqtjqASvgBo9Dpa2FTt0CDi
         eD0PY2m8B80fAYpl4I4QzQayHqdHavXV75LSUmytnpCsl2h0q5NmMxT5WZhCb7ivEZwY
         ewodlRR+yQb0KtviQOByZALstI7T+l4TcHwJzP3fTmLTR28kYoZgeuM96jwDx6Lyd7pl
         vIkA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8l9fmWbc77dRvamBa/nh01SE7pioF+txJITEKqVPa8B6PbahZ+Uo0fD9bBr7tOcvLHT4GgruujoWQsp093tc6x05tqE6WWEUHw==
X-Gm-Message-State: AOJu0Yw+AlKuvy3eSLefp7CtTHDPWw2NVFUjM6zBCPBjQ0KtTPO8ZFFF
	Kw8l9gPpRM4JZ/I2/3R7Z0AlSUKtSg9SzptHIC3I12nBjk4kydFyEzLYYMNTaAadyKbX3bEjlhs
	SMmCed1V4c4q+DCKUtnjWBaHeSFjlZN/3ds1RpslegAq6jZuZdp42X3ZRRZQ=
X-Received: by 2002:a0d:f846:0:b0:608:e5d7:9c1c with SMTP id i67-20020a0df846000000b00608e5d79c1cmr8051726ywf.14.1709532325853;
        Sun, 03 Mar 2024 22:05:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHTlmltvviEqtiBfJAMa5OmglMw2ETbXP0sNCTBYR0tGLQV/nFW8uq5jXIEYq2GL6VNohQtg==
X-Received: by 2002:a0d:f846:0:b0:608:e5d7:9c1c with SMTP id i67-20020a0df846000000b00608e5d79c1cmr8051715ywf.14.1709532325594;
        Sun, 03 Mar 2024 22:05:25 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de. [109.43.178.133])
        by smtp.gmail.com with ESMTPSA id t125-20020a818383000000b005ff846d1f1dsm2435788ywf.134.2024.03.03.22.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 22:05:25 -0800 (PST)
Message-ID: <35dd5506-4fd5-4cf5-b414-3f6758a440f5@redhat.com>
Date: Mon, 4 Mar 2024 07:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 2/7] migration: Add a migrate_skip command
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
 linux-s390@vger.kernel.org
References: <20240226093832.1468383-1-npiggin@gmail.com>
 <20240226093832.1468383-3-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240226093832.1468383-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 10.38, Nicholas Piggin wrote:
> Tests that are run with MIGRATION=yes but skip due to some requirement
> not being met will show as a failure due to the harness requirement to
> see one successful migration. The workaround for this is to migrate in
> test's skip path. Add a new command that just tells the harness to not
> expect a migration.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   common/selftest-migration.c | 14 ++++++++-----
>   lib/migrate.c               | 19 ++++++++++++++++-
>   lib/migrate.h               |  2 ++
>   powerpc/unittests.cfg       |  6 ++++++
>   s390x/unittests.cfg         |  5 +++++
>   scripts/arch-run.bash       | 41 +++++++++++++++++++++++++++++--------
>   6 files changed, 73 insertions(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


