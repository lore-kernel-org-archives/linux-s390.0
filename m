Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A72550DD
	for <linux-s390@vger.kernel.org>; Tue,  5 Aug 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395760; cv=none; b=j4XMC2MSeABGDAtvPZgkLgjEu4pVPYqGXnkneKVs8Btla4Awdrx6Oei4VgRXTGHNljfEPXzOWaLiYE7PdiQXzP7uR8QeMj4ug5dKhYUCYSKN8v65FrJO6AjCXFmfXiMgs2LavwQKhwdJJ0JgG3Dhx1j7TtMd9loQxhnFfmeNbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395760; c=relaxed/simple;
	bh=4YEkrQgKpa9tyVagW9cBfffSfEXxSwg1X6OxfJYO19g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiEy/A0Qer9ayHQBPSy7H00DhisJaLVkhice+WboQo+T8pBLxCEqPQc2bMjmooaiFUrS/UXd0phn7InBSpsIkzj3drxQB512hI9pIuprDdKR1vzQFj4pp77cCN9mlDSkDMqN4N93opixjyeD3upX8L/VD+KTGvJlHqpwDk8mt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O66zRrwb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O66zRrwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754395756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yHxtl1DwwIyTZIgGScRCJCvFqJGnoli7ahv7PabNDIs=;
	b=O66zRrwbJ12fy2NfFic/qDGlkfd19bZhsBGVtjHd0yH1oGvbJLGAx1T1j/62avMLrJ0xWc
	SBXI5hEkknoYcgHJwo48QNjiU77VwyJSaEkaH8w3zOekucNa2uECVHohicWOfTjbMpTvh/
	UCxJX0QLDeB3rdt5ifBHVmCJ6PEnLqY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-169GcxoYNnqT8vGB8J3qzw-1; Tue, 05 Aug 2025 08:09:14 -0400
X-MC-Unique: 169GcxoYNnqT8vGB8J3qzw-1
X-Mimecast-MFC-AGG-ID: 169GcxoYNnqT8vGB8J3qzw_1754395754
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45526e19f43so14062285e9.3
        for <linux-s390@vger.kernel.org>; Tue, 05 Aug 2025 05:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754395753; x=1755000553;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yHxtl1DwwIyTZIgGScRCJCvFqJGnoli7ahv7PabNDIs=;
        b=FtU8Fb1N12pf/TcMIixmWMLdR+lWkAnPlEmoR0cllztDA8r5buI6n9IFehbA2bIXdD
         mTltpI7x6HKtA2VdfIvvXxyAbwktA38Ln8DhOkQfLyW8ZA8ZKDwQIGvelaADAthnopcx
         BwlBeRUhISCAo+v8Acvj0UoBoj9XKq+dBZsf5z5e488hnRrgDl+gyaSRnS4th4zLxxO5
         AZjsBu89el28SdMXlcPoOW/u1M9hO1pcEu4Pd/QFYTXRL/vUrGu0B+TBkcd4exKBCEVC
         7GHARKz0uR+vyweLwECNnID4MNRDgw3pgl1XoVRjM9f0UtT64RAcf3TMjLGi0z5jJILN
         zeXg==
X-Gm-Message-State: AOJu0YwuqI7XxPWuX3vzUl9PLxVliTNBOs5Z5o4uUjw0HDM8XGTjJfjV
	N1kuldfQuRzcolIGkX7NtR+5czywr6+oMnQJMxy/REmQFLb2ip6nbCTlGw4AJT4RGewR4LEhHhK
	rLFC+gJN/Dw76mTtGNSTPIbYUevi23fVQ+BDDBXFlk+GowaOja9UuZAPEKTMLIqOWSrzCrIvOcw
	==
X-Gm-Gg: ASbGncuwRJ4LKHL04QROFc+xjKcECgaMlROI+9mK9q3p+5FG8Neyz5lkmmsxMvm23h0
	3vUzN4UTjEqg//8oItm1a6W7D1cjx2bdZTKKE9Ptvdqd1qKEI64/Igx35Vg+YJK2pkwSoU0AWz9
	Enn9fAGxhBmViX5U+6WV9IH5OrsqQJ/IUmg04RIqeSu7HpfGvAZx6/5f2Fb4v13SUjFqPUjKSxR
	C3hPQfHKMxjCKSwITrHCi2ZW0Er+PSvfq2V4YzD/PqbqTgTwvM/K+bc3vtZr791w72TPYxrBTen
	4EF7WlpYpHrv9Io1VX6ij/Q6UuoI/7Fo5ogNoBcm1lqjlWA7wDI5NLiZL0NvqNAIuM7kN1Jswm2
	IifVsTe98IzuCwrx4OtBcfKdJ7DwW22gDEEt62p+fxLwlc9b0s9+tjKRB3GDYsytI9PI=
X-Received: by 2002:a05:600c:1394:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-458b6b551b3mr92294905e9.33.1754395753490;
        Tue, 05 Aug 2025 05:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFY4u/tbqYyR0GlQ3KYjriQcoM4+gDZW9pPzBsR4N1Fxy3JYB8s/h/fvR/GiL/Mh7ntOC+ng==
X-Received: by 2002:a05:600c:1394:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-458b6b551b3mr92294665e9.33.1754395753053;
        Tue, 05 Aug 2025 05:09:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9eddsm18971490f8f.22.2025.08.05.05.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:09:12 -0700 (PDT)
Message-ID: <0bd8a969-e8e0-4eb6-97a2-300fc322f8a2@redhat.com>
Date: Tue, 5 Aug 2025 14:09:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] KVM: s390: Fix incorrect usage of
 mmu_notifier_register()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com,
 seiden@linux.ibm.com, nsg@linux.ibm.com, nrb@linux.ibm.com,
 schlameuss@linux.ibm.com, hca@linux.ibm.com, mhartmay@linux.ibm.com,
 borntraeger@de.ibm.com
References: <20250805111446.40937-1-imbrenda@linux.ibm.com>
 <20250805111446.40937-2-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250805111446.40937-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 13:14, Claudio Imbrenda wrote:
> If mmu_notifier_register() fails, for example because a signal was
> pending, the mmu_notifier will not be registered. But when the VM gets
> destroyed, it will get unregistered anyway and that will cause one
> extra mmdrop(), which will eventually cause the mm of the process to
> be freed too early, and cause a use-after free.
> 
> This bug happens rarely, and only when secure guests are involved.
> 
> The solution is to check the return value of mmu_notifier_register()
> and return it to the caller (ultimately it will be propagated all the
> way to userspace). In case of -EINTR, userspace will try again.
> 
> Fixes: ca2fd0609b5d ("KVM: s390: pv: add mmu_notifier")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

