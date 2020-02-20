Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:57216 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgBTSbf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Feb 2020 13:31:35 -0500
Date: Thu, 20 Feb 2020 10:31:34 -0800 (PST)
Message-Id: <20200220.103134.65963913215957539.davem@davemloft.net>
Subject: Re: [PATCH net 0/3] s390/qeth: fixes 2020-02-20
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200220145456.11571-1-jwi@linux.ibm.com>
References: <20200220145456.11571-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 20 Feb 2020 15:54:53 +0100

> please apply the following patch series for qeth to netdev's net tree.
> 
> This corrects three minor issues:
> 1) return a more fitting errno when VNICC cmds are not supported,
> 2) remove a bogus WARN in the NAPI code, and
> 3) be _very_ pedantic about the RX copybreak.

Series applied, thanks.
