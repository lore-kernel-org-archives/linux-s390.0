Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:59570 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfKTUaE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Nov 2019 15:30:04 -0500
Date: Wed, 20 Nov 2019 12:30:03 -0800 (PST)
Message-Id: <20191120.123003.1420968007513594046.davem@davemloft.net>
Subject: Re: [PATCH net 0/2] s390/qeth: fixes 2019-11-20
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191120132057.1788-1-jwi@linux.ibm.com>
References: <20191120132057.1788-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 20 Nov 2019 14:20:55 +0100

> please apply two late qeth fixes to your net tree.
> 
> The first fixes a deadlock that can occur if a qeth device is set
> offline while in the middle of processing deferred HW events.
> The second patch converts the return value of an error path to
> use -EIO, so that it can be passed back to userspace.

Series applied, thanks.
