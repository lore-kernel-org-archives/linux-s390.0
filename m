Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Feb 2015 10:26:31 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] dcssblk.c : Array index 'i' is used before limits check.
Message-ID: <20150225092631.GA4271@osiris>
References: <1424796110-7736-1-git-send-email-ameenali023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424796110-7736-1-git-send-email-ameenali023@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ameen Ali <ameenali023@gmail.com>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, keescook@chromium.org, wsa@the-dreams.de, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 24, 2015 at 06:41:50PM +0200, Ameen Ali wrote:
> avoid out-of-bounds-read by checking count before indexing.
> 
> Signed-off-by : Ameen Ali <Ameenali023@gmail.com>
> ---
>  drivers/s390/block/dcssblk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 96128cb..da21281 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -547,7 +547,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>  	 * parse input
>  	 */
>  	num_of_segments = 0;
> -	for (i = 0; ((buf[i] != '\0') && (buf[i] != '\n') && i < count); i++) {
> +	for (i = 0; (i < count && (buf[i] != '\0') && (buf[i] != '\n')); i++) {

Applied, thanks!
