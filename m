From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [patch 1/4] lcs: convert to net_device_ops
Date: Fri, 9 Jan 2009 11:54:47 +0100
Message-ID: <20090109105447.GA2929@wavehammer.waldi.eu.org>
References: <20090109090156.422658000@de.ibm.com> <20090109090220.554541000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090109090220.554541000@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 09, 2009 at 10:01:57AM +0100, frank.blaschka@de.ibm.com wrote:
>  #ifdef CONFIG_IP_MULTICAST
>  	if (!lcs_check_multicast_support(card))
> -		card->dev->set_multicast_list = lcs_set_multicast_list;
> +		lcs_netdev_ops.ndo_set_multicast_list = lcs_set_multicast_list;

This looks wrong. lcs_netdev_ops is static but this code used to set it
up per card.

Bastian

-- 
History tends to exaggerate.
		-- Col. Green, "The Savage Curtain", stardate 5906.4
