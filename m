Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBA171652;
	Mon, 18 Nov 2024 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962924; cv=none; b=GzB/mqmvxuw4HFPLPFUbF/Tstu8516YHieZ8UvqCvONGwX6Gq/DBSZWk8tGpBYdGklY2Ti5pmz6NVx+IG/vpIfjSduZ7wZA/eRBpmojVkHc7m0FAjozSCwQr+E0Ptpc79h2nwmsUXMovefu5rzDtNtsVZYxW7agFr59f1s/PTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962924; c=relaxed/simple;
	bh=9aRhU7SYTiy9GTZdVZfR4WneooPr3fJ0MNcnsVkz+ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+hCn4aKa2D+MBm4qgXO4Wyn5nDgSN6a1HHL/KOEunZlVFCp79kH1LyUagnArlA9lzONzGYwkcQ3Y5Le84WeWOlfV8KRhlTedKMMfI9tH46IMB4dD3ds+HtOObCc5DEUsE00C6BXntbrGKqTpEPfX5suR2XZ7H9zIl94VD5JhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I57jX91b; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I57jX91b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731962923; x=1763498923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3tO4Q4IodwMB3txyonk+PdRsnAHyv4Ng/JNgI4AXdKU=;
  b=I57jX91bbvfgpEwvCLLuE4r8ofOT1oAoQezzUGk0FXBoOtB/Rw+ZsdBh
   Krq1F7WZ4+9hDkH4/vASd59CKIN1dPKiZJQsYm8nsnpUHiJB4szWXy2HZ
   OwoW9em+tc0rwVF9wQUR1LBDWAobjSxxIzsi5SYQOL7oItXBDsz+iRCEi
   s=;
X-IronPort-AV: E=Sophos;i="6.12,164,1728950400"; 
   d="scan'208";a="674618741"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 20:48:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:26921]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.2:2525] with esmtp (Farcaster)
 id 1bbcfe20-ac78-474e-94b5-fc72fd89125b; Mon, 18 Nov 2024 20:48:38 +0000 (UTC)
X-Farcaster-Flow-ID: 1bbcfe20-ac78-474e-94b5-fc72fd89125b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 18 Nov 2024 20:48:38 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 18 Nov 2024 20:48:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <liqiang64@huawei.com>
CC: <alibuda@linux.alibaba.com>, <dengguangxing@huawei.com>,
	<dust.li@linux.alibaba.com>, <gaochao24@huawei.com>,
	<guwen@linux.alibaba.com>, <jaka@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<luanjianhai@huawei.com>, <netdev@vger.kernel.org>,
	<tonylu@linux.alibaba.com>, <wenjia@linux.ibm.com>,
	<zhangxuzhou4@huawei.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next 1/1] Separate locks for rmbs/sndbufs linked lists of different lengths
Date: Mon, 18 Nov 2024 12:48:31 -0800
Message-ID: <20241118204831.70974-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241118132147.1614-2-liqiang64@huawei.com>
References: <20241118132147.1614-2-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: liqiang <liqiang64@huawei.com>
Date: Mon, 18 Nov 2024 21:21:47 +0800
> @@ -596,10 +632,26 @@ static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
>  static struct smc_buf_desc *smc_llc_get_first_rmb(struct smc_link_group *lgr,
>  						  int *buf_lst)
>  {
> -	*buf_lst = 0;
> +	smc_llc_lock_in_turn(lgr->rmbs_lock, buf_lst, SMC_LLC_INTURN_LOCK_INIT);
>  	return smc_llc_get_next_rmb(lgr, buf_lst, NULL);
>  }
>  
> +static inline void smc_llc_bufs_wrlock_all(struct rw_semaphore *lock, int nums)
> +{
> +	int i = 0;
> +
> +	for (; i < nums; i++)
> +		down_write(&lock[i]);

LOCKDEP will complain here.  You may want to test with
CONFIG_PROVE_LOCKING=y


> +}
> +
> +static inline void smc_llc_bufs_wrunlock_all(struct rw_semaphore *lock, int nums)
> +{
> +	int i = 0;
> +
> +	for (; i < nums; i++)
> +		up_write(&lock[i]);
> +}
> +
>  static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
>  			       struct smc_link *link, struct smc_link *link_new)
>  {
