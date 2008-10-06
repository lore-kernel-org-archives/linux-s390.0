Return-Path: <linux-kernel-owner+w=401wt.eu-S1753443AbYJFBZU@vger.kernel.org>
Message-ID: <919fe2b30810051825l4f0907d1ucc9ffe9f201ddc4f@mail.gmail.com>
Date: Sun, 5 Oct 2008 21:25:06 -0400
From: "M. Asselstine" <asselsm@mcmaster.ca>
Subject: Re: [PATCH 2/2] drivers/s390/cio/chsc_sch.c: Correct use of ! and &
In-Reply-To: <Pine.LNX.4.64.0810042205090.19286@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0810042205090.19286@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Oct 4, 2008 at 4:05 PM, Julia Lawall <julia@diku.dk> wrote:
> From: Julia Lawall <julia@diku.dk>
>
> In commit e6bafba5b4765a5a252f1b8d31cbf6d2459da337, a bug was fixed that
> involved converting !x & y to !(x & y).  The code below shows the same
> pattern, and thus should perhaps be fixed in the same way.  In particular,
> the result of !scsw_stctl(&request->irb.scsw) & SCSW_STCTL_STATUS_PEND is
> always just !scsw_stctl(&request->irb.scsw).
>
> The semantic patch that makes this change is as follows:
> (http://www.emn.fr/x-info/coccinelle/)
>
> // <smpl>
> @@ expression E; constant C; @@
> (
>  !E & !C
> |
> - !E & C
> + !(E & C)
> )
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
Reviewed-by: Mark Asselstine <mark.asselstine@windriver.com>

>
> ---
>  drivers/s390/cio/chsc_sch.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -u -p a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
> @@ -261,7 +261,7 @@ static int chsc_examine_irb(struct chsc_
>  {
>        int backed_up;
>
> -       if (!scsw_stctl(&request->irb.scsw) & SCSW_STCTL_STATUS_PEND)
> +       if (!(scsw_stctl(&request->irb.scsw) & SCSW_STCTL_STATUS_PEND))
>                return -EIO;
>        backed_up = scsw_cstat(&request->irb.scsw) & SCHN_STAT_CHAIN_CHECK;
>        request->irb.scsw.cmd.cstat &= ~SCHN_STAT_CHAIN_CHECK;
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
