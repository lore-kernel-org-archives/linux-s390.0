Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D2FC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 08:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiDRIG1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiDRIG0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 04:06:26 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E2119291
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650269027; x=1681805027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rst7WZOXaJnTOprfWYkoaRENgax/3SjcG41/Nf0ZaiQ=;
  b=VRmMwKTizmJzha4qWT5ATLf18qITazrbJhuIvMhghq11z56t53l/xaf0
   pcG75CxQbUJqcrI0v4YB2i9dUgrYrTzNlqB9SdxHQqbm8qjrMKO266WlE
   rGuHg5e3YKGi9OomOXpjFBZor7PS3bpCXrPcXcNAD61IxLOL+gjHgIA0D
   D5Md+inZdNCtkxt/+y+l2+1SJ1uQSkch4MXeFUdQTkvi4GRVxeoUddK/I
   l5qmpCaMLoGI3sKlAHBBfd/JD8pdQp10H71ZrfaBQeIRwR6IMgwOAwCzh
   TN9uiwXQv6CuDlNleYYzVieFCJtr2m+V1kPkfBBOrd6EX7Df94jbu9+WU
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="203014637"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:03:46 +0800
IronPort-SDR: prwCWi5cLlHzAz4b0VzJAAvjeG4imBphlotwfig3z66tnclpG3Sr3BBY4E6nEjeKHLFARsKdPp
 UylMd2sokWA72ViigMkO5iOSTOuS1aukeVbZrHGtOnbz+NVz7RtZzesjA7KS4F4bkq28fjpbS4
 SAd8VlWWoDW3EyU0qn3jLw60qpO5FNx1X+UhwexbLAz0aqWVjegGRlDrHw1Izxkwr3H2nP7yd/
 iyGgiO8y/FGhcJr0h/2p5Kc+JIiNLgqO+5sicpIYRlEs9ZUHoFVpqF8LGACrrnr3L4PleuDDqY
 aAbFnkAc6AxUiSUQHq5U53EZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 00:34:04 -0700
IronPort-SDR: mJOmngETZBPJKy04Qn7odxlbyUsLaNCu/QI5vzzJLAxsWLlZRSuFR6FA4+ebpLf6F7GIuMzmjx
 JkeIteIUAlUr9hNlHRqoYRRyDxQOvWkBdKyXlPI8U12A5uwjvwSo+HOwWE0ZotlhkJyGIHCSnj
 f4sCuZrfP9veHLFK7qvOg7oUvnx4bIeb1EihGspL4kXXKLqZD8beXGToO6J4OjlAxAwy4scPK+
 raGXT8vg+BqDUaav6MVBuE9ss+clOkGy56c3dPaiPC4Z8of9vpO+B3+y3ai3A6owFPZLiDqv3L
 Ljk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 01:03:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfZl41pYz1SVp2
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:03:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650269022; x=1652861023; bh=rst7WZOXaJnTOprfWYkoaRENgax/3SjcG41
        /Nf0ZaiQ=; b=k/wWzmmm2mZiM/ewBYvITJF4lq6rUDh2cOF7medHWCRms6ali4K
        cmsUMPnv+11ke+dcJMqdHi78/nHqy7qP8KSBVECU/14iKM2QiwMZ5RSyv3w8qT7S
        xlveFRxheMNhYX6ukLpVSJjx7rJm1hUviNx0vdLPyHXo9hRa3+JS30WcAvz31Pdj
        REkM1jfEzC/yE6LWYc1GnErshn9kE3jwbU3zXmWIjE2FGZwQcw8k8zOw/wl74Ik/
        4p11eeyi0wRjJXJE9DwwkghyuPjiZnJUMe5TVmPA4z2xIF/G5tJciClJzAeXlh6d
        O8hZxw8UZiDqrwR15XLejWpz4dbpVOf4kAw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vS0kKOKjuVvt for <linux-s390@vger.kernel.org>;
        Mon, 18 Apr 2022 01:03:42 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfZg2dWsz1Rvlx;
        Mon, 18 Apr 2022 01:03:39 -0700 (PDT)
Message-ID: <034efb57-9e1d-41ed-1855-e2b057b03ea7@opensource.wdc.com>
Date:   Mon, 18 Apr 2022 17:03:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 11/11] xen-blkback: use bdev_discard_alignment
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
 <20220418045314.360785-12-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/18/22 13:53, Christoph Hellwig wrote:
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
> 
> Also switch to use bdev_discard_granularity to get rid of the last direct
> queue reference in xen_blkbk_discard.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/xen-blkback/xenbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index b21bffc9c50bc..04c90cb8955f6 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -583,14 +583,14 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
>  	if (bdev_max_discard_sectors(bdev)) {
>  		err = xenbus_printf(xbt, dev->nodename,
>  			"discard-granularity", "%u",
> -			q->limits.discard_granularity);
> +			bdev_discard_granularity(bdev));
>  		if (err) {
>  			dev_warn(&dev->dev, "writing discard-granularity (%d)", err);
>  			return;
>  		}
>  		err = xenbus_printf(xbt, dev->nodename,
>  			"discard-alignment", "%u",
> -			q->limits.discard_alignment);
> +			bdev_discard_alignment(bdev));
>  		if (err) {
>  			dev_warn(&dev->dev, "writing discard-alignment (%d)", err);
>  			return;

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
