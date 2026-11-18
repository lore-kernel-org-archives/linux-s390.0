Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993089;
	b=SfXzNakQDa7gqlgbUoLt3Q+GtrNWsIMn5zoZoc9m9WJ3KwNUcLTrgdyylLwQAC7q4wn5
	 vrOWCRK5tStptenq3rMy/O4CfcDSyOexlMsuyOXyzNLvcOdpL5hCzZNYfVb9hBVWKiH7U
	 n6crtA6c3nMn4JA17bF/xA2FQJG7YmJaaX9WueUUH+rYAny1Bicdtjs68pg8w5QUl2Cxr
	 RWT/JxNJjc8rFY71XQUQsPTv6UzVUBsHuXSESlHDrNEhNeDPixyjKOpBVWKFISWQtiaeb
	 RrH7XoC30ubsRqaiEFMycvRNv/S76uYI9tgcdZCvz70rtK+vhYKaWo+A5HRi6N74L4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YGpixNBxWXCW1MjpAmJloCJpQLDbcvvCFftHkMbvGwc=;
	b=RYDvR1c/iiAJOMmv5ixLHGMVHCPDqleQZW3ZZUbQRJ7a2nMfMwOb57+YBmrfNoGEK9Lv
	 5Je5yqj/WPYvpBTPHrh35x3hPXTJTpUn3R3v/eMZogTcdtqQtz3Gk6lLr8+GUYLlklmsu
	 zPdFnAsPDLriKylii3X22a0fecM54dObEiOmkEDFbE0ph+zchAL2pNS04qp6cadI1NPaH
	 2hcxXzLPxhJS0pFuW+bE9z5NjFZv0k/Nuyj33JJZms2NatZ0oPKloSMdncV78tLpbQQZf
	 PMsaupPRf26FU4XVqIPR/lTGMsQNFHRSks+R4WoJeeVjUSoU+eCwpyw2Vl1y7HNbr+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g2s4Iku7;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B40606A31C
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 09:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B40606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g2s4Iku7
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so7389595e9.3
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 01:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794993087; x=1795597887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YGpixNBxWXCW1MjpAmJloCJpQLDbcvvCFftHkMbvGwc=;
        b=g2s4Iku7fL1iTpQaoQ708ygu6fzygbaE3zOXWXqM2MbDKrmoFPXbpRNn/oB1g93lvQ
         z5AqF2xM8Zd2xkzLJcHIL7kyUU4ZqUeUbjYi9p/+iXy0d/SpfRQy0dSprtNIa6kkJd+n
         wsNgPp88gBZY0BDKjaOZQ7yOHgN/JcGSDoQ9YvjW12uWCHIvmAy0FXlyIhXqB7VFlCPP
         +EibaSR72QQxvUZsQ+6k17i5SVeNRD0miwLTN8lIfZ71RID6+xxVT662FNSdV6USC++b
         JTBAFKky90kvtDDZ2CQ///rf0mmoWyqIRAzn7Qdlu8bJHfU4SFQJxRtCpROJbkaVvN6e
         FW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993087; x=1795597887;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGpixNBxWXCW1MjpAmJloCJpQLDbcvvCFftHkMbvGwc=;
        b=zjolDyRs9SlwImwU99nmiOrfPc+sOR5Kt31m62FmNQCIxsH2PEVD5xkxbFkJ64NljN
         RcQXl1dsY7ajRBoh8UKYj5tCtrwSFIaG8gntVaZ/6EkAclFZSv7355s2uRADoXia7nOk
         3+NwWOakVdCx6jRNTfDBrsJIRsSZhCjm050pvCES1+paAxP0HqXz/Ku25/v4ZaTIwbRu
         Fda3q16RyicNCdU/XA6reTSj3ujAwHQwWeSoM3cmQic9fKFEptZYVka+ALxs7XfQSpSn
         YNo2bZiiu7WhWnoNevYNG02xa+Jsk/NYNIuJTMhpeNv79/X8ikM6Wli2+rtmH4SBYWjo
         A0TA==
X-Forwarded-Encrypted: i=1; AL+hErHuccOKC/ZsYXsUGH3vn2K1VbycfKmwLiUlioSi7glLVRiJXWPGmDeMqAN8nVDj+v05LtnP6ZLILIi9@vger.kernel.org
X-Gm-Message-State: APuU4Z/sk3hSff4r85bGI/x2aY7h4yFggHb3Wg+lUJ/LQQBt1Qa2AyuK
	yA7Om0+KSf2ZDInTDu+FRlhNGZfs9w55N8vPBuT6aDJnoiduUMbbJdTR
X-Gm-Gg: AYBFou2jT6Fxv4paOX8GmSpC+nTpY3ysB5ZVayGqXp4qfdzKos/rwWg5GGmcB2kgnh2
	m1sloCXkBbq0foMm+jZwydne/VJz3zh//36Vg6JayTYNwvPyOX5pumCL7UQG9JG6pW/Xj6zHmtI
	H8xQyyDPZXZn16t3Sl6Lp/jfmVd9J8/8yl55NYWFFW8OSfEWDg6V7iUgV2ZnmSHNIL/SSY84KDo
	dy7JNyRFAzdgtHcSqBCZEZ4Q4UwghvI+e61uaAWaJpCrZdLqpZ7oIyKJ7OxB7fwEJq4tKusR5uO
	52SCIwkej7qieaIysBce+U6GcTiO12ByIdMkdKYlY7H6pA7Eo2fEIHxSzrYzBpL1B2QZ/UqlJNU
	HNsigpt+kt9xmZoLoX4otYJHGaNufslgZsmfaCCkf0jQ3LXjQeCBofiJoTxU+utyyCIwpwNgu0/
	LpDL2U0hTw6iQslwfaOmJ50POmcGANUx+xT89mvI10u9IuYEaIWNFPSuUZ7QS/ejXSwDhbkQTu2
	cNs8lbrB9RZiVOJcnyy6i3mJuqlbX2/bcU+8+dhOJx2aCeEZt4V4eKVNCnQm47rj6+NhGEv8HMA
	mcU5yGT6PecR4z1jd+/3ZGseq9d23GqJsQsBahvp0Q0s6Df2pz1OShqs0sOpVasXHQ==
X-Received: by 2002:a05:600d:6011:b0:4a2:1050:aff with SMTP id 5b1f17b1804b1-4bb7da12dd2mr34320085e9.6.1794993087333;
        Wed, 18 Nov 2026 01:11:27 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm137000655e9.12.2026.11.18.01.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:11:27 -0800 (PST)
Date: Wed, 18 Nov 2026 09:11:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, David Hildenbrand
 <david@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Vlastimil Babka
 <vbabka@kernel.org>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/14] s390/sclp_cmd: Replace page allocator calls with
 kzalloc()
Message-ID: <20261118091126.25efaea8@pumpkin>
In-Reply-To: <20261116152216.165348Aa5-hca@linux.ibm.com>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
	<20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
	<20261116152216.165348Aa5-hca@linux.ibm.com>
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

On Mon, 16 Nov 2026 16:22:16 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Sun, Nov 08, 2026 at 10:58:41AM +0200, Mike Rapoport (Microsoft) wrote:
> > _sclp_get_core_info(), do_chp_configure() and sclp_chp_read_info()
> > allocate the SCCBs used to read the CPU information, to configure a
> > channel path and to read the channel path information.
> > 
> > These buffers can be allocated with kmalloc() as there's nothing special
> > about them to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Performance difference between kmalloc() and __get_free_pages() is not
> > measurable as both allocators take an object/page from a per-CPU list for
> > fast path allocations.
> > 
> > For the slow path the performance is anyway determined by the amount of
> > reclaim involved rather than by what allocator is used.
> > 
> > While on it, allocate only the amount of memory the SCCB actually
> > requires in _sclp_get_core_info() rather than rounding it up to the next
> > power of two. An SCCB must be page aligned and kmalloc() guarantees that
> > the alignment of an allocation is at least its largest power of two
> > divisor, so the extended SCCB is still page aligned.
> > 
> > Replace use of __get_free_pages() and get_zeroed_page() with kzalloc()
> > and free_page[s]() with kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  drivers/s390/char/sclp_cmd.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> > index 1dc93d945be6f..6aaf1f6a3633f 100644
> > --- a/drivers/s390/char/sclp_cmd.c
> > +++ b/drivers/s390/char/sclp_cmd.c
> > @@ -102,7 +102,7 @@ int _sclp_get_core_info(struct sclp_core_info *info)
> >  		return -EOPNOTSUPP;
> >  
> >  	length = test_facility(140) ? EXT_SCCB_READ_CPU : PAGE_SIZE;
> > -	sccb = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA | __GFP_ZERO, get_order(length));
> > +	sccb = kzalloc(length, GFP_KERNEL | GFP_DMA);  
> 
> It is a bit subtle that this really works. EXT_SCCB_READ_CPU is 3 * PAGE_SIZE,
> so we end up with a guaranteed 4k alignment from the slab cache, which is
> indeed sufficient here. But this is really not obvious, and not as stable as
> before, IMHO.
> 
> I'd prefer to have this changed to:
> 
> 	sccb = kzalloc(PAGE_SIZE << get_order(length), GFP_KERNEL | GFP_DMA);
> 
> which comes with the same alignment guarantees as before.
> 

Would it be better (more obvious) to round up EXT_SCCB_READ_CPU ?

David
