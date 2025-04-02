Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FE1F1936
	for <linux-s390@vger.kernel.org>; Wed,  2 Apr 2025 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628548; cv=none; b=bw/vyXAwTb4iVo3z8MT2BVdmInOhcaJiGr01KKDx0x7DmbfbyBhrjXd9M4C7Q8ycR3s75tRR+b4jF1KHSYfuxYAwJAS3f5vi0ypPY5JIWcScRgMR1O5sry6a3516r8mTM2BuW//9BUOdW5nc+F2c6lkuCtd3S8Yq5qutxbUiL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628548; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6yTmiSFfAxzxJrYNWN+NMazX7HDtP6OMpDK3GSnZwK6fA9DOMU6ShtQJlO45oMTxx2K0LeJtQQ+I1eBrCjXe39CHRBCT4w17lcKQTendYQdEkyVMO9rzmUkXNM+1FhRpAmtQGyGD5iHPJw69oXziMHsYPkrvIUkDta3vdhFX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hw8VPkNm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hw8VPkNm"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so466300a12.0
        for <linux-s390@vger.kernel.org>; Wed, 02 Apr 2025 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628545; x=1744233345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=Hw8VPkNm+5fjt3Mzlin2bjYI0xC1YPWPxGAQjlE8idkn9jl8LFxvfQYwdblKBe4PuJ
         vkwNUg0vSu/uQYZb9psNaKwF3ryXt80wT39FomQ3gpUr1/T0uxHqR+n92+PFX6j6vaYt
         XSbIjkO6d7l84EmQY7T3C6ZaPBLcgN4L5P/kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628545; x=1744233345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=CyO3ou86yLvc/bgv43akWeJ0W0NtPDEp2QDfTkFOE2nDu7OyObC1wFQQKfL+YQfI/D
         IlJJtz/+hTUnIxwe1BXilyHWQzqBeC6xAnY3gDEn4ak0yWoPG27SOvAqht7rT3J06wLc
         8wdZmk+RwdFDo9s2cLn0Np2VLQM15CCiVTz+ilZJklnmMZs0sEnVm1jwRUXp4mOdWfhF
         I3l0wNJPDgBWGYIaBVEndslLwiCM27mGUurGPmf377KXmwksYv9Mn7lBcur3DeSjhOuh
         ZssHrlhsec5S3RnUkR5cO7oRpNSTlbZgJqWhjt/Dq0KIv2FYh1Jz0cjWGJwvcV75qvez
         VW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW98Ckdov0xB3MpGMqoY9s++Sv2rTfXzyJ/ChgSLjbIeLlunJKQOWnrnUEAzLABkC2PTkNhGeZYE9Dy@vger.kernel.org
X-Gm-Message-State: AOJu0YxbazD83vps+vYS3zU8akKuTOUU1VDSlG4lFPaQEw7o6b+3EvOq
	x/uJWaPnuwU820m3ZKbDCYa9qy91+NKeMtjCRvqnWXnwW3/WotsJys/r+kcfE8n8Wb2+CKJ8Cbp
	fos5IAw==
X-Gm-Gg: ASbGncsqmNhb89YirQDtAhlg+mFRizqzTpcHinlBygLZYHAwWr5waiV7cvnCQT2sfL3
	4QhhtQoZfCWyDsaM8aQH6Do5NAQtRx7aaWZRLfHmXswGTMwiDMeF9wiZmSbfGZmtr6p+ccYi2X6
	VDV/TRTJu0JcUP3CQ4TESH4eYTNVRsFv0/qB2uO1ugIkiqX1NRZNOo4sSx3S8ONztvSviQKsbqR
	MXAsFmUROEn/J19n6qOSPpfzEpZpKKzBX9afNUUIcELXFoXI286aQhzmPhWcaH8YoLjpuhiOJ2F
	2M4LFm3sKLjqtMmPmlbuui1cYAxoisBbcRvarNL6i9lfsoGyhuEHGnsfVdHY7plcx275TWMQuy7
	Uo5kBGRpJ2jigIYootgjlGKo3ykg6fg==
X-Google-Smtp-Source: AGHT+IGAU9TV+t4K9bw4KMZT3ClWHbC6NSD5JATBbIncEbnnioaTPqHTi2Smh9yaST2irMLZB4d43w==
X-Received: by 2002:a05:6402:d0d:b0:5ed:1400:f879 with SMTP id 4fb4d7f45d1cf-5f087221922mr60591a12.32.1743628544655;
        Wed, 02 Apr 2025 14:15:44 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae9esm9183958a12.11.2025.04.02.14.15.44
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:15:44 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2963dc379so32001666b.2
        for <linux-s390@vger.kernel.org>; Wed, 02 Apr 2025 14:15:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwn8xyNo+Awe6PjIjuQa+u5yMLKChQPCXlCj3v5i9/59AGg2eMMuU3i7WEBRnhcNw+xV5rRaoQSlaN@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus
