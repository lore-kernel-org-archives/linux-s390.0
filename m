Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:56390 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFEDNh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 23:13:37 -0400
Date: Tue, 04 Jun 2019 20:13:36 -0700 (PDT)
Message-Id: <20190604.201336.1810440055167628114.davem@davemloft.net>
Subject: Re: [PATCH v2 net 0/4] s390/qeth: fixes 2019-06-04
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190604081509.56160-1-jwi@linux.ibm.com>
References: <20190604081509.56160-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Tue,  4 Jun 2019 10:15:05 +0200

> same patch series as yesterday, except that patch 2 has been adjusted
> as per your review to use dst_check(). Please have another look.

The correct usage is:

	dst = dst_check();
