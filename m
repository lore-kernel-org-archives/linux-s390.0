Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D61BC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 18 Apr 2022 08:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiDRIF3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Apr 2022 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiDRIF2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 04:05:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A991928C
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650268970; x=1681804970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MERTNbn4AhK74X7Db7lDnICPdc+nuPVKeYAvKUf3y7M=;
  b=LjPWW5GmPSguUVaOLNOWbklQDNJrSPkOpkE8/J6/gH2xewysV0dWjsE3
   z+r+1u6Pcl6loZbYeHmrXfLl+N1M7iiOhjJtN4hoa8GPtAjgXS3GjTsmT
   WwtfFQTLPI3SCxkG0AHVakiVt5UDmzcUSztLHIpzsESxmse8QaWJkAw3V
   jj3HQKcb7TKRdTInmtsoRzy8/lKSO3zKpMzukHuvmPy0sSJFTGNncskLz
   X9h7EKZiXNq4iQ4QVN+CnkXM2FyuLh/6foGo1ZfCZ88J2vlFXqmvc/Brb
   8DvYLz5l5fEZSwlwUo04XgDktXWTTXZDKuA+uPSbnilOcz9NyN3oUNeTj
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="198150228"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:02:47 +0800
IronPort-SDR: RWEkhNj7/4VnxZ2kWgVwUX5v6whhcy+8TjbcML5X/rayJBzrs+4KYmpEKRxrub3tapzLfI2H0x
 gDt6GoIj2+XkRN5cyGwq3sCPnQCEvzTjdGYNW7vNx9Wy6Af1seWUqf0e8aGVnRmhJ0b2GqiSOl
 pePHmG8ISZCNix1LJJ1R9CflRtTSPnr4urAWgXMzECrLW5jrJ2L+eRR+zcoFx643FqJ4pUFvEV
 2fd75yJc6h2PuRxf4h8LtdcPr2GLslvWBCVf5acLNyQVn818UudbzaJySV0LtQFFvPKD3LU1lU
 Gqaa07uh9PaFRetCck+nP+H7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 00:33:08 -0700
IronPort-SDR: Hq/eMLxrgXlx/+cU1C95WmN2al473Vqb+76bBAdf//9h+m0JoZbgtm2fRXjYj8YE5k9y3WsZZS
 aQnDXusB03xqzHLtKv8V08Xxy7g6dncWAjrfSMWxQZEJWnlOyVmLWLr6zKlmQhMgedR4e6JHkh
 asN5cAL29jiBAmU0Dr46jQMAerKilfsPZpPbCLdO8Wg0t8JkjA4eOUe9Fda2SO/fr9zcznbIUp
 RrE4o7IFXorqmznNHnrSVI8wVP7g67spFZUmyKl0KFbarYqu0rMc7qp9gLJ/T+U9pkw/aKTLR3
 K3Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 01:02:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfYg1Q5nz1SVpC
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 01:02:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650268966; x=1652860967; bh=MERTNbn4AhK74X7Db7lDnICPdc+nuPVKeYA
        vKUf3y7M=; b=maQuzRZ/p1t712qIY+IhTpqcG/pQm05duyWvErv19vVeNzSmghD
        V4UuT2NV8F1UHjPSFwamLFQzH0XOoOisHdD5+ADyIjpRhXJPPl5hYhdFZR4R3yn2
        vTW1rZBntXlrodM4xw/I5C7zh7jqW/1gkWMPa3JzW2mwGm1TfLpwL9s7bmvPqTHL
        AfCw9bTeUQ4nuJGbirW25tkuQc/GVk+wNgRm9VpyFwcn0iHRVCCSn/lEXHWhxPHO
        KFbkC86QG+PviD2uM16wutWPiPD0SXUHyCsj7Zbgqnz3gff3TOmOT2Wu5Xp0PjTz
        AO6u+oKpxJEkPaiLyjsLleOyU/qelBVlYrg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jj-NaEEcw24W for <linux-s390@vger.kernel.org>;
        Mon, 18 Apr 2022 01:02:46 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfYZ5jVFz1Rwrw;
        Mon, 18 Apr 2022 01:02:42 -0700 (PDT)
Message-ID: <1cef25df-b00d-4590-5598-555c5d97d1c1@opensource.wdc.com>
Date:   Mon, 18 Apr 2022 17:02:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 10/11] rnbd-srv: use bdev_discard_alignment
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
 <20220418045314.360785-11-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/18/22 13:53, Christoph Hellwig wrote:
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rnbd/rnbd-srv-dev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index d080a0de59225..4309e52524691 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -59,7 +59,7 @@ static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
>  
>  static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
>  {
> -	return bdev_get_queue(dev->bdev)->limits.discard_alignment;
> +	return bdev_discard_alignment(dev->bdev);
>  }
>  
>  #endif /* RNBD_SRV_DEV_H */

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
