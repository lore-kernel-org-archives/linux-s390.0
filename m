Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02998D2E0
	for <linux-s390@vger.kernel.org>; Mon,  4 Mar 2024 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533350; cv=none; b=hGUEkR3cMKwU0ZDDaTP5+Cy9pVieMI0sJBvqK6kHVOj4xtJXf2alhFDxGn7p6eU9bktZovTzjZRfdhgO29kj9JkQc/N7PqMVQfzlrZyPf74W+I7Es8G99eJuKWnWBw4IbWJFuokLxB3A+MHRSqKncazRMg0AwR+qtoFAJlNPxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533350; c=relaxed/simple;
	bh=oaAYSn+CKMr5zZbFL1nS28YJwe1FjjDu01N2MiMMLIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMVO86KkuRCpReQ8+RE9KpCc1uztUIOMFMWMFepRMKRW7wXu0OoahxJs5qr4dZEYeM3zJKeObKi3HfFSlVXjL4z8WDo1KdBSk5EzjwXNcHckbBAiayQJs5UxaAEM6sceskTtXyXtIkU1117f4FlyqjqOG9vXcndZHbAvvT3uLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3slO4RT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3slO4RT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709533347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0vc4Zmb8L094rZ1gY9Cchmv8ksKAo7EZKhul8nM1Mw4=;
	b=T3slO4RT1hVFDK9MeCGrAfcHW9V2c8GKIQca+6HkLelGzEW80nxsNycygMNbQWWxe/Aq3I
	r3m+lB4ajpfUQwgtnTMBs488/07+fPycj4ET9hS8iWuqZQHZnGp0+1hP3M2eUucdYmEli8
	mgx+RI9CTAB+Lc/utqWW/aBktr6Redk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-LeurN9uaPi2USFkax7yphQ-1; Mon, 04 Mar 2024 01:22:25 -0500
X-MC-Unique: LeurN9uaPi2USFkax7yphQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78812ef08ccso294523785a.0
        for <linux-s390@vger.kernel.org>; Sun, 03 Mar 2024 22:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709533345; x=1710138145;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vc4Zmb8L094rZ1gY9Cchmv8ksKAo7EZKhul8nM1Mw4=;
        b=jFKCj5A0kSmfh4DEffINcvvCSIkJwW+0fHkvRCH61W75egYirDtqMJ1B07gp+vjnXt
         aPL8oE44UoT+0Gd3+23z7dqR6LviqxSatVfcLdipJn867dlHt3dzSm+k08SNp5I7hRmc
         30IUXIAR5KPDwEgbnPVDW/Gh19jrVTdGpQwBCksxsf5hgrpVx6LjIp0Od88Mj3qAXCh1
         AbW7oDKdWR7dPB3yxAc1qstQCU2ftHbxCACl/Sr2HX1+xlrQWVGpWp2zHCBviuUCgQf0
         KmzjaDXPHH2dUW/DFogf4GMDkvixLLaXsSBwtRGN+MCaal+RUITTlaDQC/h1eIp3Qi2C
         s+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVmA2qv+bsmZflxW3yhMX24DwwNM99OPLF8af0j11uKcAt10CjkySnUUSLQ2mOvJ5RCoaiAq7pAgPry59uvj6CVnbWQHuymwEPnLQ==
X-Gm-Message-State: AOJu0Yz+PWdGjyligjFUUJiw1CrvP6GIHGWGAKN0ZTACqVUa5vtmbfEo
	ImsPQnIyhoe7kFlTXejJIKiBKHu5hbSdk47VmuNje490pc6Y4BBfkQ+lD6/knV1F4qNm0UygWEq
	RcMUREPtORwxkRQrU0DD5Rigqcyzy6s6aFDxdzOpEZTJ71hPCjIQlNYW7PDI=
X-Received: by 2002:a05:620a:469e:b0:788:22e4:8c56 with SMTP id bq30-20020a05620a469e00b0078822e48c56mr4797927qkb.18.1709533345442;
        Sun, 03 Mar 2024 22:22:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK9JEmr9SYlUiIXaA+KwOw+p1F2N/m4FvMas+Hp7eeKx8Gu//kaDRmYmveE91UGdsqJTa7nA==
X-Received: by 2002:a05:620a:469e:b0:788:22e4:8c56 with SMTP id bq30-20020a05620a469e00b0078822e48c56mr4797865qkb.18.1709533343297;
        Sun, 03 Mar 2024 22:22:23 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de. [109.43.178.133])
        by smtp.gmail.com with ESMTPSA id op36-20020a05620a536400b00787930320b6sm4060260qkn.70.2024.03.03.22.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 22:22:23 -0800 (PST)
Message-ID: <e967e7a6-eb20-4b2b-ab7a-fc5052a3eb52@redhat.com>
Date: Mon, 4 Mar 2024 07:22:18 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 7/7] common: add memory dirtying vs
 migration test
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
 <20240226093832.1468383-8-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240226093832.1468383-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 10.38, Nicholas Piggin wrote:
> This test stores to a bunch of pages and verifies previous stores,
> while being continually migrated. This can fail due to a QEMU TCG
> physical memory dirty bitmap bug.

Good idea, but could we then please drop "continuous" test from 
selftest-migration.c again? ... having two common tests to exercise the 
continuous migration that take quite a bunch of seconds to finish sounds 
like a waste of time in the long run to me.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   common/memory-verify.c  | 48 +++++++++++++++++++++++++++++++++++++++++
>   powerpc/Makefile.common |  1 +
>   powerpc/memory-verify.c |  1 +
>   powerpc/unittests.cfg   |  7 ++++++
>   s390x/Makefile          |  1 +
>   s390x/memory-verify.c   |  1 +
>   s390x/unittests.cfg     |  6 ++++++
>   7 files changed, 65 insertions(+)
>   create mode 100644 common/memory-verify.c
>   create mode 120000 powerpc/memory-verify.c
>   create mode 120000 s390x/memory-verify.c
> 
> diff --git a/common/memory-verify.c b/common/memory-verify.c
> new file mode 100644
> index 000000000..7c4ec087b
> --- /dev/null
> +++ b/common/memory-verify.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Simple memory verification test, used to exercise dirty memory migration.
> + *
> + */
> +#include <libcflat.h>
> +#include <migrate.h>
> +#include <alloc.h>
> +#include <asm/page.h>
> +#include <asm/time.h>
> +
> +#define NR_PAGES 32
> +
> +int main(int argc, char **argv)
> +{
> +	void *mem = malloc(NR_PAGES*PAGE_SIZE);
> +	bool success = true;
> +	uint64_t ms;
> +	long i;
> +
> +	report_prefix_push("memory");
> +
> +	memset(mem, 0, NR_PAGES*PAGE_SIZE);
> +
> +	migrate_begin_continuous();
> +	ms = get_clock_ms();
> +	i = 0;
> +	do {
> +		int j;
> +
> +		for (j = 0; j < NR_PAGES*PAGE_SIZE; j += PAGE_SIZE) {
> +			if (*(volatile long *)(mem + j) != i) {
> +				success = false;
> +				goto out;
> +			}
> +			*(volatile long *)(mem + j) = i + 1;
> +		}
> +		i++;
> +	} while (get_clock_ms() - ms < 5000);

Maybe add a parameter so that the user can use different values for the 
runtime than always doing 5 seconds?

  Thomas

> +out:
> +	migrate_end_continuous();
> +
> +	report(success, "memory verification stress test");
> +
> +	report_prefix_pop();
> +
> +	return report_summary();
> +}

