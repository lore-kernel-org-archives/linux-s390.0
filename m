Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 16 Jul 2018 15:14:46 +0200
From: Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH net V2 1/1] net/smc: take sock lock in smc_ioctl()
Message-ID: <20180716151446.088ffc3b@epycfail>
In-Reply-To: <20180716115652.72331-1-ubraun@linux.ibm.com>
References: <20180716115652.72331-1-ubraun@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org, eric.dumazet@gmail.com, lifeasageek@gmail.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 16 Jul 2018 13:56:52 +0200
Ursula Braun <ubraun@linux.ibm.com> wrote:

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

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano
