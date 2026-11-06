Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926446;
	b=q74LygQhatqD71IOF7yD1ViD1i276QzID8r4RgDunu+TmGvPLYsb+qiN1Q7mPK+/rfYo
	 1DH5nmv8jm1lPHv+1q0ennTLm04i4RmfqJKJ3VMXIvUkR8tWi8rscktekkuMMzLwCg561
	 MzQY4l0f93KzbWNmyALGXydzwBtmCjYVqA4Zb515FCz7L01dkbBR/1pUH11xc4wBIhwRm
	 nmT0uz7qGoTLEE4EWShrqXpd2HckBI6xI4312oN4VwUFvfV+6J7HqJ2JI+6T2fUMVlHQ3
	 3prUXwPUBg+pI9UQoQMnmbyyYHZKQGHtoZ3qQ7JDdKYfZNn7myIPZ02bz+/DGZwe5rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sFdRb1ZcezZvg9sinKms+DcyU8fQawoewDHaZdVLz+U=;
	b=wPIEvDQP4qQcz58G/H5zXbdlih5HqjW9lFkCJUPj5iTnN2f4mwlzcu9rUtHxxTg51XMK
	 c/HOR7JpXnsBPpfz7yqTG0HoxbguthTJQVBU7X24NgxqeK3ew896/6yKtThJplLZOKf05
	 muvjR00Uw4VHsMMOWw7lvMqv1YBz5jHD3EJ2RRxN3TcooxtmW8hpFZ4XL0EPMca7i/6Qk
	 dC7bJ/GVq3dWINPabtCTY3uavXUG+dzTFp50+lZu2kSnaZk7D4eQhQHJuKjm4RdXTalrW
	 oaMapjZfeqHJylEwEYXSEYTOS5BcV6ET0tqeFxzYe0HdLvFaLoG9K3ysm0x3Wn0zTsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcpFfZe8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26605606A326;
	Fri,  6 Nov 2026 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcpFfZe8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634351F0089F;
	Fri,  6 Nov 2026 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926445;
	bh=sFdRb1ZcezZvg9sinKms+DcyU8fQawoewDHaZdVLz+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OcpFfZe8BuS8KcP8XIbb0Ipdxh8erDi3AnixhqbmKQrLyxYquJ4bnfk/z3AcWN6ds
	 47DjlLoSyagQfhyt1NRu1Lv3tPmZAGna9GLLzExVX0ASVXIThbI9CbiHfnOm0TFbvi
	 Wzi7Dh8zLhv5pxmxm3E39wENk3aBujUemuzZpFe6hFhYE6amDNC0Jg1vVhK+J5WvyL
	 C5RVu1n7YoesWmQMYkcb7hktcG4Z6AxMcmWbv2ZY9zebPPN+ulOInIBSxEWuL7v2Mt
	 7ObTfCsZd0zTlXNquShKIo6Skkcs/Pllpmle9GMgJUqYdhgf8gP9bI0d6u9EejpX9x
	 HUbs6aV87ZLpw==
Message-ID: <sashiko-outbox-200458@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 03/11] NFSv4: Clear idmap keyring cache when the
 last client unloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, samba-technical@lists.samba.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Anna Schumaker" <anna@kernel.org>, "Bharath
 SM" <bharathsm@microsoft.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "David
 S. Miller" <davem@davemloft.net>, "Eric Biggers" <ebiggers@kernel.org>, "Eric
 Dumazet" <edumazet@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "James Bottomley" <James.Bottomley@HansenPartnership.com>, "James
 Morris" <jmorris@namei.org>, "Marc Dionne" <marc.dionne@auristor.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Namjae Jeon" <linkinjeon@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Paulo
 Alcantara" <pc@manguebit.org>, "Ronnie Sahlberg" <ronniesahlberg@gmail.com>, "Serge
 E. Hallyn" <serge@hallyn.com>, "Shyam Prasad N" <sprasad@microsoft.com>, "Simon
 Horman" <horms@kernel.org>, "Sumit Garg" <sumit.garg@kernel.org>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Tom Talpey" <tom@talpey.com>, "Trond
 Myklebust" <trondmy@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>
In-Reply-To: <20261105005311.804098-4-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NFSv4: nfs_idmap_delete() flushes !WQ_MEM_RECLAIM work from reclai=
m context
--

commit 4e575974579117eaf53b52bd9cc0b5c049e02d3d
Author: Jarkko Sakkinen <jarkko@kernel.org>

NFSv4: Clear idmap keyring cache when the last client unloads

This commit tracks active NFSv4 idmap instances and clears the
id_resolver_cache thread keyring (followed by flushing key garbage
collection) when the last NFS client is destroyed.

> diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
> index bc397110d977f..c88444cc6bf68 100644
> --- a/fs/nfs/nfs4idmap.c
> +++ b/fs/nfs/nfs4idmap.c

[ ... ]

> @@ -483,6 +492,7 @@ void
>  nfs_idmap_delete(struct nfs_client *clp)
>  {
>  	struct idmap *idmap =3D clp->cl_idmap;
> +	int ret;
> =20
>  	if (!idmap)
>  		return;
> @@ -493,6 +503,17 @@ nfs_idmap_delete(struct nfs_client *clp)
>  	rpc_destroy_pipe_data(idmap->idmap_pipe);
>  	put_user_ns(idmap->user_ns);
>  	kfree(idmap);
> +
> +	mutex_lock(&nfs_idmap_cache_mutex);
> +	if (--nfs_idmap_users =3D=3D 0) {
> +		ret =3D keyring_clear(id_resolver_cache->thread_keyring);
> +		if (ret)
> +			pr_warn_ratelimited("NFS: Failed to clear idmap cache: %d; cache pins=
 remain\n",
> +					    ret);
> +		else
> +			key_gc_flush();
> +	}
> +	mutex_unlock(&nfs_idmap_cache_mutex);
>  }

[Severity: High]
Can calling key_gc_flush() from nfs_idmap_delete() trigger a workqueue
check_flush_dependency() warning and risk a memory-reclaim deadlock?

In security/keys/gc.c, key_gc_flush() flushes key_gc_work, which is queued
via schedule_work() onto system_percpu_wq (a workqueue without
WQ_MEM_RECLAIM):

security/keys/gc.c:key_gc_flush() {
	do {
		rcu_barrier();
	} while (flush_work(&key_gc_work));
}

However, the final reference on clp->cl_count can be dropped from
workqueues allocated with WQ_MEM_RECLAIM or from tasks running with
PF_MEMALLOC set:

  nfs41_free_stateid_release() / nfs41_sequence_release() [on rpciod_workqu=
eue, WQ_MEM_RECLAIM, and potentially PF_MEMALLOC via __rpc_execute()]
  or nfs_local_probe_async_work() / pnfs_generic_rw_release() [on nfsiod_wo=
rkqueue, WQ_MEM_RECLAIM]
    -> nfs_put_client()
      -> nfs4_free_client()
        -> nfs4_shutdown_client()
          -> nfs_idmap_delete()
            -> key_gc_flush()
              -> flush_work(&key_gc_work)

When the last NFSv4 client is freed through one of these asynchronous paths
after id_resolver_cache->thread_keyring has been populated, flushing
key_gc_work on system_percpu_wq from a WQ_MEM_RECLAIM worker or PF_MEMALLOC
context will trip the WARN_ONCE() in kernel/workqueue.c:
check_flush_dependency() and could deadlock under memory pressure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D3
