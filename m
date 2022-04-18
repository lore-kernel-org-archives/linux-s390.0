Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB20DC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 08:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiDRIFB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 04:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbiDRIE5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 04:04:57 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A91928C
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650268937; x=1681804937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OmPuKz2YWA8zfnI8UisdXu/UB5gIbMI/eeJtu4mrOgE=;
  b=BrAlzaIG4nRPyxn/oTfPVYR8bEn7B0mzNMk1qKd8F2HB/kzjNaP8qwls
   2y5FYGiuaeIWuxr9NXvzxaWMr3sbpXdM4qjIc8qehvkUiPLx/+0vVL5BF
   o9wPvylrwc1P81EzYTzMZynKlcoQE6VkW5A13GEcwa3l6EgBNaFTZf7p/
   fDH7geoCZeOkK0ckYN2pbY/iBm3W+KV5vhklVRf/4Mw7kErHzto7Qk6KT
   l1gkOp5BX1XW1dNqHVcwoSATp/9yzmNhpWD7JC95mccHutzZ1SdtsXc2O
   4zcw2kbCA5DE4KX6agu+E2D0jpSQ0uOvD5aLrbNyaxkt0lDjXd3XmtLXX
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="310120096"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:02:17 +0800
IronPort-SDR: Az/1O0L8xm5fsaYtSwH5ET8OWmp0kNYDYt+P5+SdHkTuxYKx7Csaj1GoT9NbiKAyLuvZnxTjME
 CtcLnlrDkin7BNmeYSYQyDb7uarv0lTEYZ9+Xbkt51XUif+WSh5AuWAc5IpW/LtLc0mzqOn+zv
 rLTEtnY5WvgHiTBDJoD6dfhrrIg/aDfxhGLkJQbqsZRJbMgns0yy3AvRsodRytKCw449t7yfZI
 LsAHMbS5kEJH51Cjr6kgI5cxsr45+OE0B1UTTLel9F5HmbpD0GDEzZn1DmiPmYDYEtt8BkLUyR
 yFY3hwXCfiqRdgFdfn0APANJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 00:33:26 -0700
IronPort-SDR: 8b4YnCkBNv0bs6Se/j33kIC3UsN55e9PY7JI61k3PYlrDupX/K9RDEDFKeRAAxOXHjFOvTDD4P
 eXyi4c/OsZFoaEVEnqRkjfGCYFrvh8sQIinlQQPkzLMO+Y2/yLeUFFYXwR2efjr5vco4eVvqnT
 oy2lvhknzy+n2lEKYkCTcvgsNOdrXnrMSxR03LoaSJRg967cM/v5FHgv1UmwJCiT12iGGyfSkP
 VsE+ojmm/bnzRnFOaHBHxFwnH0mtbe/zmjOb1sjNWCmhnLZ0tShWy6ua2zJgXDinA5k4PVIvYa
 T6U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 01:02:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfY66c0Wz1SHwl
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:02:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650268937; x=1652860938; bh=OmPuKz2YWA8zfnI8UisdXu/UB5gIbMI/eeJ
        tu4mrOgE=; b=iq/DZtxIsH78J5+wxR20C/juR8srBcWxSV3ywtDv3tYOwTkL3uf
        A4HxBcRKotnvWTD1KOdCakjP9CBAMXOHFJQO+gW4W6NrXUdaQZyeATpC3vgDmC2/
        b6aR8MWIxQbBtWd1k4bmN29Kj9j2x8zQll9Nsvat1LryPuatUaKeqt6IZHWw7oia
        bqBLagLvqtOUd2viud2b+TaA8azo8Z+FIKRDbpTaA5wl7IVqak3jDSz781qRatoX
        CTPLw/8uTXPPOE41sDbbehCUr8tIW9Z/uhgJpZu1tDB8tDKbjkbWp6PdcoxYla18
        GMXcdKSGpAk9WAmZJwmUHgxuVE+HqnZ5TbA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oQHZ5OpT6dmb for <linux-s390@vger.kernel.org>;
        Mon, 18 Apr 2022 01:02:17 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfY24GYPz1Rvlx;
        Mon, 18 Apr 2022 01:02:14 -0700 (PDT)
Message-ID: <cd77bfd9-e133-1929-2d61-73822ad95366@opensource.wdc.com>
Date:   Mon, 18 Apr 2022 17:02:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 09/11] nvme: remove a spurious clear of
 discard_alignment
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
 <20220418045314.360785-10-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/18/22 13:53, Christoph Hellwig wrote:
> The nvme driver never sets a discard_alignment, so it also doens't need
> to clear it to zero.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b9b0fbde97c80..76a9ccd5d064a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1628,7 +1628,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
>  			NVME_DSM_MAX_RANGES);
>  
> -	queue->limits.discard_alignment = 0;
>  	queue->limits.discard_granularity = size;
>  
>  	/* If discard is already enabled, don't reset queue limits */

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
