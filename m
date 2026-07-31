Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288983A3821;
	Fri, 31 Jul 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482492; cv=none; b=WpD0qDhB7bfz8TctEJQnnRJz4Nmtft6NRGH0RI+nGy+Ylvv36uUkvA2SQhnHltMs3TcuZc79cRWxih+Ycd4kmhEnhlF1elG7qrHNiP52V6ejY6Fo34LtKxVD9q/sO7Gl4fS3g3YOGOYgYcgh+2W6EA/dUGF0pJzQlDF/62guchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482492; c=relaxed/simple;
	bh=3uXyMmsZRmUpjX2VUIwVcvqSkMBdhvzCzVdhtmfizxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK2vABbEslrIA20T80g/9m43ZZY7wCtngSBqwfpSD6DMGZb4Rciy8X935FHZlBFxjvhV803y6sRR7HgCUZY5eFdYYCNPodhTFtMgCZHlnqkYIw/z6U3Z27h45hwJuDo0LDTH5cfBFX2FlnoHOwOGmiddyNq/j2R5LoZXFk52jgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UazAU2un; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UazAU2un"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785482472; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=hoqgqKWejrNZ15I77YEKbjzFiJLhpSrL/rO8JGN3cdg=;
	b=UazAU2unKUBqBcDghY/WDUnKg/FwUT+KXJxQP6tXj0nmRb/mjpMZlRimQg/VnRgZvU0kd20QLgY0fumOLZ//teqOI9e5fRPBrAo9+IBr4TyZn2w7E1HXD9xo0XT5HTsO2NiBBFp46TNZkZoBYU5X4YcAu5O19BLi0OhMjbUPBGE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X87HIkl_1785482149;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X87HIkl_1785482149 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 15:15:49 +0800
Date: Fri, 31 Jul 2026 15:15:48 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	hidayath@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix qentry overwrite for CONFIRM_LINK and
 ADD_LINK_CONT in smc_llc_event_handler()
Message-ID: <amxLpKV3OBZ3rxus@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260729130153.970800-1-mjambigi@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729130153.970800-1-mjambigi@linux.ibm.com>

On 2026-07-29 15:01:53, Mahanta Jambigi wrote:
>The SMC_LLC_CONFIRM_LINK / SMC_LLC_ADD_LINK_CONT branch in
>smc_llc_event_handler() stores an incoming qentry into the local LLC flow
>without first checking whether a qentry is already pending. If a malicious or
>buggy peer sends a second CONFIRM_LINK or ADD_LINK_CONT request while a flow is
>active and flow->qentry is already set, smc_llc_flow_qentry_set() overwrites the
>pointer without freeing the previous allocation, leaking one kmalloc-96 object
>per spurious message.
>
>The sibling SMC_LLC_DELETE_LINK branch already has the correct !flow->qentry
>guard. Apply the same guard to the CONFIRM_LINK/ADD_LINK_CONT branch so that a
>duplicate message when qentry is already occupied falls through to break and is
>freed by the kfree(qentry) at the out: label, rather than silently leaking the
>existing allocation.
>
>The response direction (smc_llc_rx_response()) is unaffected: it already guards
>with flow->qentry at the equivalent site and drops duplicate responses
>correctly.
>
>Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
>Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>Reviewed-by: Hidayath Khan <hidayath@linux.ibm.com>
>Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>---
> net/smc/smc_llc.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
>index 954b2ff1815c..aa6d83af55ed 100644
>--- a/net/smc/smc_llc.c
>+++ b/net/smc/smc_llc.c
>@@ -1927,7 +1927,8 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
> 		return;
> 	case SMC_LLC_CONFIRM_LINK:
> 	case SMC_LLC_ADD_LINK_CONT:
>-		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE) {
>+		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE &&
>+		    !lgr->llc_flow_lcl.qentry) {


I read sashiko's review comments, and I think both of them make sense, but
they were pre-existing issues. So I think we can solve them in the future
patches.

https://sashiko.dev/#/patchset/20260729130153.970800-1-mjambigi@linux.ibm.com

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

