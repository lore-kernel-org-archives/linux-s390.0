Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76714282F29
	for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235330; cv=none; b=gEdDs9UvZIT+WXPIYyDXV43pAuJF6nKJufrM6xBFTmyE2edmGX/r9cWd0fW07BMn3CfGUyOJsbhIGpt2Tjx42XpBGfH5vqTMp6z2oki40uIypLEepaJmuwrP/BcG045X1FPLPT4lATRwZUqVIHQipDR6tHfXKkxq5aZMWxuxyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235330; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwGD5X6wLTv2mG8aklRGICq3sVCgM2G+aNIU/cdDbExx0vJqC1/NuRvXAvta4Twws0+Lzd1xb9CuXEYMK4avU9JKIZNcaLjfCDOlfMSr3bc25e+f+oHT1KwtSpIaniR265t0nz1D9ulVlnPe27yGcMq1c17qs2WETnA/H3rYd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2423153e0c.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 06:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235328; x=1773840128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=PWx3fDURZUCeOnWpqrm6uql0Pexr0Oi9GZUTc8fEhpf/J8zTfpBd8Be16G+z6IPAyX
         QGM+rjwSH+WMmCx7kN2RycZZvoy292UArIaYQnRnUDB8g/KI9jcs0b56+ZLSYpy+cUvQ
         wWbF0dzi15BnQxGyXjXjlx65SQDf0ayab3PH4YNtSXgpOGE1jfH6MbxGML/OSyJbAcvz
         +PIEwjadhVXAN9KlQIrrXfzZUj4KTrSJblPeBRvMMyOEs9D8HRqCiK5RtclAqmYVSRUZ
         EidBlGbxFyQ5EsvPPaegrjEJgYV2irdU2GASBucZgFpskokTdkEY+PooHvZDK2zNlPe4
         RvUA==
X-Forwarded-Encrypted: i=1; AJvYcCVwmaNXO+8CWtr+6mRyvoea6TFXOU5P+NAfZ+kuP/urjCEEyLHeu6L2WL5tWTbGMplxvBU/iDdhYcUo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4UdKOOdge3OtiKJjwWUPIBLrT2o0o+1tqPwJmAtSPZJNSCOp
	aNWZfDnU9zVp1kbW3v3wvPv+fN2HchsB6uPx4dwQavlhwaRE8UJYVX1/EAVJtgVj8CM=
X-Gm-Gg: ATEYQzy6owYmuHZMOekHJ7CTJRXADRiOpM2qcCqCKeBCA0V1/ckKJ9zqAsPj+NmWeph
	nyjHSZsTJlxaSZxW50hpaO+SCjLn8MpKWgZ1dozL+qNI831swmrUzVSJcE/fuv8IXFtirkumtdK
	x0hPyOd2TACtwqTJBtzDaMkRMCidfCYv2SR3jPHnHDd5CJz57pmrZOtzQO4sjDWjF9i6aTOu7VP
	1H1EWDpaLZWGgV60dQZNgKB6+bClSmO6Z25T1MFNcnVub2ij6vm+45OzFoK1uPAh6dWGomp/82g
	bJgrxHG6WhVQr0cxCmXILl36ZwvjfzMzKpo14NQo/xdvWOQ8K/7CKpxEEURn+kmnCjuiMJcTEDo
	68q/gIUm+sW1uyKd1T9yBBCsYLIVmX54wejgOR15QHeYpRiH09I06q1Mdaig5U4PcJXKxWZzeOV
	woYD/PspyY2lB9eA9dICpPtmorW6kiy5es5JaF4TZ+K84us5Gg7beA4W/0R3oTa5Ut
X-Received: by 2002:a05:6122:62f1:b0:56b:1ec:d923 with SMTP id 71dfb90a1353d-56b472c7c03mr989537e0c.0.1773235328415;
        Wed, 11 Mar 2026 06:22:08 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b46336442sm970647e0c.5.2026.03.11.06.22.08
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:22:08 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56ae58f3fc6so6635614e0c.3
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 06:22:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGXcB279U5i/rivccxnd7dPveESK0L9+vRcXJfsDmDYyYmAPgrL7AxYjV3wYgYprOkbPP5994SMrva@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
