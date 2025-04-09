Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D8255230
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195610; cv=none; b=CalowuRDOuAW/loZxYoE5+mbA/xWghSyDXxllrq4Y69RlS2P5hQ9/qM4RdkoQq5RTyV3SEqL6UbxjZf1W2LlIQ6pC9w81HbEuIY0tiBfORcadUFcIg7ALsw2t5xnpcrxGBfQaTu80iMeGOfrvyObgKteRmjNr0yiU1kN03x+XDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195610; c=relaxed/simple;
	bh=A2izym1Utk7diiSIRS/WVNxBg+tpqvZb4BlF0EjbH74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYeOANNQR8JWMU2fgvUlujis8IWL6zVHaSqhiWSWLgN0W4QBJFzgGf+Fsm+VT8GpOo5x7JMkZXeI42S9ga+HN7payzfCWYXKGsvqwLdYTO7XdnZ97AP3X1e3ET+7Y0N3AWnyGxXLAZ4OZ56DYXXTmntqpa62XMIyTv37fyyTohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xd6xezr9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd6xezr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744195607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C6GURs+rA2kl1DB3dCBq9SPCewqe7vVe7c7T2yJZQFo=;
	b=Xd6xezr9cfaP1+qjkrXqaw6ZKXqtL4Ce+gIuOQ2O+3SsF+NZb5lIlDP+vXfu0UVwwR3s9v
	6mw75wRq4wmJTPF8OlQGM3HxymGJaj1awu5eM3qUjurZ0YdrMPG+WL4ehMZ13m0cpCJ+E2
	tXQYQBdkXVg+NdMQV7uWlV9RLs1bhE4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-bPxCv-PhPGiDNFj2Sd2XiA-1; Wed, 09 Apr 2025 06:46:46 -0400
X-MC-Unique: bPxCv-PhPGiDNFj2Sd2XiA-1
X-Mimecast-MFC-AGG-ID: bPxCv-PhPGiDNFj2Sd2XiA_1744195605
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso47249515e9.0
        for <linux-s390@vger.kernel.org>; Wed, 09 Apr 2025 03:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195605; x=1744800405;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C6GURs+rA2kl1DB3dCBq9SPCewqe7vVe7c7T2yJZQFo=;
        b=CUwgtg11JT4gnqhGp1RvodV3FMAgY/2gJJ8wFzrxCw0Y6SPfBCnMigU+yZqYrDy3yU
         RmUnEIYgiKTDJVa8F6SW/xZcEDw4fhCjPVohL7OmjrGXiSulQhpm1qSAJL4BZehYsZlJ
         hTcvk3/JAKCvCDUPrir27jyFeK6FRvr8ZPzntLm4g6i/TCRDcJ4rSw/JonHB2Uqjoc9P
         oCUSoZE8/iB1jSTPPcBJkzRVM9ii3tmQiCmdVmmAIgl2XwwnIehlDXv0GFSdowbmeCeI
         g6lwaBG4bSMYpHxhxWYn9bFs1B+ctLgSlKCHDE/I4EVs+yu31lqsGXPU56TRz131ou0/
         msww==
X-Forwarded-Encrypted: i=1; AJvYcCW2viPj8LmGzxueVtA1NzRVdxmPB/BfDmd/1yMWLIKkkLMEaFF1nx8OXpOgpfMFuohfkdUICVTKolOq@vger.kernel.org
X-Gm-Message-State: AOJu0YzhiOsudiduVmT6MjwldtUywfx1Wz49rNO8hnz+00Rdt8R/cPhx
	0wULg1r35QPs3F22jgthi9q65R9UEUReE/1gOuzpp28BiIEHEH/k/qz8TWnQzX1IOWNkpKY2U/I
	f6GgrNTdhfBD2eKkw6lNs/6U9rC886da1iTSCDwQC0rpEllpRkLMm1rwd+dY=
X-Gm-Gg: ASbGncsPR/uzX9PfsL4DIva9o20Kp41O8fAOzmrc/qjVXq+hOBzgUNskT5J8es6eATd
	4PeTtgRH6dNHxurFjNfBV8P5fFarh2fpnjI0ZMMoFzuv8Pjdv5nddrqmD9zfRSYRSU++DKeURqI
	dB9WGEeW7Rjlh276wWlPG1iYbv+YRTIUbnW8KBogRV7jVN9zlgQ0IN1fLjl+DTHRheM4Pr7g1XK
	fxMJ9+sOClNh/H3jnyB40cFVCgF6LiVgaOgb7GUw1X8+5Cr4ONOqoPm793TDuHoUhHhH4ajUhn2
	F2f3G5HXKNLHNvgcCxY+mGqgxOLxT4YHoFZTd0Uz81YAK5DnlsTCP0X8wTYsdksM/4mhipXpXc5
	jloVqtEjKtV6hjdgwLQNE7JbiKxdyKTXG1Q==
X-Received: by 2002:a05:600c:3541:b0:43c:e467:d6ce with SMTP id 5b1f17b1804b1-43f1ec7ccf2mr23763525e9.4.1744195604948;
        Wed, 09 Apr 2025 03:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmXr3kF+YruO7Uq1wa7mPMZCskFwiPljKb7DzlEdURTSUO/hZuYTN96OR5ijWouCv8RJEFvQ==
X-Received: by 2002:a05:600c:3541:b0:43c:e467:d6ce with SMTP id 5b1f17b1804b1-43f1ec7ccf2mr23763245e9.4.1744195604612;
        Wed, 09 Apr 2025 03:46:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:8400:ed9b:a3a:88e5:c6a? (p200300cbc70d8400ed9b0a3a88e50c6a.dip0.t-ipconnect.de. [2003:cb:c70d:8400:ed9b:a3a:88e5:c6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm16164845e9.22.2025.04.09.03.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 03:46:43 -0700 (PDT)
Message-ID: <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>
Date: Wed, 9 Apr 2025 12:46:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>, Halil Pasic
 <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
 Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Wei Wang <wei.w.wang@intel.com>
References: <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
 <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
 <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
 <20250407170239-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250407170239-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.25 23:20, Michael S. Tsirkin wrote:
> On Mon, Apr 07, 2025 at 08:47:05PM +0200, David Hildenbrand wrote:
>>> In my opinion, it makes the most sense to keep the spec as it is and
>>> change QEMU and the kernel to match, but obviously that's not trivial
>>> to do in a way that doesn't break existing devices and drivers.
>>
>> If only it would be limited to QEMU and Linux ... :)
>>
>> Out of curiosity, assuming we'd make the spec match the current QEMU/Linux
>> implementation at least for the 3 involved features only, would there be a
>> way to adjust crossvm without any disruption?
>>
>> I still have the feeling that it will be rather hard to get that all
>> implementations match the spec ... For new features+queues it will be easy
>> to force the usage of fixed virtqueue numbers, but for free-page-hinting and
>> reporting, it's a mess :(
> 
> 
> Still thinking about a way to fix drivers... We can discuss this
> theoretically, maybe?

Yes, absolutely. I took the time to do some more digging; regarding 
drivers only Linux seems to be problematic.

virtio-win, FreeBSD, NetBSD and OpenBSD and don't seem to support 
problematic features (free page hinting, free page reporting) in their 
virtio-balloon implementations.

So from the known drivers, only Linux is applicable.

reporting_vq is either at idx 4/3/2
free_page_vq is either at idx 3/2
statsq is at idx2 (only relevant if the feature is offered)

So if we could test for the existence of a virtqueue at an idx easily, 
we could test from highest-to-smallest idx.

But I recall that testing for the existance of a virtqueue on s390x 
resulted in the problem/deadlock in the first place ...

-- 
Cheers,

David / dhildenb

