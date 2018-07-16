Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 16 Jul 2018 14:45:49 -0700 (PDT)
Message-Id: <20180716.144549.1700210071419801130.davem@davemloft.net>
Subject: Re: [PATCH net V2 1/1] net/smc: take sock lock in smc_ioctl()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180716115652.72331-1-ubraun@linux.ibm.com>
References: <20180716115652.72331-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org, eric.dumazet@gmail.com, lifeasageek@gmail.com, sbrivio@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Mon, 16 Jul 2018 13:56:52 +0200

> From: Ursula Braun <ursula.braun@linux.ibm.com>
> 
> SMC ioctl processing requires the sock lock to work properly in
> all thinkable scenarios.
> Problem has been found with RaceFuzzer and fixes:
>    KASAN: null-ptr-deref Read in smc_ioctl
> 
> Reported-by: Byoungyoung Lee <lifeasageek@gmail.com>
> Reported-by: syzbot+35b2c5aa76fd398b9fd4@syzkaller.appspotmail.com
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied and queued up for -stable.
