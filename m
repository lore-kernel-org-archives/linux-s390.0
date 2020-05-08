Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHBFf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 21:05:35 -0400
Date: Thu, 07 May 2020 18:05:33 -0700 (PDT)
Message-Id: <20200507.180533.1047191517962735284.davem@davemloft.net>
Subject: Re: [PATCH net-next] net/smc: remove set but not used variables
 'del_llc, del_llc_resp'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200507142406.14638-1-kgraul@linux.ibm.com>
References: <20200507142406.14638-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu,  7 May 2020 16:24:06 +0200

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> net/smc/smc_llc.c: In function 'smc_llc_cli_conf_link':
> net/smc/smc_llc.c:753:31: warning:
>  variable 'del_llc' set but not used [-Wunused-but-set-variable]
>   struct smc_llc_msg_del_link *del_llc;
>                                ^
> net/smc/smc_llc.c: In function 'smc_llc_process_srv_delete_link':
> net/smc/smc_llc.c:1311:33: warning:
>  variable 'del_llc_resp' set but not used [-Wunused-but-set-variable]
>     struct smc_llc_msg_del_link *del_llc_resp;
>                                  ^
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied, thanks.
