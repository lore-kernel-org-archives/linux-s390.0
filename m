Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A23FFAC3
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653696; cv=none; b=Z/OphQ26xUuFM/TeUbHMkA/IHXz6msgmlSOWFQcdNcnpR5/qj2JswOofYBfMypB8deDE4xVKAlJ29MUhc9VUikFesHcpa/8t52DKIKjkVzpOLmt7CPVDs3NFZdp0RZoB6dJUg7+a67PNOfShbTex3v6yWe5ZV+uh6DYfyM0xDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653696; c=relaxed/simple;
	bh=8X0Qzt6MGp46Z6CpR5N84E980+bM1rhJ/+1AR3iuCGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vy4MDA3gHBR7gYiL3FDfJ0PF4TBdUYlQyqi2RvNU3IoXZq74hMwQmFV+2KKiW/RYbvjCtNjWeByQPyotxDUmUi69rsFqVhALn10XF/DCiWwy22OO8xlMgy6x3x7ATBkPTNUTRKKKQ6+jKs7I3YI4fUIQMZ+CXkm1eG6EL35G00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTjT+5Ca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTjT+5Ca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3431F000E9;
	Tue, 21 Jul 2026 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653693;
	bh=Aj57Lzx1dGs9/eFUwmE6m3TDdAleMJzwd+1/UpdjoOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTjT+5Ca6QT9YPHu+BvtL8YlszzRz6qCnOnER9hHPImYgSU8Nmtmtpuh4/uXnXjkz
	 ZzJs6xXGatmyuLRtrrVeEFVBHMxCIsYJAZya87GeOswh+zrmlHIaDsjsNqw334zAE8
	 w//bztQYaZFhvGmdWi9fIYE4ZjL02RmukwKYLGbqCLAmyNkjx58Ns/pEyv8p+oifoD
	 6cSD4je2xhv6figQhteGMFKAYcdHdnxSjufSQT6DVcipnhAhLmYwAzjZTbmy7wknsD
	 YFmCO7vUYmmPa+N9d88wswaqFco9KtqkQwc84QN+Yu1UP5cZFcyN5zfgE6APppT9H8
	 u3sFcHZp2eFxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: validate peer CDC cursor against RMBE size
 before accepting it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260720170717.11425-1-security@auditcode.ai>
References: <20260720170717.11425-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:08:13 +0000
Message-Id: <20260721170813.7F3431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fails to prevent remote kernel memory disclosure bec=
ause an attacker can bypass the bounds check by exploiting a flaw in the `w=
rap` counter validation, which allows infinite inflation of `bytes_to_rcv`.
- [High] The patch explicitly excludes SMC-D from cursor bounds checking, l=
eaving it fully vulnerable to the original unbounded cursor out-of-bounds r=
ead and write attacks.
- [High] Incoming CDC messages processed during early connection establishm=
ent can trigger a NULL pointer dereference on `conn->rmb_desc->len`.
--

--- Patch [1]: [PATCH net] net/smc: validate peer CDC cursor against RMBE s=
ize before accepting it ---
commit 2f986d59395ef38131fb12b9fd2f5e861bf4a2d9
Author: Ibrahim Hashimov <security@auditcode.ai>

net/smc: validate peer CDC cursor against RMBE size before accepting it

This commit validates incoming CDC message cursors against the receiving
buffer size to prevent out-of-bounds reads/writes. It modifies
smc_cdc_cursor_to_host() and smcr_cdc_msg_to_host() to reject counts
exceeding the buffer length.

> SMC-D (smcd_cdc_msg_to_host()) does not use this helper and is
> a separate, out-of-scope gap.

[Severity: High]
This isn't a bug introduced by this patch, but does explicitly excluding
SMC-D leave it vulnerable to the same unbounded cursor out-of-bounds read
and write attacks?

If an untrusted SMC-D peer sends a CDC message with a massive cursor count
(e.g. 0x7FFFFFFF), smcd_cdc_msg_to_host() blindly copies it without bounds
checks. When smc_cdc_msg_recv_action() consumes it via smc_curs_diff(), it
massively inflates bytes_to_rcv.

Would it be safer to apply similar validation for SMC-D connections to
prevent arbitrary out-of-bounds reads in smc_rx_recvmsg()?

> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11f2303b..f07bbef47073a 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h

[ ... ]

> @@ -235,6 +236,14 @@ static inline void smc_cdc_cursor_to_host(union smc_=
host_cursor *local,
>  	if ((old.wrap > temp.wrap) && temp.wrap)
>  		return;

[Severity: Critical]
This is a pre-existing issue, but does this wrap check flaw allow a malicio=
us
peer to bypass the newly added bounds check entirely?

If a malicious SMC-R peer alternates sending CDC messages with wrap=3D1 and
wrap=3D0, the check above evaluates to false when temp.wrap is 0. This
improperly allows a backward wrap jump to be accepted.

Consequently, smc_curs_diff() will compute a massive positive difference
when the wraps differ, which is then unconditionally added to
conn->bytes_to_rcv in smc_cdc_msg_recv_action().

Could this inflation of bytes_to_rcv defeat the count bounds check and
still lead to remote out-of-bounds memory disclosure?

>  	if ((old.wrap =3D=3D temp.wrap) &&
>  	    (old.count > temp.count))
>  		return;
> +	/* count is an offset into the RMBE and must always stay inside
> +	 * it (see smc_curs_add()); the peer is untrusted, so reject an
> +	 * out-of-range wire cursor the same way an out-of-order one is
> +	 * already rejected above, instead of letting it drive
> +	 * bytes_to_rcv / the urgent-byte offset past the buffer end
> +	 */
> +	if (temp.count >=3D size)
> +		return;
>  	smc_curs_copy(local, &temp, conn);
>  }

[ ... ]

> @@ -246,8 +255,10 @@ static inline void smcr_cdc_msg_to_host(struct smc_h=
ost_cdc_msg *local,
>  	local->len =3D peer->len;
>  	local->seqno =3D ntohs(peer->seqno);
>  	local->token =3D ntohl(peer->token);
> -	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
> -	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
> +	smc_cdc_cursor_to_host(&local->prod, &peer->prod,
> +			       conn->rmb_desc->len, conn);

[Severity: High]
This isn't a bug introduced by this patch, but does directly dereferencing
conn->rmb_desc here expose a NULL pointer dereference during early connecti=
on
establishment?

In smc_conn_create(), a connection is made globally discoverable by adding
it to lgr->conns_all before the underlying buffers (like conn->rmb_desc)
are allocated:

smc_core.c:smc_conn_create() {
    ...
    write_lock_bh(&lgr->conns_lock);
    rc =3D smc_lgr_register_conn(conn, true);
    write_unlock_bh(&lgr->conns_lock);
    ...
}

If an attacker predicts the sequential atomic token and sends a CDC message
during this race window, smc_cdc_rx_handler() finds the connection and
proceeds to message processing.

Would this result in a kernel panic when smcr_cdc_msg_to_host() evaluates
conn->rmb_desc->len before the buffer is initialized?

> +	smc_cdc_cursor_to_host(&local->cons, &peer->cons,
> +			       conn->peer_rmbe_size, conn);
>  	local->prod_flags =3D peer->prod_flags;
>  	local->conn_state_flags =3D peer->conn_state_flags;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720170717.1142=
5-1-security@auditcode.ai?part=3D1
