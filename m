Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AD26AA8C
	for <linux-s390@vger.kernel.org>; Tue,  1 Jul 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360579; cv=none; b=kch/xNaKxsImWliezv3v4aJ0e8OVjJ34kLaHZYLgATlci1oUd3vJXETlRUigI5QTy4CmZBA07UYhW0jLNaGz5k6AS4spShjV/Sd5L3w+Ks6GtE3BSRACmTJj4iEYRpc7feV3z4Il7qjSnbto+zkBVrTFq9a0kXPe8C0wuJ7ESxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360579; c=relaxed/simple;
	bh=1CRUAXr5GBbRdmumb0+cV0Od7MCxxqW2fhnqqDHHk8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxDYgVOJqxcs4ejrNr5V4VIZ4Er5seu+PNeZstB8+OhhrpzInGUcJ5eoLwlU3BqVsEnN2AvrCx8/w62jeNWxLtz/7SU3zm9mrJSKUjI3x0yFNlNGMsWwYiwQ8zzntQ7ERB64E84ZtkWBIzoFolevVU0ELC3sDAm1EBSpgJtVkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+gHXcV8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+gHXcV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751360576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odFmyP7U2sVYXt+ILmpIyMRKTHdQ4Z+Ben4YpGt3RBA=;
	b=Q+gHXcV88/pQIu1kcI4uU1ZtbqLwG6jQDQw7WkWsAtQgFx6Ftg1WbMqueMTf7Kw2EiSOJM
	1kCyrQKFST4ByxR6QRkZOQMc9SWFVpBuzrkpF269h/VjfptgJJi3KwXYwcK6+8+HWOyEdo
	ikpEsIXlJUHIO56Q54iyNKaMUFQ0f0c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-2G90n_ciPzefeVrRDPhy0A-1; Tue, 01 Jul 2025 05:02:55 -0400
X-MC-Unique: 2G90n_ciPzefeVrRDPhy0A-1
X-Mimecast-MFC-AGG-ID: 2G90n_ciPzefeVrRDPhy0A_1751360574
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso3552298f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 01 Jul 2025 02:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751360574; x=1751965374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odFmyP7U2sVYXt+ILmpIyMRKTHdQ4Z+Ben4YpGt3RBA=;
        b=do7Bh98S58xZg3comW8jonx1gDk1nPdJeksJcOd5QDgmalKsrFCDTSIAqIOC0o6Dsg
         Az+3hyUVdnBv2LpiIUpcQ+waEP36i3KWtIYhH7PYd2JlYD3Q4RTkxuBc74ggN3k7W9SH
         n+pYVplh0hocnrnHNLUDXPVmvQHShMo0mX0Utc7GoDin5Vk+1vL1BwV6t7p3I4z92ERx
         XR1BTJile4WbV0Ffy1q3LYJ7RPFIUq6XSVAApDWfnzHrJifcrrZpZwNaElCtbqwbjbxy
         x7YO5C5+ozi+U+fE3277Md3ynZ2HUy4soZji7oMelxuR68dBP2kSCnn6FMJFd4OXpGw3
         lu6g==
X-Forwarded-Encrypted: i=1; AJvYcCV0fsPZqCxz14aVJmEZ/n/+pVZgEIaZjgNU0iVwSJWs8GHXeBs8pLPW4OVX8ZVGm20t1nq7aPps9k8l@vger.kernel.org
X-Gm-Message-State: AOJu0YyHh5vQahayIQahQdTfGkiFNmXwT/ju0kzdegRROQmXhn89Iagh
	qkMqxu6TzEMPr+PnlclOy8uWBloC5w6Aah2PMpTtScEUfZx21z1m5ap+71zksJjHxj4OrfL/TS6
	LhPJe57LyykzCtW8SqDecJlo5k/V+ihXkC1XpinIEYQL7E+gsG/xxvEcf7ZJN8NI=
X-Gm-Gg: ASbGnctmf0EXvK2419qWPHXiNoIbM097XMoyvcQEPkE36aJpsm+ydNgVna6TQJzSdHi
	xl71H0zhSLg+IiYxTfrMlpkXHsQFgMTrCGEEYG3UcTqcKfbhPqhNvF5zc5u7ijtq/RmcMjMfz6M
	M4iUMun4kELPifIODnL/Oy3g9bivQ8QPEwM3A6B/KbPR1rImEWlrjIh7B4LzpBh6yfssazhZV7Y
	VedSjykGnoa5uDn/r2UMSTVCLsz6Y9ETRindoXaDuxeLZtJKOxrxpFvAweLU9obOv2Zl1eTtF5I
	jIqddOTk3HlBgJj5oOn2lDYyrEuXj02eYnDUHZHM8Pxorw1f3rpF23Y2nQhBuse4daIWHw==
X-Received: by 2002:adf:f6d1:0:b0:3a5:52cc:5e29 with SMTP id ffacd0b85a97d-3a90d0d7317mr11929790f8f.7.1751360573691;
        Tue, 01 Jul 2025 02:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYRKtwQ5aZnc0XqPhfEJjz3LC5qLMurZ/9vUE7Xlx2VhB/BrreyXJkwS9hDRJ79YaRjeUeIA==
X-Received: by 2002:adf:f6d1:0:b0:3a5:52cc:5e29 with SMTP id ffacd0b85a97d-3a90d0d7317mr11929762f8f.7.1751360573210;
        Tue, 01 Jul 2025 02:02:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm161825945e9.29.2025.07.01.02.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:02:52 -0700 (PDT)
Message-ID: <c405f957-0f88-4c88-98d7-3a27e5230fc8@redhat.com>
Date: Tue, 1 Jul 2025 11:02:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] net: Remove unused function parameters in
 skbuff.c
To: Michal Luczaj <mhal@rbox.co>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
 <20250630181847.525a0ad6@kernel.org>
 <beea4b9f-657f-4f98-a853-e40a503e2274@rbox.co>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <beea4b9f-657f-4f98-a853-e40a503e2274@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 9:27 AM, Michal Luczaj wrote:
> On 7/1/25 03:18, Jakub Kicinski wrote:
>> On Thu, 26 Jun 2025 10:33:33 +0200 Michal Luczaj wrote:
>>> Couple of cleanup patches to get rid of unused function parameters around
>>> skbuff.c, plus little things spotted along the way.
>>>
>>> Offshoot of my question in [1], but way more contained. Found by adding
>>> "-Wunused-parameter -Wno-error" to KBUILD_CFLAGS and grepping for specific
>>> skbuff.c warnings.
>>
>> I feel a little ambivalent about the removal of the flags arguments.
>> I understand that they are unused now, but theoretically the operation
>> as a whole has flags so it's not crazy to pass them along.. Dunno.
> 
> I suspect you can say the same about @gfp. Even though they've both became
> irrelevant for the functions that define them. But I understand your
> hesitation. Should I post v3 without this/these changes?

Yes please, I think it would make the series less controversial.

Also I feel like the gfp flag removal is less controversial, as is IMHO
reasonable that skb_splice_from_iter() would not allocate any memory.

Thanks,

Paolo

