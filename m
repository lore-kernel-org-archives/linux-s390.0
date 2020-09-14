Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgINVif (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Sep 2020 17:38:35 -0400
Date: Mon, 14 Sep 2020 14:38:33 -0700 (PDT)
Message-Id: <20200914.143833.1403433161550913976.davem@davemloft.net>
Subject: Re: [PATCH net-next 5/8] bridge: Add SWITCHDEV_FDB_FLUSH_TO_BRIDGE
 notifier
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200910172351.5622-6-jwi@linux.ibm.com>
References: <20200910172351.5622-1-jwi@linux.ibm.com>
        <20200910172351.5622-6-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com, wintera@linux.ibm.com, roopa@nvidia.com, nikolay@nvidia.com, jiri@resnulli.us, ivecera@redhat.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 10 Sep 2020 19:23:48 +0200

> From: Alexandra Winter <wintera@linux.ibm.com>
> 
> so the switchdev can notifiy the bridge to flush non-permanent fdb entries
> for this port. This is useful whenever the hardware fdb of the switchdev
> is reset, but the netdev and the bridgeport are not deleted.
> 
> Note that this has the same effect as the IFLA_BRPORT_FLUSH attribute.
> 
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Ivan Vecera <ivecera@redhat.com>
> CC: Roopa Prabhu <roopa@nvidia.com>
> CC: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

This still needs review by bridge experts.

Thank you.
