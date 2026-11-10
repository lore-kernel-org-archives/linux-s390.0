Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273779;
	b=RRcp/2MV/CLtTicZDz3B56wxg+Kappq5swYy2NFVuD2t4uxCosI/FMB8PEB7m3YSBUvU
	 EEIP6u1LnycvQmI4IuNzatFQLPoEKAEoOA+rcV1ex6Ni6hqHeSVobUKYUf7GZjKXPpEU6
	 CyXyL5UraO0yfVtfAo2YsXI5+4TjFvVlbByqHmSjg4lleJh8egfuY3yQOPuHGoPwz0QQu
	 RAnakdg4fdd1y/TMhsiSBOHw+VHOPXrkhi3DIuqyGJm8woRXiXWsDl2f4D0yZJFnoooe1
	 T76/7SUaUwfvH3hZauSBT78XGc+sD1eQChnBEFQnPpnxcpGIvlWoM5ryop/MHz30QRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=YwyHw0FRAm07rjjSnjrRknrvba4/4EXVr/NZ63Sjp0Z2Dvh+rrmumuMDNgb5uBAsQIep
	 uiYECQvBjwUcU5SEDoJH8AW1BqdtfVS+BzpMpcvtf+cK1DTdRIpdhkX6LBFNZa+d/GotZ
	 YlsC3J0q88xoEwne04lH7VLoa2Td2WRYyCgu7wurZZVS8eDrnZy9x9hdpVvb8aQEF5FGq
	 6JpsUGoDb9cqubYLdBqYia5QYnuAN2Ljg6ofQr0utv84S6wT7vUoGcT60k7cu/xeC0Flo
	 4XsFho+PfyWKfw0Rs7AKrUTb38NLiZbYcsI9Mi/t/+SDDhD+9bGh6i5kEJKeTflIWwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=BtxEvFK1;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24860A3829
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 01:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A24860A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=BtxEvFK1
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so1964808a12.3
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 17:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273777; x=1794878577; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=BtxEvFK1iMuH7WPtfAjH6VnrMJ3eP1bYq2GCZEebpKy3TNqbbTww0fNd4Sw+s6K15o
         ytII+maT/QD9rQJmEODkGuTiUUXuqoDGzbbZZA2rbja4hx1Io9oegujW2F+JPBUWA801
         2FzzQKGHC+fJUPpWmopqrlMpA2LvNqXxJHcNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273777; x=1794878577;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=mmzasKZ66V0ardGi5iL+cfRDnZP96EQi+p9e6HVPtQYP24IKRIG/JcA2TOO7jhCejq
         m6zh20PvkWyX9QlyJQKkgrQ0KcMH6M7Qzs3thlfY0M0iHEpDfx7TcIYrlwMG9gtXSl3q
         On9JscaBSxaRuCBiishIEht9Yc0KDMH7XYd/hw9yytXSZ/l+6fGNwsw5r30NSEmd2qFy
         MHWRaRgdzEVoK6oNAeDeSnW/4DAeBBCeTEp227bDeviXVaODs93tC8/l1kE2GExUevHT
         +Kk1BlLuMn6dfxrIhxJs1Q+QDBYlwdD8y7yxvAe4JcpI9uiQ/ZeGG/dL6j7FkYyl029E
         TaNw==
X-Forwarded-Encrypted: i=1; AL+hErHDLjFlc3GCb1ahlSuKH+CKPHjwf/pG4sobUsc5PVcdWEikh1pvC8312/27h9jWuJhVPePX3EDRGiLM@vger.kernel.org
X-Gm-Message-State: APuU4Z9MsgC9UaIxeYtdf8KSbMeExjRpWbnBT/mp5w1BnWfMYeo7q9s2
	VF6WCErfcRX2p5bJAnRPMQC3qqvnSaIKQqmUhwpSabwa0TVO42/raYgNgSOMnwBhmo4NAWRU2Gd
	sD4ulatj5+JEj
X-Gm-Gg: AYBFou3UwP2v4ddpB3bhapJolO9CwsjnU4OA7JapDcblICSRMFhg02lAA1B2OmlGoZF
	uaXFPk767EIbV45/cALyYzA0BKrcI8qbKruyuhMxaB5TDo46Mivz2IZWBRKrQXWSe63t1mJL9kK
	JaYMfdzZuS8YnbYMNZXjonYQUtkpRkb4XEhxtRcfMagcVpihNiuxloiqFb7rK7t4IwBvbb6ooDe
	17RPkulhkglEkTh5SteJ+nZQaYeZjZ8ILprnmCt9cwnJ1ZI7+y+K4Dbx0udopoRatkfwmzS75eh
	DSAcvI0HoBjAwYjvIKee+5IjSol26XLIJkAho4HeqFJ+BtSuioZw9xPu/d6U3rce8THxdMlrAN4
	ichGa8SpfubJ4O903tOAjKFcw1jcHFQRYBPTdou2PkLPxiWDZiW8Wvtgt9pRmCGF163IFZt5X3D
	RXoIXajrYmQA1N8wzE85ZUdhs2Kr46m8KTPXiPfevjzB4d0N83rslCXozATJIon13BYQzOd0ybI
	WU7q/UMlAHEdpZhlc2b0zz8TXr91gvT7dXdW367/r7G5EiV0da4+5G3ziuy4O8lvFOV2r7rIm7k
	Fg52HsNH3BvQhx3vDt8Ku09nv7KhtO/4DjLLgIwVYIXs3JkC/2xvRbuiB436ef8gYfIpfXdMaf0
	f1g==
X-Received: by 2002:a05:6402:5003:b0:6b7:6f9:2ef7 with SMTP id 4fb4d7f45d1cf-6b7564f9d5emr898764a12.11.1794273776917;
        Mon, 09 Nov 2026 17:22:56 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579031e0sm419206a12.29.2026.11.09.17.22.56
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:22:56 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c450ab1483cso245964266b.3
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 17:22:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEMaiq7b58QZAxmuN6/Wd4vxU99VAsMM1dBp+1c7PMGd33lIiA2UFKWxGs9sZoO4Hxv23OPsTF4fgb2@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus
