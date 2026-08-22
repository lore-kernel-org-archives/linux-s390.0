Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275E1AB6F1
	for <linux-s390@vger.kernel.org>; Sat, 22 Aug 2026 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390249; cv=none; b=mz+ON3+Oqvb3WrKfcyCvQEw43u6jQ2NsNKwh1nWmOKgaYJOpgW9NOBtFOAZ1H3+RTfaz+cxLr49OHlxLJKGqPAoRtrpUa6nz9ItQJJMjaCoEYPXdMdAXb0EuLsVD0EmsTmXORRFPFsykhpVy6ZNSk/rSVZP9yMmF0zWmeMQZDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390249; c=relaxed/simple;
	bh=TChvcLlcPmD5XQ/lz+BqmBkXNsWRA9FGTLSokAVXKac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KzIZ5HIZ+oCDhvDL+CjKf0z4ZbIdytngmkHnwX3Mblz6JpE/FEzA2wfLVsgna4OcQu1Wfu3QNHCU+MmoDsYTD3JDDXHA5MqT1PUVyosEtnqwFaNZ5Ul34qlSOj33nYho0n8hP6WkQVbbgDJzCqgju9pqloANA2fqVkuTC/tb2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQyXjNDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQyXjNDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3101F000E9;
	Sat, 22 Aug 2026 09:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787390247;
	bh=TChvcLlcPmD5XQ/lz+BqmBkXNsWRA9FGTLSokAVXKac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQyXjNDR9HGQonD/gHr6SRPaAEDoBDofrYK8ksTE+EhtImT2le8pxMmSVyiAB8aQD
	 7DEzCTL9Z/tdgh2H5AbTWD9OtHRQ6AMYaB2u4BWUSiIPjHeyXBvk1dMlZlY6rhsMkz
	 aa4ysfd8BaRIEp7uWLNZsiQF/9kXoe9NYj+EkqxQLfzBnB2inYmKY8OzhK2SjPaPVT
	 nhEp41mg37fyfjIgbD1u0fpXU42ZToE2EINDVyNZhQEqOSvnzXaHdzmj9a7onvbA7x
	 yaDSBv1z2EBmgE5oVIYG4fwaQD6QmuAZS7vLUjEpAjKgcOEEQ09aABIoNnY4YxZn8o
	 8NUqSpILl3AqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/2] net/smc: reduce TX slot contention with
 exclusive wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260821091702.21458-3-alibuda@linux.alibaba.com>
References: <20260821091702.21458-1-alibuda@linux.alibaba.com>
 <20260821091702.21458-3-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:17:26 +0000
Message-Id: <20260822091727.4F3101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> smc_wr_tx_get_free_slot() waits for a free TX slot with
> wait_event_interruptible_timeout(). Since the wait_event family
> enqueues waiters as non-exclusive, wake_up() may wake multiple
> waiters even though only one can use the slot, causing
> thundering-herd contention when slots are scarce.
>=20
> Use an exclusive wait loop with prepare_to_wait_exclusive() so
> wake_up() wakes only one waiter per freed slot.
> smc_wr_wakeup_tx_wait() still uses wake_up_all() during link
> teardown, so teardown behavior is unchanged.
>=20
> This also corrects the return value on a pending signal: the previous
> wait_event_interruptible_timeout() path fell through to the "no free
> slot" case and returned -EPIPE, masking the signal as a connection
> error. The open-coded loop now returns -ERESTARTSYS, matching the
> [ ... ]
> So the change does not regress the uncontended case, and recovers most
> of the throughput lost to thundering-herd wakeups once slots become
> scarce.
>=20
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821091702.2145=
8-1-alibuda@linux.alibaba.com?part=3D2

