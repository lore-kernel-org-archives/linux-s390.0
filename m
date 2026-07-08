Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2B3A718D
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494080; cv=none; b=LxiuffF/C9892VXXWbmazvqEhy2t5Vcntv8yeZyV3WcGkNPPfAbOKzRLWm+dJe0gg5t7xHtyiB2hipWNCEtNroQYcFEvpGlwmiyQyuqyO9UAfFhbl10j2/1vhG7TnSt3z50vN+KYrB5mqKRMRoyZCpUvsT89Y1C715gHuoKrl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494080; c=relaxed/simple;
	bh=SwjlTLK+s1S6gQKUeZHZfWKu/MNsc9Zp+JgjLNZFKao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bpbXWXB7EnJW9uASaBLRKLfv/Zw1uAjKKASjTuIncIiVbzyYF39Or4Oy2PBeiajOL1iBGaLiQEfXOV10SrRawp9jRx9U8fb7VDUjlY1T9bVtuKfEj28F3dnA1ELWvV03ZHUD1UWhI9ESnuWLrGL05Eapq2rPXnMXZWIH0mpVEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp+543sl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp+543sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBEC1F000E9;
	Wed,  8 Jul 2026 07:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783494064;
	bh=GlOTQXcGwGTa4FomG2Z8BU/YVbuYbTNCnSGfGBycb7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hp+543slQDp7aws0GPS2/9CVc9lwhv1AjfcLPYKxzADt6Qpz98usYDk2f64Id1T2c
	 yOgPXYbvLtzNQJMEhU6x0YoUOyZh9LLgmT3oii+zoXEcdHR78fEQgsM5+puYcciPvN
	 MqkGpDWrm5xTDni2pK4awTOZsClSNO7bUe8Bv5wAC26RDKPU+5Kes0SuKLnSWeYvkJ
	 cBFNvYsL2/XDWSyeCtyplukS+7C63BDdXmFtj+e6kt4+1X8OTKI2kNa1fg7giHjuSK
	 R/2BSjUKdFqlsu1g7Wawrl8vxJ0WDdD/dDrB23DIo50XDcNPHSPkEPjG4huu/W6Uye
	 hefMcyaRwsOmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/iucv: fix use-after-free of a severed iucv_path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me>
References: <20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:01:03 +0000
Message-Id: <20260708070104.2EBEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent Use-After-Free of `iucv_path` due to incorrect ordering=
 of queue cleanup and path freeing in `iucv_sever_path()`.
--

--- Patch [1]: [PATCH net] net/iucv: fix use-after-free of a severed iucv_p=
ath ---
commit 9139c973711b1b0860aa18a8e778aceb20d5b1dd
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: fix use-after-free of a severed iucv_path

This commit drops queued message notifications in iucv->message_q when an
IUCV path is severed. It acquires the message_q.lock and frees any remaining
notifications that reference the severed path to prevent use-after-free
during a later recvmsg().

Closes: https://sashiko.dev/#/patchset/20260705-b4-disp-fc79c0dc-v1-1-d2cdc=
b57afa9@proton.me?part=3D1

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fed240b453bd9..2869a103f7fa2 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -348,6 +349,19 @@ static void iucv_sever_path(struct sock *sk, int wit=
h_user_data)
>  		} else
>  			pr_iucv->path_sever(path, NULL);
>  		iucv_path_free(path);

[Severity: High]
This is a pre-existing issue, but does freeing the path before clearing
the queue leave a race window for a concurrent receive?

If a concurrent recvmsg() is running, it could acquire the message_q.lock
and pop a notification containing the freed path pointer before we acquire
the lock here to clear the queue:

CPU1 in iucv_sever_path():
    iucv_path_free(path);
    // preempted or delayed before acquiring message_q.lock
           =20
CPU2 in iucv_sock_recvmsg():
    // pops notification from message_q
    iucv_process_message_q()
        iucv_process_message(sk, skb, p->path, &p->msg);
            __iucv_message_receive()
                parm->db.ippathid =3D path->pathid; // use-after-free read
                       =20
Would it be safer to move iucv_path_free(path) after the spin_unlock_bh
block that drops the queued notifications?

> +
> +		/*
> +		 * Message notifications queued on message_q still reference
> +		 * the now freed path; drop them, otherwise a later recvmsg()
> +		 * would pass the freed iucv_path to message_receive() via
> +		 * iucv_process_message_q().
> +		 */
> +		spin_lock_bh(&iucv->message_q.lock);
> +		list_for_each_entry_safe(p, n, &iucv->message_q.list, list) {
> +			list_del(&p->list);
> +			kfree(p);
> +		}
> +		spin_unlock_bh(&iucv->message_q.lock);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-b4-disp-78=
3fedbb-v1-1-463b9dbda2ea@proton.me?part=3D1
