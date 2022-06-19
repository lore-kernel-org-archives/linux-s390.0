Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D0AC433EF
	for <linux-s390@archiver.kernel.org>; Sun, 19 Jun 2022 07:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiFSHnF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 19 Jun 2022 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiFSHnC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 19 Jun 2022 03:43:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EACD10EA;
        Sun, 19 Jun 2022 00:43:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C513967373; Sun, 19 Jun 2022 09:42:57 +0200 (CEST)
Date:   Sun, 19 Jun 2022 09:42:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org, Neo Jia <cjia@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>,
        Dheeraj Nigam <dnigam@nvidia.com>
Subject: Re: [PATCH 03/13] vfio/mdev: simplify mdev_type handling
Message-ID: <20220619074257.GA27867@lst.de>
References: <20220614045428.278494-1-hch@lst.de> <20220614045428.278494-4-hch@lst.de> <6900fbd9-5f12-e53d-1a57-d9671491372b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6900fbd9-5f12-e53d-1a57-d9671491372b@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 16, 2022 at 01:25:25AM +0530, Kirti Wankhede wrote:
>> +	parent->mdev_types_kset = kset_create_and_add("mdev_supported_types",
>> +					       NULL, &parent->dev->kobj);
>> +	if (!parent->mdev_types_kset)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < nr_types; i++) {
>> +		ret = mdev_type_add(parent, types[i]);
>> +		if (ret)
>> +			break;
>> +	}
>
> Above code should be in parent_create_sysfs_files(), all sysfs related 
> stuff should be placed in mdev_sysfs.c

Yes, it could. But why?  This is core logic of the interface and has
nothing to do with sysfs.
