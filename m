Return-Path: <SRS0=Xlyd=RW=vger.kernel.org=netdev-owner@kernel.org>
Date: Mon, 18 Mar 2019 18:35:15 -0700 (PDT)
Message-Id: <20190318.183515.422559718847958116.davem@davemloft.net>
Subject: Re: [PATCH net 0/3] s390/qeth: fixes 2019-03-18
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190318154056.4231-1-jwi@linux.ibm.com>
References: <20190318154056.4231-1-jwi@linux.ibm.com>
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
Date: Mon, 18 Mar 2019 16:40:53 +0100

> please apply the following three patches to -net. The first two are fixes
> for minor race conditions in the probe code, while the third one gets
> dropwatch working (again).

Series applied, thanks Julian.
