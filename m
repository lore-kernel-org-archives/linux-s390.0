Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989B39FCAF
	for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326403; cv=none; b=KTsz2grrLMzB28FC3/AlXqoMbaFt+0QgBFFhW03eIx+kWj2DXQEJpP5ZpRkVpOc51+CMcpHnNA7KFV7v9iN9xg2x0K91SW8wUVzEATonAfctlXwTAMPQgVEb9Pe0h257xBB5OKX2OZTcOt5wHH05hVvtFMFOxJ3bHBYAliCmSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326403; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtpxzZ+IDOrxQzk59wjsdXOgWuQgtMIX4HC6piU+WL75DaRSfc8HAqn0oJdIcPa5Y2QxO09aoAbfvf0fvErScdHwD2Gk86TNBRmHa8APC0E7lSWeWjyjxjO5sjdk37LsQmktKFAXyiypdECA9KToUsPfBW9G3KUZOrTVqxretpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UDDT239Y; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UDDT239Y"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c01854477so696731266b.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326400; x=1777931200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=UDDT239YfWXsiUsf65Gu1b0CA0M9Rr+dERsGWS3i0CZSdOCOQQoHrbBMWzRikJQfVK
         SseaGM1pVyv6ienC6QhforxoOoekcmtUl54zKICMN3HLrnAHNZVlHox2tKs0p3k/AubO
         o4Rxvo8eUqBo6q/VwTgH19isuzPzruNb4gVu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326400; x=1777931200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=BZgkfJipLkENHgAF1Ys00/6nv48SuCdvWQyrby0KmPIo8N/YTDbxtuIK1zloC2rIob
         2XmTrwn6DujTpUJwwlTw7WLccXmPYUdT9uVOXy2EoZYi++11AwG+r5Ld4H+4TrurGHZ/
         poHkrn8ZgLd4JG+7FV6jQHCE2MTEKsL4CSoVfyPrZNFhGRkeWEDJHx4oJJEdk9rnrGHb
         Su/SbRORmB6OocGRJ+3zWT3gUIi/jlRZptgr+TC5t5feCIEaNF8DwdNv+6qd6sbdYaBc
         vkcMO1cM4MFhAVTGMyOY74M79aUCOM6c5YzhOBIzcFmutyTtbrJyD+vocyYUHhYvtwvH
         cJtA==
X-Forwarded-Encrypted: i=1; AFNElJ8lqXqqWqFcJI/sctXeYzFIC+EIVGZgoHHT8mriYEZwiW7uk8bWuwk+soghA1j71pDKy8EVL6iYd/kC@vger.kernel.org
X-Gm-Message-State: AOJu0YzcatKsFDt0EcaFAwGh1qETLvg1BaEVGkVars98nUIMVvw9G7UW
	9+KO0Hsl+wkx0oq1v0Mrrq4GL/FkUkQVFgEfy/UUDka82opizUO7b8Wi87T28X8tVEEUEfrvVZ5
	y7x1g2dbCJA==
X-Gm-Gg: AeBDieuQg4yFL6kFXBzUYaqUC7raEAHNPDQ9OP4FFRDZCT+7HWPtj5s8w9f1qrYj8gN
	fkXHVGpldFiUgpm0ZHWfbLA2iqcUykmD13AGk179+IJXFP9WY+u5uEA45Z8g9BzLnxrNjAcJ9lA
	+cbbtnwLPfAVtkT7Q+bC80hbHdmRf9AKo3JR5WGXa5DIr1B7A0ggXCy6O357XOi0zJ2w/CoC6tI
	uuMaOUe1n//MFkTRruA5iZDp5btHFA/+OoP3+/3O9zKmjWD1neUsTap5ew3UuCyOOEKHxRkSTmk
	ivDkJL7QW0/BQYQxrDaKjE86GYCeL78joqqrWYv/etmyJym0JshGTb8yPJNLCmH6bo4u2bdv3u/
	eAv65Ir8iGoxK+uH6fiK+MbqfJQsHWdiSz+uRWRKa2COjhA4lbgcNfT6Yet8CaPW6JZT6ltXjep
	l2QsqfWn7x4qg6cAexSvwGe9q3z3P1loPPLZ/o4LbyH5uaQE/DjYZTDB3DsBDvqxxkAk0Z/ukkl
	d7ix4W49Jo=
X-Received: by 2002:a17:907:c408:b0:bb7:c28f:26e2 with SMTP id a640c23a62f3a-bb80520b15cmr26010266b.46.1777326400234;
        Mon, 27 Apr 2026 14:46:40 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2aded9sm9441666b.41.2026.04.27.14.46.40
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:46:40 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b886fc047d5so1921066566b.3
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 14:46:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+CJ3/BKocTFn70U0VwweI3i5PahEX3IkQc+ICAxz57JzeJkHZjr2n1K4Yaxznru1CR9qJHYQdwY/bD@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
