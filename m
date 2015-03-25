From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/1] s390: fix /proc/interrupts output
Date: Wed, 25 Mar 2015 11:42:31 -0400 (EDT)
Message-ID: <20150325.114231.1294268694116098633.davem@davemloft.net>
References: <1427297497-22104-1-git-send-email-ubraun@linux.vnet.ibm.com>
	<1427297497-22104-2-git-send-email-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1427297497-22104-2-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, sebott@linux.vnet.ibm.com, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Wed, 25 Mar 2015 16:31:37 +0100

> From: Sebastian Ott <sebott@linux.vnet.ibm.com>
> 
> The irqclass_sub_desc array and enum interruption_class are out of sync
> thus /proc/interrupts is broken. Remove IRQIO_CLW.
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>

Applied.
