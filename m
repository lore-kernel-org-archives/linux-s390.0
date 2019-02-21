Return-Path: <SRS0=K4f4=Q4=vger.kernel.org=netdev-owner@kernel.org>
Date: Thu, 21 Feb 2019 10:20:55 -0800 (PST)
Message-Id: <20190221.102055.331192649932336315.davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: fix smc_poll in SMC_INIT state
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190221115654.3889-1-ubraun@linux.ibm.com>
References: <20190221115654.3889-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 21 Feb 2019 12:56:54 +0100

> smc_poll() returns with mask bit EPOLLPRI if the connection urg_state
> is SMC_URG_VALID. Since SMC_URG_VALID is zero, smc_poll signals
> EPOLLPRI errorneously if called in state SMC_INIT before the connection
> is created, for instance in a non-blocking connect scenario.
> 
> This patch switches to non-zero values for the urg states.
> 
> Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
> Fixes: de8474eb9d50 ("net/smc: urgent data support")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied and queued up for -stable.
