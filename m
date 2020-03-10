Return-Path: <netdev-owner@vger.kernel.org>
Date: Tue, 10 Mar 2020 11:31:22 +0200
From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 net] net/smc: cancel event worker during device removal
Message-ID: <20200310093122.GC242734@unreal>
References: <20200310083330.90427-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310083330.90427-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Tue, Mar 10, 2020 at 09:33:30AM +0100, Karsten Graul wrote:
> During IB device removal, cancel the event worker before the device
> structure is freed.
>
> Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
> Reported-by: syzbot+b297c6825752e7a07272@syzkaller.appspotmail.com
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
> ---
>  net/smc/smc_ib.c | 1 +
>  1 file changed, 1 insertion(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
