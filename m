Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:37984 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCXXn2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Mar 2020 19:43:28 -0400
Date: Tue, 24 Mar 2020 16:43:26 -0700 (PDT)
Message-Id: <20200324.164326.639594724461733845.davem@davemloft.net>
Subject: Re: [PATCH net-next 01/11] s390/qeth: simplify RX buffer tracking
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200324182448.95362-2-jwi@linux.ibm.com>
References: <20200324182448.95362-1-jwi@linux.ibm.com>
        <20200324182448.95362-2-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Tue, 24 Mar 2020 19:24:38 +0100

> +#define QDIO_ELEMENT_NO(buf, element)	(element - &buf->element[0])

Maybe this works, but I would strongly suggest against using a CPP
macro argument that is the same name for the singleton element on
the left branch of the expression as the struct member name on
the right side of the element.

Furthermore, as far as I can tell this is only used in one location
in the code, and for such a simple expression that is excessive.
