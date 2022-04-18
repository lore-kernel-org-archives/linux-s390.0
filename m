Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB017C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 08:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiDRIDq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 04:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiDRIDp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 04:03:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96E8DF76
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650268865; x=1681804865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3/KeY74fCa89/HKmeQeN7bAvF9g3Fcpr0R9Z+15MzFA=;
  b=dfk9ylDwPt40mXcPpIJiyRAQUat6xObweJpI0jSAI/+meBW/k/TiTrXv
   iIeJJMo/4OOtOxbBJrbBy5CGFjmdT1CmyhMcaM/CkCQyyeHnMx4N5BwNC
   aqC4UuADbgx4nN+0jToIuqrYARiLSSI8YqRSUcu0PJLP0rPM605cL27Iq
   mVttnpYB86WDtDBFB1e7rYXb2NvqWGmWCN070xC7DkQxXCpVKKN9D49jp
   by7OlMQWKre9yrY/eKA1oNRackVpNaxbAEsRnRSKrnIbGlH3uaZp31G+6
   /6baJ9G5c1nISGksXw31BlvWFX4Ns2ApIz4CqfNPRSkf676eiB5krOiF0
   g==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="310119964"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:01:04 +0800
IronPort-SDR: z5ICaR1ERoJpqFj0WzCRM488oPcaUrQofCXA/H8lVqT7DBVLmFT8Y5JX6QrpO7ou7hdHica0oG
 MABzNwJY2t5xLTus+PSaJVpmiMDLyJ/iqm91gqq+00oMycwmkMFDekAaz46zhm3sjB1j0GSUqz
 d5ipyqE8RdiooRneA/o0JgqHYsVOdXeqmKy1vfSyhsiwfXUijktX5wwJKq1JMFZ7GjRxNvTlQC
 Mu5i22zWlimg8w8PxD0oSgWPayZKSfY18DGk5DFheceFp6Bds7Af1e2oGucQZBMYJRpha5c0CS
 wLOt7kVADdSzDRfLTB9tUHbH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 00:31:27 -0700
IronPort-SDR: JGG/qcluxWl0i6RN4QYyJuRofzcCPj2knOM66VxMZ47kbytBCU7QO8siQUBeavN5DxRSJ6X9LQ
 1ffPwF992mZRh+mBJIfxcRVhxMvM+bbIxDKgNjZcF/Er2EUOs4IfbZS1FQJ13/cWyJuX/VLaIY
 CW5XDa6Nge9g6Rkmo4IQURbm+TixzYtgDo1INBFJlgpA346t4H4wO07nuHRI1lc4LXWLC1lqnv
 smoL4TQRH29H055ji6UIlclu7L93b296aFNXx8K9DmhHf3quRpW0T9RklGtwnk7lJIXMCuHABY
 VY8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 01:01:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfWj4sv1z1SVp8
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:01:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650268864; x=1652860865; bh=3/KeY74fCa89/HKmeQeN7bAvF9g3Fcpr0R9
        Z+15MzFA=; b=RIA+H92HNPzO4gWSeMVoqSWT3m10rBKmlLQcVEyCT9Rid+o1KlV
        iqV2xUypq2hDG/V8+vod3GcZtiyWFYkzYA2YHoTyC2BIJE5k41aqBGin/fd1TZ/M
        b3+meMBaDqT3CBOEkN4Dr3xrqtXr8bCAOS1SaCim+QrPo47IHpeoOFz8wKR5cl/D
        fK8/F9+hBEendDrUaP6UYa6QADixsBuszVbfs+uTK8Xu2BiLh3viWdBB/rO1zH6b
        GQbc1dCPmhvl/dHQXgJxs/XwFf43p3Vpekh27O0opPRrekskDKSmIKghQQKDVaXj
        krlHvgQVnrfyY2BhYOMFK2yeTZa3G6VdKyA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b1kjcNuzSCX9 for <linux-s390@vger.kernel.org>;
        Mon, 18 Apr 2022 01:01:04 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfWd1wHlz1Rvlx;
        Mon, 18 Apr 2022 01:01:01 -0700 (PDT)
Message-ID: <fb5baf81-fa19-bb48-865c-e13277a0952a@opensource.wdc.com>
Date:   Mon, 18 Apr 2022 17:01:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 03/11] null_blk: don't set the
 discard_alignment queue limit
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Song Liu <song@kernel.org>, dm-devel@redhat.com,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, linux-s390@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        xen-devel@lists.xenproject.org, linux-um@lists.infradead.org,
        Mike Snitzer <snitzer@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
        linux-block@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
        linux-raid@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-4-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/18/22 13:53, Christoph Hellwig wrote:
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by null_blk is mostly
> harmless but also useless.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/null_blk/main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 5cb4c92cdffea..a521e914a9843 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1765,7 +1765,6 @@ static void null_config_discard(struct nullb *nullb)
>  	}
>  
>  	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
> -	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
>  	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
>  }
>  

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
