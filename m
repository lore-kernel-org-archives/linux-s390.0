Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435EB5C61B
	for <linux-s390@vger.kernel.org>; Thu, 14 Mar 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400785; cv=none; b=ZdUu1bMfVNrIMVStzgDr+jLO8py7k98TWVLZDZQ5hma2P4n3gyHPNSNE7ALv/V4ZzDXATONB8tnfvJiadpqU0jeLm3OyX3vmQWnlD7BqxBThAW8nYixpoj0zochUiKzxnZPjD5MtEkBwH77grz9/FOfXw8ipeSxQvpG2PGDk7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400785; c=relaxed/simple;
	bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MprnRJu+t3BYSxy8gBJrvIk62fnMjPIVHSIHpyeJRrgpYgBQRM5JDS9CaD2MpwoR6pssRBg1XW4+kJjW5rNt83m6fqcgSaQpu7Yo8bgNdFlTzn0WjEtTwjMZ6iFrie25BsXL0+W+BnBG0qnFNlsgeRQiq2AQ3biVBFIEFeut1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHIMVnJN; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHIMVnJN"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d36c20d0f7so914140e0c.0
        for <linux-s390@vger.kernel.org>; Thu, 14 Mar 2024 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710400782; x=1711005582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
        b=dHIMVnJNZyu9wR5geyJVPDj4comCj9wjcuOeFrKBDzqLgGw+CQBPZ1Rmihoo5GCkQk
         gydtmwqK3bAyUQ83K7aML4v1hC9BZsKaZY0525UWagjZ8fsfJjDvJCfTzPWBJIkRmnUw
         aqsxskaVNMTLF/3Z9nA5isBPT4u3Yq4jYupi2OgSKlS9m8HMCQRgUMFlHHuDSHNq1156
         fe20i6sKg0KFcplI/SjlxLz5IVdQUpSXorjm5CgzoGPqRpdOLawFaN1HF8KKz8kq7kL1
         bQm1n65uWSarY1LTrouE2yAnbqFw/ncMm7t62skCvSwOMTp5rQvjdSJYjYug/MnRNZrc
         YT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710400782; x=1711005582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
        b=O+5inJRawBzbQLNQ/+nk69ru5SrBy53Kv4qYrvX2d44kCBC58BbLxZ8TMeo+0HCayW
         3IYOXzIQ5W6GGiCIbZDy8vre0ccD4ji0XN7+TX+DfADz6x8kvkVN4hDP5hJFxFM5xQdQ
         Fv67a7hGqzZZ28ERD40HGu/K0B/0Ki6Zb8nHVS1IwHHAtlzRYdxvYNcSLoTCk6X5SgT5
         m6RPjIktge+1o6VZM2AFdoaw3994IT6+LDlEI6KWfLToRnZcq/59pr8ujHub6dHzY2EO
         6ksaUBJsuivuo6EGrazw3RBbDuvDD3SVeLIoRLHRA4kBnu+1TjdZb8u0pFwPH9dVuHhe
         a8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg03I7G8rsQ/7bFucLdNAFTRbrWXHBUe0eBnd4ce4ozhS1te5+U+fuEGNW1zJLtYqgtjBqDwLut6Q/A0+OsJxxDhk9FsNB7ykj9w==
X-Gm-Message-State: AOJu0Yy3CweUtQJCBc31mxhwvMPZaijuL1xTV9iPW4m5KnlraNHwf5uO
	71+wtfUWl7C1nPZWhx0NyNmj9t6T2z6jxC53WlKg/ZAo66eJrFJCf8UyVVqup88d0EHI68M7BCK
	/fnUbhlY+SQyBWB/ZwKmJGOKS/1CRFetVb7CrnA==
X-Google-Smtp-Source: AGHT+IEu7MNUInwIY97dleYnWeWXfcA+5F5T/ApvKi6n0MwxHEqr/RR8abTAy2/zINbSlyHB23weCyfflgDg+RLDw2Y=
X-Received: by 2002:a05:6122:1296:b0:4b9:e8bd:3b2 with SMTP id
 i22-20020a056122129600b004b9e8bd03b2mr431224vkp.2.1710400782181; Thu, 14 Mar
 2024 00:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312170309.2546362-1-linux@roeck-us.net>
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Mar 2024 12:49:30 +0530
Message-ID: <CA+G9fYsHhTLw3c1Eg-L6G3H2g7-mPf9zdR+hKDCV10RhHk5vhg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, netdev@lists.linux.dev, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 22:33, Guenter Roeck <linux@roeck-us.net> wrote:

<trim>

> This series is based on the RFC patch and subsequent discussion at
> https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
> and offers a more comprehensive solution of the problem discussed there.

Thanks for the patchset.
This patch series applied on top of Linux next and tested.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org
