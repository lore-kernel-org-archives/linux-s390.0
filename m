From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/2] s390: scatter-gather for inbound traffic in qeth
 driver
Date: Mon, 16 Jul 2007 18:29:29 -0400
Message-ID: <469BF149.3060901@garzik.org>
References: <20070712105133.165267000@linux.vnet.ibm.com> <20070712105450.168931000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070712105450.168931000@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <braunu@de.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Frank Blaschka <frank.blaschka@de.ibm.com>, Frank Pavlic <fpavlic@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Ursula Braun wrote:
> From: Frank Blaschka <frank.blaschka@de.ibm.com>
> 
> For large incoming packets > PAGE_SIZE/2 qeth creates a fragmented skb
> by adding pointers to qdio pages to the fragment list of the skb.
> This avoids allocating big chunks of consecutive memory. Also copying
> data from the qdio buffer to the skb is economized.
> 
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
> Signed-off-by: Ursula Braun <braunu@de.ibm.com>
> Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>
> ---
> 
>  drivers/s390/net/qeth.h      |    9 ++
>  drivers/s390/net/qeth_main.c |  182 +++++++++++++++++++++++++++++++++++--------
>  drivers/s390/net/qeth_proc.c |    6 +
>  3 files changed, 165 insertions(+), 32 deletions(-)

applied 1-2
