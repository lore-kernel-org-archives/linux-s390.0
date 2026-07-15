Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E540436BC9
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110579; cv=pass; b=Hfg7+P9GPhz+hXkg88wxiNkkvEOVt1RqCHlIieNReaC4q8Ts9FrhGtAwRoex1KTcfLsVRWH7wbJL3k9oRaWHHh/ftQIc5vBOOqIsYYNX5H9U4xQT39YsEycPTytqZNGiQHZf85FNQPhHx6q3jo0+GIH1V8RW/BDOC/7/iW9wuqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110579; c=relaxed/simple;
	bh=TeXan7JGFfsg6yrmywwHvvL9MdAl1Bc9W8Rbhlw4hmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezeeyeMQHz1Jsa+W1wpY5qOAH6SQmSek453BQF5QRh+bTe71lqyu6T6ezhjEqNKm2Xm9wVCs1Kt6E/BKqI3IrDnC8CvZkCXHU5ZN6WQMmg91AdknP/gfL1WJPOIa8w+wnBSsVw4sZJSsNl+y6KOZOmWKtud7m0w2ZwfquVHkqx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpIpP8fZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=chi+lize; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpIpP8fZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="chi+lize"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784110576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Vl9QN7NrDMgbM574d5FZjPwxnbkejsp2FCaMY17Kxg=;
	b=fpIpP8fZdfWzMF7oUui4FOieyjKDAqAITmYqrs8EW92zdLyPvd9bKz9vEby4wqPUPfDZhx
	wuF9+Ej0av+ATIOrd84Ix85Q+sCV3r4Q+3+NA3b+YeN1l9pT9EODLYqy8BwJJOoqZhqS7A
	59OFtbancJ9817btSpws9SfeSpi79tE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Yqq6GjWbP_SLo7ZjL4_ccg-1; Wed, 15 Jul 2026 06:16:15 -0400
X-MC-Unique: Yqq6GjWbP_SLo7ZjL4_ccg-1
X-Mimecast-MFC-AGG-ID: Yqq6GjWbP_SLo7ZjL4_ccg_1784110574
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47e9f03e80bso2048871f8f.3
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 03:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784110574; cv=none;
        d=google.com; s=arc-20260327;
        b=PylvAME/CSR9vD06isGcuPdbayUvavIq/TNUMlF8pPCt1O80W3beZ7VQ6Vu7hi79z5
         4DgqFosKtHZt7lak0N/qxk9xUZbC3W+lo4Edb39gDYjxy8GHMpri8w5FF7j2dJX5M+9E
         1ASsitskxCXriUvRyoKqdZylv/QjUgooSksYhOZ7LQgjmOrXyMYeM1HtrosrSnqjPQVf
         CAyqZImdvP5Zjmg6zs6M3vEhnNqZXeZRs2YOtEAyZ5KI0rWlni7VKmVd6qyXvqCiblCK
         pAZ8Z818EJLQdglWEgTsM2sA83Tz1C/QkOs5+okqAd2bw8HXrTdXJOPTnV0AoigGJtAr
         /S5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Vl9QN7NrDMgbM574d5FZjPwxnbkejsp2FCaMY17Kxg=;
        fh=qt3CkA59YFAmHOv9NQA40G0fs/tZNj4REyW4FsQeW8o=;
        b=qUyHvxMo55A/+shANOTHBk9TU3BNexxTzFCfhmyCdKJdBRr0i94bC1g6h2UtSgWas0
         e5nuJUS8rdoK31sMVMjgu9x8fs/+eTEslDzVwDjvCUV1GFbqoaMCOAv6UlHsunMHNPLj
         xo8xMHd/9rDrH8I+kAQd4u0ESB2rgizltIAQ5YAnDFEy8SGwGj1tmI7LLLYrSJLs8/eF
         1zlpl3ap10XrlbrEQbVwxrnZS+D/KWkqEKlZu929J/0ak2fI5TSL6qJGFKydUUNuZ8GI
         1YALW3r4x9r1IeeBtc8n9GbdMYjtKjSLLzEivpeXroi8MWQLJ4OCUjruRdbRViLX+BnI
         VxWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784110574; x=1784715374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Vl9QN7NrDMgbM574d5FZjPwxnbkejsp2FCaMY17Kxg=;
        b=chi+lizepEe7PIAyGY8WQ7fmPu7STRFl+x5IkLsFEb9GvEYz4pJ30Y1uT5lH6kN1ei
         nHEfuQ/fFafpC6L7YrJySEqrFrp0pkZrx2lYMlHLzoLM9rG12VCtB5KKliwKmmJPGJ9F
         hKvBYYpTjC0qkuI4xSvP82legWmHU8LhaJtlo1w6yCH9jZfHxXtMMy8EReeBHlPTjtFO
         qGNYQ2phPqAcYhg6erF50ij57nUm9etZ9tHmRymAt8Oevy/OnqS5raDu63LQuo/FVHf2
         kSDjRnhJ4oRZyyEDncQpL9J2XzD2WEzwxh638RNEoy75hBwj3shGIz4tW4miGXjSgux6
         666w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110574; x=1784715374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Vl9QN7NrDMgbM574d5FZjPwxnbkejsp2FCaMY17Kxg=;
        b=px7NjDOzNCrjGHNmAkzVg0JoJv0eHlqd4kkmh/ufl1kojqSI7DSHPPfdDxngsgalY7
         191Od+3+wSfOqip9R/7IO+tucPK7QXOs3c0TO6vVtb4WaVx5DvAu3SPmqaPNhe1E6BJ0
         QALKX0G6U2StfQ8P4EGdquw/7PwW4+BOjIL8luzpp6Wvdz0bIavKixTz4jdBh8pDY+9l
         d9c1HKN2TDtn/To0JRy3kMsnr5M2ZhJK3XDrwq9Y8qYWNl0OF1BlZndm7NxvmGFdpi2d
         eUsMtZoZ9IiLzYVyGm2pYmCz6w9wX/pXDsrwQminhBKAiXdX6YeO38P0uacf13eYMQ+z
         tTNw==
X-Forwarded-Encrypted: i=1; AHgh+RqmrqRfMQ5s+JBqpTDrrJ09PfbA6RMmABedcMBSovC5h2zc9KL7oaJY/bXlyzi5MHeOsHlyBG9zNSKs@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSMJW7krAHjqR8as4yVLarXIXFtoRDuExRXz+RXtj786Stsin
	a2HWooe12+jqN4tsMh+yY6sk7MBBd3CcQsczrYsNuL8zaXkz/kCd5td5qqmSkiHW+O2660ILFTh
	ZjuM4KAkHVzl9uy/Rdszs9YZ65EXYRTzyQXfM5t09jehbR2gDel8zCWellPfvb9wnJI6P5nyclL
	JqAteGjGI5jTj3kvKQfh0wUzzw2lDt/7y/iCsQog==
X-Gm-Gg: AfdE7cmkeePVTp4WPXstYp3h6a1/09Z0PuparhjRakS8FVNCcI7lSt6TLEkqqy0yinb
	GJZzaaoEZGMKKs76CrDO8hpkBnb4hpcwfmt/7S/yhgR9xSVKxM0lbxnw575LqaE1wDYNTU09vUU
	u/yauJZlBr7+TegkUlteAEIBNKOeqFFrhBUPQwfUnSUhWnF4LhpSivoqHv3XB97HSmcCnlhjFhr
	9FbvY+lbC8Yd6pHAtZX97cvBsg2wKIWzFjbHi7S0gKGtoqfoJMXakMPS22rIL8e5UsbaA==
X-Received: by 2002:a5d:5f48:0:b0:470:3edf:e28e with SMTP id ffacd0b85a97d-47f488486f8mr7258359f8f.10.1784110573796;
        Wed, 15 Jul 2026 03:16:13 -0700 (PDT)
X-Received: by 2002:a5d:5f48:0:b0:470:3edf:e28e with SMTP id
 ffacd0b85a97d-47f488486f8mr7258297f8f.10.1784110573180; Wed, 15 Jul 2026
 03:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713083007.65863-1-borntraeger@de.ibm.com> <03826018-1116-47be-8ad5-4a07e6f96e67@de.ibm.com>
In-Reply-To: <03826018-1116-47be-8ad5-4a07e6f96e67@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 15 Jul 2026 12:16:01 +0200
X-Gm-Features: AUfX_mzZPDV3voE9ojgWKY5KKQeCQr88BqFgkW4Ss6eDq4suBzMoKlrmVBh1WBI
Message-ID: <CABgObfZ9OmQ_MZy7F+g0MVMNM8hypP6Ya75OrCEm5nKX75=A+g@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixes for 7.2
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 1:34=E2=80=AFPM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> Am 13.07.26 um 10:30 schrieb Christian Borntraeger:
> > From: Christian Borntraeger <borntraeger@linux.ibm.com>
> >
> > Paolo,
> >
> > please pull the following changes since commit 8cdeaa50eae8dad34885515f=
62559ee83e7e8dda:
> >
> >    Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)
> >
> > from the Git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tag=
s/kvm-s390-master-7.2-1
> >
> > for you to fetch changes up to 3e3aa6da87d30a0064a17b836685cd43c90a3572=
:
> >
> >    KVM: s390: pci: Fix handling of AIF enable without AISB (2026-07-09 =
16:23:10 +0200)
> >
> > ----------------------------------------------------------------
> > KVM: s390: Fixes for 7.2
> >
> > - more gmap KVM memory management fixes
> > - PCI passthru fixes
> >
> Paolo, FYI the PCI sashiko findings are independent from these patches an=
d Farhan and Matt are
> already working on additional fixes.

Thanks, pulled these ones for now.

Paolo

