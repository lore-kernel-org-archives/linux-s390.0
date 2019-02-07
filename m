Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 7 Feb 2019 11:24:52 +0100 (CET)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH v2] zcrypt: handle AP Info notification from CHSC SEI
 command
In-Reply-To: <1549488686-3746-1-git-send-email-akrowiak@linux.ibm.com>
References: <1549488686-3746-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1902071120580.7264@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, akrowiak@linux.vnet.ibm.com, oberpar@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 6 Feb 2019, Tony Krowiak wrote:
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> +void ap_bus_cfg_chg(void)
> +{
> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> +
> +	ap_bus_force_rescan();
> +}
> +EXPORT_SYMBOL(ap_bus_cfg_chg);

There is still no need for the EXPORT_SYMBOL. You only call that function
from chsc.c which is always build in.
