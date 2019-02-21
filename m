Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v3] zcrypt: handle AP Info notification from CHSC SEI
 command
References: <1550509295-1199-1-git-send-email-akrowiak@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 21 Feb 2019 11:19:45 -0500
MIME-Version: 1.0
In-Reply-To: <1550509295-1199-1-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <02b26d9b-f4f3-d577-3248-3895d80c882e@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, akrowiak@linux.vnet.ibm.com, oberpar@linux.ibm.com, sebott@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/18/19 12:01 PM, Tony Krowiak wrote:
> The current AP bus implementation periodically polls the AP configuration
> to detect changes. When the AP configuration is dynamically changed via the
> SE or an SCLP instruction, the changes will not be reflected to sysfs until
> the next time the AP configuration is polled. The CHSC architecture
> provides a Store Event Information (SEI) command to make notification of an
> AP configuration change. This patch introduces a handler to process
> notification from the CHSC SEI command by immediately kicking off an AP bus
> scan-after-event.

Ping!

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> Reviewed-by: Harald Freudenberger <FREUDE@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   arch/s390/include/asm/ap.h   | 11 +++++++++++
>   drivers/s390/cio/chsc.c      | 13 +++++++++++++
>   drivers/s390/crypto/ap_bus.c | 10 ++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index 1a6a7092d942..e94a0a28b5eb 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -360,4 +360,15 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
>   	return reg1;
>   }
>   
> +/*
> + * Interface to tell the AP bus code that a configuration
> + * change has happened. The bus code should at least do
> + * an ap bus resource rescan.
> + */
> +#if IS_ENABLED(CONFIG_ZCRYPT)
> +void ap_bus_cfg_chg(void);
> +#else
> +static inline void ap_bus_cfg_chg(void){};
> +#endif
> +
>   #endif /* _ASM_S390_AP_H_ */
> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
> index a0baee25134c..eaf4699be2c5 100644
> --- a/drivers/s390/cio/chsc.c
> +++ b/drivers/s390/cio/chsc.c
> @@ -24,6 +24,7 @@
>   #include <asm/crw.h>
>   #include <asm/isc.h>
>   #include <asm/ebcdic.h>
> +#include <asm/ap.h>
>   
>   #include "css.h"
>   #include "cio.h"
> @@ -586,6 +587,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
>   			      " failed (rc=%d).\n", ret);
>   }
>   
> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
> +{
> +	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
> +	if (sei_area->rs != 5)
> +		return;
> +
> +	ap_bus_cfg_chg();
> +}
> +
>   static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
>   {
>   	switch (sei_area->cc) {
> @@ -612,6 +622,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
>   	case 2: /* i/o resource accessibility */
>   		chsc_process_sei_res_acc(sei_area);
>   		break;
> +	case 3: /* ap config changed */
> +		chsc_process_sei_ap_cfg_chg(sei_area);
> +		break;
>   	case 7: /* channel-path-availability information */
>   		chsc_process_sei_chp_avail(sei_area);
>   		break;
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index 5a699746c357..d0d415954142 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -861,6 +861,16 @@ void ap_bus_force_rescan(void)
>   EXPORT_SYMBOL(ap_bus_force_rescan);
>   
>   /*
> +* A config change has happened, force an ap bus rescan.
> +*/
> +void ap_bus_cfg_chg(void)
> +{
> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> +
> +	ap_bus_force_rescan();
> +}
> +
> +/*
>    * hex2bitmap() - parse hex mask string and set bitmap.
>    * Valid strings are "0x012345678" with at least one valid hex number.
>    * Rest of the bitmap to the right is padded with 0. No spaces allowed
> 
