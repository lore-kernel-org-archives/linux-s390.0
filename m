Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx.sdf.org ([205.166.94.20]:55263 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgCaTHm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Mar 2020 15:07:42 -0400
Date: Tue, 31 Mar 2020 19:04:48 +0000
From: George Spelvin <lkml@SDF.ORG>
Subject: Re: [RFC PATCH v1 27/50] drivers/s390/scsi/zcsp_fc.c: Use
 prandom_u32_max() for backoff
Message-ID: <20200331190448.GB9912@SDF.ORG>
References: <202003281643.02SGhHN7015213@sdf.org>
 <20200331161321.GB17507@t480-pf1aa2c2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331161321.GB17507@t480-pf1aa2c2>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, lkml@sdf.org

On Tue, Mar 31, 2020 at 06:13:21PM +0200, Benjamin Block wrote:
> it would be nice, if you could address the mails to the
> driver-maintainers (`scripts/get_maintainer.pl drivers/s390/scsi/zfcp_fc.c`
> will tell you that this is me and Steffen); I'd certainly have noticed
> it earlier then :-).

How the $%$# did I mess that up?  I know choosing recipients for
this series was mostly manual, becase it didn't fit the usual
pattern of the entire series going to everyone affectrd by any part
of it.

And then there waqs a whole lot of shuffling things into a logical
order and grouping.

But I checked MAINTAINERS originally, I really did.  :-(

> On Fri, Nov 29, 2019 at 03:39:41PM -0500, George Spelvin wrote:
>> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
>> index b018b61bd168e..d24cafe02708f 100644
>> --- a/drivers/s390/scsi/zfcp_fc.c
>> +++ b/drivers/s390/scsi/zfcp_fc.c
>> @@ -48,7 +48,7 @@ unsigned int zfcp_fc_port_scan_backoff(void)
>>  {
>>  	if (!port_scan_backoff)
>>  		return 0;
>> -	return get_random_int() % port_scan_backoff;
>> +	return prandom_u32_max(port_scan_backoff);
> 
> I think the change is fine. You are right, we don't need a crypto nonce
> here.
> 
> I think I'd let the zero-check stand as is, because the internal
> behaviour of prandom_u32_max() is, as you say, undocumented. This is not
> a performance critical code-path for us anyway.

I agree.  Sorry, that comment in the commit message was a bit of
a "not to self" that I didn't clean up.  Feel free to rm it when
queueing if you like.

> Steffen, do you have any objections? Otherwise I can queue this up -
> minus the somewhat mangled subject - for when we send something next time.

Thank you, I'll put it in my "accepted" pile.
