Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60973399F
	for <linux-s390@vger.kernel.org>; Thu,  2 May 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642477; cv=none; b=REi24LWRl0F5iQF9r/LocGJp5y89DRPSNYuS6c1Hr1DhYUJtZU6jf64FPHjwZnmG3CF5XiH240diS6lpCALXA/neoF8H7Fni/BTDmYJPfhWKK8hyFRxSf3JKRyyKSnKSAXam4fG5W4V1ta6PtZDVfw3KJpkEsrMy6Z3QqqoEUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642477; c=relaxed/simple;
	bh=qSSJkG/Ikh9gERRoCiQYZwS3yQg0faB4Oz4JhQK5biw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zqmyu5psmfjEH+FFKokRDP+31vJXeKWDKk+jC6hp+s0OUBBnnaLFjH6EU48xGC1l7dddwsUtf6tbte6CD7F6gc4oW1YCDucieoo2KupBgHAYgV0p1u4Nh00h7lupVzG5vwUa2jYCziLm/z+H1Fed01YMmQ3cA9jvxbeKJjOubRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oz1xKZWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oz1xKZWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714642474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B3HsCvi7JRMplpCo1M88u0oBTuwHb7sgBWwzcjZp03M=;
	b=Oz1xKZWpULhQotLFhHFjTWV1ayrjPWNuyynyNJMUtaWxa0ga+xfsv72qmYDs+zOBqUoQB/
	o2WNiwsutVaZFcxfFKNMSkIHyLKyd4Q+CHh9ecKpma2kgRKkV5RzDhbZKsSD8k0gGqXgrF
	JTPn5V1iupSwyQfGAy9WKDDsnQcAs4E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-6EeJgsEbPUGIhSfd1Hef8A-1; Thu, 02 May 2024 05:34:33 -0400
X-MC-Unique: 6EeJgsEbPUGIhSfd1Hef8A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43a2a23190cso93034471cf.2
        for <linux-s390@vger.kernel.org>; Thu, 02 May 2024 02:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642473; x=1715247273;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3HsCvi7JRMplpCo1M88u0oBTuwHb7sgBWwzcjZp03M=;
        b=i6xX5HCJRRSK+dV9UXKW425Pt/29PdwRic0NVStusnpZbEYO5wgWgudcucvfHj299c
         zwjBOJyujCKC3YQEVLg4nlRjEgfNUMPo8eMo7tygYncUqC76T8ejvb5MN3qXyS/9xo5P
         Dzajyhl6HVm+ZFienKKVtB64WPd03vh0jlR/Vhgd8jbFKDIoAQ3Edonv2FsDSjK7aK2v
         vLSKAjmHlGz6o+t/aiBqNpSd3p5BmcARKbS3ZUu5uGbxiNwmcdRPUgwTijQANSwUTnyz
         x9BF/M0ECYAyIDQ62zQniaXgSz/dGF7GXHy/Adc/1TWE45u95d/VWvwlilBdLngg/2m2
         Dm5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt/Cg8mNF0GMBSBAOlJay0ewS/KkG07re6A63BBmw2ZUe73wqHgsejPS52HchLB3ZxbyjaKvk1GzHvcwr4Ye9nPsSpjZwXvBTHPw==
X-Gm-Message-State: AOJu0Ywz9gdKdntgQ+gfC0VAy+DIlDiNLLLUmaKGt0wj/3fmcVPvPATa
	vSw9SUxMFMMSEi8+ok+RD1Cok71LNpRHuJBdD+uI+DL5MkpjRIq6vxrHbYOM2iOeOm5aE6JAsVT
	fTcXTPLWk/+yfj4/eRVVwArxkzM+Cx4ud8HZmKGLjE9FIOUkY/7ytjNcsAzM=
X-Received: by 2002:ac8:7f03:0:b0:43b:1561:6c41 with SMTP id f3-20020ac87f03000000b0043b15616c41mr1729085qtk.1.1714642472855;
        Thu, 02 May 2024 02:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFioATpRiK/0+kNxgR7F3wjLJ+cCjPVuRG2lY8GhuazVhK0dhNU0y4Gk69ZU8AnhbH42TiVXQ==
X-Received: by 2002:ac8:7f03:0:b0:43b:1561:6c41 with SMTP id f3-20020ac87f03000000b0043b15616c41mr1729054qtk.1.1714642472483;
        Thu, 02 May 2024 02:34:32 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de. [109.43.179.34])
        by smtp.gmail.com with ESMTPSA id hg7-20020a05622a610700b0043ae2fd5a7esm307132qtb.23.2024.05.02.02.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 02:34:32 -0700 (PDT)
Message-ID: <28975cc5-ef8f-4471-baca-0bb792a62084@redhat.com>
Date: Thu, 2 May 2024 11:34:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 0/5] add shellcheck support
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
References: <20240501112938.931452-1-npiggin@gmail.com>
 <2be99a78-878c-4819-8c42-1b795019af2f@redhat.com>
 <20240502-d231f770256b3ed812eb4246@orel>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240502-d231f770256b3ed812eb4246@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/05/2024 10.56, Andrew Jones wrote:
> On Thu, May 02, 2024 at 10:23:22AM GMT, Thomas Huth wrote:
>> On 01/05/2024 13.29, Nicholas Piggin wrote:
>>> This is based on upstream directly now, not ahead of the powerpc
>>> series.
>>
>> Thanks! ... maybe you could also rebase the powerpc series on this now? (I
>> haven't forgotten about it, just did not find enough spare time for more
>> reviewing yet)
>>
>>> Since v2:
>>> - Rebased to upstream with some patches merged.
>>> - Just a few comment typos and small issues (e.g., quoting
>>>     `make shellcheck` in docs) that people picked up from the
>>>     last round.
>>
>> When I now run "make shellcheck", I'm still getting an error:
>>
>> In config.mak line 16:
>> AR=ar
>> ^-- SC2209 (warning): Use var=$(command) to assign output (or quote to
>> assign string).
> 
> I didn't see this one when testing. I have shellcheck version 0.9.0.

I'm also using 0.9.0 (from Fedora). Maybe we've got a different default config?

Anyway, I'm in favor of turning this warning of in the config file, it does 
not seem to be really helpful in my eyes. What do you think?

  Thomas


