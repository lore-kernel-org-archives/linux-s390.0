Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8311DFEF
	for <linux-s390@vger.kernel.org>; Tue, 16 Apr 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269209; cv=none; b=c0MGUfGRYo9BfKsRfu/B/X5KGk5nRO3Qcuuae7fRW4a9xs1hOT+UlkscZe1ivCmK8EazeAIQPEnxJny3A4S0EsHMJpVh8u1voiuVQHOGCN4mAr4PGN/nf8LpfdQc7bvJ/BJQuNQ7Ca9IuAf+1IWZ882DQFsvjtz4wsxtTrLFVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269209; c=relaxed/simple;
	bh=L3gLHmGR54K6SZNtYN6NHQ8Yv2YeQe4FVtPT6weNbkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ul950lqNx0aPYEueq/CUY03nR5nkR5H/sAgPGDwWX7faT+zm5Dhheb2a5PcXpDuUNdNEa77kTkuWukRH0zO+yd4MUWnRx+V+HjVBf0lEzpQkHGI6YoNAFncGHil95n8UdTGMDFhifPXeratgbExv9zW+gerIu3eh5vL39M/vZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9Yd1l6y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9Yd1l6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713269207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TqRKbpNBE+kprBkHiETijO6t8ioX2KMP2NFaEORNgog=;
	b=I9Yd1l6yUPqyojmJ8j1L52TJfSzP6hJnm1WioVA0oDTmWY7oT43zLtyuDIV4eEBLuzKUJH
	S2T0fJ5+xykB2on0DugJsy2QaZc8IxMUjoBIcAodiMx4AUG/wdZIOm+3zqxWeOF9q1d2Zi
	C61EkzDfNIfxHRW9b/PqqW+Kpgs3BGE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-ZIG1IKNoMraEgoqhFiWbUA-1; Tue, 16 Apr 2024 08:06:45 -0400
X-MC-Unique: ZIG1IKNoMraEgoqhFiWbUA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343b9425ed1so949798f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 16 Apr 2024 05:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269204; x=1713874004;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqRKbpNBE+kprBkHiETijO6t8ioX2KMP2NFaEORNgog=;
        b=W1Y+8rzKS+Xz7Q3M+X5ojmcx5F4uo5rRFJhMKLN+lqNBWziQZZkdvioi32douH3Eqp
         Y/9+oV8bRDFqE0cwtaCS8zfQMAy3KIVTHY8gTFOYsKJXxnWrCt7ROG6qo7MtCFgmhX7v
         aww3s78Ug0D57zADVyQNJkf+7wt1qO8j72nXR9foU60lwv9PrOF0JTN7q881XC3FB01P
         tG14lR+3RkM2J7nT4QI3eIk1oGdvN48CvdSmdeHdqFLN27cBdNzUCGuxXgutzZZtu6hw
         B9lUqcHxiP8NHQzYMzsJFObS8v8xtV1t16k0rBoqAHmvwuX2zxgqbvRkiLp1Ur6uMpKZ
         7Z1w==
X-Forwarded-Encrypted: i=1; AJvYcCW4uYC6GtWRgcdQIFEDsUD2IuW1ZNfdnrIsiSPUWEB/jg9bv8u1KGYY/o5/baeWAh+eEYhDpfez3XkakxAur81OxkXKhqlTsDA0wg==
X-Gm-Message-State: AOJu0Yyia5qQxAIp6P0jXXtkxHwnNOCl31V+fQSWp4juxeg7wQJb/uSm
	kmqwAaaxAkySytAnxtkSnWWMr/8ijN1XJtq4xRHghf6XsOlx0dnT7rVDO2vxn8nCVSdK/BHdDRt
	S7Sj2//aUgBJo4MQyFHKJVQb62l7V4Trq6kzZjSTdinls2GL2trfAaN7o2l0=
X-Received: by 2002:a05:600c:3556:b0:418:3cf7:7f7b with SMTP id i22-20020a05600c355600b004183cf77f7bmr5411903wmq.3.1713269204735;
        Tue, 16 Apr 2024 05:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp9e8u/HJoCPvdDm1tdgrLn9iFLeuSuJJQGxRhAu4E1tl/xynojmx7/RiaY9ChbsAR72lJDA==
X-Received: by 2002:a05:600c:3556:b0:418:3cf7:7f7b with SMTP id i22-20020a05600c355600b004183cf77f7bmr5411886wmq.3.1713269204369;
        Tue, 16 Apr 2024 05:06:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b004148d7b889asm23021219wmq.8.2024.04.16.05.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:06:43 -0700 (PDT)
Message-ID: <b2573ccf2340a19b6cb039dac639b2d431c1404c.camel@redhat.com>
Subject: Re: [PATCH net] net/smc: fix potential sleeping issue in
 smc_switch_conns
From: Paolo Abeni <pabeni@redhat.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org, 
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com, tangchengchang@huawei.com
Date: Tue, 16 Apr 2024 14:06:42 +0200
In-Reply-To: <20240413035150.3338977-1-shaozhengchao@huawei.com>
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-13 at 11:51 +0800, Zhengchao Shao wrote:
> Potential sleeping issue exists in the following processes:
> smc_switch_conns
>   spin_lock_bh(&conn->send_lock)
>   smc_switch_link_and_count
>     smcr_link_put
>       __smcr_link_clear
>         smc_lgr_put
>           __smc_lgr_free
>             smc_lgr_free_bufs
>               __smc_lgr_free_bufs
>                 smc_buf_free
>                   smcr_buf_free
>                     smcr_buf_unmap_link
>                       smc_ib_put_memory_region
>                         ib_dereg_mr
>                           ib_dereg_mr_user
>                             mr->device->ops.dereg_mr
> If scheduling exists when the IB driver implements .dereg_mr hook
> function, the bug "scheduling while atomic" will occur. For example,
> cxgb4 and efa driver. Use mutex lock instead of spin lock to fix it.

I tried to inspect all the lock call sites, and it *look* like they are
all in process context, so the switch should be feasible.

Still the fact that the existing lock is a BH variant is suspect.
Either the BH part was not needed or this can introduce subtle
regressions/issues.=20

I think this deserves at least a 3rd party testing.

Thanks,

Paolo

