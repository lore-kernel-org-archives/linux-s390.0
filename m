Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:56748 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0RSm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Jun 2019 13:18:42 -0400
Date: Thu, 27 Jun 2019 10:18:41 -0700 (PDT)
Message-Id: <20190627.101841.1281601732982101635.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/12] s390/qeth: updates 2019-06-27
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190627150133.58746-1-jwi@linux.ibm.com>
References: <20190627150133.58746-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 27 Jun 2019 17:01:21 +0200

> please apply another round of qeth updates for net-next.
> This completes the conversion of the control path to use dynamically
> allocated cmd buffers, along with some fine-tuning for the route
> validation fix that recently went into -net.

Series applied, thanks.
