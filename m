Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F827FBBE
	for <linux-s390@vger.kernel.org>; Fri, 22 Mar 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141357; cv=none; b=KapxO57H6/M+Mz5wtjjZMt4bxLRzId1qe1wTc3mxJuEjbkfb5i/9WB8coPTpvGrx8oT+G6alW3tTH3k4ypRQHl9C/ztRA/OeTA8UV8jpekVxyvi/1c8zSMssOFvkzXwCU79Xs+48PmK5wnMk6D3zsbQKGI4PjLbv0ShVoDK8Un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141357; c=relaxed/simple;
	bh=MJOUiylT1gO5PYdopB+gDEf0uAhJHYMUDIxAepGiL8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2SAylooNBcmaPPeaRATYqc712xLyYS5zwhHQj7MicpeVBWdkFoUf6itTXGrn6PuEnrCaTpha4QBXdcqM4W+UMdk8rw5NmVUz1Sm6aws179LpkIt/e0hqkMITCAqq9ycS2p5IuTo9XpzRSKL2fJRu9+6GJ9GFXbTYpy8SH0kywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYNsDHEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYNsDHEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711141355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PFVyegIhf//HHhHfQmh5NpqjlKK9ka89h1dvT9SewD8=;
	b=bYNsDHEivvcw3cHzxQSFd4dkBb/hXZj0aBAOmFTibWk7yCS9IYsFMJP5mzhH74dalCYiQ9
	cC5O+XKDAcWe5zielp18evVVCvBHR7IRJ12zM3999UU5/yXq9Ua1g3Dddd6QW17RoQDoGF
	Df5dgJL0qoZITYPXGby3yq6gesl+WMo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-jnCuowSUOQOLzyykSfB5eQ-1; Fri, 22 Mar 2024 17:02:31 -0400
X-MC-Unique: jnCuowSUOQOLzyykSfB5eQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ed44cb765so1170023f8f.2
        for <linux-s390@vger.kernel.org>; Fri, 22 Mar 2024 14:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711141350; x=1711746150;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFVyegIhf//HHhHfQmh5NpqjlKK9ka89h1dvT9SewD8=;
        b=fLON6E43l9Ud4jnHCNFuQ8gFmBQMX+mLtBJVt/HhilCM4jHDaLYg8EOf4aOgHnecr+
         y9pEc1fvbziMR9yMfIgSKOQVe4sP0z1bNWaw7Ru+rZe6/P+Jp3etaZFxMJDEzSE/GFgZ
         6Mhm+/aAjzwTfRFHHaCoMtmbMTunmEKBweNrTWCoo/mdXuPTV2rDShxYKUK1XYy04thL
         hSs0C1LBM5dOXzpDnd/9n3iBRGf5i6UaXe0YGIrkUeJC5EoJIcSUuqnrfB8YgK7Z9tOL
         wUE5wmvm0yvkLegk3tLz3HC7MXjzzIk45G9AFS4eoXW3stanikDkyCWQ78/VPwxqJONX
         zddQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9M8KGf03zi0EAUAaUn3HIbUWgYx3i0cjyXCdjbym7xr8CAka/71k0eF4ipGjm+pmBKVJQ0hziAAM4fFeFVMEN2jlJMZ1yo3vjkQ==
X-Gm-Message-State: AOJu0YxbTjT698BkTuZj3F+uVOWNsosR86VzYWOvHPvbzHztHao0uokO
	K6FDWZCTEbLO9bSnSqLSlZ0J07yq+WFDfkE3w91OnDRqOJfKDryil1BrPctUemBDRah1Qw3u86C
	yFyUf8Z1Bqyh6YhdnacQ6OTuOACJhdi6iCzem6F8+f5U1jik3TG+f2ecwhao=
X-Received: by 2002:adf:f544:0:b0:341:a813:2679 with SMTP id j4-20020adff544000000b00341a8132679mr310982wrp.29.1711141350249;
        Fri, 22 Mar 2024 14:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaqp+JyTk4JX0MqO3wQQNDlBTOTaTSJHLvU5DsMsBkD33yBR1gLLawTwsXpzKlCPKxd+Etog==
X-Received: by 2002:adf:f544:0:b0:341:a813:2679 with SMTP id j4-20020adff544000000b00341a8132679mr310953wrp.29.1711141349682;
        Fri, 22 Mar 2024 14:02:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7e00:9339:4017:7111:82d0? (p200300cbc71b7e0093394017711182d0.dip0.t-ipconnect.de. [2003:cb:c71b:7e00:9339:4017:7111:82d0])
        by smtp.gmail.com with ESMTPSA id dw1-20020a0560000dc100b0033e3cb02cefsm2861423wrb.86.2024.03.22.14.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 14:02:29 -0700 (PDT)
Message-ID: <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com>
Date: Fri, 22 Mar 2024 22:02:27 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
 names[] is null
Content-Language: en-US
To: Daniel Verkamp <dverkamp@chromium.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
 <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.03.24 20:16, Daniel Verkamp wrote:
> On Thu, Mar 21, 2024 at 3:16 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>
>> Currently, the init_vqs function within the virtio_balloon driver relies
>> on the condition that certain names array entries are null in order to
>> skip the initialization of some virtual queues (vqs). This behavior is
>> unique to this part of the codebase. In an upcoming commit, we plan to
>> eliminate this dependency by removing the function entirely. Therefore,
>> with this change, we are ensuring that the virtio_balloon no longer
>> depends on the aforementioned function.
> 
> This is a behavior change, and I believe means that the driver no
> longer follows the spec [1].
> 
> For example, the spec says that virtqueue 4 is reporting_vq, and
> reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
> but there is no mention of its virtqueue number changing if other
> features are not set. If a device/driver combination negotiates
> VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
> VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
> that reporting_vq should still be vq number 4, and vq 2 and 3 should
> be unused. This patch would make the reporting_vq use vq 2 instead in
> this case.
> 
> If the new behavior is truly intended, then the spec does not match
> reality, and it would need to be changed first (IMO); however,
> changing the spec would mean that any devices implemented correctly
> per the previous spec would now be wrong, so some kind of mechanism
> for detecting the new behavior would be warranted, e.g. a new
> non-device-specific virtio feature flag.
> 
> I have brought this up previously on the virtio-comment list [2], but
> it did not receive any satisfying answers at that time.

Rings a bell, but staring at this patch, I thought that there would be
no behavioral change. Maybe I missed it :/

I stared at virtio_ccw_find_vqs(), and it contains:

	for (i = 0; i < nvqs; ++i) {
		if (!names[i]) {
			vqs[i] = NULL;
			continue;
		}

		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
					     names[i], ctx ? ctx[i] : false,
					     ccw);
		if (IS_ERR(vqs[i])) {
			ret = PTR_ERR(vqs[i]);
			vqs[i] = NULL;
			goto out;
		}
	}

We increment queue_idx only if an entry was not NULL. SO I thought no
behavioral change? (at least on s390x :) )

It's late here in Germany, so maybe I'm missing something.

-- 
Cheers,

David / dhildenb

