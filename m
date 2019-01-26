Return-Path: <SRS0=Za8y=QC=vger.kernel.org=netdev-owner@kernel.org>
Date: Fri, 25 Jan 2019 21:24:12 -0800 (PST)
Message-Id: <20190125.212412.952290013894879457.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/8] s390/qeth: updates 2019-01-25
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
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
Date: Fri, 25 Jan 2019 15:44:15 +0100

> please apply a first batch of qeth patches for net-next, primarily touching the
> net_device parts of the driver.
> In addition to the usual refactoring & code consolidation, patch 7 makes use of
> netif_device_detach() to let the stack know when our control plane is down. This
> helps quite a bit wrt to overall locking and proper init/shutdown sequencing.

Series applied.
