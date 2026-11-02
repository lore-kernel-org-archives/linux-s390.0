Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642353;
	b=r4a/xKzlxBaFD9sRlQNe+zonXdUGPx8CBlLVr1S38fvbEK8LCZCnhySVqXwAror0k8YX
	 rvdPXLoLu8etR30nm+tV/idPaVip6DWzpiyITGqg1uUttLD+lZX0j6nT82VMdq6GfodqU
	 3ZT3YY2eofQ9hDpg2CGafII0bGJnzlPoFe2ieYXQdpg+YNzstWyOdaPy8F0BMBWtjQM/0
	 2B5/MwPneILLKqoSa0CnAJgvX6Ss1C1T7aME4AG3y4SV8KKG4Mr08U16jtZawI3v7g10/
	 xvpSL51axZ8lWKmjnANsbULjES+v/krfj0Mn6BCCns6AT4HHoK6DVACmwGGoDXiFueQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=DghokFA0prJfmdVX6wSmG0qPivICpM6hP0fCJwOdKLYr58aAgkfDIoOmsWI4IeQqNOiq
	 D8YAyFdq71dF4xSpX9w54C3TpdlXcl4dag1kYrh2okPPrLur9K5KMsxVSLCSm80IQrNq3
	 GmtpFAUkQ4fa+wk0C7bbbNBE8AqaFwA7Y9EqKQD3Euuo6epdEFlpQdr0fvT+fOvzUs9BW
	 f0WQlHaPUwecQNsbvwqV0ofx2PSQzP/kKS5xdcCPF0jPNihBAR2oQ+Fzoen/jFADIuxMG
	 kt9bWITEWo9WOXRgjShCY4iUTTB4KPQ1lmThpk0i8rWtlgIYhx4eI5Z+1l9OFfwTZ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ekg5TOf8;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E8606A5AA
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 17:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F05E8606A5AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ekg5TOf8
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso4855932a12.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Nov 2026 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642351; x=1794247151; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=ekg5TOf8PXlbMPoS4qdrUH0qtWO732M+jubYVeFRHzubEalPOb+31Lw828wpBa++rq
         hzAaV9LYLYH4oiPKof8252Jsp9PZHQCBmEyGXQ16X2cSkMFbWYT0UcG8eZrNpE8TZTsq
         aQpK1vS0JWFQvV2YncXbbT/3XzBR73lEvrSrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642351; x=1794247151;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=Yb+4pug8Iuo7DopLI5hbixwuH0ScmoOcVJ9ngyj/UOt/GUEjMLNoatDXkYv9qaUnoH
         PkImwaATGVClVJ8Qwr/UTMuxIN4uEymN9jdjs3Tq0wrwwfnDmuGsj3i9RcYfTpjj1Kcz
         MF9JOamHr1wXs1tEgA4VJ1IhZ8M8BtOGKkUgj4OdkNpldFEIjiRBntRuhQN9+rgIcncK
         ArFfG9CIq9DT81fwNq3fAmhE71r8ku0D/h53RmUqgUie93gaPBdvLJxi/5t+04vTMWx6
         /px4RrKIYi5bwl9LhPsSkFo4qm29U6zi5wNngEhxAdvF+c4cmRxd5ssLG+X/K5bnlxY1
         YS2Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3eB7uwmVHtYLkqf6thW2gsPdD0ONub0MvlEGveZkiC8oqGi5BRCv2jgfykSHaQc6hZiq5CKU/8c8d@vger.kernel.org
X-Gm-Message-State: APuU4Z/gRssYEU9K4JbHKre7WODvUb5pXmb2xDBfniWdoKqUsZ7nweQn
	IIzWvK7oe7L/N07476p4QreAa4yzZ8TER1iLCSFg8+nPt7l354aIQqA6z7K8t3+7N+BOPy1Sv/5
	gbd+Cr9I=
X-Gm-Gg: AYBFou32sVgYgFhTAlKZJHJCYPFoKftjfjoT546kLCXzOMwsekhpBf1TDVrBhmb8yww
	6u7QTylbYS5n5mARCZwhmydCrlVO+VNbMEQerjDKFh1AosOLeuAnJCMFn4c8iecbR4vZpD0DMxy
	Qp8a3AJRmiHOaZWc+EEBb2ACELZ1mrU0GjtWVQkNU8ZqeSCaghoefVullbQfKRUlNHQ6mZBsNsT
	MLL+UWJfS/HLPS6sUgNCk2yMhknMAoJw2IsNlTMbIwxJdMdXwcU00YmAzL30LvQzksGT9dm7Vwp
	oI+3izPzENxDEI+kGaOE9DrkMLSrx7JY5UM9RUmPsmYPCDiABvsfltTYQ30OJxUzOlOVbGLMgPS
	Z5lrKovzU+2mgQ+bIwLuMw083FLXiZFNAKTRtSwcsib0hdhL0/r2hBT8rthXEh67gpT/rCCRDSP
	Ihgs+7IGW5owcacMH0N2ikvTMuQolNRBNtHbm1Bg/W5hsH79bzxm5Qya4KQ3tXkigwlgPv/GxJh
	ypGt+AeJhs+/i6KMJ54Upy/N7BMS+UlKdNphKKFaTJEvApUgBrGxEnfH6RNknU1RYR0ykqbLEXF
	dKeEOmbrwqPZk2P4r3pCewsFVkLAHSFdsy2dur3ZAX4D1auGhZnLDDm2Ishxmka0/VIptYOMVKQ
	SDw==
X-Received: by 2002:aa7:d645:0:b0:6aa:e144:7290 with SMTP id 4fb4d7f45d1cf-6b4b0c0e54fmr7691714a12.17.1793642351225;
        Mon, 02 Nov 2026 09:59:11 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b52f3c18a9sm518155a12.16.2026.11.02.09.59.08
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:59:09 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso7716047a12.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Nov 2026 09:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwBZa7+XwK/2bmViQaGK/V8nvBXiO7IEAeB5HVndnfxiPMGciFxSitcszehWnPcLiwjDVxdCpdlj4Nc@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
