Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 4 Mar 2016 15:47:33 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: Use pr_warn instead of pr_warning
Message-ID: <20160304144733.GB4005@osiris>
References: <43507081eed8c522d66746b916f098b4ca39461d.1457066864.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43507081eed8c522d66746b916f098b4ca39461d.1457066864.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 03, 2016 at 08:49:57PM -0800, Joe Perches wrote:
> Convert the uses of pr_warning to pr_warn so there are fewer
> uses of the old pr_warning.
> 
> Miscellanea:
> 
> o Align arguments
> o Coalesce formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/kernel/cpcmd.c         |  3 +--
>  arch/s390/kernel/debug.c         |  6 ++----
>  arch/s390/kernel/time.c          |  6 ++----
>  arch/s390/mm/extmem.c            | 16 +++++++---------
>  drivers/s390/block/dasd_devmap.c | 10 ++++------
>  drivers/s390/block/dasd_diag.c   | 28 +++++++++++++---------------
>  drivers/s390/block/dasd_genhd.c  |  4 ++--
>  drivers/s390/block/dasd_ioctl.c  |  5 ++---
>  drivers/s390/block/dasd_proc.c   |  5 ++---
>  drivers/s390/block/dcssblk.c     | 13 ++++++-------
>  drivers/s390/char/monreader.c    | 10 +++++-----
>  drivers/s390/char/sclp_cmd.c     | 27 ++++++++++++---------------
>  drivers/s390/char/sclp_cpi_sys.c |  6 ++----
>  drivers/s390/char/tape_core.c    |  4 ++--
>  drivers/s390/char/vmlogrdr.c     |  6 ++----
>  drivers/s390/cio/blacklist.c     |  9 ++++-----
>  drivers/s390/cio/ccwreq.c        | 13 ++++++-------
>  drivers/s390/cio/cio.c           |  2 +-
>  drivers/s390/cio/device.c        | 23 ++++++++++-------------
>  drivers/s390/net/lcs.c           |  4 ++--
>  drivers/s390/net/qeth_l3_main.c  |  2 +-
>  21 files changed, 88 insertions(+), 114 deletions(-)

Applied, thanks!
