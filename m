Return-Path: <netdev-owner@vger.kernel.org>
Date: Tue, 15 Sep 2020 13:22:05 -0700 (PDT)
Message-Id: <20200915.132205.83625953736297072.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/8] s390/qeth: updates 2020-09-10
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200910172351.5622-1-jwi@linux.ibm.com>
References: <20200910172351.5622-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com, wintera@linux.ibm.com, roopa@nvidia.com, nikolay@nvidia.com, jiri@resnulli.us, ivecera@redhat.com

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 10 Sep 2020 19:23:43 +0200

> subject to positive review by the bridge maintainers on patch 5,
> please apply the following patch series to netdev's net-next tree.
> 
> Alexandra adds BR_LEARNING_SYNC support to qeth. In addition to the
> main qeth changes (controlling the feature, and raising switchdev
> events), this also needs
> - Patch 1 and 2 for some s390/cio infrastructure improvements
>   (acked by Heiko to go in via net-next), and
> - Patch 5 to introduce a new switchdev_notifier_type, so that a driver
>   can clear all previously learned entries from the bridge FDB in case
>   things go out-of-sync later on.

Series applied, thank you.
