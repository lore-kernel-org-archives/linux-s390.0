Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:40160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0WhO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 Mar 2020 18:37:14 -0400
Date: Fri, 27 Mar 2020 15:37:13 -0700 (PDT)
Message-Id: <20200327.153713.1413768121067153435.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/3] s390/qeth: updates 2020-03-27
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200327101934.31040-1-jwi@linux.ibm.com>
References: <20200327101934.31040-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, ubraun@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 27 Mar 2020 11:19:31 +0100

> please apply the following patch series for qeth to netdev's net-next
> tree.
> 
> Spring clean edition:
> - remove one sysfs attribute that was never put in use,
> - make support for OSN and OSX devices optional, and
> - probe for removal of the obsolete OSN support.

Series applied, thanks.
