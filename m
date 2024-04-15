Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44966B5E
	for <linux-s390@vger.kernel.org>; Mon, 15 Apr 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182403; cv=none; b=tLAemu7TnhOkNl7umuegz2IT4AKLJDyXf+iYTLwu35EcNfIk2pTx38lxDYmGFm339nVyaPhFV9Frh9EQmNPqt9KEclzBVeyc2JL5Fwzodiv7kMVxqjCIwpFRFRFNyHBoMNGkqk6N5HdoF+QhRNC06nWd/WnhLUE3pG3UATfgkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182403; c=relaxed/simple;
	bh=napJXjLj3U8I6q7OUl8fTUznItnXsqsg1UsCutw66zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGGXtTwV6xt6JVq/SKiA1Uaht5XgY2OK25cZHYbOTUSjW6MzIKKuZjCccTg7lhLiFWEAu/58dTvOh/0ufS1zcwWybIYacLbLNHBd2VVrjpxI1n/aGBgS9TSfQtOOWB5khqOj5ry9s7Ix5LahYZSKAWLjZJeP9DhOU1KPtWzduy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvPtsF6a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvPtsF6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713182400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X2FokXM5pJzeEUQHx+N783w38I8i9hW9WaFMev4UKRo=;
	b=MvPtsF6aPmZvurVRi6rSMIdIip9DhPe7V+Wj1n5ahgqacefcimMFL5pCtKCe8avyG6iVph
	EkzSK4YDMl8FYvi7ZUvlHjlvuuKT1ZPpnF3T8WyLc7S7qZY5IZtVgXTKTPuUSAVQbjKxoH
	20sV5dNdCf5jcszwQbAYxiAQSHfqF/4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-S8Gct52UMGKyp2sM8FxVJA-1; Mon, 15 Apr 2024 07:59:58 -0400
X-MC-Unique: S8Gct52UMGKyp2sM8FxVJA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43473ded688so33113601cf.1
        for <linux-s390@vger.kernel.org>; Mon, 15 Apr 2024 04:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713182398; x=1713787198;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2FokXM5pJzeEUQHx+N783w38I8i9hW9WaFMev4UKRo=;
        b=Tyu9lwej5H7AAd+6MDUr1XEStwKU7704xK9qsZNd5dNBIY2yXIWHmqOAPp2Vkl0Fts
         gNZafH/pB+/TrjirYtCaRyMaTUvuZ5UEqIqyFFwgZwOqOEBAdHonZuUEjLpHSGMLVq1u
         ljONkk9Cb4eOyWW3nXcGE6U2wRLrQjQmaREVP+uI90qUYAADqiVGTTPQFlRSYRWSZzk9
         U13tOGrJP5/MbO8yB2EfUHsPB4O12m8iTmoiGoXWbklmwWaPpwRhpdfCn+tj3CEhOS/g
         fGq84c14fJ1XNU859dPbKBNb3mHhwLiPRHqVJwLn8zXa05FqFvxGJ+iTwqnwjAyT5TsB
         TYKw==
X-Forwarded-Encrypted: i=1; AJvYcCVvvmSjX5iVAapdKeA9u1J0naVuhYjpQCFNIo7aXYNjIIfMW7GmIldRxiVZCQ/qk9ctp82h/ClHExXkxqzE4xbTMR/IYRvJeayJ3Q==
X-Gm-Message-State: AOJu0Yx0c9jIMNd26CYWgyU8TUE9FwfqzSupj7Zncx+Iqz8/qRiyIsai
	l0cUPYTASjAwojTEgG3HuljezV/+Z35/wnfWtt8Bcnn9e80aNbqsh5RiN2ny+cJofylQl2cnpCy
	NyGxnZW864gbLdbTP75akoQ/7LjwD1cYg+l5h4rimmuBCAivPa4Jd8G0tkww=
X-Received: by 2002:a05:620a:191b:b0:78d:6427:6176 with SMTP id bj27-20020a05620a191b00b0078d64276176mr13511923qkb.61.1713182398425;
        Mon, 15 Apr 2024 04:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyR3ka1K2kLSCsQ2AnoVFeEamqSD/fRjjnTltJe9LRL9AaBLcdMWNNamrfpWiMyPq2otZwpA==
X-Received: by 2002:a05:620a:191b:b0:78d:6427:6176 with SMTP id bj27-20020a05620a191b00b0078d64276176mr13511886qkb.61.1713182398031;
        Mon, 15 Apr 2024 04:59:58 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-142.web.vodafone.de. [109.43.179.142])
        by smtp.gmail.com with ESMTPSA id da8-20020a05620a360800b0078d5af15c4csm6268025qkb.38.2024.04.15.04.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 04:59:57 -0700 (PDT)
Message-ID: <a7cdd98e-93c1-4546-bba4-ac3a465f01f5@redhat.com>
Date: Mon, 15 Apr 2024 13:59:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC kvm-unit-tests PATCH v2 00/14] add shellcheck support
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
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240406123833.406488-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2024 14.38, Nicholas Piggin wrote:
> Tree here
> 
> https://gitlab.com/npiggin/kvm-unit-tests/-/tree/shellcheck
> 
> Again on top of the "v8 migration, powerpc improvements" series. I
> don't plan to rebase the other way around since it's a lot of work.
> So this is still in RFC until the other big series gets merged.
> 
> Thanks to Andrew for a lot of review. A submitted the likely s390x
> bugs separately ahead of this series, and also disabled one of the
> tests and dropped its fix patch as-per review comments. Hence 3 fewer
> patches. Other than that, since last post:
> 
> * Tidied commit messages and added some of Andrew's comments.
> * Removed the "SC2034 unused variable" blanket disable, and just
>    suppressed the config.mak and a couple of other warnings.
> * Blanket disabled "SC2235 Use { ..; } instead of (..)" and dropped
>    the fix for it.
> * Change warning suppression comments as per Andrew's review, also
>    mention in the new unittests doc about the "check =" option not
>    allowing whitespace etc in the name since we don't cope with that.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (14):
>    Add initial shellcheck checking
>    shellcheck: Fix SC2223
>    shellcheck: Fix SC2295
>    shellcheck: Fix SC2094
>    shellcheck: Fix SC2006
>    shellcheck: Fix SC2155
>    shellcheck: Fix SC2143
>    shellcheck: Fix SC2013
>    shellcheck: Fix SC2145
>    shellcheck: Fix SC2124
>    shellcheck: Fix SC2294
>    shellcheck: Fix SC2178
>    shellcheck: Fix SC2048
>    shellcheck: Suppress various messages

I went ahead and pushed a bunch of your patches to the k-u-t master branch 
now. However, there were also some patches which did not apply cleanly to 
master anymore, so please rebase the remaining patches and then send them again.

  Thanks!
   Thomas


