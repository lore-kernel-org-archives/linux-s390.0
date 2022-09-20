Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F27ECAAD8
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 07:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiITH17 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiITH17 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 03:27:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A43108D
        for <linux-s390@vger.kernel.org>; Tue, 20 Sep 2022 00:27:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 751FC68AFE; Tue, 20 Sep 2022 09:27:55 +0200 (CEST)
Date:   Tue, 20 Sep 2022 09:27:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: RFC: dasd: use blk_mq_alloc_disk
Message-ID: <20220920072755.GA18172@lst.de>
References: <20220721133251.1878402-1-hch@lst.de> <244e66a5-2a81-2275-e97d-ebe3186ccebb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <244e66a5-2a81-2275-e97d-ebe3186ccebb@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 26, 2022 at 12:58:16PM +0200, Stefan Haberland wrote:
> Am 21.07.22 um 15:32 schrieb Christoph Hellwig:
>> As far as I can tell there is no need for the staged setup in
>> dasd, so allocate the tagset and the disk with the queue in
>> dasd_gendisk_alloc.
>>
>> Warning: untested due to a lack of hardware.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Thanks for the patch. From a first quick look it looks reasonable.
> I will give it a try on my test machine.

Did you get a chance to look into it?
