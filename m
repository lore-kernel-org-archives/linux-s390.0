Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 07 Dec 2020 06:57:13 -0800 (PST)
Message-Id: <20201207.065713.357907127824978080.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/6] s390/qeth: updates 2020-12-07
From: David Miller <davem@davemloft.net>
In-Reply-To: <20201207131233.90383-1-jwi@linux.ibm.com>
References: <20201207131233.90383-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon,  7 Dec 2020 14:12:27 +0100

> Hi Jakub,
> 
> please apply the following patch series for qeth to netdev's net-next tree.
> 
> Some sysfs cleanups (with the prep work in ccwgroup acked by Heiko), and
> a few improvements to the code that deals with async TX completion
> notifications for IQD devices.
> 
> This also brings the missing patch from the previous net-next submission.

Series applied, thanks Julian!
