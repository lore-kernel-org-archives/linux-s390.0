Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:48628 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfHXXjf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 24 Aug 2019 19:39:35 -0400
Date: Sat, 24 Aug 2019 16:39:34 -0700 (PDT)
Message-Id: <20190824.163934.1752882295039249516.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/7] s390/qeth: updates 2019-08-23
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190823094853.63814-1-jwi@linux.ibm.com>
References: <20190823094853.63814-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 23 Aug 2019 11:48:46 +0200

> please apply one more round of qeth patches. These implement support for
> a bunch of TX-related features - namely TX NAPI, BQL and xmit_more.
> 
> Note that this includes two qdio patches which lay the necessary
> groundwork, and have been acked by Vasily.

Series applied, thanks.
