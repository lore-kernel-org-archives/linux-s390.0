Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfIZLBB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Sep 2019 07:01:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8QAwpmO088887
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 07:01:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8sxx6rfc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 07:01:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 26 Sep 2019 12:00:58 +0100
Subject: Re: [PATCH] zfcp: fix reaction on bit error theshold notification
 with adapter close
References: <20190924160616.15301-1-maier@linux.ibm.com>
 <20190925224305.00183208C3@mail.kernel.org>
From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 26 Sep 2019 13:00:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190925224305.00183208C3@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <77d90d91-68a3-187e-7d5a-114f02a05dea@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>

On 9/26/19 12:43 AM, Sasha Levin wrote:
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 1da177e4c3f4 Linux-2.6.12-rc2.
> 
> The bot has tested the following trees: v5.3.1, v5.2.17, v4.19.75, v4.14.146, v4.9.194, v4.4.194.
> 
> v5.3.1: Build OK!
> v5.2.17: Build OK!
> v4.19.75: Build OK!
> v4.14.146: Failed to apply! Possible dependencies:
>      75492a51568b ("s390/scsi: Convert timers to use timer_setup()")
> 
> v4.9.194: Failed to apply! Possible dependencies:
>      75492a51568b ("s390/scsi: Convert timers to use timer_setup()")
>      bc46427e807e ("scsi: zfcp: use setup_timer instead of init_timer")
> 
> v4.4.194: Failed to apply! Possible dependencies:
>      75492a51568b ("s390/scsi: Convert timers to use timer_setup()")
>      bc46427e807e ("scsi: zfcp: use setup_timer instead of init_timer")
> 
> 
> NOTE: The patch will not be queued to stable trees until it is upstream.
> 
> How should we proceed with this patch?

It's sufficient to have the fix in those more recent stable trees where it 
applies (and builds). My fixes tag formally indicates since when it was at 
least broken but I don't expect all stable or longterm kernels to get the fix. 
If I happen to find out we need the fix in a kernel where it does not apply, 
I'll send a backport to stable when the time is right.


Showing the possible dependencies is awesome!


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
