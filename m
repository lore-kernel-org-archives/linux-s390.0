Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823058;
	b=N230xi22HK5oupsGrD4EWr2lICKzxzZY6MwES1JTHTUyuPUZdzYH1LrLY8qk7hZyVDMS
	 PfVvxFiXpXarmgY4VoT4Ydhu82eCQt1R8Ha2Q82TEcgt5BjglQ0QNpFlZc10YqzWyia2p
	 49NW0FRuWejTI0eABorG8k96bS8NpWrVt3wERd8pisBABi90rDGgqWgZmku3VApugmofX
	 9v0298WjqLnp0uyNffXUYgy/inbuKIm/Itm2wUW8mPFc6BulMTIRjMsLdckhJthl2/0Sd
	 C0iq7GQoWlkipsObENtp2FdhK/VzJEx3N8oPOUbTttKGSnVZXGBsOKIQCmPplPkcgyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=Jb6JVQZOIGnl877hV752shTFAlQYnFHQRMoQSq5Rx5Fc70sUERFVXYhRVzHIujjfZu4k
	 dTcgfnyC/S/xyphO7XybDVWBLBpD1FWMGcIUGwZOjK3QIxQvbcQdt9Z7/4LF7kedXdNBU
	 mVNTuCiK9tCj6m41bHsM+bajt9wOH18p1JNZHVPa8DUllqd7ab192TwFNRmcN2kx9jKbD
	 gd5wyi+LhjzaZgd8YJi4It6mJvxZTxRCMzpn5dlCDLU9X3y6+mB1t+L1hO1I0jvkZU9ka
	 BHdWW1TwEZH85cZV6bSE2mkQmqtCoEfsnEg2aZf9wbuY3wBqYZI4kWDwK4m+MvOOu3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KGTPnbq4;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF66070F2C
	for <linux-s390@vger.kernel.org>; Wed,  4 Nov 2026 20:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87FF66070F2C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KGTPnbq4
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4550d8ab15so176737066b.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823056; x=1794427856; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=KGTPnbq4anQea8pl2YkuJ34NMrOgoSx+ZFfVFqb0jCMfHd7ngtiDiD3+WLYu8eJbdG
         Rr8zmHwD9IQMDA2eGfLZesekUCGyIUx0xoHA1a/ADEiOabdll+YY009hjGA1BykLKYEQ
         XBXR1tk/vPHrCsGVxg1wiVueO7U/B1C0PeQxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823056; x=1794427856;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=fIgq9lCqug7kSZWAiEK5/0ShG88m5P5BSlu2qt4mhq0THSA8BgHicKwz7GyWK4Julb
         hwteGFNh900bNlffOiaJtXr47Gk3i2scrC5hWuyj2d984JHIQSuCrfgbQ6ki9JO47ZBx
         Bx1DAUASN7QhXDvm7J3Y8iCBP24/sudxfpYNI4HNH/Su5yYDzflNpneMDXR+tMNRIKWK
         LP7O20av58iNXuyb7HcNx/lkulLzygK5bub1pwAI41FZP551wTr6EDEhVJXJzRvfl9+/
         /0qamO+YJRQLi7zzK0YXbHkzz+R/oSg9gTkkY0PUb8SkJ2sW+ATlsLmvSQC8sf8R30yF
         XfSA==
X-Forwarded-Encrypted: i=1; AKwUvBwD+zc1Uc5gD1p+S1ljA8zl01BkICkkfuXivb9bGoY8QvK3crFUkmgZAh0aFmOsKSpdUMVS2iWfhI8F@vger.kernel.org
X-Gm-Message-State: APuU4Z/TsONscKl0eiIaiodKCIYUIaacX6U+2K6KqjuiHPr0toK9w8fV
	WQg8nND2VjjUexpaEhGGeLn//z+x5IiElwmz2wF/m02T+HBk7xr2nV4HjvYsjscKOL5SOtuBxkQ
	pOGyvjJqg8w==
X-Gm-Gg: AYBFou3zw2apvV2DUERlBwA2Gqt5hIT0wBc0YyMQYUeyXA8FjJsjohMa1VETEeh5KR9
	Qar6/HyQOS/RlERy6H9MslQGhC6VmfuwdrwTigNKGATAwNx3DTsD7/JHh+e4NnT9H1VR9vXlRBU
	0OctBC7ESjSnzE08Azj4frt6DUwWbSrYrGtIoa9rSVVAaHymky7IS6NQTegKb2HZWnx6FrShJM/
	CetKBGL530iXzLQVYx30rq7vPUtdMIRVSF+K32Uf/wE1grcVLiuiBcs5QAwXcSetyrSeYc/p0OJ
	0DI+fZwyUd0ikQL2yuzxvmWZsleRkMPUwzq8GFQrv+6TQw4RhGKORhtKufqXKmO4H9PIUjgdChP
	NbQwSItEV3bBFirXkqfvzs7U00y2ae1sW7XZtho86qk1xeIq3c3PBTXZqp3oTqiTflZbsJ9Rz2+
	vHdSHnyV7U/j25O8rEFHfmLRDPW+WGlYEE5hQWHWl7ahZHnqDZr40nP6etM+sO0OV50+XM3n7as
	ac/n1hUAAHru48qM/ZiZuJHPz/VP3D60NNMgfKrcsbEGRpUd3NYgxnKAUpHqZYO8Juo6axn5xfz
	sSgVNi51X8PkG5lFb+Ka58+uZadSJxKD0uuoZW8qOB+6Xjh/d1hSsMnKAsoFWRmJKWtqHjbiOO4
	N9XpNisnJsoW0Xm35WfkUxBA=
X-Received: by 2002:a17:907:d9e:b0:c21:9b4b:2690 with SMTP id a640c23a62f3a-c4ca7a5763dmr1538515466b.17.1793823055859;
        Wed, 04 Nov 2026 12:10:55 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e423a1esm106174466b.22.2026.11.04.12.10.55
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:10:55 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so1561302a12.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 12:10:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwqUJxquCnzbeMzaaeyhE/1kABvjZVKrvsuBNyc/op6FWTZ/u4FJrql2IBixo5WvwJJGzg8vgb1Jn0m@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus
