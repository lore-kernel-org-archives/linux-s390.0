Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB504252BF
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949085; cv=none; b=fwP9q7GSvgs+jqDrtFLyC1VmoA81/blBKPQAPcYEoRr11liWcVt4oLVYipkzdgVA2RxD7hG70MWVjm/4eapo9+UwmUdYaCTSMRsIVoy+FFIHSigf8PIuqlk0e+FMFku9/+HFwd7t1EHey4Z5XyKdC4rIacacdKt+EuaP5Qz7yX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949085; c=relaxed/simple;
	bh=SD0QydIM+/yoeK5kEju3glLM8jKW6W+AxcIUwHNPEsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frJqD8LLT77Sw557WZ8zf5q6eEKUQd5Z7VWsxhD/B7vtSkDQGZnvJBlCAaogXCEhM/UG0HwhaCSVu+gjjn09oQyWdJ+nV3D1QFNWNrbkDT3CZ3cUUqMf7Pp9idFiOaoejn0m86pY/owvVV5Bd5Xu0LlqRSwtp4gUr8s+2akqbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=SrX8heeI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="SrX8heeI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-476a130c138so3793769f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783949080; x=1784553880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xjZ7NtwsFGiweoS+gCGkEmR8ZqgtuQmxjICy7rYDGs=;
        b=SrX8heeIfPTAyvAW49ZeasDaz+WdFcG1we8vbrQn6wtW3d3VSFJ7XOX0VggDnElKw+
         Fidvn8KoXq1l2Oe2N5es8SGvNgg6VB0W5XtW3qSIIlU6sI8gP/iR4pXje2m20E6l8cqu
         qLzreEgZSm32RzMICv5udyBb3YxrovXRtTxfnvdHgLiN76SCrGEwcmQazaPMJpdCLd2a
         ATu+oL0ZZLB5jK6XVIMv+ABxR7TwVBRO66VfyOWPF96h/bPDz8d0DVdMZQbERtP+i6tO
         UkBps9mDN697+J0r/iUVjG2OaMcMyLjLH5qcqDaCnf8AXrttWYLxJ3Tnv94Y8xdZT1Ay
         Zqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783949080; x=1784553880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7xjZ7NtwsFGiweoS+gCGkEmR8ZqgtuQmxjICy7rYDGs=;
        b=HbB8MKCs53dhpNZZHPG99jAb7YlniDEVV0wvpmXHcUE1QLK5AlYXxakWJlXPpebMXA
         ZGle8W50vZTLgE5n9evyxA+ik8Y/ZF3z3L0oXp21CXL2qmtYtsuVTJFjHgx/BazMUSao
         pXqVErisv2ATLV6kdLq0pHRm6X9Qfk5KZTu6jqau39RrGWehobIv3YsjFS3XA403P/cD
         A43obMXS56cYLOQs9ocPitDrRpyiKfsrh8BriL8O0A0er7BWYNQTHZZgwUb4SLgqR3vw
         9Qpo9by/fEfjY6lWkjs9HaeEufd6ijTkCK+eXzZ3d30q7XyReC3BBIs+Uk99Xn1EfZZ7
         fabg==
X-Forwarded-Encrypted: i=1; AHgh+RqdzP77Ay/BNjU6M34AbgohVPlkYjGnTbRM+bj8wqDjhJMmsswliQfz+7tMSNYiOpnFJpqWZAUy1Ig0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8ikpPvtyG6B2YJJa0t66QF37DFVLmi+nEf833IDvkdkQkcbF
	q/YzY6mPtgM1PUK34ZcD9ISiVS4FJ3IJiPhpSu45qd5ifXexJ56IthTXMNZ/m1CXLJE=
X-Gm-Gg: AfdE7cle/Oei2B16ghLOpjb43/tUZgdS36k/0/UgRLcboUXcCv1qY/5zs7GQ9WVqEg2
	8Rp8txOmd6DBDfZdBDP/Ihdzmyn56esykzeIeho8O74uuMHTpQZz1I18DK5Kkc97b9DeoKcnDIf
	Q5dZpHVznk5ZnzL/noPjHbpPUTTIcTRsorGHxsnE0j97jXeoNfr85cq4FyvZjMnFlqoLh1/Mycb
	arpazGAT2BsCkRdNr2AoxqBxNtuY4CmTkqp14U3III8G/EGd5DESEwrVnVBtrv5Ti/XoRQpDpd7
	67/eETVr+62qeEUO0HwykO/h+RUk6aKiU1nERwkE3sXcDl+lsUNgQGb5Fig8aP8UKo8BWOGhy33
	sS3NwK9JEX3tG25MXgcw67W46TOfCykC4fO6oXzHTl5tLIOAr76bOkRg4gnOGohrJLQa5qSZIRx
	Py6wtAoLeYtpGQaKEMDESZPw==
X-Received: by 2002:a05:6000:2dc9:b0:475:f100:35f7 with SMTP id ffacd0b85a97d-47f2dd3d5aamr10903873f8f.52.1783949080022;
        Mon, 13 Jul 2026 06:24:40 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e785sm84082951f8f.8.2026.07.13.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:24:39 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:24:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, tj@kernel.org, 
	linux-s390@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Subject: Re: [PATCH rdma-next 12/13] RDMA/rxe: Implement
 disassociate_ucontext callback
Message-ID: <alTnCW2s8kA6Gc0Q@FV6GYCPJ69>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-13-jiri@resnulli.us>
 <20260710095630.C5F851F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710095630.C5F851F00A3D@smtp.kernel.org>

Fri, Jul 10, 2026 at 11:56:30AM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [Critical] Implementing an empty `disassociate_ucontext` callback bypasses the core's VMA zapping because RXE uses legacy, untracked VMAs. This leads to a Use-After-Free of `ib_ucontext` and `rxe_dev` when the VMA is eventually closed, and potential kernel panics upon module unload.
>--
>
>--- Patch [12]: [PATCH rdma-next 12/13] RDMA/rxe: Implement disassociate_ucontext callback ---
>commit 8946fc9f2a378bad6f910a408699c6a70e97a6f6
>Author: Jiri Pirko <jiri@resnulli.us>
>
>RDMA/rxe: Implement disassociate_ucontext callback
>
>Implement an empty disassociate_ucontext() callback so the RDMA core
>can move rxe devices between net namespaces. The core requires this
>callback to reset user contexts without waiting for userspace.
>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index 1ec130fee8ea7..6eb10d2f0653b 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -240,6 +240,10 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
>>  		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
>>  }
>>  
>> +static void rxe_disassociate_ucontext(struct ib_ucontext *ibuc)
>> +{
>> +}
>> +
>
>[Severity: Critical]
>By adding this callback, does this opt the driver into asynchronous teardown
>which can lead to a use-after-free and kernel panic?
>
>Because RXE uses legacy, untracked VMAs (bypassing the core's
>rdma_user_mmap_entry mechanism), these VMAs are invisible to the core and are
>not zapped during teardown.
>
>If a user process maps an RXE resource and the device is then removed or
>migrated to another network namespace, the asynchronous teardown will free
>the ib_ucontext and allow module unload while the process still holds the VMA.
>
>When the process later unmaps the memory or exits, the untracked VMA's close
>callback (rxe_vma_close) will trigger rxe_mmap_release(), accessing the
>already-freed ib_ucontext and rxe_dev:
>
>drivers/infiniband/sw/rxe/rxe_mmap.c:rxe_mmap_release() {
>	struct rxe_mmap_info *ip = container_of(ref,
>					struct rxe_mmap_info, ref);
>	struct rxe_dev *rxe = to_rdev(ip->context->device);
>
>	spin_lock_bh(&rxe->pending_lock);
>    ...
>}
>
>If the module was unloaded in the interim, jumping to the VMA's close callback
>could also trigger an immediate kernel panic.

Fixed.

>
>[ ... ]
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260709095532.855647-1-jiri@resnulli.us?part=12
