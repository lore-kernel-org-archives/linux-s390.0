Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLNpz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 12 Jun 2020 09:45:55 -0400
MIME-Version: 1.0
References: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
From: Mauricio Tavares <raubvogel@gmail.com>
Date: Fri, 12 Jun 2020 09:45:42 -0400
Message-ID: <CAHEKYV6edAHyrW-VQtW5ufZkqpXbfd1sU9N4BqOktezdffHTsg@mail.gmail.com>
Subject: Re: [PATCH] s390: protvirt: virtio: Refuse device without IOMMU
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

On Wed, Jun 10, 2020 at 12:32 PM Pierre Morel <pmorel@linux.ibm.com> wrote:
>
> Protected Virtualisation protects the memory of the guest and
> do not allow a the host to access all of its memory.
>
> Let's refuse a VIRTIO device which does not use IOMMU
> protected access.
>
      Stupid questions:

1. Do all CPU families we care about (which are?) support IOMMU? Ex:
would it recognize an ARM thingie with SMMU? [1]
2. Would it make sense to have some kind of
yes-I-know-the-consequences-but-I-need-to-have-a-virtio-device-without-iommu-in-this-guest
flag?

> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 5730572b52cd..06ffbc96587a 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -986,6 +986,11 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
>         if (!ccw)
>                 return;
>
> +       /* Protected Virtualisation guest needs IOMMU */
> +       if (is_prot_virt_guest() &&
> +           !__virtio_test_bit(vdev, VIRTIO_F_IOMMU_PLATFORM))
> +                       status &= ~VIRTIO_CONFIG_S_FEATURES_OK;
> +
>         /* Write the status to the host. */
>         vcdev->dma_area->status = status;
>         ccw->cmd_code = CCW_CMD_WRITE_STATUS;
> --
> 2.25.1
>

[1] https://developer.arm.com/architectures/system-architectures/system-components/system-mmu-support
