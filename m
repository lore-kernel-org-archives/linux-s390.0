Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B442C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiDRIHB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiDRIG7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 04:06:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974A1928C
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650269061; x=1681805061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rpofyDUALxK7dXMfprZ48DmzWqCt1/MYuoJj74ZUCIU=;
  b=KtUkPCdM4MEBk2FgdZ8qXPA8wxD6ecg+nVbMHWmWynr4bln4tzg24nhB
   AcIwJH62hJ0dCzs8YIV15KYMwKvLfBm1sist8rDJwkG8da3G5FShMKcrJ
   1683lJTsPpDY03D9HE8RDBO4fCvNjr4N/ywHXI0vx4fAm3I6tgymIoKwf
   ACh2dCdIMMWzdLbhzBmup+hm9W4+PMRFwRIihpfjzpg8YvpuBWDjfQ4yK
   M/3lNyQjMlNCmtEn/cN08j7xpjqNhNz6L4eFmcIAKMe1YkDxrY29xiVpD
   hsP/W1no806TIXIxG6ofcZ+GzR17jrCLR7rAB3yqsGbq/TfHEIab/z9DB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="302341878"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:04:20 +0800
IronPort-SDR: vxXnx5B2/vw3GhIqYdfzundGxw8+/plDbkZXMvbpJIVII6SDJ11ge5nZa7eJ+pNQLQWV0uXe15
 MUJImb+cp2sWHagPcHMhOLQ6jzfw06zOzjVu8WfX9vjMMz39Zui1iwmNO8YX/sgYY+i7Tt3oe4
 Hi/1gSaiZBGbuiMbasX3QkwoXx3dzBWT7V+3E9567B8JBXsb1ZyQSJXHQs99t/ithneIUbWlZX
 VBnrIJza3HkKYh+92gExEh7xfH4Xa30YczJ5ZxnMf4M9oyFOqzdWVaX3YcMnTLewlVNlDpf5D/
 voJI00CzVkqSAuejoS2wjlE3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 00:35:24 -0700
IronPort-SDR: HPlEgVK4DfrOh3UVK9HlUR6eZIFLGBYhlScoszLGYkexMrrsKsD1NkEXyLIbEwS0DoTvWbqF56
 5LDe+gD70nhXgXDe2tGdD5fIp+ocJIafP30kenicHoMHEELspJUEmsTmypGFdh5e2FY5YogGJn
 6DOAKn9qYdydre/KY2B84SQHyE0/q3jSuut3NdStl9hwNDTVGZllMxwTucat55FLjvjKdPSqg2
 QimqXX1Udf5Qe2/JOZD2Y/q/jal9uT77K8vp4WH4TPWcSwLv8VWC53eaSoX5YmwutDJqOOGVRI
 MT0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 01:04:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfbP1Y2Pz1SVp0
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:04:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650269056; x=1652861057; bh=rpofyDUALxK7dXMfprZ48DmzWqCt1/MYuoJ
        j74ZUCIU=; b=Ipq2PwOMV6FMZnNHjzfOvCDO/eCvkHdBynAyRqHT0JYbL8aPJHg
        lk8/9NE8bxun2r7t0MS14013lawVGOzmf/X3f+8Ic4AvpnDkmhKMyefb2r7esi8c
        DPsaxfOdnQoK+7d4vOoATpt13x1/UJ8S/DPnmNBBwT32S9G+Wy2AQLrr3B49RYi+
        aLZinYUF9RJ+4lF/gqbzoQ5jz3HTqFiUmYZWkVzKfH36FzrmlF6gE6Ej5wqCOTd4
        pLzwGmboJ+p18OsmI93m/uKn1qd+a7S0N7bV75aqhYJOgfIIfT23fOLfPAhxUFLH
        ZzG5axr0DZzGRMD/V2vUJVApf7rh+IIODDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2T1JPga9fZZB for <linux-s390@vger.kernel.org>;
        Mon, 18 Apr 2022 01:04:16 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfbJ6g7Wz1Rwrw;
        Mon, 18 Apr 2022 01:04:12 -0700 (PDT)
Message-ID: <18032025-f1aa-2daa-d012-8996590ada6a@opensource.wdc.com>
Date:   Mon, 18 Apr 2022 17:04:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 08/11] loop: remove a spurious clear of
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
 <20220418045314.360785-9-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/18/22 13:53, Christoph Hellwig wrote:
> The loop driver never sets a discard_alignment, so it also doens't need
> to clear it to zero.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 976cf987b3920..61b642b966a08 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -789,7 +789,6 @@ static void loop_config_discard(struct loop_device *lo)
>  		blk_queue_max_discard_sectors(q, 0);
>  		blk_queue_max_write_zeroes_sectors(q, 0);
>  	}
> -	q->limits.discard_alignment = 0;
>  }
>  
>  struct loop_worker {

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
