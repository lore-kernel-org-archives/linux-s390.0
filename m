Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6251DDF4;
	Tue, 22 Sep 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093227; cv=none; b=fZAmIrPfKtYulafnhk41bOlXnVZe6+WlnSNggozNYMUXC56wXZPrxhvJuvbRygmi/wshu9gUBCa4xsIzHJ+XPE+RRYlkHTJg2ytPhMYiZ+RqHWvf0bA/iypC01b32pBeVbMH9sZh+yFcdj/ETIw2224ht2R4XYt0rSh1opHLXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093227; c=relaxed/simple;
	bh=/NIDHB/qZvBR54apWJdVrYRyfo2N6e64oYVHCRQ7nDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHQYxAAIXJeNHzaTOpodMDq0q/OnUJI6MlE68I9CxGmxfUTfyhZbIvoEO9A4lIIs3bfWyQ2/UK+Jjd0RFCGLArJipULtuHU0/vxNhCd43Ld7gTH265/238jCtkS+NoqVMLQCEt80YwVj/whyo0FdXbBdgVqI/OWkMutawGsU1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QS0NAy8r; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QS0NAy8r"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790093213; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Lccu25ZMZmH8wBWm/9KHW0iBPuhOoZxVdNftCRxBmcM=;
	b=QS0NAy8rmcKHoeUX3Y5xfkwhkjA/FxVrD4TwPzof65ny1zun3b+ZVoEJtnodzU1cAfieeH8GgV8HX3LIS2Tw3FyQ/pv4nHiwIMec4w9RgV05EAg+SB7Ow8ON/8ez6jMvZcF9uuYXWx3OrLZhTzxj+F1rlUs081uOWCahTjoiBzw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XBUBSgm_1790093212;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0XBUBSgm_1790093212 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 00:06:52 +0800
Date: Wed, 23 Sep 2026 00:06:45 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Sidraya Jayagond <sidraya@linux.ibm.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alibuda@linux.alibaba.com, horms@kernel.org, mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	hidayath@linux.ibm.com, pasic@linux.ibm.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix UAF on lgr list traversal in
 smcr_port_err()
Message-ID: <arKnlYTap3hKFR5q@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260922073149.474762-1-sidraya@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922073149.474762-1-sidraya@linux.ibm.com>

On 2026-09-22 09:31:49, Sidraya Jayagond wrote:
>smcr_port_err() traverses smc_lgr_list.list without holding
>smc_lgr_list.lock, allowing a concurrent smc_lgr_terminate_sched()
>to free an lgr while it is still being dereferenced.
>
>Hold smc_lgr_list.lock across the traversal. Update
>smc_ib_gid_check() to call smcr_port_err() after releasing the lock.
>
>Fixes: 541afa10c126 ("net/smc: add smcr_port_err() and smcr_link_down() processing")
>Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust


>---
> net/smc/smc_core.c |  2 ++
> net/smc/smc_ib.c   | 10 ++++++++--
> 2 files changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>index 04aedd957543..9974149659c2 100644
>--- a/net/smc/smc_core.c
>+++ b/net/smc/smc_core.c
>@@ -1849,6 +1849,7 @@ void smcr_port_err(struct smc_ib_device *smcibdev, u8 ibport)
> 	struct smc_link_group *lgr, *n;
> 	int i;
> 
>+	spin_lock_bh(&smc_lgr_list.lock);
> 	list_for_each_entry_safe(lgr, n, &smc_lgr_list.list, list) {
> 		if (strncmp(smcibdev->pnetid[ibport - 1], lgr->pnet_id,
> 			    SMC_MAX_PNETID_LEN))
>@@ -1863,6 +1864,7 @@ void smcr_port_err(struct smc_ib_device *smcibdev, u8 ibport)
> 				smcr_link_down_cond_sched(lnk);
> 		}
> 	}
>+	spin_unlock_bh(&smc_lgr_list.lock);
> }
> 
> static void smc_link_down_work(struct work_struct *work)
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 9bb495707445..daaa8a72da90 100644
>--- a/net/smc/smc_ib.c
>+++ b/net/smc/smc_ib.c
>@@ -333,6 +333,7 @@ static bool smc_ib_check_link_gid(u8 gid[SMC_GID_SIZE], bool smcrv2,
> static void smc_ib_gid_check(struct smc_ib_device *smcibdev, u8 ibport)
> {
> 	struct smc_link_group *lgr;
>+	bool stale_gid = false;
> 	int i;
> 
> 	spin_lock_bh(&smc_lgr_list.lock);
>@@ -348,11 +349,16 @@ static void smc_ib_gid_check(struct smc_ib_device *smcibdev, u8 ibport)
> 				continue;
> 			if (!smc_ib_check_link_gid(lgr->lnk[i].gid,
> 						   lgr->smc_version == SMC_V2,
>-						   smcibdev, ibport))
>-				smcr_port_err(smcibdev, ibport);
>+						   smcibdev, ibport)) {
>+				stale_gid = true;
>+				goto out;
>+			}
> 		}
> 	}
>+out:
> 	spin_unlock_bh(&smc_lgr_list.lock);
>+	if (stale_gid)
>+		smcr_port_err(smcibdev, ibport);
> }
> 
> static int smc_ib_remember_port_attr(struct smc_ib_device *smcibdev, u8 ibport)
>
>base-commit: f0b88fade64c6fe52e15b246097d10bb115d8af3
>-- 
>2.55.0
