Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:53000
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbgCRNHg (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 09:07:36 -0400
Date: Wed, 18 Mar 2020 15:07:20 +0200
From: Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH net-next 08/11] s390/qeth: don't report hard-coded driver
 version
Message-ID: <20200318130720.GW3351@unreal>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
 <20200318125455.5838-9-jwi@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318125455.5838-9-jwi@linux.ibm.com>
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

On Wed, Mar 18, 2020 at 01:54:52PM +0100, Julian Wiedmann wrote:
> Versions are meaningless for an in-kernel driver.
> Instead use the UTS_RELEASE that is set by ethtool_get_drvinfo().
>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_ethtool.c | 1 -
>  1 file changed, 1 deletion(-)
>

Thanks a lot for the patch,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
