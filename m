Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727474AbfJBIbI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 04:31:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x928RSDG184377
        for <linux-s390@vger.kernel.org>; Wed, 2 Oct 2019 04:31:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcr2vgpce-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 04:31:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 2 Oct 2019 09:31:05 +0100
Subject: Re: [PATCH v2] zfcp: fix reaction on bit error theshold notification
 with adapter close
References: <yq1d0fhw2ex.fsf@oracle.com>
 <20191001104949.42810-1-maier@linux.ibm.com>
 <20191001141408.GB3129841@kroah.com>
 <71b8fc68-23a8-a591-1018-f290d6e3312a@linux.ibm.com>
 <20191001154208.GB3523275@kroah.com> <yq1tv8stj87.fsf@oracle.com>
From: Steffen Maier <maier@linux.ibm.com>
Date: Wed, 2 Oct 2019 10:31:01 +0200
MIME-Version: 1.0
In-Reply-To: <yq1tv8stj87.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c0a921a4-f529-03cd-b39c-24c5f25f8b44@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, stable@vger.kernel.org

On 10/1/19 8:26 PM, Martin K. Petersen wrote:
>> Ok, then why make this a module option that you will have to support
>> for the next 20+ years anyway if you feel this fix is the correct way
>> that it should be done instead?
> 
> I agree.
> 
> Why not just shut FCP down unconditionally on excessive bit errors?
> What's the benefit of allowing things to continue? Are you hoping things
> will eventually recover in a single-path scenario?

Experience told me that there will be an unforeseen end user scenario where I 
need a quick switch to let even shaky paths survive.


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
