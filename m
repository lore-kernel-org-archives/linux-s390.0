Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from m42-8.mailgun.net ([69.72.42.8]:20779 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhA0FMi (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Jan 2021 00:12:38 -0500
Sender: kvalo=codeaurora.org@mg.codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH] Fix "ordering" comment typos
References: <20210126195042.2909405-1-helgaas@kernel.org>
Date: Wed, 27 Jan 2021 07:11:22 +0200
In-Reply-To: <20210126195042.2909405-1-helgaas@kernel.org> (Bjorn Helgaas's
        message of "Tue, 26 Jan 2021 13:50:42 -0600")
Message-ID: <87zh0v9d6t.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Luca Coelho <luciano.coelho@intel.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

Bjorn Helgaas <helgaas@kernel.org> writes:

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

Please do.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
