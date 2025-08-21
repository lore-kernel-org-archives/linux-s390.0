Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276135336D
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807889; cv=none; b=AZb98d1wPtO9ImHEozqYV4fbOSESHPp8GLr+o0KOiu486pK4qiGfql1q/4Y+1Z64xjHvUp7oc5f/uiOCldx3XFap6xZOMbdzH3y4EKM4yipOmcwA8fft7CtKKOvUmBRJlbpi6bqUcuzRCUEavrZ6HSY7AcmzmyoElMRh6SG6kAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807889; c=relaxed/simple;
	bh=oA3XFTq+X9InxrtY53OI1FqTpqPTKR+1uoMqvtlA0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABpzs2iQydAl+kT909YdeZ/0zgcCwwlr/K1pfM8yCsBldULqApFD1xC8Hdicq3Jo1gf3ZAxh+ieHn5XaywtwLMwAPm0gYjcLAPs41lu/qGBOc7CnLBS1nF6f2tQu007vczbBH9xKMVUiZMqqZ3R9YAvaDlKFNI3bS3ddraWLNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rn087/J5; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rn087/J5"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53b1718837dso603909e0c.0
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755807886; x=1756412686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=Rn087/J5j5FyNm4Qob+9GCqTtp8pQbHjYbCRu64LYME9nCB/R8OdClXzzaa7a+/uxY
         ujfPt2eRSJw/WeMN0EQF8as3k6xLpR5eUf3rYsO8DckcIhSxFOL7+S65CbXwcqa1jcr4
         iB1ovtPyDAUUI5rkLx/QO2uZ3EMX/16guNRXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807886; x=1756412686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=Hf8Gxa7yFWHjcB2Bd0wNR7RFUVljtErW+vMBxmFJfTeEFJ6QIOLZaOCwvGLkvkCHPE
         J5NJBNA2itglKEuvm4YUUUvgJVNdxfyLQammHymlJ3tyV0vGxuuxWvP6TnL+JI/DDiSq
         auGd3kyODQwXnOhO1dZg8xeV3IyIss4OiGUkhzdsXL0xDMIy73XriIdikUwiG80WF1nd
         jQaJfV5ojaW5LD09hYHqYjvu8YsT78V+f5s/vVWxTMlzwMi6O/baaudgItkHJyRXrG1S
         HEDFYD3VA4S55FlMg92Ny//CmKw5PLRxPWczztHkTJLgsfnO5sOKuWt+fXANsJB8/jxY
         m2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWrA806HeDhyng86HPqmnyRDOKHWrDHpXslydFjWeExFgjmm7y9mXP9LenniTOc1uWjLK34MDzMG7XX@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEjhJW4EyYYOLcr4xCjCuN5jhDGfO+XExW06u5+zJ+Cl9yMAX
	+Fepu5M6GNH8PSYoX436t/j6a5LGn/JOvyUysigDYmOgzHXU3VcwHU4Azmddad1jhqMZtC82Ds0
	UNL56IBM=
X-Gm-Gg: ASbGnctgzJcj5kq5nvdrv7hzBeW/gX2O9cZrBhMd6kJjnNe4xg1fVQFYref/NEihHly
	FMJyp3FA46w5BQpIhKJdH60ekoBdk3sYgY0VFqFCJR714SAq7DGyO77gWzqElmo0yGFAVZ9dUsO
	2xgkFe9aP97+IwQbEyLh6/H+6E+D9U3rHxwrAqjYYbgLvbQJnX+J4OgkjIrnAxp8Q7hOxXafgWz
	lquUrraM50vy+YrvsLcEEq7R0Jci7+KFNyGp2MVdgcNVRku5+Ll0saOuYoCMrGKuJe03ht92qiM
	SU7amKSxyJXO3sHly5WrRTCH1Rto0FKX/anBLDk2+yrezPMUdZDFGdv/tl6njl9NkJUrmXRPHFI
	Epl54cIONJLBcqpHwwo5qCYRPYny1cC8nS6FPpb7sci7VWQbfxc8mNU7c2aSqZ66IwaMowc5Y4e
	hlVF84RaxoAGs=
X-Google-Smtp-Source: AGHT+IHdfYXldvTZj9mLvv2RYILrA11gRWM0yEqSE/A8HTw+e5PZBwf0D8W1TSAs0u35cu9rchrQVQ==
X-Received: by 2002:a05:6102:449a:b0:4da:fc9d:f0c with SMTP id ada2fe7eead31-51d0d34212cmr197219137.12.1755807885850;
        Thu, 21 Aug 2025 13:24:45 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bdb84f5sm3949165e0c.13.2025.08.21.13.24.45
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:24:45 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53b1737003bso507919e0c.1
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrPE1XNEVRt9t00HDuNO/lFt1MJNmjAXzlv8eWBCFJqrDK/23plQr/EYdxi+dcZjq9bwRCYHSvSNkN@vger.kernel.org
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id
 71dfb90a1353d-53c8a40b923mr212315e0c.12.1755807884664; Thu, 21 Aug 2025
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
In-Reply-To: <20250821200701.1329277-32-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:24:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
X-Gm-Features: Ac12FXxaZhwn04a0gbwY6rjh9UGLxnRlGOG0Jy0WjRbVAG0UxLDqNy0Wydj0GQk
Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:08, David Hildenbrand <david@redhat.com> wrote:
>
> -       page = nth_page(page, offset >> PAGE_SHIFT);
> +       page += offset / PAGE_SIZE;

Please keep the " >> PAGE_SHIFT" form.

Is "offset" unsigned? Yes it is, But I had to look at the source code
to make sure, because it wasn't locally obvious from the patch. And
I'd rather we keep a pattern that is "safe", in that it doesn't
generate strange code if the value might be a 's64' (eg loff_t) on
32-bit architectures.

Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
64-bit signed division by a simple constant is something like ten
strange instructions even if the end result is only 32-bit.

And again - not the case *here*, but just a general "let's keep to one
pattern", and the shift pattern is simply the better choice.

             Linus
