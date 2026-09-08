Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A7549373;
	Tue,  8 Sep 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871539; cv=none; b=F3vUJR5kfv/ZDxC1bHUgJ+8OypbTPUNPLtBmcSq7O5HYoPDIZK5fEFNcQd+w8jBuTGiIaZrltLah7Hab8cX4npmo4szPALcPSkt+TMkmfRmkryWBpLTfsr/Tkpv0eRWiVzU+EDEQU1qBEJaJPG5J7UHMvJ7GuW/38x/Rg5St3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871539; c=relaxed/simple;
	bh=I3O++xlc5GpM4IzIPuCmTJk4ggbk0/QpLeatNwsahFI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d9bAxmVIvDFAzpHK+bAgnd3XaF0nMUbPncUzu9L85QaYZrP8pkhlno7UDO5TlrzoSPNVAe29sHxHbKSgu3W69ymjZgrTM2snA2qn9/O/Zhu362Hcmg5E3WYoaWsxfpfWr0aawPwTdayZWvGe9b+BJtemPFkWVo2fhPNPFG/Vn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D285E1F00A3D;
	Tue,  8 Sep 2026 12:45:36 +0000 (UTC)
Subject: Re: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in
 dibs_lo_move_data()
From: netdev-bot+sashiko@kernel.org
To: wintera@linux.ibm.com
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, mjambigi@linux.ibm.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org
Date: Tue, 08 Sep 2026 12:45:35 +0000
Message-ID: <178887153533.219967.1817289806507440884@kernel.org>
In-Reply-To: <20260904094446.1342654-1-wintera@linux.ibm.com>
References: <20260904094446.1342654-1-wintera@linux.ibm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The patch fixes an observable lockdep "inconsistent lock
  state" splat produced by the plain spin_lock(&dibs->lock) in…

--

Here is the report.

dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()

This converts the plain spin_lock()/spin_unlock() around the
dibs->subs[]->ops->handle_irq() call in dibs_lo_move_data() to
spin_lock_irqsave()/spin_unlock_irqrestore(), because the same lock is
also taken from hardirq context in ism_handle_irq().  The commit message
notes this is not a real deadlock since dibs_lo devices have no interrupt
context.

> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
> index 649e4e375be33..44a2e74c2efcb 100644
> --- a/drivers/dibs/dibs_loopback.c
> +++ b/drivers/dibs/dibs_loopback.c

[ ... ]

> @@ -267,12 +268,12 @@ static int dibs_lo_move_data(struct dibs_dev *dibs, u64 dmb_tok,
>  	if (!sf)
>  		return 0;
>  
> -	spin_lock(&dibs->lock);
> +	spin_lock_irqsave(&dibs->lock, flags);
>  	client_id = dibs->dmb_clientid_arr[sba_idx];
>  	s_mask = ror16(0x1000, idx);
>  	if (likely(client_id != NO_DIBS_CLIENT && dibs->subs[client_id]))
>  		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
> -	spin_unlock(&dibs->lock);
> +	spin_unlock_irqrestore(&dibs->lock, flags);

[Severity: Medium]
Should this carry a Fixes: tag?  The lockdep splat quoted in the commit
message is reproducible on shipped kernels, and git blame attributes the
converted spin_lock()/spin_unlock() pair in dibs_lo_move_data() to:

cc21191b584c6f ("dibs: Move data path to dibs layer")

The hardirq-side acquisition of the same lock is in ism_handle_irq()
(drivers/s390/net/ism_drv.c):

	spin_lock(&dibs->lock);

which matches the {IN-HARDIRQ-W} registration in the report, so the
warning can be hit by ordinary SMC traffic through
smc_close_active()->smcd_cdc_msg_send()->smcd_tx_ism_write()->dibs_lo_move_data()
on a lockdep-enabled kernel.

The splat also ends with "INFO: lockdep is turned off", so further lock
checking is lost for the rest of that boot on affected kernels.

Would adding the following help backporters and stable tooling identify
which trees need this change?

Fixes: cc21191b584c6f ("dibs: Move data path to dibs layer")

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904094446.1342654-1-wintera%40linux.ibm.com
