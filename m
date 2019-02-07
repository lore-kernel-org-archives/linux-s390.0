Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 7 Feb 2019 10:59:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] zcrypt: handle AP Info notification from CHSC SEI
 command
Message-ID: <20190207105940.19b34df1.cohuck@redhat.com>
In-Reply-To: <1549488686-3746-1-git-send-email-akrowiak@linux.ibm.com>
References: <1549488686-3746-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, akrowiak@linux.vnet.ibm.com, oberpar@linux.ibm.com, sebott@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed,  6 Feb 2019 16:31:26 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The current AP bus implementation periodically polls the AP configuration
> to detect changes. When the AP configuration is dynamically changed via the
> SE or an SCLP instruction, the changes will not be reflected to sysfs until
> the next time the AP configuration is polled. The CHSC architecture
> provides a Store Event Information (SEI) command to make notification of an
> AP configuration change. This patch introduces a handler to process
> notification from the CHSC SEI command by immediately kicking off an AP bus
> scan-after-event.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> ---
>  arch/s390/include/asm/ap.h   | 11 +++++++++++
>  drivers/s390/cio/chsc.c      | 13 +++++++++++++
>  drivers/s390/crypto/ap_bus.c | 11 +++++++++++
>  3 files changed, 35 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
