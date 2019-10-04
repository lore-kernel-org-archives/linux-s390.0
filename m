Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:40842 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfJDBsB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Oct 2019 21:48:01 -0400
Subject: Re: [PATCH v2] zfcp: fix reaction on bit error theshold notification with adapter close
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <yq1d0fhw2ex.fsf@oracle.com>
        <20191001104949.42810-1-maier@linux.ibm.com>
        <20191001141408.GB3129841@kroah.com>
        <71b8fc68-23a8-a591-1018-f290d6e3312a@linux.ibm.com>
        <20191001154208.GB3523275@kroah.com> <yq1tv8stj87.fsf@oracle.com>
        <c0a921a4-f529-03cd-b39c-24c5f25f8b44@linux.ibm.com>
Date: Thu, 03 Oct 2019 21:47:50 -0400
In-Reply-To: <c0a921a4-f529-03cd-b39c-24c5f25f8b44@linux.ibm.com> (Steffen
        Maier's message of "Wed, 2 Oct 2019 10:31:01 +0200")
Message-ID: <yq1pnjds2m1.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Greg KH <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, stable@vger.kernel.org


Steffen,

>> Why not just shut FCP down unconditionally on excessive bit errors?
>> What's the benefit of allowing things to continue? Are you hoping things
>> will eventually recover in a single-path scenario?
>
> Experience told me that there will be an unforeseen end user scenario
> where I need a quick switch to let even shaky paths survive.

Can't say I like it. But it's your driver.

Applied to 5.4/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
