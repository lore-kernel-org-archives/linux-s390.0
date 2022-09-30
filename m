Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0DDC4332F
	for <linux-s390@archiver.kernel.org>; Fri, 30 Sep 2022 21:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiI3Vb6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiI3Vb5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 30 Sep 2022 17:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404EE18CB3D
        for <linux-s390@vger.kernel.org>; Fri, 30 Sep 2022 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664573512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u99SFb2mm6IMO2C/mDjsVShY7ib8HgVHNq4m7TjUMlU=;
        b=is4Ec/N7Y2KZFLY5ROYxSVIlxZXpyWG1DB3xBBkpjx9MKPrBifwjC+NbAXZwljo7ID5HLI
        jKpsIBs5Ws8RAqJ6daIG1YCfmlIak7N6rH9USOZKZsna3yYio+WFbuQurKDPLEk4CQllAc
        simcdXY4+n/dxg8G+zcC+X/rTQeqv+w=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-nxmiZkYYNYaoFIY6_Mg54Q-1; Fri, 30 Sep 2022 17:31:51 -0400
X-MC-Unique: nxmiZkYYNYaoFIY6_Mg54Q-1
Received: by mail-il1-f200.google.com with SMTP id x6-20020a056e021bc600b002f8c7ccd2c4so4316580ilv.17
        for <linux-s390@vger.kernel.org>; Fri, 30 Sep 2022 14:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=u99SFb2mm6IMO2C/mDjsVShY7ib8HgVHNq4m7TjUMlU=;
        b=q5q08mQ0rqsxytlHUbzy9tHVcbO6dvoLmAE9i6cCXkKXB7YZh4E/5fPgCnwxhBbCM/
         TqWP2c0J8iu93TwyzMTWp8jgR32BCAWGK5jHmBipNcvr5j0+Kf9vvyOsD2IfMJcFhE51
         cGDi8MrIcsd79RAaTvgdh1PMhDUkd3fWqgB4pcTymrQzyzw/kyjvVXewOtNf7Cq/s0Cg
         pzll7RvftEQf09u8vq9wfCHOBb3h4ak+C6dE73rvTWsRxuAmrkaUvs/3+wCmq0XUysOb
         0zLPgTCyA93Xc6GP6ywDvNLC0ff7c4Wer0TYslCAlwk3qFpaewGbtotSuWdX6v/wvh4q
         IT8w==
X-Gm-Message-State: ACrzQf3hd2zN3EYaq0DP+1SGxHaAWa5FA97l7vyUGfl64KhBtzHdnKt2
        YrkFQb/av47yt3HSH1tDjmy017hP6DwNbZ4Ijdd/IigeklYT4HNtwHDyQEvcphDuIVcMp4PT1Xx
        bemxCxns9YD78I+QrKTNdvw==
X-Received: by 2002:a05:6638:3712:b0:35a:9c8a:698d with SMTP id k18-20020a056638371200b0035a9c8a698dmr5772790jav.151.1664573510567;
        Fri, 30 Sep 2022 14:31:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4VTcmsFBjypWqMFwP2pQez8YMxKnmnM54iEalnSS3t8MH21D5OVP8HPDXTGJs8BfLF5xZXKQ==
X-Received: by 2002:a05:6638:3712:b0:35a:9c8a:698d with SMTP id k18-20020a056638371200b0035a9c8a698dmr5772780jav.151.1664573510387;
        Fri, 30 Sep 2022 14:31:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638169000b0035a578870a4sm1337172jat.129.2022.09.30.14.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:31:49 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:31:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org
Subject: Re: simplify the mdev interface v8
Message-ID: <20220930153148.5eb8808e.alex.williamson@redhat.com>
In-Reply-To: <20220928121110.GA30738@lst.de>
References: <20220923092652.100656-1-hch@lst.de>
        <20220927140737.0b4c9a54.alex.williamson@redhat.com>
        <20220927155426.23f4b8e9.alex.williamson@redhat.com>
        <20220928121110.GA30738@lst.de>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 28 Sep 2022 14:11:10 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Sep 27, 2022 at 03:54:26PM -0600, Alex Williamson wrote:
> > Oops, I had to drop this, I get a null pointer from gvt-g code:  
> 
> Ok, this is a stupid bug in the second patch in the series.  I did not
> hit it in my mdev testing as my script just uses the first type and
> thus never hits these, but as your trace showed mdevctl and once I
> used that I could reproduce it.  The fix for patch 2 is below, and
> the git tree at:
> 
>    git://git.infradead.org/users/hch/misc.git mvdev-lifetime
> 
> has been updated with that folded in and the recent reviews.
> 
> ---
> diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
> index 1b67328c714f1..b0d5dafd013f4 100644
> --- a/drivers/gpu/drm/i915/gvt/vgpu.c
> +++ b/drivers/gpu/drm/i915/gvt/vgpu.c
> @@ -123,7 +123,7 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
>  
>  		sprintf(gvt->types[i].name, "GVTg_V%u_%s",
>  			GRAPHICS_VER(gvt->gt->i915) == 8 ? 4 : 5, conf->name);
> -		gvt->types->conf = conf;
> +		gvt->types[i].conf = conf;
>  		gvt->types[i].avail_instance = min(low_avail / conf->low_mm,
>  						   high_avail / conf->high_mm);

Fix folded in, re-applied to vfio next branch for v6.1.  Thanks,

Alex

