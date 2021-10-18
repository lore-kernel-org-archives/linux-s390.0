Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CA1C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF5961212
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 18:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhJRSd1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:33:27 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:48730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229696AbhJRSd0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Oct 2021 14:33:26 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 14:33:26 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 571A518028B7E
        for <linux-s390@vger.kernel.org>; Mon, 18 Oct 2021 18:22:36 +0000 (UTC)
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 50382181D68DB;
        Mon, 18 Oct 2021 18:22:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id ABD3A20A297;
        Mon, 18 Oct 2021 18:22:32 +0000 (UTC)
Message-ID: <fae1a43259879b797bb13ac8dcc2579246977b2e.camel@perches.com>
Subject: Re: [PATCH] s390: replace snprintf in show functions with
 sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Qing Wang <wangqing@vivo.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2b1b939e1ea960c2268791f3007305955a70a90f.camel@linux.ibm.com>
References: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
         <2b1b939e1ea960c2268791f3007305955a70a90f.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Mon, 18 Oct 2021 07:20:39 -0700
User-Agent: Evolution 3.40.4-1 
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: ABD3A20A297
X-Stat-Signature: k6gtg8qg4bm3f9b6ixg5bdepsjia3h5w
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+E0FhiHCg+F/OTIuiyA/MW2dW4ngF7I84=
X-HE-Tag: 1634581352-566392
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 2021-10-18 at 13:50 +0200, Vineeth Vijayan wrote:
> Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>  
[]
> On Thu, 2021-10-14 at 23:50 -0700, Qing Wang wrote:
> > show() must not use snprintf() when formatting the value to be
> > returned to user space.
[]
> > diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
[]
> > @@ -731,7 +731,7 @@ static ssize_t dasd_ff_show(struct device *dev,
[]
> > -	return snprintf(buf, PAGE_SIZE, ff_flag ? "1\n" : "0\n");
> > +	return sysfs_emit(buf, ff_flag ? "1\n" : "0\n");

It's more common to use

	return sysfs_emit(buf, "%d\n", ff_flag);

> > @@ -773,7 +773,7 @@ dasd_ro_show(struct device *dev, struct
[]
> > -	return snprintf(buf, PAGE_SIZE, ro_flag ? "1\n" : "0\n");
> > +	return sysfs_emit(buf, ro_flag ? "1\n" : "0\n");

etc...


