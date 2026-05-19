Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5722FC881
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199471; cv=none; b=Z48maWBy+qN6WD3Q2MjxRPUbT7L/BsY9UhBKxC8jhDrLBhyUWjJbe20Q+3C26e0+rLdj2jdAsGSxqfU2H1lR7I1lwGNxlT28rtCT8/vUnmudJIoThYkycsScEX6z4c6SYWau9R61JBVI9TVK3BnrPIqv0NwrxhMteTDbw09zAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199471; c=relaxed/simple;
	bh=FMaMUKz/x8QbjfR3g5V6+iL3OxM0o0sNRaKeIldoQQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STBTsl5qxPW8tA/+0446Ze6s307DyBXUJCU2VfWrLQLyNav3J9i0LzAu+SskUI1dP2VZDziWZ55gV2KGlGTyWxj1Wn9MgdFhsK1Z4xMomXAjvGJflG+LVDhCZ91U1InEMwCz57pQm29cDDCynaZZkMRZFL6PfNsmOO6d4dDxs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cP4QR9s4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwGqlPGP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP4QR9s4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwGqlPGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779199466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
	b=cP4QR9s4dD8cEYEUak9SkCrANmRUiQBXD7UQtJ0JsZNLhT6I1rfodF5FVi12txuOYTwerc
	qkQn6DZC4kKmsMlusRI7ZUF9RxIzOle3ZZ0T4AdD4IxWNwiCbKfttXIqy71laEhnT9Id7v
	8JpFWCYl28AzCezli0rk7n2RiqdZpSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-PsfhjmNEO4yxU4SVi73Xug-1; Tue, 19 May 2026 10:04:17 -0400
X-MC-Unique: PsfhjmNEO4yxU4SVi73Xug-1
X-Mimecast-MFC-AGG-ID: PsfhjmNEO4yxU4SVi73Xug_1779199456
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fdc746a8bso18232895e9.0
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779199456; x=1779804256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
        b=BwGqlPGPyTAEKuDwo8sJ84HiXt9d6LyIl3O6pJQ3hFJOV4X0PKuplQNp5LYIT5tB3W
         jvYM2P1TV4Ezar8/q2HeMsjw+6oduw9NQD8f/Hb0CxUzal9g5uUqJrYPYRRryByceluC
         dN+sGVRQWEkkApEI9FS4l42ymmv6oRo5fa4yDkCGQYSpQJ+2Kw/S4P2ZS7+TICNjVrMc
         /H2GzVj7PBn6KpvYWQafxXhQfq5dJT5yS3XCF4/o9+sEC6gxlvL4jze434UqMaL0jH3F
         ekmJ6zok9+j/itf1kcEJY5lMyadAa/kjXBfmEp9QEGC+/nTaVVsIpHljlx5YsJjmxU2W
         G0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199456; x=1779804256;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
        b=jLv9/YjKOQF8cy6VPJzec18xfZagwWDfv4+V5ERXZ6foj9d+TxGnqoHtTsOm5VmuyC
         Xq2ckOeBByhXXJa582g0tw5beTP5vlVCI40Tj8kv8yYjq/5ZyTeQ+1VQ5Re5WxNttkTc
         3UEy8qvq1NILiSNE8jXOPQolWRHxlWFQEa5UTOqFeN+w0+L8wftfX0IocRROy0DKOqLk
         i6I9788xgsXJVU7vXlC+yDyGEZMgQiS7cR2fSOry9LnFt7BsojnaqvX9Fh74sE0qCMh9
         EWqcnMHX4tHgmNL0b3kf2uBBtV2dtUnmyBTjRHRMld1zreAw2s8OZtiGWWpp3mV3UnQo
         T8Zw==
X-Forwarded-Encrypted: i=1; AFNElJ/TSFVAe0UmLrBldT0tt08YyjrmFUDUxr5d05nLEpRaxQFjgvF6/rAC+0CXnvyGndE9Vzk7TZ73qazQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6ZD6I+PCxrtNU/Wi5xSUMbmkws/2JmXUQVGxHXe+d+jJLsKP
	7x7QLwZhY+zHvT5ClYAkrrF1U4lUd0YrEnj1Mrr6ipvKEszNZxfMdJpMaKm39JakgIjagZX+02R
	otoabWom7OmqHWwPNXfR9vYAsQ8xZorIfx++oqZmBovgWhNBHin5B+aZndkx+n30=
X-Gm-Gg: Acq92OEZa3SJLa8neZ82sSS0hFDm2y00aAQgwbRbyTtrjcGSUyaWR2R9vRNmuSgqhe4
	7ZwCbwTnewzre4TRqdJnxjc+L3l4XeYrocSdT1nyr64LPZXb1cx5VvabD1cup3XfDOv/LYxmvJH
	yGhq0kXGYfsllP+iMbGpXn3JXCSCBU0rjq4EI7z15Wq3+a6bFlYb+848FyizI0D50O56u5/E6ws
	hkBeXOnFT9BrSKrT5COHHyOAu4vG4YFK6YpGkaMP1/I8JYiGW8xXlmViC3siIfVcfMr/P+rojWp
	uLhtMpkpLXauK8y+i/97fA25U3V2fKUlep0yVlb5kcV8uXFV8ZNs/IR+4361T1bXu6wZFqdpzPl
	6efS/lzOg+fH6kogBwQWLuN1yZJxZiEWbWzyEWiUOtGhtxuKJLHsfwYE=
X-Received: by 2002:a05:600c:34cd:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48fe61f2c03mr335533505e9.21.1779199456385;
        Tue, 19 May 2026 07:04:16 -0700 (PDT)
X-Received: by 2002:a05:600c:34cd:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48fe61f2c03mr335532795e9.21.1779199455912;
        Tue, 19 May 2026 07:04:15 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm337222105e9.8.2026.05.19.07.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:04:15 -0700 (PDT)
Message-ID: <eada2df3-7e3f-46a5-b290-fe0e8975a1bb@redhat.com>
Date: Tue, 19 May 2026 16:04:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] atm: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, David Heidelberg
 <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
 kernel-team@meta.com
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 10:32 AM, Breno Leitao wrote:
> @@ -797,13 +798,13 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
>  }
>  
>  int vcc_getsockopt(struct socket *sock, int level, int optname,
> -		   char __user *optval, int __user *optlen)
> +		   sockopt_t *opt)
>  {
>  	struct atm_vcc *vcc;
> +	int val;

I *think* you should use 'unsigned long' here to avoid user-visible
changes due to put_user() replacement.

/P

