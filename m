Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872281;
	b=zTrtfi/vPSv5iMK2YXhBNce2e2zd/S4L7TqnsUfXmAFiLpNIw+WvkFjf05HkBe2p2URr
	 28mkVq6g4gs27k9oo58UxK857MYxRybyz6tu/Ypbtkmdq8BOkw4qCNB1M+GHNPNMI/cB9
	 Qia5+6OkExZ/gRelhbwWXE6feBeC+c5DSDduX2cibq6Z2HRQ6O6SrvsEFopbiPQ3w6WqS
	 5/a3Q8VXHJzFe4+hRTFK4bX91N/x7AZyXoOuIB6pQHh950AJxWrQFHFlzNRAviDWYx5sl
	 QhBbyEmtb4CEtvCC1Pq4J0JiuU70om9yjDkvZBcEoKxjkYec0FHb3luJljobHFbeN4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872281;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=Yu8QUC6kHPCLMUUe2FMj54O1hJW+TCqfFhNLpXvlRVZd/uS+Ae7axLVSNofJlwajLUhu
	 RH+3WT/DHGqXzqL6ChHnyEJNQIwHpMiiif6NVkNmovs/xPatChu+PdFki5ueOWaTQTpSY
	 UvtfNVfFZ6qmpodi4nhg2U6yiLXMBd2ihCFh8fauFr3mua2XWztA4tZvMWzofDP2/GlJl
	 Fdr7r9JdpPo6FetGpMEMB0K+ijyN1cPMWtY88p9znvZDoCzvg2Pp8xoIKo+usJsOj1tsu
	 29wVDSY4WV4I3YKfRfyDvfGdFUTw4v4D1A2NvpRmY2l47alpN+hnNsYV+D30EpELS8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4B606A326
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 09:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68E4B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c7a0c1617so23257816d6.0
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 01:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872280; x=1794477080;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=wRakWnKBkbnnN5h0SMGGKIoGgvlB5unlwF1XMerNBx0GzN/gerQcc6muoiVl4TYiVG
         najub6cejWlvh2tr1iMdvP6oVsUBRNujmI18toFKjcaotdIWWofOckc8TMcRf5crQBAL
         FVJvsmRCHxAyU4M2vkj+9Uwthl1pzBrwsvDRzjR7R0ir3eztjZtdNgRXuh/GdzFlFW1R
         2XJqlYvBLwDJ+uBD0yRh0QZK+0YnMm6yoNrfnMCxQ9XYhYFDvAG0ddp2WhvnN7jcbM9o
         Tn0QYh+bGtfvvJmboYeIwHvP3bbJOHg8PIPmUKl32DJ7WGIzNcT1+ByMRUgsdPd9NrNT
         vu3g==
X-Forwarded-Encrypted: i=1; AKwUvBxyftwTmFcJrKQOIuF+Dv2xz+xO2cEN6W9PRtyEu8hIxmsyU5fXLS/KDpb8nfxNZEqp5cw0eZR3VZKz@vger.kernel.org
X-Gm-Message-State: APuU4Z/YSUifGYt76TnUoGB25YRNQ8KLDwq2d7hW5eSPo51+QohVu1CT
	X61rJprZ517wOh852nmLfvKi7WJm6C03sSZxHeMeHvvsDkSwWdo/Bfsfa5UZWMK3IDs=
X-Gm-Gg: AYBFou1qp51nw5oxN7gOQDwlQkpkwy2hez7qq2cCy/42YcPcGsv6YTIHiraLCmsKLye
	No2TTyE7Cz6S62QPnctV9ZWH55WKJPZCN7wFugIPxCm+fDII1ehphDgUUQO3mNWvnkd9W8tSAhs
	4nIEdTmoJkSrfIpoVh0o424U+qajjWFU0MEDr09g8ucMZ3swxgPnrV2cx8MdtMwzN3wEjq6+VwM
	ZivkRx5o24DJYhNawSoheq7W7iepJRrvZlKyAPObo1pwBpWhTQuSrSzU4nlElTplCZ8peQtkW9O
	bbnIkU/f66knMS1JrWU1VuoCYawxS+LwTHNW33pUvI+pKYs1enc1/0I6nMYTNKox4BGe8v7Pcj4
	dYU3sLaMh89/YTpbqvSu34Dzc2yFnLLkAsy+a1d3j4QGc4GrVUgISqai3nuA6Ak8JLT2Faj2Ag3
	1cW7FeSYasEcmcylu/yiLB6FatuJ/C519ZYHwHYKmEV+EZOupt9tUUEI6zSBRTmia++ptLe6Nex
	/Z6tGRLX7E438E7VUvqWF1OjL+8nvJpYFz4dEHg3NFOg+SJrMOkbYVKUtCoKI31x4KidcxySfxG
	9mHguMZumXw3Xv7ypB1vZLrECy2oPQrxPtoFQQwC4fo5sAKWG1ayH8MKySChPKt3E4lXKszRAtl
	i9NOcDFx28iXATxE=
X-Received: by 2002:a05:620a:4413:b0:943:faab:a149 with SMTP id af79cd13be357-94421700a82mr3193338185a.63.1793872280491;
        Thu, 05 Nov 2026 01:51:20 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d479a81asm424527785a.14.2026.11.05.01.51.20
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:51:20 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e635220b4so159011485a.1
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 01:51:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzw7nwFY4bkmUfajxq5fqQdtQUOaw30a3lN/sOOFOMlfvRiv9fh9kPrvTwG2xH5OX3scCwueU8GG/6x@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
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

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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
