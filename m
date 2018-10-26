From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V2 1/1] net/smc: fix smc_buf_unuse to use the lgr
 pointer
Date: Fri, 26 Oct 2018 16:00:28 -0700 (PDT)
Message-ID: <20181026.160028.1687112089665155201.davem@davemloft.net>
References: <20181025112528.77307-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181025112528.77307-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 25 Oct 2018 13:25:28 +0200

> From: Karsten Graul <kgraul@linux.ibm.com>
> 
> The pointer to the link group is unset in the smc connection structure
> right before the call to smc_buf_unuse. Provide the lgr pointer to
> smc_buf_unuse explicitly.
> And move the call to smc_lgr_schedule_free_work to the end of
> smc_conn_free.
> 
> Fixes: a6920d1d130c ("net/smc: handle unregistered buffers")
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied and queued up for -stable, thanks!
