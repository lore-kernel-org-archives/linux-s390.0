From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 22 Jul 2013 04:40:28 +0000
Subject: Re: [PATCH V2] s390: replace strict_strtoul() with kstrtoul()
Message-Id: <20130722044028.GA4183@osiris>
In-Reply-To: <002901ce8679$57937750$06ba65f0$@samsung.com>
References: <002901ce8679$57937750$06ba65f0$@samsung.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 22, 2013 at 10:18:15AM +0900, Jingoo Han wrote:
> The usage of strict_strtoul() is not preferred, because
> strict_strtoul() is obsolete. Thus, kstrtoul() should be
> used.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/s390/block/dasd_devmap.c |    8 ++++----
>  drivers/s390/cio/ccwgroup.c      |    2 +-
>  drivers/s390/cio/cmf.c           |    2 +-
>  drivers/s390/cio/css.c           |    2 +-
>  drivers/s390/cio/device.c        |    2 +-
>  drivers/s390/net/qeth_l3_sys.c   |    2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)

Applied, thanks!
