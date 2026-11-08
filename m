Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=1Hels/tw/ciNXfgyKmrmLxDYczkJrKXpTCROISl2LYC8PdQGgZpd4LEkRqWuZBUKRudI
	 qGJassH4yOdf7T+P/Cakzn5POD1HSmY1dbyi/uncS3BPFNY3bkushAbQpG1u/lMvELHwk
	 XLzNuuW874UYmlwxmmCTaMfPlsIw8QQZ3TkSWuQdSeJ32Au0FLffVn/lri9TJHfrJNAb2
	 SL5Meo79XVCxB2te9fxCLNCyLu2hKxM8NaZNBtdXFTBBTJF+lixLHiMKIVJLSlpTHsQV2
	 nQ7GHh+l5PGrkYT8euu1vHmG55xjB8UIQAU17r+H5aYs2B/IMzDOUcGux7waK0648Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=HR4IXg8MRfEWmV/YLO1hXBIPK5GPCdZyz9+A/+ZWYcFHBif3ttLbgAuWx+iB39kCUB4A
	 fhwdAsec2Yp3ArkkUoJj6eM/Y7DfcMTxUtdVhKVM+pytIJP/QHCjDXISbc7OF4psGNOs/
	 DbNDJMRzJkNfWE6LRbSzMBhChXX5iIqgsSv607+UAnxQ/QXFzsPm8kKZ+SX9q0xlgrxrE
	 EQ46gz5Bb6A1pEBIRAQBFrXwYaTN2u4iv27g4Dcjhmre87A+snzwlL3JTklquy6w7//Tb
	 xP74TJqxvySmOk/s94+jaz/DvnJnG0bi+Myf7A6QyKFZLArWVaVEd92U1ZZjuUJ1UTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C6606D808
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447C6606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so1338265e9.3
        for <linux-s390@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=B+Zadwt/k+I5yCq7CbU2cd3ecY6kPe09V4OODQHjp9guFEDNlFJVfcB93+MN3G5dZu
         SvahMBUkIZs6LQf0SsS030270QVKnuSqqCdca6AKmsYMRpTc8eMU/98+fL+s4G7U7ISm
         H5sV+n/2SEY4sUTwgxJsdVQoQ39ROLIEkV7DpwD/niP3LBJG5U6IoylsRKF6OliBKeOQ
         oUjDN0bL7PcP+o2n1CZRYsYgIwl2I1AONBBEl/L3KzG8sJ/2yiYIXB6xLtAFmMLnt3GG
         ngfpI5I5eJyX1RlspK1awD3OLLHinPLghwavInkYIbNQiS0r8aXQXrgJq9WbOVEHI82b
         3XQA==
X-Forwarded-Encrypted: i=1; AL+hErF5xA4D6eX+5yFoIwjhnzVVfXYRSaeItXIT4nVrd2LL7bgt/W5BxmPkaCBHVaQHuUDFmVQI/iTLux/y@vger.kernel.org
X-Gm-Message-State: APuU4Z8+7EN8bdTGSGyqN9TO/vOhMBt64JqxBxxG91dnad8iXKbcfmSl
	HpTLLf4Cq7TFFx07KX/2LiIJgnp6gtRiwujdRkiGmRHyro5aeRWTrut4
X-Gm-Gg: AYBFou15FJdM8N0WRlkiyyc0PPodP085h10pRHnAFvQFzBzLK3w0S2fZYsE0dY2oySc
	0oob3+PRAwfUZ/dOalyFgyYhmJsoLMKfP0xdQIor9k5eKmuopIni3vHBYkmtB5qyDja25/mZwB3
	SBq9vLKcs11cZNx/d/CPi+EqvqH13sV4C8MYdX2ci5HjZpe9G8M7b8HSYoYNgPgS1YE54TQ1DQj
	xjs2VugHe2MSRIZefS7Zwo08kMiNbsmyCWLBugGyKX18N98TKrc27oEWlLG6tGCWsFPGxzPujKg
	ZxCHO2ue6yGGDtTGmuNApmzp+QMZRqmjsqFo6kWE//+e2gTROEpQgpLYJwpyJ9DCjg+BO+VUZlG
	pRBLu6hz+5NpGxwUV6m0FTtWWgY//SNrN+CvAV/64T/+l9ebO43Dp7iWE0oiyGrD1Thatb5upL9
	WP6EBlSJgKk3wDWUpA1OXF17QdYelyLnIWs00h1fU+bUF60WHp7AAOaNgPnSdVOguQWb1MQCrzt
	EobeS7Db0UP3p9VrHRAPLHWjuqJXuX2owvfq4bkyv66YtkCvQSI7IBSo3Vl9AkX/m1cot9BkwOz
	jQwxQ+iyLLSfv/QDksB9Tr0cKQAVduxcCNG8cs1WVyELoVnIgy2sGkBtetkTJ95Q
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David
