Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DC255F2C
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489730; cv=none; b=XSk26XBch8bEkcGbw14qwAmoDguTqD+yY8lCquVmsLDVGlDIif7UfWmtMeteJlsKXcB31MVqdeaTlmwFZI9TtA0DXCtY+lxDcbtE/nlsKHovGFQePkuin+RlOS4rkBIsUWju7MEq11tr0jj3S9H6c//PKyf9r9xsckVyyA0dPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489730; c=relaxed/simple;
	bh=rdR0kQyigV0CXV9FZb1qsfj91drkmICFMwdJ6UZh7qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCHijtrR6c01RwhrdIBU26n7ZbmzrYlTUVi9ZsluJ2UOA4hvc2/oSLNohOD5tOskK05L31RjH6jucCpwI9iin0F/tix9ntffpTCdrW+DsohU6EvfO+5121KR4bv2BpYQ9oacRKXIEKjfB/wgjgu2XkuMCiON8KxxqpiK2ZdjCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RCOH6QU1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RCOH6QU1"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd2d8bb1068so1529188266b.1
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779489723; x=1780094523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P+Cb+Uc7oZT3PJonQSP3vI2NqOWeABlHn7+a2lZVeB4=;
        b=RCOH6QU1tKonHV/4mIMhMQwXErrrxx3bYx388iWanS2+D7SPp4smD2RfbsjOKRJ6gB
         2WaQNFExPvSn2TFSz74Ugjz/5fcDgiwGQe6PqUXQQfwW6hU//dtZVJLvBBTO4QlSjoOz
         qGSf6mqe7DKNotBOPQfoHp0Mio9+ik7noHn/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489723; x=1780094523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+Cb+Uc7oZT3PJonQSP3vI2NqOWeABlHn7+a2lZVeB4=;
        b=LBI+PMJB2L5cUmin8sTIO8nqdQrKRjeV81/CKWppJ5NqbHVSHJF9YYM7VYj+mnvMlV
         bt5h5064pJ5dbrDTDeRZwHgxPOP62pMBTTFYOvgLdvitC911WoCd125haLDCvvcEfYEe
         +KWbx3+dzHafgNG4bZOhRiB3FtJgpkny9lLTMpf5/p5hkgvKGJKPnpcge92vuEfDif8i
         8FJzgxIwiBW9A3fzzK7CAFNsaXkMbgrJUzIYg5c8Vg+eyTGx3OVsdDbAOXeRlj9NYxhH
         e11hAYHB8Q4KUQ/GylAHDJz1oQ37AvenqdqeH/XFBFxvd/0QH7SaywXV4MiggsMG3aCM
         Edbw==
X-Forwarded-Encrypted: i=1; AFNElJ+gdqi7yu1TXEfeuB+npSpKWfqYzDg6Hyv7q7Ff4tbGrInTK/vVni3Lw1PKLiucwwhzBGeFYOpB7PfR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3CLQisOzYreQMruuk+Bw9JdTghAG7Hd5CSc3mSDGTiG7E+VA
	h43GfLYOX7NopwbAYV/xPla/+CmviksMm1rBacIzrLVTUx1A3EQY7sRlQtD9ivSx0ngjUQ9U7Fi
	5wd0KIu0=
X-Gm-Gg: Acq92OEbvx0XUQCzw6/jHJafhO7pOaDAXk6G2hluYI6NFEFCR012xmHv8AsnbdmmNk+
	m+n49cm0yOed+vbPU9/dH5zRHJvmZtUaRskXf3UN7tyKWF4CI9eK/WxR7w0Nx1fZq6x0MbFBzCM
	TBhSUyMm7BYDPiiq0H2tmmSsiSKEt84A6PZHXRBamzdioXy+0n/qwcIPnffqlfrKhMfylDzNdXS
	aow0eJvEvGa9bP1P1630b9MFvcQeSSkix3mzwuQIvpzI0A4NfdkYkPqlbm7Zsc+VH8CRXzIdGRU
	XL3tbzWBXHOtJb36eubZv/m5bxpA40jkrhfviqRnJBy1nl5ToiTvrDVuXMLDzvMuq7flYCTjGO8
	PlvSZzyu0w11j8MzbCpgCPYN1nbsIiZ21L9BMU0f3ygrhKxSGNj0FIojo3rlEF1iyOcTer/Le1P
	fufcSPp/saLQK9wNk+s3TFU2wR5YxiFEyDHMWLWOf4Ahgh8GZDbjDiGRhWK5JrIscg7Zhstxz2y
	++6phZMwIE=
X-Received: by 2002:a17:907:a0c8:b0:bd5:5ac:d70e with SMTP id a640c23a62f3a-bdd274c7593mr416749266b.26.1779489723026;
        Fri, 22 May 2026 15:42:03 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddbf97f89csm101825366b.0.2026.05.22.15.42.02
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 15:42:02 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6804e24803bso299363a12.1
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 15:42:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+TiiDjj4tvNWPjhUP7J8JQTli6hQJy0aN8d0FIo0ZeICRYCdx2i5eiO5DBYWJvj6uJLT3k+mATp4E3@vger.kernel.org
X-Received: by 2002:a17:907:7803:b0:bd5:e3e:98cf with SMTP id
 a640c23a62f3a-bdd281a5d20mr270251666b.46.1779489721924; Fri, 22 May 2026
 15:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511214226.937793-1-minchan@kernel.org> <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com> <agefLhQeWpvil14M@google.com>
 <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
 <aggE2haQ7yGeHPeF@google.com> <CAHk-=wg08=sZb=hVa22KjN2pD3aNk-diGmKQnizCgmoMMfrvwQ@mail.gmail.com>
 <agzNyXKIirm1zOob@google.com>
In-Reply-To: <agzNyXKIirm1zOob@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 May 2026 15:41:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqfr-M9ip9OWAUR1X6aOEy2P4gSWYDkbkTCc3E=jCz_A@mail.gmail.com>
X-Gm-Features: AVHnY4J4xF7INrh69EQAzG7z68YTyOrxLQkqkg7ZrFeZIDyZR4c38ibtE6rv0-8
Message-ID: <CAHk-=whqfr-M9ip9OWAUR1X6aOEy2P4gSWYDkbkTCc3E=jCz_A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
 flag
To: Minchan Kim <minchan@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org, 
	david@kernel.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"

 On Tue, 19 May 2026 at 13:53, Minchan Kim <minchan@kernel.org> wrote:
>
> First, the -ESRCH race remains unsolved.

Do we really care?

> Without Jann's patch to preserve the mm pointer via task->exit_mm, the
> userspace killer won't even have a chance to attempt reaping.

.. but without the mm_users grab, the memory gets torn down
regardless. The mm_struct remains, but none of the page tables would.

So no, it won't attempt reaping and will get -ESRCH, but the process
will be gone, so what's the difference?

> Second, the latency bottleneck transfers from mmput() to mmap_lock.
> If a low-priority procfs reader is preempted or stalled while holding the
> mmap_read_lock, the exiting process calling exit_mmap() will block indefinitely
> when trying to acquire the mmap_write_lock.

Yes. However, that really does sound like at this point it's no worse
than the PIDFD_SIGNAL_PROCESS_GROUP_EXPEDITE you suggest. That needs
the mmap lock too.

One thing that makes /proc/pid/smap worse is that m_start will take
the lock even completely pointlessly, over and over again.

Even if we just remove the mmget_not_zero() - which I think we should
do, and just rely on the mm_count of the open/close - it *keeps* doing
that silly lock_vma_range() using  lock_ctx->mm - even if the task mm
has long since gone away.

So I think that the code should - in addition to not taking the
mm_users count - then also do

        if (!task->mm) return -ESRCH;

in m_start(), which should simply stop doing any pointless work on a
VM that no longer exist.

At that point it will go through at most one iteration of show_smap()
with the lock held, but that will be true even for your
PIDFD_SIGNAL_PROCESS_GROUP_EXPEDITE case.

             Linus
