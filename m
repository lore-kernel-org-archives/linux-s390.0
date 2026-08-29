Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DC21F09A5
	for <linux-s390@vger.kernel.org>; Sat, 29 Aug 2026 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787986520; cv=none; b=Ghz08j4tVODTJ5D7IonfEo4+BpUF2RH6cPHAyuDFsKM2faLjVraqOozbdVK+NObQntabZNgTI3pslzMKRKybrsoccOwnKtXPbR0kJgwlhM5j94daqV64E9dz0wpBc3MQZVg7HQJnlmBfgcc2+JgLbky3+7kyTSOBo3S8nw35A6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787986520; c=relaxed/simple;
	bh=WmJPNeOT4H2kjoifC//3XpNmLv2696//VcdnLdSfLzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GIYVP/3lrK7+E8Xj+ANMeuRLI4pzH6s1hnhk6bxlff3y6qzAjFXleNspUSWTP+SBHKf94GgQawddfyF0FrBD0wUfA2DtNT5zJOrZi+bN67vRXdehHXiRJ0ztIWsp60Rd0xlJ0gtX/28TC1J0eZOjSDblrkLis+p5PUIJhcVzyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrr3QZAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrr3QZAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785121F00A3D;
	Sat, 29 Aug 2026 06:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787986518;
	bh=VMB5fpzXwslnY8zoYvW3MQzLfuaiDMaQeNALeHg8IJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hrr3QZAqMKIPHDuBwh24LSTcYKWAuceuM8FJ4v/AD8Ot8sURVjGSdDhZnzWx4CG35
	 cp+gd2aMLHmoOLhOc53GJT1qzYvbIWhbInaB26iFxMch5XkjP18Ar342r/szB0Xy3d
	 G6LY0wusb1KAi8xKiTZnPrFIfZOiNUuOGWce7k7WoHF9X2avG5fd6ftYTsZLhHwRaI
	 A6+6SY8y1SyzCs7kAvEzlbRVVLQD4cx1B8qk5GE2YnKzfhAblyAkr51fHO8mmhJvjT
	 hDb3QXQtkTa5uMDxnzDYS+31Io8TO+WHW5lJmoRHIrNZmVM2zq6UeSwP/sChFuUnA3
	 SlT7ctiodSFeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] net/smc: add connection lifetime
 infrastructure for diag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260828065439.3582783-2-mjambigi@linux.ibm.com>
References: <20260828065439.3582783-1-mjambigi@linux.ibm.com>
 <20260828065439.3582783-2-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 06:55:18 +0000
Message-Id: <20260829065518.785121F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Setting `conn->lnk =3D NULL` and `conn->lgr =3D NULL` in `smc_=
conn_free()` introduces fatal NULL pointer dereferences in concurrent and d=
eferred readers.
- [Medium] `conn->lnk` is modified in `smc_cdc_msg_validate()` without hold=
ing the newly introduced `lgr_lnk_lock`, violating the stated synchronizati=
on invariants.
--

commit 340542b4422ee1313d9e6622b416469a93adf1be
Author: Mahanta Jambigi <mjambigi@linux.ibm.com>

net/smc: add connection lifetime infrastructure for diag

Add the basic lifetime synchronization needed by the diag dump path.
Introduce a per-connection lock that serializes connection-owned
conn->lgr/conn->lnk updates against readers. In smc_conn_free(), NULL out
conn->lgr and conn->lnk under lgr_lnk_lock before releasing references to
close the window where a concurrent diag reader could observe freed memory.

> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 427b6d63b9931..f5ed51d8eb939 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -232,6 +232,7 @@ struct smc_connection {
>  	atomic_t		sndbuf_space;	/* remaining space in sndbuf */
>  	u16			tx_cdc_seq;	/* sequence # for CDC send */
>  	u16			tx_cdc_seq_fin;	/* sequence # - tx completed */
> +	spinlock_t		lgr_lnk_lock;	/* protect conn owned lgr/lnk refs */

[Severity: Medium]
If this lock is required for all updates to conn->lnk as stated in the
commit message, should we also take it in
net/smc/smc_cdc.c:smc_cdc_msg_validate()?

net/smc/smc_cdc.c:smc_cdc_msg_validate() {
        ...
        conn->out_of_sync =3D 1;
        spin_lock_bh(&conn->send_lock);
        conn->local_tx_ctrl.conn_state_flags.peer_conn_abort =3D 1;
        conn->lnk =3D link;
        spin_unlock_bh(&conn->send_lock);
        ...
}

Without lgr_lnk_lock here, concurrent diag readers could observe an
inconsistent link state.

>  	spinlock_t		send_lock;	/* protect wr_sends */
>  	atomic_t		cdc_pend_tx_wr; /* number of pending tx CDC wqe
>  						 * - inc when post wqe,

[ ... ]

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 04aedd957543a..5af55abece577 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
[ ... ]
> @@ -1287,8 +1290,13 @@ void smc_conn_free(struct smc_connection *conn)
>  	if (!lgr->conns_num)
>  		smc_lgr_schedule_free_work(lgr);
>  lgr_put:
> +	spin_lock_bh(&conn->lgr_lnk_lock);
> +	lnk =3D conn->lnk;
> +	conn->lnk =3D NULL;
> +	conn->lgr =3D NULL;

[Severity: Critical]
Does setting these to NULL here introduce NULL pointer dereferences in
existing paths that don't take lgr_lnk_lock?

For example, in net/smc/smc_core.c:smc_conn_kill(), if smc_conn_free()
sets conn->lgr to NULL, and a concurrent smc_lgr_terminate_work() is
waiting for the socket lock:

smc_conn_free()
  conn->lgr =3D NULL;

smc_lgr_terminate_work()
  smc_conn_kill()
    if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)

Similarly, a deferred release callback in net/smc/smc_tx.c can race:

smc_release_cb()
  smc_tx_sndbuf_nonempty()
    if (conn->lgr->is_smcd)

Also, concurrent threads calling smc_switch_conns() in
net/smc/smc_core.c can race and dereference the newly NULL conn->lnk:

smc_switch_conns()
  smc_switch_link_and_count()
    atomic_dec(&conn->lnk->conn_cnt);

> +	spin_unlock_bh(&conn->lgr_lnk_lock);
>  	if (!lgr->is_smcd)
> -		smcr_link_put(conn->lnk); /* link_hold in smc_conn_create() */
> +		smcr_link_put(lnk); /* link_hold in smc_conn_create() */
>  	smc_lgr_put(lgr); /* lgr_hold in smc_conn_create() */
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828065439.3582=
783-1-mjambigi@linux.ibm.com?part=3D1
