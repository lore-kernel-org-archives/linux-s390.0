Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 20 Mar 2019 08:27:48 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390:tty3270:move spin_lock_bh to spin_lock in tasklet
References: <1553011956-28747-1-git-send-email-chongguiguzi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553011956-28747-1-git-send-email-chongguiguzi@gmail.com>
Message-Id: <20190320072748.GA3625@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jeff Xie <chongguiguzi@gmail.com>
Cc: schwidefsky@de.ibm.com, rppt@linux.vnet.ibm.com, akpm@linux-foundation.org, mhocko@suse.com, keescook@chromium.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 20, 2019 at 12:12:36AM +0800, Jeff Xie wrote:
> It is unnecessary to call spin_lock_bh in a tasklet.
> 
> Signed-off-by: Jeff Xie <chongguiguzi@gmail.com>
> ---
>  drivers/s390/char/tty3270.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> index 2b0c36c2..2963396 100644
> --- a/drivers/s390/char/tty3270.c
> +++ b/drivers/s390/char/tty3270.c
> @@ -563,7 +563,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
>  	char *input;
>  	int len;
> 
> -	spin_lock_bh(&tp->view.lock);
> +	spin_lock(&tp->view.lock);
>  	/*
>  	 * Two AID keys are special: For 0x7d (enter) the input line
>  	 * has to be emitted to the tty and for 0x6d the screen
> @@ -590,7 +590,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
>  		tp->update_flags = TTY_UPDATE_ALL;
>  		tty3270_set_timer(tp, 1);
>  	}
> -	spin_unlock_bh(&tp->view.lock);
> +	spin_unlock(&tp->view.lock);

I'm not going to take this. There is close to zero benefit, but rather
high cost to review this - just because the function is named *tasklet
doesn't mean it is only called in tasklet / softirq context.
