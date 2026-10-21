Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588213;
	b=vfIaNZLtX3TmQ953offGnFotCdOI5CkE1AzSpvZZp7v6wZXgltVL0GirdT70Iea0sbYh
	 CbYWQOhh1SGXmm9JfQWe9KjJBX/F/L8WTnBGKv4ay4W++LnPA62NTUXZh4iNtDhxvjmDJ
	 8WQSzwSNHalD8k+iVhKwo0l6wU5BZ5doZtt2TdiaeSMAEsIlrVQY0XhlGoUoIef/V+Woz
	 FPvtkBPvcyxdnB7/tugYzFYgyfpwoXnG6aVshGLxRuBfkXs3/k3x5I0dhovz2ONxVMwip
	 LBQPUZ+7H/1BiyE5169WfzZ5POeHDUTVSSQvRtvrP92dKQUT97i3wNNJGgAUoFFdgiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wAu9HBWi61HBml8gtb2PatsPeIBadW0JdLkMJX2ihqM=;
	b=jB9otuW6qII9yaHL2J6Ky/4zfFlu41R+8Xr00QbfLtRR4v93PzhLTpszTvWaXbY/QYHh
	 4Khec6xKykhm19YMBiiNQkOnjY+H1o6mmlqtzFrmCH9yvHTAfvWeggdBzjHr+P5Dg+g4I
	 5d7JefqgiLHiHQpZF13U61L9SnkGI819behykcm3hOBunD6pRGbOBgqHO8zWQx0JMLm9l
	 cJZTBrA1Lh2sJHCqsVd7ZmsAJCJGMyWX0WsHTMgZFQHY0EhJNKaHr50WoNMU0L+dyPQsl
	 9SfctcPCuKXcZgDHCuJfpw6E8KeRKr5A99kv5z/+gvfrUTw07Ol8alc1DxQnWtrYEVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XW18dDuN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E660A2603
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XW18dDuN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1742C1F000C9;
	Wed, 21 Oct 2026 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588212;
	bh=wAu9HBWi61HBml8gtb2PatsPeIBadW0JdLkMJX2ihqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XW18dDuNZ5qvIVXV/OX9AHHCuV95wZOXti0wj4mGSR9g9PTX2zlDu2z579d8kKivy
	 e9MjP59kR9xElmsn4LEjzCIx2vgq4gP1emILz6OG6+XuZrr6lBqS8fuaH/DKU5nkbE
	 8H27MtN9WLvHQpiiT5PseydlhPgogqGfKnKYSfKj9zC5VMS2Wprr0M0xbCyScxpBrs
	 xn5nGyoYQxQuUhVAuJXCSTiCLGc+UbYpYi2IbzcNFfEWjhnXoo8WdwwyBLo8TwSOcW
	 FOpPEfBxE6RkmR+FIOsGActxI5A9m1uFd8xZNZd4qu7FV7cgcblopDyA3Bukcvh2K4
	 RnouXUvVR/+pA==
Message-ID: <sashiko-outbox-180290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: rds_wq UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleg Nesterov" <oleg@redhat.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <atdoGiW_sHlWgOwt@redhat.com>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com> <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com> <atY42k00k0Waj6o4@redhat.com>
 <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
 <atdoGiW_sHlWgOwt@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:10:11 +0000
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
- [Critical] rds: ib: skipping flush_workqueue() in rds_ib_init() causes UA=
F on error
- [Critical] rds: rdma: rds_rdma_init() still accesses invalid rds_wq when =
rds_init() fails
--

commit 1ca141aafc7f21d383b77362aeece7748105d3b9
Author: Oleg Nesterov <oleg@redhat.com>

rds_wq UAF

This commit replaces rds_ib_unregister_client() with
ib_unregister_client(&rds_ib_client) on the rds_ib_init() error path to avo=
id
flushing a NULL or already-destroyed rds_wq.

> diff --git a/net/rds/ib.c b/net/rds/ib.c
> index 786f39169bc14..cde2d1bfabbd1 100644
> --- a/net/rds/ib.c
> +++ b/net/rds/ib.c
> @@ -619,7 +619,7 @@ int rds_ib_init(void)
>  out_sysctl:
>  	rds_ib_sysctl_exit();
>  out_ibreg:
> -	rds_ib_unregister_client();
> +	ib_unregister_client(&rds_ib_client);

[Severity: Critical]
Could skipping flush_workqueue(rds_wq) here cause a use-after-free of
rds_ib_mr_wq or the rds_rdma module?

In rds_ib_init(), ib_register_client(&rds_ib_client) synchronously calls
rds_ib_add_one() for every registered InfiniBand device.

If rds_ib_add_one() fails after allocating rds_ibdev (for example at
ib_alloc_pd() or rds_ib_create_mr_pool()), its put_dev path drops the
reference count to zero and queues rds_ib_dev_free() onto rds_wq:

net/rds/ib.c:rds_ib_dev_put()
	if (refcount_dec_and_test(&rds_ibdev->refcount))
		queue_work(rds_wq, &rds_ibdev->free_work);

Similarly, if rds_ib_add_one() succeeds for one or more devices and a later
step in rds_ib_init() fails (rds_ib_sysctl_init() or rds_ib_recv_init()),
ib_unregister_client(&rds_ib_client) calls rds_ib_remove_one() for each add=
ed
device, which also drops the final reference and queues rds_ibdev->free_work
(rds_ib_dev_free()) onto rds_wq.

Commit 24fa163a4bae74 added flush_workqueue(rds_wq) in
rds_ib_unregister_client() specifically to wait for rds_ib_dev_free() to
complete:

static void rds_ib_unregister_client(void)
{
	ib_unregister_client(&rds_ib_client);
	/* wait for rds_ib_dev_free() to complete */
	flush_workqueue(rds_wq);
}

Without that flush, rds_ib_init() proceeds directly to out_mr_exit and calls
rds_ib_mr_exit() -> destroy_workqueue(rds_ib_mr_wq) while rds_ib_dev_free()
is still pending or running on rds_wq and about to tear down
rds_ibdev->mr_8k_pool and rds_ibdev->mr_1m_pool (which flushes and cancels
delayed work on rds_ib_mr_wq).

In addition, when CONFIG_RDS_RDMA=3Dm, returning from rds_ib_init() causes =
the
module loader to unmap rds_rdma.ko while rds_ib_dev_free() is still queued =
or
executing on rds_wq.

[Severity: Critical]
Also, if rds_init() has failed and destroyed rds_wq (or has not run yet so
rds_wq is NULL), doesn't rds_rdma_init() still access the invalid rds_wq ev=
en
with this change?

1. During rds_ib_init(), if an IB device is present and either
   rds_ib_add_one() fails at put_dev or ib_unregister_client(&rds_ib_client)
   calls rds_ib_remove_one(), rds_ib_dev_put() will still call
   queue_work(rds_wq, &rds_ibdev->free_work) on the destroyed or NULL rds_w=
q.

2. In rds_rdma_init(), if rds_ib_init() succeeds and rds_rdma_listen_init()
   fails, rds_ib_exit() is called, which still calls
   rds_ib_unregister_client() -> flush_workqueue(rds_wq):

net/rds/rdma_transport.c:rds_rdma_init()
	ret =3D rds_ib_init();
	if (ret)
		goto out;

	ret =3D rds_rdma_listen_init();
	if (ret)
		rds_ib_exit();

3. If rds_rdma_init() (or rds_tcp_init()) succeeds after rds_init() has
   failed and torn down RDS core resources in rds_threads_exit(), the
   transport remains registered and active callbacks will queue work onto t=
he
   destroyed rds_wq.

>  out_mr_exit:
>  	rds_ib_mr_exit();
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/atdoGiW_sHlWgOwt@re=
dhat.com?part=3D1
