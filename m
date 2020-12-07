Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgLGUVh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 15:21:37 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A194C061749
        for <linux-s390@vger.kernel.org>; Mon,  7 Dec 2020 12:20:57 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k8so13437606ilr.4
        for <linux-s390@vger.kernel.org>; Mon, 07 Dec 2020 12:20:57 -0800 (PST)
Subject: Re: store a pointer to the block_device in struct bio (again)
References: <20201201165424.2030647-1-hch@lst.de>
 <920899710c9e8dcce16e561c6d832e4e9c03cd73.camel@redhat.com>
 <20201207190149.GA22524@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ed7a484d-91d5-50fa-7927-2703b9426d65@kernel.dk>
Date: Mon, 7 Dec 2020 13:20:53 -0700
MIME-Version: 1.0
In-Reply-To: <20201207190149.GA22524@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Qian Cai <qcai@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>

On 12/7/20 12:01 PM, Christoph Hellwig wrote:
> Thanks for the report.
> 
> Jens, can you revert the series for now?  I think waiting any longer
> with a report like this is not helpful.  I'll look into it with
> Qian in the meantime.

Agree, I reverted it.

-- 
Jens Axboe
