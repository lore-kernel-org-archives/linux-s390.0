Return-Path: <netdev-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20210128112551.18780-1-jwi@linux.ibm.com>
In-Reply-To: <20210128112551.18780-1-jwi@linux.ibm.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 28 Jan 2021 14:57:46 -0500
Message-ID: <CAF=yD-JNMTaUgfAAp5+qfOBnL171j9FFj2jvb4Na955jBqj4AA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] s390/qeth: updates 2021-01-28
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On Thu, Jan 28, 2021 at 6:34 AM Julian Wiedmann <jwi@linux.ibm.com> wrote:
>
> Hi Dave & Jakub,
>
> please apply the following patch series for qeth to netdev's net-next tree.
>
> Nothing special, mostly fine-tuning and follow-on cleanups for earlier fixes.
>
> Thanks,
> Julian
>
> Julian Wiedmann (5):
>   s390/qeth: clean up load/remove code for disciplines
>   s390/qeth: remove qeth_get_ip_version()
>   s390/qeth: pass proto to qeth_l3_get_cast_type()
>   s390/qeth: make cast type selection for af_iucv skbs robust
>   s390/qeth: don't fake a TX completion interrupt after TX error
>
>  drivers/s390/net/qeth_core.h      | 44 +++++---------
>  drivers/s390/net/qeth_core_main.c | 97 +++++++++++++++++--------------
>  drivers/s390/net/qeth_core_sys.c  | 10 +---
>  drivers/s390/net/qeth_l2_main.c   |  6 +-
>  drivers/s390/net/qeth_l3_main.c   | 90 ++++++++++++++++------------
>  5 files changed, 125 insertions(+), 122 deletions(-)

for netdrv

Acked-by: Willem de Bruijn <willemb@google.com>
