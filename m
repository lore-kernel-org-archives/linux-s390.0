Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:60940 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRXeB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Mar 2020 19:34:01 -0400
Date: Wed, 18 Mar 2020 16:34:00 -0700 (PDT)
Message-Id: <20200318.163400.1408546620540008446.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/11] s390/qeth: updates 2020-03-18
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 18 Mar 2020 13:54:44 +0100

> please apply the following patch series for qeth to netdev's net-next
> tree.
> 
> This consists of three parts:
> 1) support for __GFP_MEMALLOC,
> 2) several ethtool enhancements (.set_channels, SW Timestamping),
> 3) the usual cleanups.

Series applied, thanks.
