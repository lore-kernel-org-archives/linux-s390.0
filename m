Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926449;
	b=GJjede+kF13tiPmrooOqqakackqBWFjHT4i8HBlWji6mYoCKf+hXYLk2rKCAetBFQIg0
	 qm4T9RTrOXhTKiSFfXHX/Wgbt1gHdH42PE47dYa+pP4OZD3X8AisYLCzFrt1IPpZJcvwF
	 +Bh+w0BfiTvIEHutGVx289glK8GaRncNS8PyibxnHwzkGILKq7WFxrPfxMM5BXESSu9id
	 ieeP5GbRsmToAKl820MUbkfxYaQ7FwphPmv/IMZBYRN2jfPcVlY1p7soL07LVRJsRdKX/
	 g7EmJE6NRFPuK+YQKmBd+A4vSOJ4+J8CCgl+gx9O2SQhkasWLf0/S3Lo371jG+0dPLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HQzJstBiykpY0ho6ewJ+4qAysTeWsxWYib9TUDaSDZU=;
	b=bQMiqU/FE7OBZZMk034GP1mydQIaZEyx+CESdc4OU6ApLH9SYEJqYe3sUSQZOZeGBb2h
	 Elq6eCq561wmLMN4ZZl/g2zmVkG1DBgRAzhZl6ezFgPOQ7Kncdkk2LTkwp+FUJdqNVj4n
	 0OpdINqevV2v7iBXU1aVjnmv93BUG1+WHLnAsk+wt6XwRgkkB16t3DFvugz+85WcwhApx
	 3pPZfMn3hSvq4aEw71WIUYUbbKjSvMCyL4de0OU+YiHLN6nDux0nLuLptsL5ipj3MAsh9
	 ejja+jMucdAsoQP6eSnse3+TRPb9re1T9VORTSUFLwYQvLg8aUnPVygEXUh/uVwXzxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRFR2Qor;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224F606A32E;
	Fri,  6 Nov 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRFR2Qor
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1441F008A1;
	Fri,  6 Nov 2026 00:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926448;
	bh=HQzJstBiykpY0ho6ewJ+4qAysTeWsxWYib9TUDaSDZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRFR2QorpWlLyvPV+CjTOTwr0tb5alXl5tULdDsxx20tdMkkGqhOvulx55n37E5am
	 CIaXogJkXfw72iYTZjC1v1GqDSlZyN+lUTF8yPuxcogv7pJQ1Mah4I6qe11/3Ti6IN
	 KcHQDRjiXF31UxzwoBH5vPu/zFjsQBEoMUWJICfpOuxai+A06mC+Ia/ga7Rh0+EDy1
	 2X1e0FFnjtvDYqAK5Vr4iRVBP2KHRoSN1udYtgWimnoLQdP1AwgucEqhxXG2BMd+FD
	 LbT9HCYImkkWDQN0TiNp40NDwwofEHZrQXf1mv2Q7jj96g3saLyVyiCFBNfPZtcRXN
	 apcuKwbSZxrkw==
Message-ID: <sashiko-outbox-200459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 04/11] smb: client: Clear idmap/SPNEGO caches
 when the last session is unloaded
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
In-Reply-To: <20261105005311.804098-5-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:05 +0000
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
- [High] smb: client: WQ_MEM_RECLAIM flush dependency violation in sesInfoF=
ree()
- [Medium] smb: client: WARN_ON() on fallible keyring_clear() in cache clea=
r helpers
--

commit 359186c48dde297d60c971ef75e736ee0f7821b6
Author: Jarkko Sakkinen <jarkko@kernel.org>

smb: client: Clear idmap/SPNEGO caches when the last session is unloaded

This commit serializes SMB session count transitions with a mutex and clears
the cifs.idmap and cifs.spnego cache keyrings when the last SMB session is
freed so that cached keys do not keep the module pinned.

> diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
> index 44c4072756804..939e14e755e52 100644
> --- a/fs/smb/client/cifs_spnego.c
> +++ b/fs/smb/client/cifs_spnego.c
> @@ -190,6 +190,12 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
>  	return spnego_key;
>  }
> =20
> +void
> +cifs_spnego_clear_cache(void)
> +{
> +	WARN_ON(keyring_clear(spnego_cred->thread_keyring));
> +}
> +
>  int
>  init_cifs_spnego(void)
>  {
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index 346899da91eb2..126b976c2547f 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -539,6 +539,12 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_s=
id *psid,
>  	return 0;
>  }
> =20
> +void
> +cifs_idmap_clear_cache(void)
> +{
> +	WARN_ON(keyring_clear(root_cred->thread_keyring));
> +}

[Severity: Medium]
As reported by Sashiko on RFC v2 [1], can cifs_spnego_clear_cache() and
cifs_idmap_clear_cache() trigger a WARN_ON() splat (and crash on systems wi=
th
panic_on_warn enabled) when memory allocation fails during session teardown?

When sesInfoFree() frees the last session, it calls cifs_idmap_clear_cache()
and cifs_spnego_clear_cache(), which pass the return value of keyring_clear=
()
directly to WARN_ON().

In security/keys/keyring.c:keyring_clear():

	edit =3D assoc_array_clear(&keyring->keys, &keyring_assoc_array_ops);
	if (IS_ERR(edit)) {
		ret =3D PTR_ERR(edit);

And in lib/assoc_array.c:assoc_array_clear(), clearing a non-empty associat=
ive
array performs a GFP_KERNEL allocation:

	edit =3D kzalloc_obj(struct assoc_array_edit);
	if (!edit)
		return ERR_PTR(-ENOMEM);

If this allocation fails under memory pressure, memcg limits, or fault
injection while either keyring contains cached keys, keyring_clear() returns
-ENOMEM and triggers WARN_ON().

Notably, the companion NFSv4 patch in the same series checks the return val=
ue
of keyring_clear(), logs with pr_warn_ratelimited(), and skips key_gc_flush=
()
on failure. Should cifs_idmap_clear_cache() and cifs_spnego_clear_cache()
handle keyring_clear() errors the same way instead of using WARN_ON()?

[ ... ]

> diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> index ec28f102ea08a..11c0330be489b 100644
> --- a/fs/smb/client/misc.c
> +++ b/fs/smb/client/misc.c

[ ... ]

> @@ -115,6 +122,14 @@ sesInfoFree(struct cifs_ses *buf_to_free)
>  		kref_put(&iface->refcount, release_iface);
>  	spin_unlock(&buf_to_free->iface_lock);
>  	kfree_sensitive(buf_to_free);
> +
> +	mutex_lock(&cifs_session_mutex);
> +	if (atomic_dec_and_test(&sesInfoAllocCount)) {
> +		cifs_idmap_clear_cache();
> +		cifs_spnego_clear_cache();
> +		key_gc_flush();
> +	}
> +	mutex_unlock(&cifs_session_mutex);
>  }

[Severity: High]
As reported by Sashiko on RFC v2 [2], does calling key_gc_flush() from
sesInfoFree() cause a WQ_MEM_RECLAIM workqueue flush dependency violation w=
hen
the final session reference is dropped from a cifsiod_wq worker?

When keyring_clear() unlinks cached keys, it schedules assoc_array_rcu_clea=
nup
via call_rcu(). Inside security/keys/gc.c:key_gc_flush():

void key_gc_flush(void)
{
	do {
		rcu_barrier();
	} while (flush_work(&key_gc_work));
}

rcu_barrier() runs assoc_array_rcu_cleanup() -> keyring_free_object() ->
key_put(), which schedules key_gc_work on the default system workqueue (whi=
ch
does not have WQ_MEM_RECLAIM set), and key_gc_flush() then calls
flush_work(&key_gc_work).

In fs/smb/client/cifsfs.c:init_cifs(), cifsiod_wq is allocated with
WQ_MEM_RECLAIM:

	cifsiod_wq =3D alloc_workqueue("cifsiod",
				     WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
				     0);

Because cifs_kill_sb() does not flush cifsiod_wq before calling cifs_umount=
(),
background work items running on cifsiod_wq can outlive unmount and drop the
last reference to struct cifs_ses, including:

  mchan_mount_work_fn() -> mchan_mount_free() -> cifs_put_smb_ses()
  smb2_reconnect_server() -> cifs_put_tcon() / cifs_put_smb_ses()
  smb2_cancelled_close_fid() -> cifs_put_tcon()
  cifs_ses_oplock_break() -> cifs_put_smb_ses()

When any of those workers drops the final reference, __cifs_put_smb_ses() ->
sesInfoFree() -> key_gc_flush() -> flush_work(&key_gc_work) flushes a
!WQ_MEM_RECLAIM workqueue from a WQ_MEM_RECLAIM worker, triggering WARN_ONC=
E()
in kernel/workqueue.c:check_flush_dependency() and risking a memory-reclaim
deadlock.

[1] https://lore.kernel.org/r/20261103030226.2685251-6-jarkko@kernel.org
[2] https://lore.kernel.org/r/20261103030226.2685251-6-jarkko@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D4
