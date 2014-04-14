Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Apr 2014 21:28:24 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: fix new ccwgroup.h kernel-doc warning
In-Reply-To: <534C1DC9.7020108@infradead.org>
Message-ID: <alpine.LFD.2.11.1404142127070.1561@denkbrett>
References: <534C1DC9.7020108@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 14 Apr 2014, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix new s390 kernel-doc warning:
> 
> Warning(arch/s390/include/asm/ccwgroup.h:27): No description found for parameter 'ungroup_work'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc:	Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> Cc:	linux-s390@vger.kernel.org
> Cc:	Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc:	Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc:	linux390@de.ibm.com
> ---
>  arch/s390/include/asm/ccwgroup.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- lnx-315-rc1.orig/arch/s390/include/asm/ccwgroup.h
> +++ lnx-315-rc1/arch/s390/include/asm/ccwgroup.h
> @@ -10,6 +10,8 @@ struct ccw_driver;
>   * @count: number of attached slave devices
>   * @dev: embedded device structure
>   * @cdev: variable number of slave devices, allocated as needed
> + * @ungroup_work: work to be done when a ccwgroup notifier has action
> + *	type %BUS_NOTIFY_UNBIND_DRIVER
>   */
>  struct ccwgroup_device {
>  	enum {
> 
> 

Applied, thanks!
Sebastian
