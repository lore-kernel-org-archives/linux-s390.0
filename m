Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098542;
	b=L1pjp3YMoH3CC2ZHPv/FwdRU4KBN+JOcVO2yx4F7leFrI91n8qlzRK+f30LM2d5n40QU
	 ESn/AM3GW/sAljL4NUwIbDf+RVRNHtF/28c9//q01zJ1DXunrqR8Ws2HD4CLhK6guAxbN
	 dfFs5zyv4ggB5tRKuLtFiCRUbNjtqhfkZMgHJDXktKX7QXwSololtl1rzrRLlSgoERomP
	 GZRWfYTXyptpR5g4Sg+s2Jxl3t9MQ/OGGYevikqWr9u7FJwtffsakMIqKAJRSNVEBEuqM
	 kWtu79W/CrcVmmjkmvljt0Zv5ArD6O8v1sxxuYpvT9Hj9zZrz3N7VC3wKYmQtI1gi+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098542;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8BocTCGZMUpsE9lRakW/9wpa2Yt35PhpoqGWBBo8M9c=;
	b=dnfV+Q8pqIv+OQKGogJQVFjG2Hu3ij4UswCA4+t4ubrQfmQeVOYc9Js6PK/JwbZIz/A4
	 +suGHxXNFWHPpAl3mcs/WsXH1ipfU3KnDcV06DE508QoGQpzMiRz1jm17m07ggWyM1tqT
	 vo7HzUkUOvQjVMNcvBi+HfxgEHDvYh/EP6b8r9nxzGQ0mh+Xf+7mLXnvuGf30HoVoUj85
	 UnTPOHw4BGqvgHITGgoGX08ubPT46SSuPfaU7VIiYdXgLeUMrXpYyUTw6fB0GaxlooPk1
	 zYHKb5FNd/LFMz2tmhPQSUaFqxjuOZ2bTX1pnUXjToDxYaLBoE3sRn215yJAMOQEkCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajTOEjCv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F88606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajTOEjCv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C371F01200;
	Tue, 27 Oct 2026 10:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098541;
	bh=8BocTCGZMUpsE9lRakW/9wpa2Yt35PhpoqGWBBo8M9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ajTOEjCvUOoxJSReWF7o6uy7jQ9yCDWnZ3P5OEpeP5PJc2c8n2x9REI7/KapHPssN
	 HeoS5Q12E8SQuk60FkSE+f5WYLmGvfEZEzgBvmKG+/I/ePumSwBvIXQ0+K+GZu7rNe
	 8MpAJ5gntGjkgAIY4qkPzd90dGzulEm5beaWE8CECJvap3NVLIYnZ9GARnz5yndsZc
	 mfmh5WcLJp6H7cL4L1ovv2dYUtig+RLrs3OD+Zk5moTlRgltRPo8ggLNLOu7gn4wO/
	 Z6Zz4xSdQLy1q4ZuTzDKtk+4bklSLZ+1rc30Rngbn28+QY2iX8ozKhAtziZqXEyJ2Z
	 FAHzapwaYTTQA==
Message-ID: <sashiko-outbox-186407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] s390/diag204: Introduce diag204 rework
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027-diag204ioctl-v4-1-d5e90b56112b@linux.ibm.com>
References: <20261027-diag204ioctl-v4-1-d5e90b56112b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 10:55:40 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] s390/diag204: unexpected signal interruption and -EBUSY in diag204=
_store()
- [Medium] s390/diag204: misplaced signal_pending() check in diag204_update=
_cache()
--

commit f09eadeabe189d5ced7bd69c8dae7f95a7f3195f
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag204: Introduce diag204 rework

This commit reworks diag204 support to rate-limit hypervisor calls to at
most once per second using a shared cache, delayed work for buffer cleanup,
and a common kernel interface. Existing in-kernel users in hypfs and sthyi
are updated to use the new interface.

> diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag=
204.c
> new file mode 100644
> index 0000000000000..a68961bb8998d
> --- /dev/null
> +++ b/arch/s390/kernel/diag/diag204.c
> @@ -0,0 +1,271 @@

[ ... ]

> +static int diag204_update_cache(int allow_busy, int allow_busy_wait)
> +{
> +	unsigned long subcode;
> +	void *buf;
> +	int rc;
> +
> +	buf =3D diag204_allocate_buffer();
> +	if (!buf)
> +		return -ENOMEM;
> +	subcode =3D g_cache.type | g_cache.subcode;
> +	if (g_cache.has_bif && allow_busy)
> +		subcode |=3D DIAG204_BIF_BIT;
> +	WRITE_ONCE(g_cache.updating, true);
> +	mutex_unlock(&diag204_mutex);
> +	do {
> +		rc =3D diag204(subcode, g_cache.pages, buf);
> +		if (!allow_busy_wait || rc !=3D -EBUSY)
> +			break;
> +		if (signal_pending(current)) {
> +			rc =3D -ERESTARTSYS;
> +			break;
> +		}
> +		schedule_timeout_interruptible(HZ);
> +	} while (1);

[Severity: Medium]
When diag204_update_cache() is called with allow_busy_wait set (for example,
via hypfs_diag_create_files() or dbfs_d204_create()) and diag204() returns
-EBUSY, a signal arriving while the task is sleeping in
schedule_timeout_interruptible(HZ) wakes the task early.

Because the loop immediately starts the next iteration and calls diag204()
before checking signal_pending(current) again, doesn't a signal during the
sleep trigger another expensive diag204() call immediately without waiting
for the 1-second interval, and potentially miss returning -ERESTARTSYS if t=
he
second diag204() call succeeds?

> +	mutex_lock(&diag204_mutex);
> +	if (rc >=3D 0) {
> +		diag204_replace_cache(buf);
> +		mod_delayed_work(system_dfl_wq, &diag204_work, DIAG204_WORK_DELAY);
> +	} else {
> +		diag204_free_buffer(buf);
> +	}
> +	WRITE_ONCE(g_cache.updating, false);
> +	return rc;
> +}

[ ... ]

> +int diag204_store(void *buf, int allow_busy, int allow_busy_wait)
> +{
> +	int rc;
> +
> +	if (!diag204_is_available())
> +		return -EOPNOTSUPP;
> +	if (!allow_busy && allow_busy_wait)
> +		return -EOPNOTSUPP;
> +	if (!buf)
> +		return -ENOMEM;
> +	rc =3D 0;
> +	while (1) {
> +		rc =3D mutex_lock_interruptible(&diag204_mutex);
> +		if (rc)
> +			return rc;
> +		/* Exit loop with lock taken if there is no concurrent update */
> +		if (!READ_ONCE(g_cache.updating))
> +			break;
> +		mutex_unlock(&diag204_mutex);
> +		if (allow_busy && !allow_busy_wait)
> +			return -EBUSY;
> +		/* Update in progress, wait until flag is cleared */
> +		rc =3D wait_event_interruptible(g_cache.wq, !READ_ONCE(g_cache.updatin=
g));
> +		if (rc)
> +			return rc;
> +	}

[Severity: High]
Can this loop in diag204_store() return unexpected -EINTR, -ERESTARTSYS, or
-EBUSY errors to callers that pass allow_busy_wait as 0?

Specifically, sthyi_fill() -> sthyi_update_cache() -> fill_dst() ->
diag204_get_data() calls diag204_store(diag204_buf, diag204_allow_busy, 0):

arch/s390/kernel/sthyi.c:diag204_get_data() {
	...
	rc =3D diag204_store(diag204_buf, diag204_allow_busy, 0);
	if (rc < 0) {
		diag204_free_buffer(diag204_buf);
		return ERR_PTR(rc);
	}
	...
}

Even though allow_busy_wait is 0, diag204_store() unconditionally uses
mutex_lock_interruptible() and wait_event_interruptible(), which return
-EINTR or -ERESTARTSYS if a signal or notify_signal is pending while
contending on diag204_mutex or waiting for g_cache.updating.

When sthyi_fill() is invoked from KVM's SIE intercept handler in
arch/s390/kvm/s390/intercept.c:handle_sthyi():

	cc =3D sthyi_fill(sctns, &rc);
	if (cc < 0)
		return cc;

and arch/s390/kvm/s390/s390.c:kvm_arch_vcpu_ioctl_run():

	rc =3D __vcpu_run(vcpu);

	if (signal_pending(current) && !rc) {
		kvm_run->exit_reason =3D KVM_EXIT_INTR;
		vcpu->stat.signal_exits++;
		rc =3D -EINTR;
	}

if a signal is pending on the vCPU thread during a concurrent diag204 cache
update, sthyi_fill() fails with -EINTR or -ERESTARTSYS after SIE has already
advanced the guest PSW past the STHYI instruction, leaving the guest buffer
and condition code unupdated and preventing kvm_arch_vcpu_ioctl_run() from
setting KVM_EXIT_INTR.

Also, when g_cache.updating is true and allow_busy && !allow_busy_wait hold=
s,
diag204_store() returns -EBUSY without checking g_cache.has_bif, whereas
diag204_update_cache() checks g_cache.has_bif && allow_busy. Should the
concurrent update check also gate -EBUSY on g_cache.has_bif, and use
uninterruptible locking and waiting when allow_busy_wait is 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-diag204ioc=
tl-v4-1-d5e90b56112b@linux.ibm.com?part=3D1
