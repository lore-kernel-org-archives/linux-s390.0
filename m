Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5803F7AAB
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988490; cv=none; b=b3nNzcyPYHNiTmgZF/dR08ekyZfZznDvip04JAOvNGuoyvy1aRx8N0G5l8UADjztzH+dGlE+rF+J8LnKKCNGS2qvLhgUpczAUp8+rOEu8yujqmSFYTSPRKe0PtzID3Qa0SxbCc1VogksIFiptirzwmzBojC5jybljB1a5HSHXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988490; c=relaxed/simple;
	bh=oQ9hBpzGGynFRjfeRgk6rCjipxDSZz2VIbATAt6LYSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATxAGQRqlwBilDJtHBxVdSThJIXVBVnaw9f3zES0hJk/AOl1ykYiuB6FsGNG5xXscS30zrXRjCqtMlgcf42zUaygSkr2S7BmrtePd4AKFtH6d8Jfmpz1s7oMs6ncl1BooTTVsr4KdywX+HU74FE+RAvMJcL1jsYxsCj2nvimtac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAPfvE3n; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAPfvE3n"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4906238c62eso44506295e9.3
        for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779988487; x=1780593287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhbcizAkayIxB4NI+KgT943Z2mRTxX+yoyxWBHqdFhk=;
        b=SAPfvE3nj71tYYrcQSk9jOQf7z59ySkMNOdbJcywPBwr0OnCzhJn9p2vA1JAboA3OA
         qi+KiGSeVgdxzeVCKyghk20Bemm3/xJ6YIgMLkKfhAllQ9SoiUL3WRl1SKZXwCvy58vu
         2w5/0bQUEpROR/XOUNxlIJJIj2sp2Lq7ROyG/ZfaNE9vdwzCUR/yKu6HIbFRurZyyoP0
         i8RXpYNMEzNWfwzSi9StAQHUw8OWBVIXjbB2HAFTH3f3r9y/BxYKZaQ81jugWyg4Zy3Q
         kjcGfbZdKLvMVCMK1IqdmTozh0UOAEpOfe/4V2MZu33OtKLM0yaJ9JxQ1cDUL9+2JPcJ
         iRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779988487; x=1780593287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MhbcizAkayIxB4NI+KgT943Z2mRTxX+yoyxWBHqdFhk=;
        b=DQTYYivM3ppbYHc8NXghmMSOI7YIKMn/5NJpo7LepGOSLfcFF3mKE7ltyrnNAtcOZn
         hqnBmiQ3M0JLx/iDr+ch1vsuIpfxPQp7eR+g+jud0TaJe48E454imrlTJo2fM3lU2gXJ
         zSh/+2uCfAOxh2xhH2OJ5ZnU0Onq7wUTQ2b0J4smtIF2+axYuqC2WhN4A8E8rD5Fvlqu
         JEnPJfNjreVVyn/cuD4Wc3FcwlXqq1Yby2dIqXCAuZ8IAGhc8+076Tg8dA0cgU+7ZQKR
         ZX3OqVc7oTsz+ymhMusBrqtLDI68y+umKlOOKk4RjP1l84FJ2UTR7KvP3l3207CYazQs
         hbHg==
X-Forwarded-Encrypted: i=1; AFNElJ+z+RwKbZ9zA6dpAfb6fsB6TF57iZ1t8/QRNd7oAXCluOPI/XaGmIYSLUYN//w1F12YUd3GEIvvXUs8@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7OwivaPzZZoq7bzyA6jvATB+6Vnd9uZom6vsESPn4Da/6j2l
	9+dpenhO0W/O9yV+Ex4M74Kcr2zmrYeKvppgMBgOEm5Augh3heedWsc5
X-Gm-Gg: Acq92OGXyV/Zk8lb9gVQDfN+dD+MpbDM0H2ngaNusTPirgWUuLuRgMrF+OyDooIpRQ7
	+DKEICO8tEfBz6nZ+byyRIkIT7NLZYZO2CnVneyMh7I/TfQnTZvre/zIPvPkxKYpws7z5OHZlOz
	8tfHsolY5dCMrTXu+oH77/S6AlH3s/i1bgwCW/I24SPbv8gSVrSR8LiZ6bdeW6yVx+ocHfkzG4B
	YfNd4p3oUyB2jxEmNIEUDQtUWcodY/BM2YySsOdVZOdIJ9s3Bt1YgPnlFLXcU5BHEMBtl4nSyFy
	JFsNs9nUshsvO9EvsMJ5FbPJgJm+sXyIfdEaa/ZK+mAbv7F/5Y2ejO5r7amKYL4HqLOvaVgo63U
	Zd6hQ5BzDZTUPW3C+xNztal41ajf9OFrZ262ayTlmWlnIOj+D8NfCv8LcgANQmpZV10ZDU6gTA/
	oG/NxGN4FY0jDkQzHQQ70Gw4sP9eQxcchY5Hgq2nrsYbSgg+U33HpE6EbnhJ69KY5X/LjVdU0=
X-Received: by 2002:a05:600c:3b08:b0:490:7dfd:f7c2 with SMTP id 5b1f17b1804b1-4907dfdf7femr147259995e9.11.1779988486702;
        Thu, 28 May 2026 10:14:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49091d55972sm50781845e9.0.2026.05.28.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:14:46 -0700 (PDT)
Date: Thu, 28 May 2026 18:14:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Juergen Christ <jchrist@linux.ibm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Peter Zijlstra
 <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260528181445.79859403@pumpkin>
In-Reply-To: <20260528141441.15387D07-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
	<20260520233409.0683f595@pumpkin>
	<d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
	<20260521103742.9603C8c-hca@linux.ibm.com>
	<5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
	<20260522091805.18098A5c-hca@linux.ibm.com>
	<cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
	<20260528141441.15387D07-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 16:14:41 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Wed, May 27, 2026 at 04:44:31PM -0700, Yang Shi wrote:
> > On 5/22/26 2:18 AM, Heiko Carstens wrote:  
> > > It is amazing to see the performance improvements you see on arm64, however
> > > I believe that is mainly because of the large amount of code which is
> > > generated by the arm64 implementations of the preempt primitives
> > > __preempt_count_add() and __preempt_count_dec_and_test().  
> > 
> > Yes, we need 4 instructions on ARM64 for disabling/enabling preempt (one
> > instruction is used to load current pointer, the other 3 instructions are
> > used to RMW preempt_count). So I can remove 8 instructions in total for a
> > single this_cpu ops. That's a lot. Given this_cpu ops are heavily used in
> > kernel, we end up running fewer instructions and having better icache hit
> > rate, the better icache hit rate also helps reduce cross node traffic for
> > 2-socket system.  
> 
> You save more. Look at arm64's __preempt_count_dec_and_test()
> implementation: it is RMW + compare + READ + compare.
> 
> preempt_enable() generates this code, where x1 seems to contain the
> preempt_count pointer:
> 
>   80:   f9400420        ldr     x0, [x1, #8]
>   84:   d1000400        sub     x0, x0, #0x1
>   88:   b9000820        str     w0, [x1, #8]
>   8c:   b4000060        cbz     x0, 98 <bar+0x58>
>   90:   f9400420        ldr     x0, [x1, #8]
>   94:   b5000040        cbnz    x0, 9c <bar+0x5c>
>   98:   94000000        bl      0 <preempt_schedule_notrace>
>   9c:   ...
> 
> I assume arm64's instruction set does not allow for better code for
> __preempt_count_dec_and_test() if you would fold the need_resched bit into
> preempt_count and use atomic instructions + inline assembly with flag
> output operands when modifying preempt_count.
> As of now only x86 and s390 are doing that.

I think arm64 only has single instruction exchanges - which makes life hard.
But it has to be possible to do better than the above.
The 'normal' path (not nested, no preemption) seems to execute everything
except the 'bl'.
All the 'not preempted' paths have a taken forwards conditional branch
that stands a fair chance of being mispredicted.
There is also the 32bit write followed by a 64bit read of the same address.
That will 'break' any logic that does 'store to load' forwarding (where
the read is satisfied from the store buffer) and add more delays.
That means I think you need something like:
	ldr	w0, [x1, #8]
	sub	x0, x0, #1
	str	w0, [x1, #8]
	ldr	w2, [x1, #12]
	or	x0, x0, x2 
	cbz	x0, 1f
2:
# sometime later.
1:
	bl	preempt_schedule:
	b	2b

But the last arm system I wrote asm for was a strongarm!
And the book I have is from 2004.

The definition:
#define preempt_enable() \
do { \
	barrier(); \
	if (unlikely(preempt_count_dec_and_test())) \
		__preempt_schedule(); \
} while (0) 
doesn't really help.
gcc tends to ignore the unlikely() when the other path is empty
and just generates a forwards branch around the call.
Forcing it to generate both parts of the if can help.
So:
#define preempt_enable() \
do { \
	barrier(); \
	if (unlikely(preempt_count_dec_and_test())) \
		__preempt_schedule(); \
	else \
		asm (""); \
} while (0)
can be enough to force a conditional branch to the call.

-- David


