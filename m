Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D167449ED7
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200487; cv=none; b=HXa2yQph+q/qP3x5uz4zRLVZXHoJUQ7mGMz9gJsytlChUdm6CL3jyzjWB2mbd3+ono71VShtVvau9TkvQyKA6GfaL6ibVIEFPPDYpjMz3E0Q+SeLeNQkSbO2tdpwgQ+HxAwbT5zPsjlEaTF1u1uAQ7COtSACI4jWh6JRPrwVyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200487; c=relaxed/simple;
	bh=N5Ur6dRd32LC3EMJP4HfLjuzG7yJggZEm9t6a1aoGEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GxDNMR3ngtTtgLVVZNLw/pwU+UHwbJiVJ3+Hv9GMxENLfI/YlnxLuRMpj89kYK/34rq+8GWoN1OecgkQywLp0ZlrGXHF7QYs9d6jPoH3X4ew6fDmlOHJAs75PidkSY851suKG91W9CiRobP7u6f7hvTtsm9mJFC8Nqc9rdWnCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcEoYyYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcEoYyYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4C61F00893;
	Thu, 11 Jun 2026 17:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200484;
	bh=P22XsXab1lthFpwnmzxwZQY4MwgkWlHyG2ZlJ5uX+Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcEoYyYmdZy+/eSq2pNiPpTPyEsSjpIggU7/E7C5pIJmchSZid5lAD4S0o6UQ1zFZ
	 0L47Vd5C/aamMnBFj2SDAy5fCTaQE8D5NpSa7dEmd8sKGKmKY4vCrcMHyKdGz8n/oE
	 hKTYyokK4CUoTwhKxogWovJYfCR7HVXcvghgKUxSiacuRIl6WMQqepoxk7X+GC3hkx
	 yKCHTlD0ExxcGcKLc8A3UXdpsIlPJjZW/Ejui6tURwxWtSNRfjnIaJAhG5A89Sbi6s
	 lzLg0E7R2FQjOUKdfraOScosXbHI21rtNg/4RC8Fo0dPCyTZRQBjw2evkNlcWw1jzf
	 SSTyDW5Y3zRGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] net: smc: fix splice entry lifetime imbalance
 in smc_rx_splice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <n05ec@lzu.edu.cn>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <192d1b44ed358ca143f44ef167d14153bccc51e9.1781097957.git.d4n.for.sec@gmail.com>
References: <192d1b44ed358ca143f44ef167d14153bccc51e9.1781097957.git.d4n.for.sec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:54:43 +0000
Message-Id: <20260611175444.7D4C61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent data loss and socket state desynchronization on partial spl=
ice due to ignored short return value.
- [High] Legitimate negative error codes from smc_rx_splice() are incorrect=
ly masked as -EFAULT.
--

commit 2f35c4cc130c3fdbc834b04e4b425109926602ac
Author: Daming Li <d4n.for.sec@gmail.com>

net: smc: fix splice entry lifetime imbalance in smc_rx_splice

This commit fixes a splice entry lifetime imbalance in smc_rx_splice() by
taking page and socket references for every candidate splice entry before
calling splice_to_pipe(). Unqueued entries are properly released via
smc_rx_spd_release().

> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
> index c1d9b923938da..88aee0d935977 100644
> --- a/net/smc/smc_rx.c
> +++ b/net/smc/smc_rx.c
[ ... ]
> @@ -217,16 +226,8 @@ static int smc_rx_splice(struct pipe_inode_info *pip=
e, char *src, size_t len,
>  	spd.spd_release =3D smc_rx_spd_release;
> =20
>  	bytes =3D splice_to_pipe(pipe, &spd);

[Severity: High]
This isn't a bug introduced by this patch, but this preexisting issue seems
to cause silent data loss on partial splices.

When smc_rx_splice() queues data into a pipe, it returns the actual number =
of
bytes successfully spliced. If the pipe nears capacity, this can be a short
count (0 < rc < chunk_len).

However, looking at its caller smc_rx_recvmsg():

net/smc/smc_rx.c:smc_rx_recvmsg() {
...
                } else {
                    rc =3D smc_rx_splice(pipe, rcvbuf_base +
                            chunk_off, chunk_len,
                            smc);
                }
...
            read_remaining -=3D chunk_len;
            read_done +=3D chunk_len;
...
            atomic_sub(copylen, &conn->bytes_to_rcv);
...
}

Does this code completely ignore the actual bytes spliced (rc) and
unconditionally assume the full chunk_len was processed?

Since it subtracts the full copylen from conn->bytes_to_rcv, wouldn't this
permanently desynchronize the socket's internal receive buffer accounting
and cause silent data loss?

[Severity: High]
This is a pre-existing issue, but legitimate negative error codes from
smc_rx_splice() seem to be incorrectly masked as -EFAULT.

If smc_rx_splice() returns a negative system error like -EAGAIN or -ENOMEM,
the caller smc_rx_recvmsg() intercepts it:

net/smc/smc_rx.c:smc_rx_recvmsg() {
...
                } else {
                    rc =3D smc_rx_splice(pipe, rcvbuf_base +
                            chunk_off, chunk_len,
                            smc);
                }
                if (rc < 0) {
                    if (!read_done)
                        read_done =3D -EFAULT;
                    goto out;
                }
...
}

By overriding retryable conditions with a fatal memory error, wouldn't this
cause userspace applications relying on splice() and non-blocking sockets
to unexpectedly abort connections?

> -	if (bytes > 0) {
> -		sock_hold(&smc->sk);
> -		if (!lgr->is_smcd && smc->conn.rmb_desc->is_vm) {
> -			for (i =3D 0; i < PAGE_ALIGN(bytes + offset) / PAGE_SIZE; i++)
> -				get_page(pages[i]);
> -		} else {
> -			get_page(smc->conn.rmb_desc->pages);
> -		}
> +	if (bytes > 0)
>  		atomic_add(bytes, &smc->conn.splice_pending);
> -	}
>  	kfree(priv);
>  	kfree(partial);
>  	kfree(pages);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/192d1b44ed358ca143f=
44ef167d14153bccc51e9.1781097957.git.d4n.for.sec@gmail.com?part=3D1
