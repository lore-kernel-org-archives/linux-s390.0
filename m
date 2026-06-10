Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD2339863
	for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105021; cv=pass; b=YoJlMUBvb0glaDlVdKnrQEZqmSMYDZwLRti0ImiWkML4VCghgMWx33wZkFnUhT0HdHmskwpv7btS7s1ehXkavoixNqm83bvXIymVi0vSgOswmQ0BY8PJqxUXhgxY+n/CkoeN/S+VJsQoxXA3m0yZzeB8dOMvKcE+0HkvvyQJS7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105021; c=relaxed/simple;
	bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9kBjsQjpePbsKnq74Vlro9XXQaK+j7DPW8jkc1DFBv2Dora1N1N1lyLHOVsK4/y3AGvRCB7c7NuvygKYGbVzcuWFhuT68i0NQN8hOgUaFCXoPbQK7pt3dlo+lFeqy6w6Mjdq1jMpYJjRpXHm12jZryJbOaA2UjWN7nEn1hflzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knmeKcd7; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knmeKcd7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b23c828aso57425e9.1
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 08:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781105019; cv=none;
        d=google.com; s=arc-20240605;
        b=C+WkFf0GiF0ZyEvx/tCmmSzZnKouF3Y7PLdLB/tr3QteNxBoorke+X6PPVQ3/F9G6i
         CvcBUCkfYG82j2CColkasKLOJyToP1ddQ3zk91phg4XBzYS/WDvtbSoR+Mt9PCaxpvAZ
         cvqZeoCu22h9njWoZi59tgysHKLgcvD9e7RZFUAsgWv2gCYVh43HhIiDlD0+gxDZNpCB
         +/TP3bROCeUr9VxwW4yx9Fdxm5eA9JnxuI+usA023ra1sDWzdSPYDshS7bUDXpFejdmy
         zEQv/E3V/AC5a3zjj1dUF6fj9QXWCPVzyWMQBh+S/ZFR43KRy0P4THWKs/SLUYd5Otta
         R7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
        fh=sQQRX+9Pb6w2BmReKNF6TQ5cU2RPpeF2Ys8OId0ytt4=;
        b=kNqoWVjZDS3S4SQdedNFW+Isc1xzxxZkoCTrn3DyMykH5+HT2pyax8R6BQ4EzTH4PF
         NrVEI4wWEcR3Ipws6uUdlU0XFDsbD5c4OQiIT5Eq4WhlUwuZnH7hxqCALtt7aAYWlnHv
         1dSLsCQwdvprApaYRqoeLScqwOyXIdUdt9eC+ac9Jd/fiHt09WwO9YsZ+klz96YWjFnP
         2aeK3dVa4fobL+DXL/gMzOymErnach+KozK7tbeyPsWG9qcbpYRWPuRVEGmRcgtZFurd
         G0bPsherIUd+gbCFtZ5OPg33UWAcdigfZZ6t6uRZ/ZTDnOSuVImRNmWxs7ISSuJfklXM
         diMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781105019; x=1781709819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
        b=knmeKcd7axdf8Yj6YP1j722vqNKTazQOkcluQXH8VllnvXalQ/uLCj9lsnTvV1f2pQ
         RlMGbLm12TmFmcLMkuqTBT1Wb76e3HC+/kOXkahS8Cy+p2uXhgp7YVz1jCtuQRIjhOX1
         FNqTFBiEZcwATw7OkC/jU3YfVR/TJftCAymf9RQ4pTwbxgDpwFfAeF1pz+l1tuDyrn0G
         KOUNAmLPOHBFXm87LW7ZAPPzTUdI6d/mStrs98zbUKrOcGdaM5243xJaTH/wqxyZAu0b
         W89f9AD/ZhUpvxXWUIbORnHDT03TXJAMR1/eZYCIpfSQJFNp+9beeYD6aGA+UQcXVaeJ
         HaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105019; x=1781709819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
        b=ZMy8ZrH9rC+eye/j5MGtWbDtyKMJwGI488l7oUUffJzNr7954MjIe4Dg5zJRQjMJjq
         sRKFoLn3TTziZaOwFjnxaqAlQePH2GveOUtoagIMMRpjkbDQnIWPcRZ+MSwZLoKDns1F
         D6xub7gY2lm9jGn4Uk/634at34pmQpZovdZK63ET0RQHSOoSyFUl9ny+pYZAd4hKfo7D
         V0fTfnStKyKPFZQlViaYBY3jHvEJZuQxMVKQqMltVDOMZqTmm3cDhCUJUOnsEccEJ0C6
         +Tu4W1R2lWMu3yCg+S3Rd7QYo2lbkiAj+xlYpZkwToTGj4Zk+8jV7gykQnA0kT/x8kTK
         Mlkg==
X-Forwarded-Encrypted: i=1; AFNElJ9+Hpek+wr7QqinKjeirW5OJbaRq/yH/FqNCU627joX6HrU3iT1X//LLb34uT81M1RNqq/pKcKF0viA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SpXal2z+EVER7jc0bVhX5A0EmuL0tAg3vaseSUpSMG6hG7++
	lMrlcDOKFYisrekLPaqfVD6SXYMez1pBGRPkwSv1janK4Q2lvGI7YRSa30nkxGcAPrV1ZBrfQoy
	dq55n24ViE5iOH8z/KfiA93UasQkF8q/R2atfY6Zt
X-Gm-Gg: Acq92OFzQPFOcwhFzr+grrHiWSK5H4ij5a46yI9pPM9ljwQyOe1S0yGt7GaohuBEbsn
	cMSPFq+yZdBKg1ubaaX/R2DGrvGx9w1Xl5wSkJ5PTof42+KKQGiqQo7LqBVXix6/VaosZpXyhTA
	DEFLik+Aenm58xLq9dmPnO8oDEDfTL/txGpLXZsJbSUBFS7KTpovMIUgWlyqpYUyysR9plNHoLp
	jYF/Mj6O0tBTC/31l3zd1FXTfK+e6f0fzJQbP5qk4Fpn/jVPjEK/9DrnAKIgsvw4WtW1+B2UtAX
	B8X7RTeVLTccpeyrJDmhZedK9mRb4RnWgr75JSft9TobK0Upybf/YyKXotscM/zA0+uuoi4+Dtx
	Cuq59
X-Received: by 2002:a7b:c055:0:b0:48a:5aa3:ac1e with SMTP id
 5b1f17b1804b1-490e250419dmr39465e9.3.1781105018413; Wed, 10 Jun 2026 08:23:38
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 10 Jun 2026 08:23:24 -0700
X-Gm-Features: AVVi8CeKPjOw-ulqerfXTIRQXgt0wS2BLRdaHk4b32zpbgZavKZyW6IeEygncls
Message-ID: <CABdmKX0K22aaPTrk7Xs_8859ePYQsPNuqcG3v4oMZHK3T0xqKQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, jiri@resnulli.us, 
	hch@infradead.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, djbw@kernel.org, thomas.lendacky@amd.com, 
	x86@kernel.org, arnd@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, mripard@kernel.org, afd@ti.com, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 7:23=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro.o=
rg> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> While system heap and system_cc_shared heap share a lot of code
> and hence the same source file, their users have different needs.
>
> system heap users need it to be a loadable module, while
> system_cc_shared heap users don't.
>
> Building as a loadable module breaks system_cc_shared heap on
> powerpc and s390 due to un-exported set_memory_encrypted /
> set_memory_decrypted functions.
>
> Fix these by reorganising code to put the system_cc_shared heap
> under a new Kconfig symbol, which allows either building both
> into the kernel, or leave encryption up to the consumers of the
> system heap.
>
> Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
