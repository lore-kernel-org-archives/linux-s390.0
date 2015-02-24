Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1424796110-7736-1-git-send-email-ameenali023@gmail.com>
References: <1424796110-7736-1-git-send-email-ameenali023@gmail.com>
Date: Tue, 24 Feb 2015 08:44:28 -0800
Message-ID: <CAGXu5jK7xE0xbT+Q-w4ii1vtLZo2-7J9uKLGdFxgvw15TWHukg@mail.gmail.com>
Subject: Re: [PATCH] dcssblk.c : Array index 'i' is used before limits check.
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ameen Ali <ameenali023@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Wolfram Sang <wsa@the-dreams.de>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 24, 2015 at 8:41 AM, Ameen Ali <ameenali023@gmail.com> wrote:
> avoid out-of-bounds-read by checking count before indexing.
>
> Signed-off-by : Ameen Ali <Ameenali023@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/s390/block/dcssblk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 96128cb..da21281 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -547,7 +547,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>          * parse input
>          */
>         num_of_segments = 0;
> -       for (i = 0; ((buf[i] != '\0') && (buf[i] != '\n') && i < count); i++) {
> +       for (i = 0; (i < count && (buf[i] != '\0') && (buf[i] != '\n')); i++) {
>                 for (j = i; (buf[j] != ':') &&
>                         (buf[j] != '\0') &&
>                         (buf[j] != '\n') &&
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
