Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729162AbgEFVLu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 17:11:50 -0400
Date: Wed, 06 May 2020 14:11:49 -0700 (PDT)
Message-Id: <20200506.141149.81578290716709045.davem@davemloft.net>
Subject: Re: [PATCH v2 net-next 00/10] s390/qeth: updates 2020-05-06
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200506080949.3915-1-jwi@linux.ibm.com>
References: <20200506080949.3915-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed,  6 May 2020 10:09:39 +0200

> please apply the following patch series for qeth to netdev's net-next
> tree.
> Same patches as yesterday, except that the ethtool reset has been
> dropped for now.
> 
> This primarily adds infrastructure to deal with HW offloads when the
> packets get forwarded over the adapter's internal switch.
> Aside from that, just some minor tweaking for the TX code.

Series applied, thanks Julian.
