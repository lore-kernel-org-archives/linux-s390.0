Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:51768 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbfJAS1B (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Oct 2019 14:27:01 -0400
Subject: Re: [PATCH v2] zfcp: fix reaction on bit error theshold notification with adapter close
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <yq1d0fhw2ex.fsf@oracle.com>
        <20191001104949.42810-1-maier@linux.ibm.com>
        <20191001141408.GB3129841@kroah.com>
        <71b8fc68-23a8-a591-1018-f290d6e3312a@linux.ibm.com>
        <20191001154208.GB3523275@kroah.com>
Date: Tue, 01 Oct 2019 14:26:48 -0400
In-Reply-To: <20191001154208.GB3523275@kroah.com> (Greg KH's message of "Tue,
        1 Oct 2019 17:42:08 +0200")
Message-ID: <yq1tv8stj87.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steffen Maier <maier@linux.ibm.com>, "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, stable@vger.kernel.org


Greg,

> Ok, then why make this a module option that you will have to support
> for the next 20+ years anyway if you feel this fix is the correct way
> that it should be done instead?

I agree.

Why not just shut FCP down unconditionally on excessive bit errors?
What's the benefit of allowing things to continue? Are you hoping things
will eventually recover in a single-path scenario?

-- 
Martin K. Petersen	Oracle Linux Engineering
