Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <558BD1B4.4030209@bfs.de>
Date: Thu, 25 Jun 2015 12:02:28 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
Subject: Re: [PATCH] s390/process: Delete an unnecessary check before the
 function call "kfree"
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <558B1799.8040003@users.sourceforge.net>
In-Reply-To: <558B1799.8040003@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>



Am 24.06.2015 22:48, schrieb SF Markus Elfring:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 24 Jun 2015 22:40:30 +0200
> 
> The kfree() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/s390/kernel/process.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index dc5edc2..22e6448 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c
> @@ -81,8 +81,7 @@ void release_thread(struct task_struct *dead_task)
>  
>  void arch_release_task_struct(struct task_struct *tsk)
>  {
> -	if (tsk->thread.vxrs)
> -		kfree(tsk->thread.vxrs);
> +	kfree(tsk->thread.vxrs);
>  }
>  
>  int copy_thread(unsigned long clone_flags, unsigned long new_stackp,

maybe the intention was to check tsk != NULL ?

re,
 wh
