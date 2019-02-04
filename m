Return-Path: <SRS0=ZPcH=QL=vger.kernel.org=netdev-owner@kernel.org>
Date: Mon, 04 Feb 2019 09:44:04 -0800 (PST)
Message-Id: <20190204.094404.1397730499553928143.davem@davemloft.net>
Subject: Re: [PATCH net 0/4] s390/qeth: fixes 2019-02-04
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190204164009.7245-1-jwi@linux.ibm.com>
References: <20190204164009.7245-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon,  4 Feb 2019 17:40:05 +0100

> please apply the following four fixes to -net.
> 
> Patch 1 takes care of a common resource leak in various error paths, while the
> second patch fixes a misordered kfree when cleaning up after an error.
> The other two patches ensure that there's no stale work dangling on workqueues
> when the qeth device has already been offlined and/or removed.

Series applied, thanks.
