Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB616311C2D
	for <linux-s390@vger.kernel.org>; Thu, 27 Nov 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764280375; cv=none; b=P6r/fNsBQ828sbkrNsTpjDMHaU7t0/2Lt/fUoSFn5rNhL5yN4je4m9G3Ni0yN3muGzpbxy0G2KpBOJYOOXcaVOGgzoDC+avsywuOEJvPx2JUgUxz9NxtFglUloZ9HZ4lEGk8sLYkiw16Y/We6J3QVMeCro0DgftpZajMNhMhxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764280375; c=relaxed/simple;
	bh=4Pj66Y3umMwlrabEjE1lX88865iL+KzgEAusgbBYyKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVXHAl1Fuuiua6BG8xGvy5Dg09YhNtHd4iMq5M+Yn6N9KvQP0m5WhEciIVUahpK9N3Vw3OygVSdMqNxnCFgnfkjYq0+MGobxL3BLSbA2buZghb2amCJNEQ1DzXSnr/g54+9/g9JQp7z9cVxfQX17/bedUqExYuMFClG+lJdWtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPwhbzWO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPwhbzWO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8804ca2a730so17991866d6.2
        for <linux-s390@vger.kernel.org>; Thu, 27 Nov 2025 13:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764280372; x=1764885172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jttLJ8TWGePu+ngSo1n4o5hp2pzXFGAv2t0XowsTZMg=;
        b=TPwhbzWOGf2/62dZBmZzJ1KK5GHczMKctFSVTSa02I984aRldpda+C8QshDpc60TDR
         F5P72PVJXZwZshQZvo1i5TCNEE2NAPygOLOl4TOugZXYL0MAxIMuM5vPLF8RH6++Q84m
         o0LotgaHJqtgnpDQTQ5kvmgWhv0q+H5S/LUYsZ0Fwr7mq2GqZHfy7miVERXYk1L7O14P
         RpYHDpZysn6fHCW/+mYBMo68r6vx8ylPWwYXn/F3rVWP0Ao4FgcV7walYCt33RKgAmJO
         DVrsqWgjtircVXIRuUIDi11fkXTasnYkejpxTk7kfHTW6OdPtC7X61KxmtfNrCMMDGbs
         U3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764280372; x=1764885172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jttLJ8TWGePu+ngSo1n4o5hp2pzXFGAv2t0XowsTZMg=;
        b=J62b6a8f4YF4ag2augg0v7rYL09tY7vUWcUr1QYExGd1b5eeg7+7b49ktO+RSsB8g6
         Kbi3Jvk5a9gndBlRHldHZlJUCiKeOc1028aY8JLCG8TxI9AUb1Ww4nTldQQ41FI+BdOj
         Q8Xf/9N/99jTXunKscQsShw42dcZEDLdoNZGtUY5VcirzRcepLFAED57wQ9JN/gWMO1X
         zL5f2IAltQzmHDvgmU/A6hUODxnk1qeyycKoYFp1qh742MV0jlpyiLnC3SWdMGR7CeHh
         xU+f6bFr33YDY0kXbD0M/mtjkpu2kOtJ3e5cj+RuN/GM4X0Oh3SJgBvcZubPcH9808q6
         yhFw==
X-Forwarded-Encrypted: i=1; AJvYcCVRRy0bWUrs8gV/FiU5sufsHGYrvLjhvMRKeK0nN+vFoSMU4y1aYXEWZ0x/fQR70CRys0sNwxAGQbTq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZYmgkLODPPRHumIiCxd7E2yQIuqkFXf1hQVCHLr/6avGJnts
	9EPRqeQvHHfE0ujjw92+tBCb1MeLwZdTZoTHRBobclQEU4ydPBU6h6XBVEPn7y4wFsVrzpvrGYk
	0KSsfI+icPGWRVuWRCJaSOcNSjfBVjD0=
X-Gm-Gg: ASbGncsZTbXPDCC01jHepb9DrRLsl2rE8yhAAWShP6JDoMVZXBUqLWiP5ov7RT/0gn0
	2I2D4TSwQcaJIz1d9mEib+lcQ84UCbBYwqgrN8PD5lmcQND9sXXGL8rQ505Zw5mQ/EctM8mr7FI
	GCP488heQzk9VL811qc1VbMZJWzwTD7OLzIBg6Z2esb6hOjuFsWImRcvWje67TSgYTtPPwDdOYb
	UnHI3V7m0ig1beXlJhx4VsLbZ3IMawkXk0cFTa31BVkxm71CvbUEkQux2zoZl4sgLDIGw==
X-Google-Smtp-Source: AGHT+IGi53ssJfVFEVeCKpbOH4PM/Uba/gyP2VL/mpIj2xLrn6No0jDJl3wOawm61ht0VMTz1HcUV32B95MPtil1ISg=
X-Received: by 2002:a05:6214:19c9:b0:880:49bd:e217 with SMTP id
 6a1803df08f44-8847c486a0bmr364162506d6.10.1764280372486; Thu, 27 Nov 2025
 13:52:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127011438.6918-1-21cnbao@gmail.com> <aSfO7fA-04SBtTug@casper.infradead.org>
 <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
 <aSip2mWX13sqPW_l@casper.infradead.org> <CAGsJ_4zWGYiu1wv=D7bV5zd0h8TEHTCARhyu_9_gL36PiNvbHQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zWGYiu1wv=D7bV5zd0h8TEHTCARhyu_9_gL36PiNvbHQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 28 Nov 2025 05:52:40 +0800
X-Gm-Features: AWmQ_blYpw-GPSWAvHSSwIXD1PKL1aIx4iCUo78DT2gXpdF1CZ018OhwLE5_XJY
Message-ID: <CAGsJ_4wvaieWtTrK+koM3SFu9rDExkVHX5eUwYiEotVqP-ndEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 4:29=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Nov 28, 2025 at 3:43=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > [dropping individuals, leaving only mailing lists.  please don't send
> > this kind of thing to so many people in future]

Apologies, I missed this one.

The output comes from ./scripts/get_maintainer.pl. If you think the group i=
s
too large, I guess we should at least include Suren, Lorenzo, David, and
a few others in the discussion?

[...]

>
> >
> > This use case also manages to get utterly hung-up trying to do reclaim
> > today with the mmap_lock held.  SO it manifests somewhat similarly to
> > your problem (everybody ends up blocked on mmap_lock) but it has a
> > rather different root cause.

If I understand the use case correctly, I believe retrying with the per-VMA
lock would also be very helpful. Previously, we always retried using
mmap_lock, which can be difficult to acquire under heavy contention, leadin=
g
to long latency while the pages might be reclaimed. With the per-VMA lock, =
it
is much easier to hold and proceed with the work.

Thanks
Barry
