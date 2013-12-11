From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 0/2] Display adjacent switch port's attributes
Date: Wed, 11 Dec 2013 12:13:57 -0800
Message-ID: <20131211121357.4742d9e8@nehalam.linuxnetplumber.net>
References: <1386768540-48188-1-git-send-email-raspl@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1386768540-48188-1-git-send-email-raspl@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Stefan Raspl <raspl@linux.vnet.ibm.com>
Cc: davem@davemloft.net, bhutchings@solarflare.com, blaschka@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 11 Dec 2013 14:28:58 +0100
Stefan Raspl <raspl@linux.vnet.ibm.com> wrote:

> This patch series adds a new callback for ethtool to display the adjacent switch
> port's attributes, as perceived by the NIC, e.g. through respective LLDP message
> exchanges.
> A patch for the qeth device driver provides a sample exploiter for the new
> functionality.
> A new option for ethtool to display the settings will be posted in a separate
> patch.
> 
> Best regards,
> Stefan Raspl
> 
> Stefan Raspl (2):
>   ethtool: Add callback to indicate adjacent switch port attributes
>   qeth: Display adjacent switch port attributes in ethtool
> 
>  drivers/s390/net/qeth_core.h      |  7 ++++
>  drivers/s390/net/qeth_core_main.c | 79 +++++++++++++++++++++++++++++++++++++++
>  drivers/s390/net/qeth_core_mpc.h  | 17 +++++++++
>  drivers/s390/net/qeth_l2_main.c   |  1 +
>  drivers/s390/net/qeth_l3_main.c   |  1 +
>  include/linux/ethtool.h           |  3 ++
>  include/uapi/linux/ethtool.h      | 35 +++++++++++++++++
>  net/core/ethtool.c                | 22 +++++++++++
>  8 files changed, 165 insertions(+)
> 

Why more ethtool and not netlink? ethtool is a brittle interface, non-extensible
and does not support notifications of changes.
