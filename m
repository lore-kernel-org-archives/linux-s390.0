Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B6200110
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204857; cv=none; b=kN0q6QKaCQW45VTfmBjohNeEosTcYPFbTPWX/D+gk65kVY+0Cq920f2Cy0BgM0FUX1QOtkGyi0R5Jhe3gRHqj9A+O3E+yjG+fnLZsAL1CALtDVbU9Z4VRIAcMgHjkS6RveZj23xIatTokn+Kq+x3fY+eJ9TfCdICX/CVg/znXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204857; c=relaxed/simple;
	bh=0At0OU1l7jSi1IOGV3dmOG3zrZZNMx10F0ymLA/OCN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dxpRE7O5Zk8gsFp6U4tr0tK8JHgASMjfLLx4YBJIBwBu+EULESP4u1a4PqssGRpGMPmU95+XDxnJg71/KnAUMfLDXD45gTBFvCbD4xFTkz/SlG/M5OeoI6ZnWhmg/S+9F6uW83haHhdJDHWdSn77YE8zE+iyR+sQz140ZVSZOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ7z9Asa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ7z9Asa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F7E1F000E9;
	Tue, 28 Jul 2026 02:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785204856;
	bh=1TXD0bE4VcZeYq76p99aJla7o1Y0K2tgoaaoU48JF4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZ7z9Asay704IFSeArmLzhvHtNJfEDpIMEmjg7cWzVbp7oJNOqioho4YkQxYq03yh
	 8hMA7QaFMLO+BcTPxfOAp8KHpDrFP1yy2VZg4oKK5CmkzuRg+tM/aawadT6vdz9ci/
	 BToBJVhd+CpIQeDdmJd+usHA7NIT5iI85i8edCmO6aI+VtJL9FWXCOpdly6dKhzbUd
	 6Xj410jqmkFt1P01XE5mAHxp7J1yRcRmyMzHWog8dBiihxceMWUqkcRFRgF0DTMQWQ
	 l+nBbWViLjoSu7UidUXxXDLUJItxXWWP1E9VCecQSZmYWVvaQomzOzsF03jQGfo6io
	 GkgJF054al00w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: drain the rx tasklet before detaching the
 ghost sndbuf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260726-b4-disp-a135b4e5-v1-1-705aaec79986@proton.me>
References: <20260726-b4-disp-a135b4e5-v1-1-705aaec79986@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 02:14:15 +0000
Message-Id: <20260728021415.B0F7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The receive tasklet can be scheduled after `smc_conn_free()` frees=
 `sndbuf_desc`, leading to a NULL pointer dereference crash.
- [High] Bitfield data race between softirq and process contexts causing si=
lent loss of connection state updates (`killed` or `freed`).
- [High] Using `tasklet_unlock_wait()` fails to unschedule pending tasklets=
, leading to a UAF when the socket is freed.
- [High] The patch fails to resolve the UAF in the `soft =3D=3D false` path=
 due to a missing memory barrier, leading to a Store-Load reordering race.
--

--- Patch [1]: [PATCH net] net/smc: drain the rx tasklet before detaching t=
he ghost sndbuf ---
commit 95efe812ae27436c2b5367e550974e031445da1a
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: drain the rx tasklet before detaching the ghost sndbuf

This commit addresses a use-after-free issue where the receive tasklet
dereferences a freed send buffer descriptor. It reorders the teardown
sequence in smc_conn_free() and smc_conn_kill() to drain the receive
tasklet before detaching the buffer.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index cf6b620fef05f..da64e7a6bd731 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1270,9 +1270,9 @@ void smc_conn_free(struct smc_connection *conn)
>  	if (lgr->is_smcd) {
>  		if (!list_empty(&lgr->list))
>  			smc_ism_unset_conn(conn);
> +		tasklet_kill(&conn->rx_tsklet);
>  		if (smc_ism_support_dmb_nocopy(lgr->smcd))
>  			smcd_buf_detach(conn);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a NULL
pointer dereference if a concurrent socket closure races with device teardo=
wn?

During device teardown, __smc_lgr_terminate() removes the link group from t=
he
list, so list_empty(&lgr->list) is true. This causes smc_conn_free() to skip
calling smc_ism_unset_conn(), leaving the connection registered in smcd->co=
nn.

Even though tasklet_kill() is called here, a subsequent ISM hardware IRQ wi=
ll
find the connection, check conn->killed (which may still be 0), and schedule
the tasklet again. The tasklet executes smc_cdc_msg_recv_action(), which th=
en
dereferences the NULL conn->sndbuf_desc.

> -		tasklet_kill(&conn->rx_tsklet);
>  	} else {
>  		smc_cdc_wait_pend_tx_wr(conn);
[ ... ]
> @@ -1525,12 +1525,12 @@ static void smc_conn_kill(struct smc_connection *=
conn, bool soft)
>  	smc_sk_wake_ups(smc);
>  	if (conn->lgr->is_smcd) {
>  		smc_ism_unset_conn(conn);
> -		if (smc_ism_support_dmb_nocopy(conn->lgr->smcd))
> -			smcd_buf_detach(conn);
>  		if (soft)
>  			tasklet_kill(&conn->rx_tsklet);
>  		else
>  			tasklet_unlock_wait(&conn->rx_tsklet);

[Severity: High]
This is a pre-existing issue, but does using tasklet_unlock_wait() here
properly unschedule pending tasklets?

When soft is false, smc_conn_kill() calls tasklet_unlock_wait(). This
spins if the tasklet is actively running, but it does not remove the tasklet
from the queue or clear the SCHED bit if it is scheduled but not yet runnin=
g.

Immediately after returning, __smc_lgr_terminate() drops the socket referen=
ce.
If the refcount drops to zero, the socket memory (including the embedded
tasklet_struct) is freed while still linked into the per-CPU tasklet list,
leading to a use-after-free or list corruption when the softirq thread
traverses the list.

[Severity: High]
This is also a pre-existing issue, but is there a missing memory barrier
preventing a Store-Load reordering race here?

Earlier in smc_conn_kill(), conn->killed is set to 1:

smc_core.c:smc_conn_kill() {
    ...
    conn->killed =3D 1;
    ...
    smc_ism_unset_conn(conn);
    if (soft)
        ...
    else
        tasklet_unlock_wait(&conn->rx_tsklet);
}

Without a full memory barrier (like smp_mb()), the CPU can reorder the load=
 of
the tasklet RUN bit in tasklet_unlock_wait() before the store to conn->kill=
ed
becomes visible.

CPU A might load RUN =3D=3D 0 and proceed to detach and free the buffer.
Concurrently, CPU B (softirq) executes test_and_set_bit(RUN) (a full barrie=
r)
and reads conn->killed. Due to the store buffer delay on CPU A, CPU B might
read killed =3D=3D 0 and proceed to access the freed buffer.

[Severity: High]
This isn't a bug introduced by this patch, but does the bitfield layout in
struct smc_connection cause silent data loss due to read-modify-write races?

The connection structure defines these overlapping bitfields in the same by=
te:

smc.h:struct smc_connection {
    ...
    u8 killed : 1;
    u8 freed : 1;
    u8 out_of_sync : 1;
    ...
}

smc_cdc_msg_validate() sets conn->out_of_sync =3D 1 in softirq context with=
out
holding the socket lock. Concurrently, smc_conn_kill() sets conn->killed =
=3D 1
or smc_conn_free() sets conn->freed =3D 1 from process context.

Since the compiler generates non-atomic read-modify-write operations on the
shared byte, a softirq interrupt can silently overwrite and discard the
process context's updates. If the freed bit update is lost, the connection =
can
be freed twice, corrupting refcounts. If the killed bit update is lost, the
tasklet will continue to process data on a tearing down connection.

> +		if (smc_ism_support_dmb_nocopy(conn->lgr->smcd))
> +			smcd_buf_detach(conn);
>  	} else {
>  		smc_cdc_wait_pend_tx_wr(conn);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726-b4-disp-a1=
35b4e5-v1-1-705aaec79986@proton.me?part=3D1
