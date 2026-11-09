Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235796;
	b=3qtc6kLNquMUof5AENA4O23QnsVIVqmrcg9ISDcoIUvKvnLb+R7s6NOntAH3tgH21Sm7
	 /d1sUCg8UNhkDq2J1a1h4adoCWFd75DWkj/xAYQc1q9MHY7gtuWrQFx/qjguL+hihKflm
	 invgsI49TMVQKqhRngjbZp/5KF28Y/WkiKuYrUYG6CfH1CAyOpvzpUBQEgXkijt1g+FbQ
	 DMsUwrSuvQ4kOfNQG8AHQOBey5g1xlfxgbtk3+QNR501Korw27SI9/AUI+s0FAvyxjS44
	 +BYnFlaKzzeJatji+hY8/KeBbzNn27Lf1ugb0OmKNcduOWLwHuSi0gakvweRzhghzdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4RSmtcwNoe4fGrMvwANPOQwGQ5KlD1ttYfRV5b0y9d8=;
	b=e88u8d9oMFdC0+wAwusjpIIzAA8VdmsOl1Jg0oXn0YoF/11QH0LrhtHVKHsvOHbp0ZGK
	 oXkzLIIMtJZ3OyK+FrjEfB8wO5As32rm0tVHT3O+qm6hJ3ApMlZnkv4EWt+asLXTnNZn3
	 bh46QX4hg+x4PIv+umnCcvkDKXNTsvNcyrKUYEICBaEk31qw4ycxJe/LYZs4IK9WZUzdU
	 oXF/aaSON6pbYHmDd6sSopw3Us7UKEx4Vwzs4OKhdapiQNHC83m4soImQfsy3SjUDsAmU
	 IC9NM5ilUWswHfaEtD5P7o+6pYANt+lWIr0/1Mu7aYn19fsPtbGkBGGnvVfK6zfDIZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oKQpSjyp;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D2606A326
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 14:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318D2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oKQpSjyp
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53e1d40628eso12114641cf.0
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 06:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794235795; x=1794840595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4RSmtcwNoe4fGrMvwANPOQwGQ5KlD1ttYfRV5b0y9d8=;
        b=oKQpSjypJV/8BYimCUbLH/doWtwNr2rzEx+IZmgBxwGsp+wz24vzDEwUf7iSUD3qaF
         wN7nu5QreOwFpRBsrxAUfaVDwa44a0HXl5Q/l7Bp8LPEd9h4z+Olpjm+ExUOe6Gcl/A+
         tboUQG1VNVwmnu3dNnuxeX+CH5YL0grbY+79fh32g4rlI+XOgySVLsjAyY2mN9z2l8vI
         aZ9TxRJeRf9z4+ZEAJoOTGh6D9cVuvWTpfIBKUz1KTj4N0w4Lfe5k+8nefwMUOrunz0N
         r47XGgW1pVlYjC8lgpJ4oXfFTY3Cq0tCqsYCWf6J1n4snk6fquYK+ivMFCTQltIN5XQb
         GBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235795; x=1794840595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RSmtcwNoe4fGrMvwANPOQwGQ5KlD1ttYfRV5b0y9d8=;
        b=bAVDn8rpFIElUbmdWHmCIa1ZPb7wAXA1oIsP9Q3LzUzYF2OXNMrSHVyL9QTFTNoWjQ
         h0A3Kp18N6djlZD2J+/orjwquUKfZ/IKetPOBj1pIlmUDPB/c4YrB9KH08BOGc8Nss1/
         jXQjbns1B7XDVeZgUzcYgCQoTwjZd74sU38YcuvLFotMkagIbZZQEFcFl5PRfKjDxAjh
         pfsgbGegWjwJLw1iL/go7JnkLLAL32vE+Hto97Q+/x8G2IE4mzRxITej9T8GeU8ganws
         wymh2ryiv/tEENCx8y6rHOiRQ71/i6w2h1KPY8rHR7nV311xGGqz8t7vGExpQDtxkgu6
         9cbg==
X-Forwarded-Encrypted: i=1; AL+hErERe0UoAqaL95fwGNSr6SheiaYJ04Eygf8DElbSGJ3qQMDKskwOinFIyQ8Ss1/Mysxp2xRNLB9wTFjv@vger.kernel.org
X-Gm-Message-State: APuU4Z8+IF++Jih3KHM25daBUBdgVN3/rI71TRw5fVvScSyimmuelsTU
	ibmHJCHGpSNBqSSKrfquzKX9R+0oQ69cLmF6EFpxG430f+Q7s1lIMYZGAN5lE5mOwG0=
X-Gm-Gg: AYBFou2xwfzxAxqQ3vVUXCBqwfgHmcDpNcCEIwG5Si7uMpu6CBEcvLMFDmFrullP4kb
	yFEcOJ/9Tnj62lyWneXBQhu/zy7kLtezCn0uctbICxUudmyuHTnLOLd8kf5QpFmYYwwBjY8LRsn
	v0c2pl4DfaMDtFSXoC0wYdoivLzp5AWZ/7uao9v7tRfmnOeb1/P7WeYiJcae8vGyx1EPl1AzgIL
	SnE9NY94wrQFkajFwB3NafT2jwPY2Fqo3slNjOzb1SdVOisX/78Qvgh3tMtViZ3QJ4XonJAuS0t
	Hoh1sYFtzTa6PsTZTMOyDLBvczf9WdK0pZXE3qgUKskymF3NeTrJ7AEVDX9W0C/u37HY23YEt2J
	GI4sW7sHaoPmU3KN8fBu4TM0Z65X68t4I5gpoeA8knlbuv8BD9dKTikh00lYxbgWxL85p2eKFMM
	uJoIIhOo32UcnVXXvjJV8T4TKorUzCWhqj6YUCxHOmImcsFWmGS973F1yO6u6xaI9yi6JwhgacL
	FSEVDLiMA/d7otkHkamWzH/RfCKEhKdNeSGIVsHHwHLAPScH6mDDWS74amp4D7gAVChrnhRU3mb
	O7PRRNo+iC3o636dvw00ZQeLqOncaqYs0i6n0EvQOl6X74fkhxhBacf9puOKDltlewMFTt4oy9v
	KD7sgQ+iA9g==
X-Received: by 2002:ac8:5fc5:0:b0:535:1740:d334 with SMTP id d75a77b69052e-552a21effafmr59868371cf.3.1794235795175;
        Mon, 09 Nov 2026 06:49:55 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5525e68a565sm42604271cf.0.2026.11.09.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:49:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQQgz-00000001QsI-2Q0x;
	Mon, 09 Nov 2026 10:49:53 -0400
Date: Mon, 9 Nov 2026 10:49:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Yuho Choi <oss.patchbox@gmail.com>, Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio/ccw: Flush notoper_work before returning from
 reset
Message-ID: <20261109144953.GN663069@ziepe.ca>
References: <20261106191029.469837-2-oss.patchbox@gmail.com>
 <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>

On Mon, Nov 09, 2026 at 01:38:44PM +0100, Christian Borntraeger wrote:
> Am 06.11.26 um 20:10 schrieb Yuho Choi:
> > vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
> > the pages covering the range before it returns.  It calls
> > vfio_ccw_mdev_reset(), which raises a CLOSE event.
> > 
> > On the normal path fsm_close() calls cp_free() itself, so the pages are
> > unpinned synchronously.  But if the subchannel cannot be disabled or
> > quiesced, fsm_close() falls through to a NOT_OPER event.  Since commit
> > 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational"),
> > fsm_notoper() only queues notoper_work, which is where cp_free() then
> > runs.  That commit flushes the work in vfio_ccw_mdev_close_device() and
> > vfio_ccw_mdev_release_dev(), but nothing waits for it on the reset
> > path, so the callback returns with the pages still pinned.
> > 
> > Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
> > its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
> > and taking the host down.  A further CLOSE cannot help either, as both
> > CLOSE and OPEN are fsm_nop in the NOT_OPER state.
> 
> Does the the iommufd backend have the same problem?
> iopt_unmap_iova_range() keeps calling the unmap callback and gives up with
> WARN_ON(tries > 100) and -EDEADLOCK. So that path is also fixed, I
> guess.

Drivers are not allowed to refuse the shootdown, it is broken if
someone has done this.

Jason
