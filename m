Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:59182 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLYGl2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Dec 2019 01:41:28 -0500
Date: Tue, 24 Dec 2019 22:41:27 -0800 (PST)
Message-Id: <20191224.224127.1299414022630652936.davem@davemloft.net>
Subject: Re: [PATCH net 0/6] s390/qeth: fixes 2019-12-23
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191223140326.16488-1-jwi@linux.ibm.com>
References: <20191223140326.16488-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon, 23 Dec 2019 15:03:20 +0100

> please apply the following patch series for qeth to your net tree.
> 
> This brings two fixes for errors during device initialization, deals with
> several issues in the vnicc control code, and adds a missing lock.

Series applied, thanks.
