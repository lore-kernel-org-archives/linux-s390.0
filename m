Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E71537C8;
	Fri, 25 Oct 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900732; cv=none; b=iamO02CskZHljw+THSIogUb9tXn47h2IcssmDkCxMU1O+QiUNwGWMcqeSiHFNhtXcjFNLiMoogHliKgFemAdbSYqVF5DRoKsEGhYgQsNQ3T16bVKg1yh8aG24uBr6KA/4zoyzvW5B3VGDbrpklsg2MTLagOqS8hC8pn9tyWgf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900732; c=relaxed/simple;
	bh=TJA7CaWkwOT+Vx6n6pk7LQk4Ahrza9r536kiM47xLBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OybpqJqVuHLr/5sAH56hG+0N/tzRkDSZIUupNxjRxQ294yV/Oi1QSqigbndA6dY+5TR6UfrJdJ+d9EhxEEJ02SORceE0HFPngTsfDkjW5cfRDeJcJANnNM5nMn5AjyBSr2Xto466/GCaFGSH6Hchrr0J4fBT0AJCR4WCP6ARa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CPP2fJCB; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CPP2fJCB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729900721; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=qIXA6xds0tAHTYAKOJGCDVvDv46NuYZSlAdVmvtJsSg=;
	b=CPP2fJCBzoYG+kEzpdvJX/Ew4k8pNsMkyxYyJpOUz7DHFwaoBYJ51/h0Az7rv3EY/MQBymjhylL3RNkUY2r4JR3qx4fRxvKh7zURpqpVJQ7pqDGDxedy1663jtUBOYhTx63MAunEK7a99SrQmCTg2j3MmeQgXggZGXffULNsFs0=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WHtY9Br_1729900720 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 07:58:40 +0800
Date: Sat, 26 Oct 2024 07:58:39 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: increase SMC_WR_BUF_CNT
Message-ID: <20241025235839.GD36583@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241025074619.59864-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025074619.59864-1-wenjia@linux.ibm.com>

On 2024-10-25 09:46:19, Wenjia Zhang wrote:
>From: Halil Pasic <pasic@linux.ibm.com>
>
>The current value of SMC_WR_BUF_CNT is 16 which leads to heavy
>contention on the wr_tx_wait workqueue of the SMC-R linkgroup and its
>spinlock when many connections are  competing for the buffer. Currently
>up to 256 connections per linkgroup are supported.
>
>To make things worse when finally a buffer becomes available and
>smc_wr_tx_put_slot() signals the linkgroup's wr_tx_wait wq, because
>WQ_FLAG_EXCLUSIVE is not used all the waiters get woken up, most of the
>time a single one can proceed, and the rest is contending on the
>spinlock of the wq to go to sleep again.
>
>For some reason include/linux/wait.h does not offer a top level wrapper
>macro for wait_event with interruptible, exclusive and timeout. I did
>not spend too many cycles on thinking if that is even a combination that
>makes sense (on the quick I don't see why not) and conversely I
>refrained from making an attempt to accomplish the interruptible,
>exclusive and timeout combo by using the abstraction-wise lower
>level __wait_event interface.
>
>To alleviate the tx performance bottleneck and the CPU overhead due to
>the spinlock contention, let us increase SMC_WR_BUF_CNT to 256.

Hi,

Have you tested other values, such as 64? In our internal version, we
have used 64 for some time.

Increasing this to 256 will require a 36K continuous physical memory
allocation in smc_wr_alloc_link_mem(). Based on my experience, this may
fail on servers that have been running for a long time and have
fragmented memory.

    link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, SMC_WR_BUF_SIZE,
                               GFP_KERNEL);

As we can see, the link->wr_rx_bufs will increase from 16*3*48 = 2,304
to 256*3*48=36,864 (1 page to 9 pages).

Best regards,
Dust

>
>Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>Reported-by: Nils Hoppmann <niho@linux.ibm.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
>---
> net/smc/smc_wr.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
>index f3008dda222a..81e772e241f3 100644
>--- a/net/smc/smc_wr.h
>+++ b/net/smc/smc_wr.h
>@@ -19,7 +19,7 @@
> #include "smc.h"
> #include "smc_core.h"
> 
>-#define SMC_WR_BUF_CNT 16	/* # of ctrl buffers per link */
>+#define SMC_WR_BUF_CNT 256	/* # of ctrl buffers per link */
> 
> #define SMC_WR_TX_WAIT_FREE_SLOT_TIME	(10 * HZ)
> 
>-- 
>2.43.0
>
