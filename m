Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868F21A451
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538335; cv=none; b=gqO4x1zfEzKNv1M0zgXcDubWg+cdeIaYsvg0pnK9X7b/tDUV/20Z8oSTRMETKvYIbk2Kaun/bHIjEMMiIPmwj4szUwO24uLLR1ThBkWPC3ObdFGeikiuDGAq7bnTC0RAwoYXmR9hIB4h41bZd6PksNW8w3xVR1gDMT/Uvco6E7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538335; c=relaxed/simple;
	bh=/cujPmecUjAGwaUlj4yjPwoinlTozZS+pNkkXc0ZRlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkVQMkfZMVM19vX/zUqHDLBhHcnbyN/STb8XxLJbqgvarxpceI3D9LAf/DrfzFEjhvUamftUVjkdIYWxXCAwhEAFjB8owIpy2RJ10IP8mCs1LTGHrwhgg3a5lF8X30xgXpMYqDPOaMTRZmFVYrCM1Y/0JQusMz2zestTPUE/EC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/IgN+7I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/IgN+7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748538333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVXYcQRv3WLSWQAfJBtkuGRCwO3gzeCu1+3GwyAE/8U=;
	b=H/IgN+7IErOyxASPwZp4v4eGCi4f8p3TdIz3jh1sIqLNQlXcCuiZEjK6xMN+8XKlhURcax
	R16J5pvknyMsMYS441ytJxpTQHWAApsf9spJko2EcppRYtz0MbOFPjvhHHN4FHVUVaBykV
	JeREiDnN8DKRDZOnl4eZD5WcoIAy1/c=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-gcAZmeB2PJy4tFSrbP77Yw-1; Thu, 29 May 2025 13:05:31 -0400
X-MC-Unique: gcAZmeB2PJy4tFSrbP77Yw-1
X-Mimecast-MFC-AGG-ID: gcAZmeB2PJy4tFSrbP77Yw_1748538330
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3dc772d43ccso1307015ab.3
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 10:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748538330; x=1749143130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVXYcQRv3WLSWQAfJBtkuGRCwO3gzeCu1+3GwyAE/8U=;
        b=bYI5XuBJRtu3//zaZaPnOUFhurbVliqQiLslU6TO6+RiIVkvPwr9/yJwD58m2RdiTN
         XinY5JyB/ltgpkdH+JdlYgPOqKE5RnGSi0qpos+HcdLI3FXBUywbx35JaC0pOQmpaH/5
         FpznOV5qB/RdN7+99NqNaZt0/di25PqZc+l0+gOtuFiBkPkRuYgsoHefEv91F0myXxRn
         OJLUZU+if1qsubP+J07jchztD0cQHjI/fTxDaysMzoDd59zOTAQUktAou6g/MUJt0ncO
         4bFcF68TYpB8buuRnxlDFR1ADWFNcj7KtcMwzt+ktJnkPh4kW1DsjH+FZxVIs1xE1bLK
         1D8A==
X-Forwarded-Encrypted: i=1; AJvYcCVkiSGbTGKoBrJjAQx/iCujxdfuAQv4nmzHEkiWA25oSHvqiVmLtFK/m8YWO/nbtcMe0QbJPotrkd5d@vger.kernel.org
X-Gm-Message-State: AOJu0YwkkqBmVOe2HJ7ZbFISpnBhmRA0SaRofiMugqNZxc9/UiVvvCtU
	UJS80m1VrGd67vRegpLEArodgj4VrKm77wWuMiD0Qh18y0Xn8RJZ3IhQETd1bQ8VTUQ5p3pFa86
	zRcbroRk0JC0dJjVsZ54QKNtkwjTsywvx2w77+PQIt9Bu5jBKMFzCZckaYBTZcE8=
X-Gm-Gg: ASbGncspiM/DXPk60v3pUtzZOS/3LQJiqtCoegCI70HwGZmlTTQWA1LAxWB7f1UmoOX
	CEBqDAw1wwegVk+bKYHUuEHhigcn2sCP6i+yWvrw35/VrBHvYLfafydFtZ9XsQrfKpCbHdvnH+K
	ofJH9wFKZkx5rHW/kzRI7yErCpJRKEbklD6UscJhfQUzCGJ9XMLK7lTqKqfY8Jbq64cJdquW/H+
	eMzNw6hiRyMwfL5nyIseiWD5A2upF0f30BaDkDUyzy1Ut9Vs/FtxkntCjCTj4bzhlcDPJU1SNoR
	DfSI5XJiSzyDrc8=
X-Received: by 2002:a05:6e02:2789:b0:3dc:7cd7:688 with SMTP id e9e14a558f8ab-3dd99bd0681mr1264905ab.1.1748538329894;
        Thu, 29 May 2025 10:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfF2IypLjTHDTvX90AOSKarc6ttkVaDkLoPGB0d3lYBRme4WFH0Ya+stqq3YBkEYUuHUQECg==
X-Received: by 2002:a05:6e02:2789:b0:3dc:7cd7:688 with SMTP id e9e14a558f8ab-3dd99bd0681mr1264795ab.1.1748538329510;
        Thu, 29 May 2025 10:05:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd935462c8sm3928805ab.36.2025.05.29.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:05:28 -0700 (PDT)
Date: Thu, 29 May 2025 11:05:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel
 <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library
 instead of shash
Message-ID: <20250529110526.6d2959a9.alex.williamson@redhat.com>
In-Reply-To: <20250428170040.423825-9-ebiggers@kernel.org>
References: <20250428170040.423825-1-ebiggers@kernel.org>
	<20250428170040.423825-9-ebiggers@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 10:00:33 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Instead of providing crypto_shash algorithms for the arch-optimized
> SHA-256 code, instead implement the SHA-256 library.  This is much
> simpler, it makes the SHA-256 library functions be arch-optimized, and
> it fixes the longstanding issue where the arch-optimized SHA-256 was
> disabled by default.  SHA-256 still remains available through
> crypto_shash, but individual architectures no longer need to handle it.

I can get to the following error after this patch, now merged as commit
b9eac03edcf8 ("crypto: s390/sha256 - implement library instead of shash"):

error: the following would cause module name conflict:
  crypto/sha256.ko
  arch/s390/lib/crypto/sha256.ko

Base config file is generated from:

$ CONFIG=$(mktemp)
$ cat << EOF > $CONFIG
CONFIG_MODULES=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_SHA256=m
EOF

Base config applied to allnoconfig:

$ KCONFIG_ALLCONFIG=$CONFIG make ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- allnoconfig

Resulting in:

$ grep SHA256 .config
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_LIB_SHA256=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SHA256_GENERIC=m
CONFIG_CRYPTO_SHA256_S390=m

Thanks,
Alex

