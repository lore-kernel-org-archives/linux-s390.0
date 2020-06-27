Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0QK7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 27 Jun 2020 12:10:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975E6C03E979
        for <linux-s390@vger.kernel.org>; Sat, 27 Jun 2020 09:10:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f6so2180902pjq.5
        for <linux-s390@vger.kernel.org>; Sat, 27 Jun 2020 09:10:59 -0700 (PDT)
Date: Sat, 27 Jun 2020 09:10:56 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drivers/s390/char/tty3270: Remove function callback casts
Message-ID: <202006270853.C40CA89806@keescook>
References: <20200627125417.18887-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627125417.18887-1-oscar.carter@gmx.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Oscar Carter <oscar.carter@gmx.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kernel-hardening@lists.openwall.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 02:54:17PM +0200, Oscar Carter wrote:
> In an effort to enable -Wcast-function-type in the top-level Makefile to
> support Control Flow Integrity builds, remove all the function callback
> casts.
> 
> To do this modify the function prototypes accordingly.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>

Oh yes, the tasklets! I'd love to see this fixed correctly. (Which is to
say, modernize the API.) Romain hasn't had time to continue the work:
https://lore.kernel.org/kernel-hardening/20190929163028.9665-1-romain.perier@gmail.com/

Is this something you'd want to tackle?

> ---
>  drivers/s390/char/tty3270.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> index 98d7fc152e32..aec996de44d9 100644
> --- a/drivers/s390/char/tty3270.c
> +++ b/drivers/s390/char/tty3270.c
> @@ -556,8 +556,9 @@ tty3270_scroll_backward(struct kbd_data *kbd)
>   * Pass input line to tty.
>   */
>  static void
> -tty3270_read_tasklet(struct raw3270_request *rrq)
> +tty3270_read_tasklet(unsigned long data)
>  {
> +	struct raw3270_request *rrq = (struct raw3270_request *)data;

Regardless, this is correct as far as fixing the prototype.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
