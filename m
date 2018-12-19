Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 18 Dec 2018 22:03:54 -0800 (PST)
Message-Id: <20181218.220354.1029594559259847304.davem@davemloft.net>
Subject: Re: [PATCH v3] net/smc: fix TCP fallback socket release
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181218170221.GA21835@myunghoj-Precision-5530>
References: <20181218170221.GA21835@myunghoj-Precision-5530>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: mhjungk@gmail.com
Cc: ubraun@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Myungho Jung <mhjungk@gmail.com>
Date: Tue, 18 Dec 2018 09:02:25 -0800

> clcsock can be released while kernel_accept() references it in TCP
> listen worker. Also, clcsock needs to wake up before released if TCP
> fallback is used and the clcsock is blocked by accept. Add a lock to
> safely release clcsock and call kernel_sock_shutdown() to wake up
> clcsock from accept in smc_release().
> 
> Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com
> Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>

Applied, thanks.
