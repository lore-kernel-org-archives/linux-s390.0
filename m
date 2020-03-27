Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:40190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgC0WjE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 Mar 2020 18:39:04 -0400
Date: Fri, 27 Mar 2020 15:39:02 -0700 (PDT)
Message-Id: <20200327.153902.1896503128370913021.davem@davemloft.net>
Subject: Re: [PATCH net] s390/qeth: support net namespaces for L3 devices
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200327110042.50797-1-jwi@linux.ibm.com>
References: <20200327110042.50797-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 27 Mar 2020 12:00:42 +0100

> Enable the L3 driver's IPv4 address notifier to watch for events on qeth
> devices that have been moved into a net namespace. We need to program
> those IPs into the HW just as usual, otherwise inbound traffic won't
> flow.
> 
> Fixes: 6133fb1aa137 ("[NETNS]: Disable inetaddr notifiers in namespaces other than initial.")
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

This looks more like a feature, openning the L3 driver into multiple
namespaces, rather than a critical fix.
