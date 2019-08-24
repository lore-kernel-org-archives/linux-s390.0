Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:48596 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfHXXfH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 24 Aug 2019 19:35:07 -0400
Date: Sat, 24 Aug 2019 16:35:06 -0700 (PDT)
Message-Id: <20190824.163506.328898476555373543.davem@davemloft.net>
Subject: Re: [PATCH net] s390/qeth: reject oversized SNMP requests
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190823092923.8507-1-jwi@linux.ibm.com>
References: <20190823092923.8507-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 23 Aug 2019 11:29:23 +0200

> Commit d4c08afafa04 ("s390/qeth: streamline SNMP cmd code") removed
> the bounds checking for req_len, under the assumption that the check in
> qeth_alloc_cmd() would suffice.
> 
> But that code path isn't sufficiently robust to handle a user-provided
> data_length, which could overflow (when adding the cmd header overhead)
> before being checked against QETH_BUFSIZE. We end up allocating just a
> tiny iob, and the subsequent copy_from_user() writes past the end of
> that iob.
> 
> Special-case this path and add a coarse bounds check, to protect against
> maliciuous requests. This let's the subsequent code flow do its normal
> job and precise checking, without risk of overflow.
> 
> Fixes: d4c08afafa04 ("s390/qeth: streamline SNMP cmd code")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>

Applied.
