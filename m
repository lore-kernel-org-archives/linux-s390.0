Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] s390: zfcp: Remove unneeded linux/miscdevice.h
 include
References: <20161215141824.3297-1-clabbe.montjoie@gmail.com>
 <20161215141824.3297-2-clabbe.montjoie@gmail.com>
From: Steffen Maier <maier@linux.vnet.ibm.com>
Date: Tue, 7 Mar 2017 16:30:13 +0100
MIME-Version: 1.0
In-Reply-To: <20161215141824.3297-2-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Message-Id: <f8941f5e-bbb5-43bd-5997-40f274325864@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Thanks, Corentin, queued for next zfcp feature submission to linux-scsi as:

"zfcp: Remove unneeded linux/miscdevice.h include"

In fact, this seems a minor missing code cleanup of the following older=20
"feature" which also dropped the only former use of a misc device in zfcp:
663e0890e31cb85f0cca5ac1faaee0d2d52880b5
("[SCSI] zfcp: remove access control tables interface")
b5dc3c4800cc5c2c0b3c93a97eb4c7afa0aae49a
("[SCSI] zfcp: remove access control tables interface (keep sysfs files)")
1b33ef23946adee4b7d9d6b16b7285ce61063451
("zfcp: remove access control tables interface (port leftovers)").

On 12/15/2016 03:18 PM, Corentin Labbe wrote:
> drivers/s390/scsi/zfcp_aux.c does not contain any miscdevice so the
> inclusion of linux/miscdevice.h is uncessary.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/s390/scsi/zfcp_aux.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> index bcc8f3d..82ac331 100644
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -29,7 +29,6 @@
>  #define KMSG_COMPONENT "zfcp"
>  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>
> -#include <linux/miscdevice.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>

--=20
Mit freundlichen Gr=FC=DFen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
