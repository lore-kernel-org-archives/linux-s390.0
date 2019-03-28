Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
Date: Thu, 28 Mar 2019 12:58:37 -0700 (PDT)
Message-Id: <20190328.125837.1360833902667746793.davem@davemloft.net>
Subject: Re: [PATCH net-next 00/10] s390/qeth: updates 2019-03-28
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
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
Date: Thu, 28 Mar 2019 16:39:18 +0100

> please apply the following patchset to net-next. This reworks the control
> IO code in qeth so that we no longer need to poll for cmd completion,
> and refactors the IDX setup code to also use this improved IO path.

Series applied, thanks Julian.
