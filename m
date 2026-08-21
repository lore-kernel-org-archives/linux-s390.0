Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7CC3B27E3
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298425; cv=none; b=aY5j7+mVV9xMusK8bc+T2HoC7J2Ht4DBSrUuHcuY20LAZ6Bvk9tHCpaSriL8iXwcIt5NtTTa2RDwnTm/EZICXWzHVy7zmn1nHxy8kBSNkTjieym9lR4In6LbZmXiTkoO3Y2xPbt/O3br5ok+yBilobOlkcyJdgRGjlRW/vtA42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298425; c=relaxed/simple;
	bh=sz+M7JpXG8XDUdhjkMrkGz2+NbwacH7xz1Hl/zfRPjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n8PbjSMa67SpC8hM4yzQcIlsteYnm0CkCAmA5EF6eZVNrytyvi+dgBxzCCMZ3hbIUaeOzyNJYQTXi6hA/gO0Tc/yFntoqexwkIgfXlVtgeDRnE0sN40s+FEDTI9pVWo/Roze14kniGDDBzhjh0AG5H75Et24JllyB/TujCfJvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE+TiOkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE+TiOkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FEB1F000E9;
	Fri, 21 Aug 2026 07:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787298422;
	bh=TiQY1capoove5IV39rCHEySWIXbqzwWQy0eWszS50q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WE+TiOkc+z52rVc3YwyGDlMl5YbcdWkp68lPYNxYaL6ukN3mIEvginB1pvgy+NLpz
	 8Lq/4AFVe6vqUAMDGKptAOANTuq6Op9sX+QRGhH1w+DiokbyAojlSoQGE21+W77LK6
	 SgZOywRK53KSBQ5jxEXF3TRyi/oa48SgmQOGboDwxi5SsT+08mCQ83U1Dc70sjrJgr
	 2+UZNHcOBmRkGpXYx/pZhLyVuCBIw8OIzR/ejpu+M8J4EYOdSI6FT8vJlN/+RMzfZp
	 ayVQLrm1wUbpw+j7lJSaiib7eicZGA791sUyGz7A1wZDvn99OqmTjzZaz3NrzJlFEo
	 tYHvj571TZDWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] net/smc: stop killed, freed and out_of_sync
 sharing a byte
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260820074642.966856-2-hidayath@linux.ibm.com>
References: <20260820074642.966856-1-hidayath@linux.ibm.com>
 <20260820074642.966856-2-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 07:47:01 +0000
Message-Id: <20260821074702.40FEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent Read-Modify-Write data race on `struct smc_link_group` =
bitfields (`sync_err`, `terminating`, `freeing`).
- [High] Read-modify-write (RMW) data race on `conn_state_flags` and `prod_=
flags` bitfields in `struct smc_connection`.
--

--- Patch [1]: [PATCH net v2 1/2] net/smc: stop killed, freed and out_of_sy=
nc sharing a byte ---
commit a4fa7f6a3c11e3e694e6c9235dfa2ed1bd680cdf
Author: Hidayath Khan <hidayath@linux.ibm.com>

net/smc: stop killed, freed and out_of_sync sharing a byte

The commit changes three connection state flags from single-bit bitfields to
separate u8 fields. This prevents read-modify-write data races between
process context and the receive tasklet.

> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 52145df83f6e7..427b6d63b9931 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -277,9 +277,9 @@ struct smc_connection {
>  						 * 0 for SMC-R, 32 for SMC-D
>  						 */
>  	u64			peer_token;	/* SMC-D token of peer */
> -	u8			killed : 1;	/* abnormal termination */
> -	u8			freed : 1;	/* normal termination */
> -	u8			out_of_sync : 1; /* out of sync with peer */
> +	u8			killed;		/* abnormal termination */
> +	u8			freed;		/* normal termination */
> +	u8			out_of_sync;	/* out of sync with peer */
>  };

[Severity: High]
This is a pre-existing issue, but does a similar RMW data race exist for the
conn_state_flags and prod_flags bitfields embedded in struct smc_connection?

These bitfields are defined in net/smc/smc.h:

struct smc_cdc_conn_state_flags {
#if defined(__BIG_ENDIAN_BITFIELD)
	u8	peer_done_writing : 1;
	u8	peer_conn_closed : 1;
	u8	peer_conn_abort : 1;

Process context modifies these fields holding only lock_sock(), which doesn=
't
disable softirqs. For instance, smc_close_wr() in net/smc/smc_close.c sets
peer_done_writing =3D 1:

    conn->local_tx_ctrl.conn_state_flags.peer_done_writing =3D 1;

And smc_tx_consumer_update() in net/smc/smc_tx.c sets write_blocked =3D 0:

    conn->local_rx_ctrl.prod_flags.write_blocked =3D 0;

Meanwhile, tasklet context modifies the same bytes. smc_cdc_msg_validate()
in net/smc/smc_cdc.c sets peer_conn_abort =3D 1 under send_lock:

    conn->local_tx_ctrl.conn_state_flags.peer_conn_abort =3D 1;

And smc_cdc_msg_to_host() writes the entire prod_flags byte.

Since lock_sock() does not serialize with bh_lock_sock() or send_lock, coul=
d a
softirq interrupt the process context's RMW operation, resulting in dropped
connection state changes or stalled connections when the stale byte is writ=
ten
back?

[Severity: High]
This is a pre-existing issue, but are there similar data races in
struct smc_link_group in net/smc/smc_core.h?

The sync_err, terminating, and freeing flags share a single byte:

struct smc_link_group {
    ...
    u8 sync_err : 1;
    u8 terminating : 1;
    u8 freeing : 1;
    ...
};

Could a read-modify-write data race occur here since they are modified from
different contexts without a common lock?

For example, smc_clc_wait_msg() in net/smc/smc_clc.c sets sync_err =3D 1
holding only the socket lock:

    smc->conn.lgr->sync_err =3D 1;

While __smc_lgr_terminate() in net/smc/smc_core.c sets terminating =3D 1
without holding any link group lock:

    lgr->terminating =3D 1;

And smc_lgr_terminate_sched() sets freeing =3D 1 under smc_lgr_list.lock:

    lgr->freeing =3D 1;

If an RMW operation is interrupted, could the terminating flag update be lo=
st,
potentially leading to __smc_lgr_terminate() executing twice concurrently a=
nd
causing a double-free of the link group?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820074642.9668=
56-1-hidayath@linux.ibm.com?part=3D1
