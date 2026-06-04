Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1B42314F
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581435; cv=none; b=inIkJjrYgzFmk425xS2pcN6CthZjVoCciZlxHYkzhUC3EpBxyz5e6c4NlH0bS/iTIgDOW4VrLSifGKM9wn0jKk0QXfq5XXh310Da7yKRU9ohZz9ExZrS2Vw8+iIGQQ1dhx3yzZuOnyA5i4de1428EkK910VX368csVAJxnioaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581435; c=relaxed/simple;
	bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3fNdG41q03s0OU1n+wSy97v3rHI/VSkQZ/t7DA2kmIBiapS7FOqPh/MzUJHfioAQ+MNc+8CQ6rXQCDCylLvpFzeMDYFb60+wFXLeQA8fgrHY7fqm5LIEolhXT9R8jn2R+oui+NHZroPdboND42PwkDUFhNKeEK4b/kIcoueHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fp6fnAL7; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fp6fnAL7"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so7641896d6.2
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780581434; x=1781186234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
        b=Fp6fnAL77gldcPHHGCxeqKc+OSaVfBOWfn7bMYW7TXK+xX92vVXhWPcYWvVhsT4Tbn
         PyVuDYfLlUJVjrPN5sac4JT2iy3BhPqvMLwjQQ6p0KClBtcimoODSoQRSe0+Q0uNNhcj
         D/xMZfdtSmCOt06KjXcS7pQbg+dNwbHE2+DTpF2t0YgheHJQ/dPKh6A0Eqlgqmf8ZWuY
         dlPWlWxOuCJq5VKbtWTyfL93TvDWfHxH37/JmUnHOV+c82/CHer6tVJtpfZhTGi0tI2g
         qIz6kv/HNJWme+MXIZuUeTTgcKbn9QQpaGjGpYXaBNsEGq4bnw6kHZp+GtcZo0R/TIO1
         zmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581434; x=1781186234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
        b=os/Jf6l7495ZPKmwXXsT5UJ7e8/VHFA/gbupL4qwwHeUh8UPzTrwkbjsWWAL4wj0XV
         3LQlfL7zYt2vT3t+2eX5e+fuJXMdh1bl+Ozbo8X6ZG3XNnexQIo8z/ui3SVyj0qeDCST
         FiiO0x/jFFst9RBViHTqKnk63038/Ny4qL/mMInP35x122STHIPeqBv+Qhi7VfliYkfq
         nA199Q55NV7tYA9s+6sfE2qKz5tnv3Ine6XXq/7LRhEP9PVO9rXYD2oRVcFVWbZOVTRR
         cTc5YRWtlKGuzQRFIJNrmApK85YghNbKm4999k8nNINsBw6Q8fpqxAq4FwKTA3M+HiVt
         mLgA==
X-Forwarded-Encrypted: i=1; AFNElJ/NAbPPzkCjM9QvU+WGiVMlIwquQjnj5UYzAIk9+UpLjs/ER1rzp/X4SJMXSfS++li1VRnNLjqIvVGK@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWfnYo5nOyMrwN8/3zVl1Af2yjEHLQwgfooxazF6pOI3gB+vS
	y0IVAROeY9ZJqlTOMxPuLhUDsnTlT7pWZffw2F9CaiWkQXJL1Z1pAPd/PJAPxErAzuM=
X-Gm-Gg: Acq92OHeJswXGtEVI93NIyCioBweZWcF/kZaKfdaAa++XmuJQIIDmFqLpEUhRWVIKZT
	AJRnQUol2bgMMSRFv4HoLKDM/0Ns7q785M1I8x1JrsrtICGGHIcJufspMG0eAqBP4Cty6o/M+uN
	F4nJyh+WzBKaFFXYnPmNdbSHHrx9Bxge/6nI/NtDbIm/1o9Sx2+iVtPU/537OC6CLphr/r8aQg5
	Qp0RHv9D9Ln6stO24TunJ2rbHgYla8Y6hvyn5RfaoD9GWhbO9Q4RJ3FO7RVDzdFp1QVeDg000zB
	XqNXryi5RMEfc8kdBGkow3E27WcxzQ9ek2SBkCDQC+V4reGUjyG2wWvWJOiIgBnoA5lVHehn8g2
	yoelgwHnKOTxPk/e5nbxBC/O8BZtUCq0k1mHvtYZ3xZ3TUWLZ9F/h/rknkiwzQwdkVmkziKidaV
	OhltI/4Ydwq+b1rezP18nB0TRNUnRDrhBOZUqjpqJ1VGdRqsohfWCSmWagtXyL7DYWUbDMxq3VQ
	T4KBTSOp0TrWfpHgC/okJFzuYE=
X-Received: by 2002:a05:6214:800c:b0:8ce:e098:d974 with SMTP id 6a1803df08f44-8cee098dc5emr22722786d6.6.1780581433691;
        Thu, 04 Jun 2026 06:57:13 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd07629dsm53598296d6.39.2026.06.04.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:57:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8ZM-00000008FiY-2nrt;
	Thu, 04 Jun 2026 10:57:12 -0300
Date: Thu, 4 Jun 2026 10:57:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260604135712.GV2487554@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>

On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:

> Given that Christoph's objection is not really about the modules part,
> but that the set_memory_{encrypted,decrypted} should not be used here,
> one option is to revert 78b30c50a7ac until that issue is sorted out?

Please no, we have stuff already using this so it would be a
functional regression. Revert making heaps into a module since that
doesn't have a functional regression.

Jason
