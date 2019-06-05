Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:38044 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFEStQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Jun 2019 14:49:16 -0400
Date: Wed, 05 Jun 2019 11:49:15 -0700 (PDT)
Message-Id: <20190605.114915.1446902922093174106.davem@davemloft.net>
Subject: Re: [PATCH v3 net 0/4] s390/qeth: fixes 2019-06-05
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190605114851.56641-1-jwi@linux.ibm.com>
References: <20190605114851.56641-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed,  5 Jun 2019 13:48:47 +0200

> one more shot...  now with patch 2 fixed up so that it uses the
> dst entry returned from dst_check().

Looks good, series applied, thanks.
