From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 3/3] qeth: preallocated header account offset
Date: Wed, 27 Aug 2008 05:56:18 -0400
Message-ID: <48B524C2.6060900@pobox.com>
References: <20080815060257.501264000@de.ibm.com> <20080815060352.948003000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20080815060352.948003000@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

frank.blaschka@de.ibm.com wrote:
> From: Frank Blaschka <frank.blaschka@de.ibm.com>
> 
> When a preallocated header qdio buffer is filled we have to account
> the offset for the data length.
> 
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
> ---
> 
>  drivers/s390/net/qeth_core_main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: git_linus/drivers/s390/net/qeth_core_main.c
> ===================================================================
> --- git_linus.orig/drivers/s390/net/qeth_core_main.c	2008-08-15 07:51:59.000000000 +0200
> +++ git_linus/drivers/s390/net/qeth_core_main.c	2008-08-15 07:52:18.000000000 +0200
> @@ -3024,7 +3024,7 @@
>  	struct qdio_buffer *buffer, int is_tso, int *next_element_to_fill,
>  	int offset)
>  {
> -	int length = skb->len;
> +	int length = skb->len - offset;
>  	int length_here;

applied 1-3
