From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 5/5] qeth: start dev queue after tx drop error
Date: Tue, 10 Jun 2008 18:21:27 -0400
Message-ID: <484EFE67.6070902@pobox.com>
References: <20080606103743.638691000@de.ibm.com> <20080606103830.766673000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20080606103830.766673000@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

frank.blaschka@de.ibm.com wrote:
> From: Frank Blaschka <frank.blaschka@de.ibm.com>
> 
> In case the xmit function drop out with an error, we have to wake
> the netdevice queue to start another xmit.
> 
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
>  drivers/s390/net/qeth_l2_main.c |    1 +
>  drivers/s390/net/qeth_l3_main.c |    1 +
>  2 files changed, 2 insertions(+)

applied 1-5
