Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgGQTad (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Jul 2020 15:30:33 -0400
Date: Fri, 17 Jul 2020 12:30:27 -0700 (PDT)
Message-Id: <20200717.123027.1640292958732505858.davem@davemloft.net>
Subject: Re: [PATCH net 04/10] net/smc: protect smc ib device initialization
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200716153746.77303-5-kgraul@linux.ibm.com>
References: <20200716153746.77303-1-kgraul@linux.ibm.com>
        <20200716153746.77303-5-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu, 16 Jul 2020 17:37:40 +0200

> Fix that by protecting the critical code using a mutex.
 ...
> @@ -52,6 +52,7 @@ struct smc_ib_device {				/* ib-device infos for smc */
>  	DECLARE_BITMAP(ports_going_away, SMC_MAX_PORTS);
>  	atomic_t		lnk_cnt;	/* number of links on ibdev */
>  	wait_queue_head_t	lnks_deleted;	/* wait 4 removal of all links*/
> +	struct mutex		mutex;		/* protects smc ib device */
>  };

So which is it?  Does the mutex protect the entire contents of the
smc ib device struct, as stated in the comment?  Or does it only
synchronize object creation?

One of them is obviously wrong, so please correct that.
