Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794248128;
	b=Ikjmj6x2ZMXlYvDAFGilX4AnYY63xthTCOTXfn0OaEHd0Ui7+z6ldMerLF74JBUcgW7L
	 W1crCtBI+7SASkjw+azTH7njyEoUUwdvOXsKxmUdv01uQaxRXQXysPlCe3Ex91k+97SXv
	 99rfyKzqQDWW6DGgzflM/HRVvKzNoy5YEHgvshAlUIRcuUxnb+XySwDcgqr5X7cKcUaaP
	 FpgCcL/K3q2ZVdpZ741WiCvu/s8S44yT0OUXu2ZKv9gvgtxQy1Z2RhYP0MXJzm4h3k0l8
	 iBn8geI8gnhdglRoDE5gMFbj+cQ3mZwMV8C3c7ZU+eC3cav6KVlw5SQxoYlXK7ceYbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=A/qVClOCqu/XJfl5OHSDd/IqxT1Vn4LDahzKvulflyQ=;
	b=LIfTf+JBL9MKfNx57gjuld+6pyHkU1DW7YUcpjYxkDorOSdRhsxFMEQRltq0ItpSHJ2o
	 D6BJWsumM+qvU442v2sK9Z7ajZvqziDjWP1WCGD1ODXNM61SQVo2lsYr1O2BhzPFC8F/B
	 kaijADwPOQ58acJSmrIJqUUjAtakGOjARM1mHOrOcuZVCJnXMbFeAF2zV4npdGobiv1aH
	 OIxI1oay44ph6DvyIUiolhqlKpm9VQU16bBM8Ik+/ZocorDM9OFRQHB0pFeu6c6zU1pmT
	 bPxVGDYrT1j5KHunXFL0abzBD1FPXaSM9WqLlX8Dxiz15t8C5VVKbBzInf+ZhPm6TUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HnyTglw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BC606A333
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 18:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 130BC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HnyTglw
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ad5529ae64so9610371fa.2
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 10:15:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794248126; cv=none;
        d=google.com; s=arc-20260327;
        b=KcGOb1Z2qQgQH9lzPVPloJc8nsPx1cQJFHS88Dg4JkEUcunDXxwZcn2zW6vtcmbxCn
         JqH+MNtZ29NUMoJRJh3UzWDMs2JhdOttIwO4WBWdBC+jQYzwzLsAmOPIHFU2PajxLAMg
         DLZnD3MiZYyvtGKVXYuhU/aHRnFCv1/wCs/FZbOiAxZJaSKKQgSxoK+1VXzJN7Muzl03
         OoorkUSKXAL8hpcu2eGf1Qa5Uy2zdk6A3HCLQglGm6B5fxIhLq2F9y0RZNMWNfABlAVZ
         Al9iqAQnQuTkBtyfT7vHE8MpX/x4nAj/gbIvt2SWbu4KTqT14ULZUVAfpzm9zYRd5yW0
         udlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A/qVClOCqu/XJfl5OHSDd/IqxT1Vn4LDahzKvulflyQ=;
        fh=68R8HeaURNm42MmWkF3a0zGud5emNKgMd7r2jVstPNU=;
        b=qKVHns86Vr/CfbC5DmXmJdT1OETHWY29NrvzCqUhCYzMLF7dO3pzfA95A6gvLOzBcY
         VQUHT48H1EsqJuoO8bRvJfirS8YsvP8x8D+d5xArhJS8KJGBq5UOu8UPtOQ0MSOd0rrY
         tA78qiMWTVA+4QJszQ/kki4HjhJ6izt6v1XphF4j0ku7kxBBOZJeXLQK+TrJsT0gXQ0I
         Os8b/KlIy63yQ6Dq8D85F9kXs547fznSFvwYIqkUyUXCkf02SojBv4QA4Cydn3r50jh4
         YkSkVaAy++feXcaqSdBBt/k6mHcwjhrLFZzsS8COghCwr+wqAYoSR7Mxzc4m5rOO6Kck
         wUSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248126; x=1794852926; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/qVClOCqu/XJfl5OHSDd/IqxT1Vn4LDahzKvulflyQ=;
        b=0HnyTglwTAL8gX+olVe8YavKHfLdVCs/Be3jlhbF7fiJ+BKhmXakYEsD8bV87zN8LX
         5baMSU6AgQuNEbABjA/yInkUpowZckQGLi5G7NdLcn+Db94+JHJKoSUatxJTey1sUiIT
         6Cc+a4BNwjPonJI5zoFYFSoxlc1OZu8/khdxk5l+nlPao2z4j3MXOPeLg7Qz3g9rmbxG
         lT/Pzdl4hmjyBx0aKYC0DXlFboMzZFYWltciUjh9KNDjKugvCvNkvYTc/qgCopKva50A
         j5/Z+wgveMoD9+aZ1FlmXreaQ+MGFHABZoYLDgqSbjYDrI9xXqGCmseyvdRwjNtX4ois
         LlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248126; x=1794852926;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A/qVClOCqu/XJfl5OHSDd/IqxT1Vn4LDahzKvulflyQ=;
        b=tF0ABE2gjzjl5CXJGF9F53EQw8loTHmGz8zlaPk+PUAIwloQizPUGD6+iGkBG9pLwR
         Xg00jwSF/sKqWnTuIt3b9ax5U5YsKetzoGlplix7ggPU3o6zsmAXXjZ9u6R5CmOvB9TQ
         duOFYywWKnbkDO417CtZbPjrNZFaMZhplbucq+40xCRAnF6z0bPRdCDDTihPH7Urs8Nr
         ZZ0TKUd73p1AuubWrbjuaBbt2F8iTyoOYd0OCnDb5fJ4PVbf+y+fMt7A7wPu0fOCdJMm
         COpEpOon4z6NdrtzUsM1TBBmnbLLpBwgYBQN8Ns+9ImD89Tud6/FzfUQ6Q0aI9V8W+/U
         HiNw==
X-Forwarded-Encrypted: i=1; AL+hErGGcNYly7dPrdUeZOufn5FDgk69dp07vZ6w/2GWXky4rfpz/3qhCCPWdxRBxb09ErIZ5VLtQhaDpmZI@vger.kernel.org
X-Gm-Message-State: APuU4Z/Il5T/+J/JAnzhckdMK2wzfIwaRGPhk+45V6HxhL0FUHQ1YjA/
	5tUJm8g7wWHFDcaXmHgV54TgEHArUXrJkt9wfe1L4c9Wk3nwUetCnvhT3t6iPIK3ecwwENKc92V
	Yfub1cwpScHFp+NjLBquC4YibozIResc=
X-Gm-Gg: AYBFou1MofJ1TJESsV2HNZmKHHDWmfX9e6i4fwqh8pLhdFo1AQkpg89e4Tkm+Ci81OQ
	Liqr7041tvLxySGpMqs2gWY9GQkm03lIEPncxnZ6X5dGykMCfobi0/Vh7JXbVMdy2QrZNUK1aJ3
	uw7UL75sQ1OxWKfKSNYUaJIVo0P1CjLtAaEZC3L4IulpIJ+IYUQsZPSage8nh/6gWCNfpQHzFfk
	j1jhIAiHOa51CrkJCORNypGE7GysoNvtr/0HLjJ3NSU4JY05cNWJzW8wInoofto0Z1Q99DS44BP
	ymjkuz3FwGUv+ehxAOaJzo/Ly4QSeOJ6FxHmWWfUBRArp9fCEZ+DEqLNiBtCfQBKdvSRiRanQgM
	XXYeYV7fiPUcWKhgQ/a4RIqAMcTltJUCyDNjP6oMZePoNDrk/Lcxlc354wcA=
X-Received: by 2002:a05:651c:1991:b0:3a9:a1ed:6341 with SMTP id
 38308e7fff4ca-3ae096266a2mr129721fa.11.1794248125851; Mon, 09 Nov 2026
 10:15:25 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106191029.469837-2-oss.patchbox@gmail.com> <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>
In-Reply-To: <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 9 Nov 2026 13:15:12 -0500
X-Gm-Features: AclHuK-kA47IWOIX7U2zRiO72EVz0LSCPAeXxYhlYbmsVsJrtKZ_L0q_mB3RhFw
Message-ID: <CAGG=RgDu7-3g1yTGRYukfhpXnPgqE5BDQ_cAzMN=78QiUrOykg@mail.gmail.com>
Subject: Re: [PATCH v2] vfio/ccw: Flush notoper_work before returning from reset
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 07:38, Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Does the the iommufd backend have the same problem?
> iopt_unmap_iova_range() keeps calling the unmap callback and gives up with
> WARN_ON(tries > 100) and -EDEADLOCK. So that path is also fixed, I guess.

Yes. With iommufd, vfio_ccw_dma_unmap() is reached through
vfio_emulated_unmap(), so the pages are left pinned in the same way.
iopt_unmap_iova_range() then retries, and if notoper_work has not run
by then, it warns and fails the unmap with -EDEADLOCK instead of
hitting the BUG_ON. With the flush, the pages are unpinned before the
callback returns on both backends.

> > Fixes: 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational")
> cc stable ?

I'm not sure, so I'll leave that to you.
