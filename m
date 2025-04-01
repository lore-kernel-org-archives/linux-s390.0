Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206E1EA7C9
	for <linux-s390@vger.kernel.org>; Tue,  1 Apr 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493521; cv=none; b=SzoRwbjcVccryNHfrLiAoB2N6d+4JXVfi/NB91EoM2fp+fI70UmF6Q+LVaNG2NqYZVjxMq70EjBM4Gwkki42t61k0eF79Ntpsw8VWcUd33CTj55q9uoG3p8G0gOFvrYheJ8N5f8QkjCKuB7c/5MUIrfnDjvxQMy9MzNZx2WdT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493521; c=relaxed/simple;
	bh=NJg9loH5DPwUT9RIGGEOKSUIUmJpxXqcl7s9uyAryf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVoxWKkCdLth7Uv4obg4sMLLw4PtfivZDum7b2kMqlu3yBZqRQXvuiSuG76aG4iy4BZ7Sntny7VkHH2EL/X07DWd0cG8gZyce1LaIm+j4LjlmUz4v3nhmJ75MYljJ7CEenn1eFZJFFvAvh1drDtboJMyt4NL8hf6QqCLilebNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHJiW8V7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHJiW8V7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743493515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPVEmBMiCehllT7+kdVA6tb5Y19MZOZXc3+AWueTqfA=;
	b=QHJiW8V7NPmVl5MoG6XXjTJZjQOeLaGk00KoTszdnObmEohnAyEGzAIXuaVkas0urqReAw
	W1VwSy/0tK0ZEc03/NJT3adKrfS06PAVkJUo/yO+iW9f/HegwiWDs5rYajQJKlGciYcf76
	gwGE+/9tKJjOZ0nGqymNpyMNaBpQjY0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-408BWGFsOWa-YL_XrQCtDg-1; Tue, 01 Apr 2025 03:45:14 -0400
X-MC-Unique: 408BWGFsOWa-YL_XrQCtDg-1
X-Mimecast-MFC-AGG-ID: 408BWGFsOWa-YL_XrQCtDg_1743493512
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39135d31ca4so2718874f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743493512; x=1744098312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPVEmBMiCehllT7+kdVA6tb5Y19MZOZXc3+AWueTqfA=;
        b=gG9kK0Pi+AGcyQm0yumQp+4bJi2aW/477KkEqAFY41OosRYGJ9vGynfzS/sOJKB0Mr
         HeW8UMJptdGgYCqFnNZtYQl00stF0q2CA7OtpzOPQBbUdezGxvyqq/HW3kpbV0IBUMD0
         k5cDD5T6oIf/LLhBgiDglapTMnlAAERtQyaumC8f4MWpNIBbd63nOQL5cyft1yMw87u5
         q4BmXHhPyNo1jkU20qWxTHF9MWG1sBC5GR5CAq/+n158D1+T6TCpnI4Fz8ycr/Qgpzo3
         P0v3HVaDAME9Z/YpRBkJAyhoQRBqa8M2i8N1zW+jM0umsh73dNQSZXiSOQsrrm3/baWW
         bKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyQaMlvJMtclfs0Zv0+uzeM8nrewTd6oWL0T6qXAmeW29Pdvw14V7h0HTnA3mA88lARVN90UV3N7HO@vger.kernel.org
X-Gm-Message-State: AOJu0YziRqPx4T9VeMneMs0XlQilHjLkvQF66wh+FG1KmfGyEbSHK874
	KO769lExQOy042y7DTZJEMyk7CXs3NO/Wr4i+rsJjKVB3/96OBeuzHdsWz3T//6pzgAVTMk2Yau
	vGyvsXC+cw5uJlxr0s9gSwjyWk9EfB4cGeAoyjnJQQly3z3LZQX8h1cW/BJ0=
X-Gm-Gg: ASbGncv9FsuucSu1/NAtRQIQ8KYSrNvtp3w4cnS0aCl4k35FjW6rs25T0eMQpi1jneY
	Kp9rtfpZt1U0UN56NHsxeNuqUxSwmp4o/XkRhWXktND+zItZrINRilzLlIlebIv7im+7ImR5nrt
	tkE1LRDDGWV9ZBGerj4aagZKdRD0RH1Dn7w9J3U+LFpdW9drgeKcgg3zlS1D30vBWXyIp2L9fe9
	30JQPSNQlisPEwaLqIJ97EjRDLEgsDSIa+pMEvW7vNYXOkYI4qyBIzqk0YwsidPR5edxV0S+Gzz
	8vXIftCdnSvG1MF+T6/y03GogN+hVj7Rer4NbX8w0pYf1g==
X-Received: by 2002:a05:6000:1448:b0:399:6d6a:90d9 with SMTP id ffacd0b85a97d-39c0c136bd4mr13298970f8f.18.1743493511677;
        Tue, 01 Apr 2025 00:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpGjDvgRuv3rPh+sZzuIo7a1UqtEX2dbLL0x3yl3Qc1zwqWs0cDqxIOuutwoJPuKYJIFAmdw==
X-Received: by 2002:a05:6000:1448:b0:399:6d6a:90d9 with SMTP id ffacd0b85a97d-39c0c136bd4mr13298938f8f.18.1743493511262;
        Tue, 01 Apr 2025 00:45:11 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6630a3sm13423505f8f.30.2025.04.01.00.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 00:45:10 -0700 (PDT)
Message-ID: <d9a7af40-84f9-446e-a708-d989b322a675@redhat.com>
Date: Tue, 1 Apr 2025 09:45:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concurrent slab-use-after-free in netdev_next_lower_dev
To: Dylan Wolff <wolffd@comp.nus.edu.sg>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jiacheng Xu <3170103308@zju.edu.cn>
References: <CAJeEPuJHMKo9T3GcAQH2+X3Rke3b4YH3_S6FmnBp4tQqLciYxA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAJeEPuJHMKo9T3GcAQH2+X3Rke3b4YH3_S6FmnBp4tQqLciYxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 3:00 PM, Dylan Wolff wrote:
> From the report, it looks like the net_device is freed at the end of an
> rtnl critical section in netdev_run_todo. At the time of the crash, the
> *use* thread has acquired rtnl_lock() in smc_vlan_by_tcpsk. The crash
> occurred at the line preceded by `>>>` below in 6.13 rc4 while iterating
> over devices with netdev_walk_all_lower_dev:
> 
> ```
> static struct net_device *netdev_next_lower_dev(struct net_device *dev,
> struct list_head **iter)
> {
> struct netdev_adjacent *lower;
> 
>>>> lower = list_entry((*iter)->next, struct netdev_adjacent, list);
> 
> if (&lower->list == &dev->adj_list.lower)
> return NULL;
> 
> *iter = &lower->list;
> 
> return lower->dev;
> }
> ```

Please share the decoded syzkaller/kasan splat in plaintext instead of
describing it in natural language, and please avoid attachments unless
explicitly asked for.

Also, can you reproduce the issue on top of the current net tree?

> This looks to me like it is an issue with reference counting; I see that
> netdev_refcnt_read is checked in netdev_run_todo before the device is
> freed, but I don't see anything in netdev_walk_all_lower_dev /
> netdev_next_lower_dev that is incrementing netdev_refcnt_read when it is
> iterating over the devices. I'm guessing the fix is to either add reference
> counting to netdev_walk_all_lower_dev or to use a different,
> concurrency-safe iterator over the devices in the caller (smc_vlan_by_tcpsk
> ).
> 
> Could someone confirm if I am on the right track here? If so I am happy to
> try to come up with the patch.

netdev_walk_all_lower_dev() should not need additional refcounting, as
it is traversing the list under rtnl lock, and device should be removed
from the adjacency list  before the actual device free under such lock, too.

Thanks,

Paolo

