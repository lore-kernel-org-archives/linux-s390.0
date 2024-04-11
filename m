Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717713DBA7
	for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819006; cv=none; b=X1DH2by/7QPo9tj82Y9Ygugl7MMnf8wJEOWm6IrM0MG5sp8qlQSF09qGZ/UO+CaXmAdJ2X6vZ6TnpHClM3j9CRM37hNb46WfqNPKoxf1MEdrlw35Lvy32xh/PqfijXrRIM2hX/OSfDjLkkQ/QF344Eg4j/NTLu/XlsX9kHUmBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819006; c=relaxed/simple;
	bh=AubONOFaA+RUpGeBw5HQNnZdsscRirVIaGi7Lfko5X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQx0QcUAc8XTasMDfNjcgnszdZpi9qJh6JWpykAcom/DCDcmkfNrQBMqHeWfXz7Ijpe6KLfJVSxzQdlxsqGIiXgdCEgD/BhSHuPbLlUUCyUs8iN1enYhRFQ5lADJGEcMabpb684PIBNtpd8zdntNlZwkWZ0tXvjYBVUyWV/qujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKW1dsna; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKW1dsna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712819004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QtHuNib59Is1i1vCWC4Y3CGuwoHokuKi4jrm90ujf+8=;
	b=SKW1dsnaKQOTzeSc7bt7LyZGxp9/sfXUih2yLf/N8NkF88s5/tIjVQndGTDwTs60BBFRxp
	r56d39M0Ki8yuNP/w8BJlvT+338sE5/JZtCnsqUqSL4J+SgK2RoVofvxGvX/Sw0prYfQAc
	qZ2U4trtixMR7Gr8mSKyL2qZ6AnHj7Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-vfaVfwmCML-AZ19k4MMQFQ-1; Thu, 11 Apr 2024 03:03:10 -0400
X-MC-Unique: vfaVfwmCML-AZ19k4MMQFQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-789f2dee101so697828985a.3
        for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 00:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712818989; x=1713423789;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtHuNib59Is1i1vCWC4Y3CGuwoHokuKi4jrm90ujf+8=;
        b=JN0gcd6WrTyuW+eM7pIKOsSAZtr4nfFXGJtGdBqOZFEQH8qO77NSfQvWDZZzzmb1UE
         3ubcRNQEc3EAA3xz57bHy5yxoQ6SXO03pM3pvXu4+++HvRnSmvgs2gE8kZcO4Rq5SOju
         xjfsEpPj/sFSr4TYnjfbYsqEcbl4jz+hQc8giAFX4f/+/xbfWq2S73yXjzyniQwr2vhN
         7JbI+aki6DZBRzZ5+Wve1xTr4SU2updTNM2O2jSqRLxGciyu5VQK1g2Z+3A5hifTwiG8
         /H2HDQNg+1Ke027pu0eag03uPznKLs2w4KQSvatfu5Jom+YyYRfdnpwEqjGNm6wcbEya
         dnXw==
X-Forwarded-Encrypted: i=1; AJvYcCWoG7uDOjMSOS7uazX6XHcpGSWSk7fanNALHDTpJln35aPQVZ6IWZGNsggcIF14BqxWQHalrNDOlbkVWIyuH5bJfDI4PG7IF3/afw==
X-Gm-Message-State: AOJu0YwSvq+9USdlW4NS9NfcUzRCyDSK84fBlZbmyr97tRhizc5Lb1wo
	qstAvI25U04KpQu34gtkTofUaSwfyhrBDdz+t/k79vYIyEBz0WDSeMRUUEGB0SV1yivaS6age7b
	mY6qczbVDlhj7+8xfNnWxt0wwnaJoH/TU9/YBEanzhXqhrqcd0N59SVYBSiI=
X-Received: by 2002:a05:620a:2725:b0:78d:6791:34d1 with SMTP id b37-20020a05620a272500b0078d679134d1mr6228753qkp.9.1712818989598;
        Thu, 11 Apr 2024 00:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGau4WYtOsSPLHVhfKvR0HvdfS+y2KoW25hx7BRdsuJh5si8R2fP0b6I2mR4Dl5Kta6TgQKjg==
X-Received: by 2002:a05:620a:2725:b0:78d:6791:34d1 with SMTP id b37-20020a05620a272500b0078d679134d1mr6228725qkp.9.1712818989317;
        Thu, 11 Apr 2024 00:03:09 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-142.web.vodafone.de. [109.43.179.142])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a145600b0078d68b23254sm628581qkl.107.2024.04.11.00.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:03:09 -0700 (PDT)
Message-ID: <27ba7613-1344-40b8-bc4d-9a9903ebdcfa@redhat.com>
Date: Thu, 11 Apr 2024 09:03:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC kvm-unit-tests PATCH v2 01/14] Add initial shellcheck
 checking
To: Nicholas Piggin <npiggin@gmail.com>, Andrew Jones <andrew.jones@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, =?UTF-8?Q?Nico_B=C3=B6hr?=
 <nrb@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>,
 Nikos Nikoleris <nikos.nikoleris@arm.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Ricardo Koller <ricarkol@google.com>,
 rminmin <renmm6@chinaunicom.cn>, Gavin Shan <gshan@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20240406123833.406488-1-npiggin@gmail.com>
 <20240406123833.406488-2-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240406123833.406488-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2024 14.38, Nicholas Piggin wrote:
> This adds a basic shellcheck sytle file, some directives to help

s/sytle/style/

> find scripts, and a make shellcheck target.
> 
> When changes settle down this could be made part of the standard
> build / CI flow.
> 
> Suggested-by: Andrew Jones <andrew.jones@linux.dev>
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
...
> diff --git a/README.md b/README.md
> index 6e82dc225..03ff5994e 100644
> --- a/README.md
> +++ b/README.md
> @@ -193,3 +193,6 @@ with `git config diff.orderFile scripts/git.difforder` enables it.
>   
>   We strive to follow the Linux kernels coding style so it's recommended
>   to run the kernel's ./scripts/checkpatch.pl on new patches.
> +
> +Also run make shellcheck before submitting a patch which touches bash

I'd maybe put "make shellcheck" in quotes to make the sentence more readable?

> +scripts.
> diff --git a/scripts/common.bash b/scripts/common.bash
> index ee1dd8659..3aa557c8c 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -82,8 +82,11 @@ function arch_cmd()
>   }
>   
>   # The current file has to be the only file sourcing the arch helper
> -# file
> +# file. Shellcheck can't follow this so help it out. There doesn't appear to be a
> +# way to specify multiple alternatives, so we will have to rethink this if things
> +# get more complicated.
>   ARCH_FUNC=scripts/${ARCH}/func.bash
>   if [ -f "${ARCH_FUNC}" ]; then
> +# shellcheck source=scripts/s390x/func.bash
>   	source "${ARCH_FUNC}"
>   fi

  Thomas

