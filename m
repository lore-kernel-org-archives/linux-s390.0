Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872836;
	b=VMih1DX/88biQRNYRf5Iu76Ubp59fakKENYaUocI0SEU7kp6qKCm6SmvxKk6mlkfk4SY
	 lCMqkS/hMw8WdcpXG3BhSJ9ZF617fixWjkcT0ekhaxxsnHf7C1bMvP7yEJrskePG/kARU
	 RQlITCCa++IiURXbsxF6ROOAXbS/kQpAQhli3hosAAabVBI8hSKz9FVR736hB8HMjUeFS
	 elyswl0ZFdpL4Bzfj3jEPrTL4Lna9UHhuluo3bgmBpejZtKNzkAa4wqhLUmtxMTrYO+gp
	 BvmZ6UWLBnMENSl2NYI7ObUZ3QSbCIA0hwKqxJ/ZT4lGeyyfokPY9Z58bc6ppmjS52g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872836;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=yfqHaq/h08uU4ecYMBhYb3P5uy2D0eMIkPaMxHrIw8yrEJScFiO1+/tjedK1X2kUSj/L
	 V1L3SR4l/7rtWsEuY0AZZX3H+jg9k20sVzoSVfmUDMPlOEsYbn00PvdBCYE7NhJNrRuXd
	 LinPvMX5KX9UAbPCSG5BAvTh+jyl3iYvT3vgbvqneQYQZYf0+14MJCe9CFjliv8a+IU1y
	 i2QIa0xczyERtYps682OtZqIn8DR02/8prPpNTE9JHoH9dvJwd72jIeAHBJT/FQiEsiRg
	 eNeHsQy7vO3BdLcXpnf2rkYGoJIighLyWi6XSRfKZUGCSvyc99mmdco17dtiL5gKVmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFF606A32F
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 10:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEAFF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53653e30353so22036061cf.2
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 02:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872834; x=1794477634;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=KEoZr+cH7ReDmTSi7JexsoBsQXxotjaddJ46lJfmzsvY86Kteao6d2AItv+UBYQ3da
         iHye9c6/OznHvO857kknsm72nlpS7LeWpy0WdmBTJMTnshZGD2DWShAF2b//8E46Ct98
         aT9853JJd3Jj5IhL4pGAb9gqFzNzqeJUsbJCLiEGNlrV4CIf9zYOIQuTXojScuNmpN3D
         fngrjLTjL7Snh1R9vOM6BgHnfOaaXagdgB63BMA9ZJEM7t7fk0D3vOUr5nvHzWRDZRX6
         Ltl8O3aurTiRpngZ4URpPhncZXaGpGXNwt/je7yPM/UUsefcwysXB46/EPfm0ZUIx3E8
         LqAA==
X-Forwarded-Encrypted: i=1; AKwUvBzbV5Sb+U83HYkLwB57VZ8lWQrhcEBWw+ot3fDUkTTKFupNawq18i08FmFjHsbYPoSR2HeRWHHwUHHy@vger.kernel.org
X-Gm-Message-State: APuU4Z8apo6Ml9WwGVa8vr+OmKVlIj+1EX71zmJQyuhx+IL7/Eqfg9uQ
	YiVGX9Po0vcpGoQkP0z7AdjvQVLbo8RwH541uTQfJNxIHZyf3rXDyFKSN22x3DsSXmU=
X-Gm-Gg: AYBFou0wogQGRFCzPIZJ8Fk0Z3v2gawMeApkJI99Tjs13H2Xl3LOfzTXaczCq60qlAo
	armvsY8ldZsqFLX58sBi62H4vovk75QAEw5P51xx2aXvjRTI1NfFbQ4ldy64Y/gg5LyUUd/qm64
	ZPdY8y5rqCx4FMld7Ox362g6Z5coT7Qwfuwm7C3NB+OWZcig5q4hqnGEBuOJFSSdcfUalCLA5XB
	K12d0BTYdXs44+U3BflsLW2whDNO2pSMrd4YloYEpg3EMRFiPwtXv7Cnzaa2NW6GQsR493VezQA
	qt1lZuXa1W8UQNQPXu8y4XU4hewQcLbMWh/r3w45jcJUBybMGGGsZoqlGwZ5JinxC0oWjBnZAN9
	5wCDRgqBgx2EiKMdjIlF6RTBSvJLRiBA1PMXw0OQMKZLNAT4+rHqNgNT2wCfG1K20uKIzjAvdmc
	RnLvDu6qNEA3raqfMnrzmGQZtj5565HvorY9L3ef7pdWa12BNHkngFXc/xCkjEIX5tnGIYiLlv2
	yI2Arsczd8IhrOYHR6MujN1zF0/CFBYmIlNOQV0beQAo4coRvIYQ7lN1A7eDYlW4/3VvdPPxOh5
	/VBkLqc5zUr98JWoMqfOE4eRndizMkZ0/bLqHeuz1+GNcWzxA44=
X-Received: by 2002:a05:622b:99:20b0:54b:235d:57be with SMTP id d75a77b69052e-54b235d7b60mr61984951cf.11.1793872834065;
        Thu, 05 Nov 2026 02:00:34 -0800 (PST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100aba28sm47932391cf.9.2026.11.05.02.00.33
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:00:33 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c1f548f87so26522036d6.2
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 02:00:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy+D4q9xupCfYlzhxleBnb2d02wTk749w/jrdW4ec1wcnNfCLEtX+IRRgo9FnbkhaTW9thOBFTfX7Yy@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
