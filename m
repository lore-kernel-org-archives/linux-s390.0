Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/dasd: avoid calling do_gettimeofday()
References: <20171106140328.1498644-1-arnd@arndb.de>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Wed, 8 Nov 2017 14:27:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171106140328.1498644-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Message-Id: <ffe1ebfd-36d3-3408-429f-76aceec04055@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06.11.2017 15:02, Arnd Bergmann wrote:
> do_gettimeofday() is deprecated because it's not y2038-safe on
> 32-bit architectures. Since it is basically a wrapper around
> ktime_get_real_ts64(), we can just call that function directly
> instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/s390/block/dasd_eer.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
> index 4630782b5456..5169c717c9d6 100644
> --- a/drivers/s390/block/dasd_eer.c
> +++ b/drivers/s390/block/dasd_eer.c
> @@ -296,7 +296,7 @@ static void dasd_eer_write_standard_trigger(struct dasd_device *device,
>   {
>   	struct dasd_ccw_req *temp_cqr;
>   	int data_size;
> -	struct timeval tv;
> +	struct timespec64 ts64;
...
> +	ktime_get_real_ts64(&ts);
> +	header.tv_sec = ts.tv_sec;
> +	header.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
>

I renamed ts64 to ts to match the usage below and fix the compile error.

Beside of this, applied. Thanks for the patch.
