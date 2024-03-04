Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB056025E
	for <linux-s390@vger.kernel.org>; Mon,  4 Mar 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574105; cv=none; b=UaBwpCxZz4oQwMXk82GgcFj47G9FotRQzttTPfsrdDCfz4+p2fu4926PKP/zv8uvtTZxtlLWa43d4F3XGh/n5SghBu1JckyWnsGOjhzbzUQrZdCAeucHWc5igRohVKU3XSyxBvwR6ii+E+EPorWk78YH/jB7zhPTlKuqgddHZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574105; c=relaxed/simple;
	bh=qJMgPawedp3OfAEL1xk7KGXyHJTjGNsXEZPqedbFgnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqdwWrFkjJfRhnRyxaFCYAPYlzh01iBIETv+8SiunxAKayh9fb/B2Karj5O5x9vjJSta0AzEZ95UWgv+Xsg0H3QxOph+asGhDNefARyW7Vjogq0ry/JAwoRfbi33H7tz5nlEnvMypYEWZVyoR3uSWWnoEVzFKxs5RZg0/v2hbWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wy9gM7ly; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wy9gM7ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709574102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irOzKbJngmE8lAvg1EEurmlk1LMdtkA2xD+8hsC2ASY=;
	b=Wy9gM7lyipZUioOY+Y5r/TqEzLOMRTkZKaPEUfZHn5RtM0CuQJOfllSw4fcL4juTadgDh9
	nZOb/prXz2Grh/1qDXGfmHUS91h/jA6ef/ubb35r91oVegmzYBEHM4oXaVrIO7Z783ZqAp
	YzzqKHUdld35xPdfaeup/kof21fCQCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-dxNZ4nP2NaaFgBJchMmRPg-1; Mon, 04 Mar 2024 12:41:37 -0500
X-MC-Unique: dxNZ4nP2NaaFgBJchMmRPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBF80185A787;
	Mon,  4 Mar 2024 17:41:27 +0000 (UTC)
Received: from [10.22.34.161] (unknown [10.22.34.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7652648C;
	Mon,  4 Mar 2024 17:41:27 +0000 (UTC)
Message-ID: <76d4a653-3525-4359-bcdc-b5e80f63a426@redhat.com>
Date: Mon, 4 Mar 2024 12:41:27 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/spinlocks: Make __raw_* lock ops static
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <78c366485bff13753de758fd27fb6b465ed2850a.1709549641.git.geert+renesas@glider.be>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <78c366485bff13753de758fd27fb6b465ed2850a.1709549641.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


On 3/4/24 05:56, Geert Uytterhoeven wrote:
> If CONFIG_GENERIC_LOCKBREAK=y and CONFIG_DEBUG_LOCK_ALLOC=n
> (e.g. sh/sdk7786_defconfig):
>
>      kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
>      kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]
>
> All __raw_* lock ops are internal functions without external callers.
> Hence fix this by making them static.
>
> Note that if CONFIG_GENERIC_LOCKBREAK=y, no lock ops are inlined, as all
> of CONFIG_INLINE_*_LOCK* depend on !GENERIC_LOCKBREAK.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Waiman Long <longman@redhat.com>

Thanks for updating the change log.

Cheers,
Longman

> ---
> Compile-tested on all defconfigs that have CONFIG_GENERIC_LOCKBREAK=y:
>    - sh/sdk7786_defconfig,
>    - sh/shx3_defconfig,
>    - s390/debug_defconfig,
> and also on s390/debug_defconfig after changing:
>      CONFIG_DEBUG_LOCK_ALLOC=n
>      CONFIG_DEBUG_WW_MUTEX_SLOWPATH=n
>      CONFIG_LOCK_STAT=n
>      CONFIG_PROVE_LOCKING=n
>
> v2:
>    - Add Acked-by,
>    - Drop RFC,
>    - Improve patch description.
> ---
>   kernel/locking/spinlock.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
> index 8475a0794f8c5ad2..7009b568e6255d64 100644
> --- a/kernel/locking/spinlock.c
> +++ b/kernel/locking/spinlock.c
> @@ -65,7 +65,7 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
>    * towards that other CPU that it should break the lock ASAP.
>    */
>   #define BUILD_LOCK_OPS(op, locktype)					\
> -void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
> +static void __lockfunc __raw_##op##_lock(locktype##_t *lock)		\
>   {									\
>   	for (;;) {							\
>   		preempt_disable();					\
> @@ -77,7 +77,7 @@ void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
>   	}								\
>   }									\
>   									\
> -unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
> +static unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock) \
>   {									\
>   	unsigned long flags;						\
>   									\
> @@ -95,12 +95,12 @@ unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
>   	return flags;							\
>   }									\
>   									\
> -void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)		\
> +static void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)	\
>   {									\
>   	_raw_##op##_lock_irqsave(lock);					\
>   }									\
>   									\
> -void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
> +static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
>   {									\
>   	unsigned long flags;						\
>   									\

