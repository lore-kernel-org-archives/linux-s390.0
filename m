Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231642AbhA2Qdy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Jan 2021 11:33:54 -0500
Date: Fri, 29 Jan 2021 10:24:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] Fix "ordering" comment typos
Message-ID: <20210129162428.GA85218@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126195042.2909405-1-helgaas@kernel.org>
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Luca Coelho <luciano.coelho@intel.com>, Kalle Valo <kvalo@codeaurora.org>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

On Tue, Jan 26, 2021 at 01:50:42PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix comment typos in "ordering".
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/s390/include/asm/facility.h             | 2 +-
>  drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/file.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> Unless somebody objects, I'll just merge these typo fixes via the PCI tree.

Applied to pci/misc for v5.12 with acks from Kalle and Vasily.

> diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
> index 68c476b20b57..91b5d714d28f 100644
> --- a/arch/s390/include/asm/facility.h
> +++ b/arch/s390/include/asm/facility.h
> @@ -44,7 +44,7 @@ static inline int __test_facility(unsigned long nr, void *facilities)
>  }
>  
>  /*
> - * The test_facility function uses the bit odering where the MSB is bit 0.
> + * The test_facility function uses the bit ordering where the MSB is bit 0.
>   * That makes it easier to query facility bits with the bit number as
>   * documented in the Principles of Operation.
>   */
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 6e7f16f4cec7..dab190a547cc 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -141,7 +141,7 @@ static void qxl_drm_release(struct drm_device *dev)
>  
>  	/*
>  	 * TODO: qxl_device_fini() call should be in qxl_pci_remove(),
> -	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
> +	 * reordering qxl_modeset_fini() + qxl_device_fini() calls is
>  	 * non-trivial though.
>  	 */
>  	qxl_modeset_fini(qdev);
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
> index 597bc88479ba..04fbfe5cbeb0 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
> @@ -866,7 +866,7 @@ struct iwl_fw_dbg_trigger_time_event {
>   * tx_bar: tid bitmap to configure on what tid the trigger should occur
>   *	when a BAR is send (for an Rx BlocAck session).
>   * frame_timeout: tid bitmap to configure on what tid the trigger should occur
> - *	when a frame times out in the reodering buffer.
> + *	when a frame times out in the reordering buffer.
>   */
>  struct iwl_fw_dbg_trigger_ba {
>  	__le16 rx_ba_start;
> -- 
> 2.25.1
> 
