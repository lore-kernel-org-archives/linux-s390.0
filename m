Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D8C54EBE
	for <linux-s390@archiver.kernel.org>; Fri, 13 Jan 2023 02:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjAMCFV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 Jan 2023 21:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjAMCFU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Jan 2023 21:05:20 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B5621A5
        for <linux-s390@vger.kernel.org>; Thu, 12 Jan 2023 18:05:19 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so25548494pjj.2
        for <linux-s390@vger.kernel.org>; Thu, 12 Jan 2023 18:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imvHeHfSB76NKxqNg7yS5d0bnfZ/68ukGArZSjXXLbU=;
        b=gfL4hh/PAfTWoPxrgPNOjugdRQT6/WV65DgBrSnpV5ljD3nsqQZO//RzEo7T4oLQqx
         c4Q0mI405eGfoj8LuS0wI2sQdlqaeNnCgTAsK9ojs6iEaCaHua6vjwZaKDc+OIsKFBm9
         w5TSAgwjkuR9lTRDlbRtIxIeYn77XVQL36m+j6TNN1IPYFjq7eERVWltVZh8xI+AuS6x
         Ebb8o0T31ad1vrZqKXtO581o4RiY7HqEeVSqH6w/J7bYR6aLkGoMN3t0S7fDWdcn2JdL
         sRmydefKjnfHqNzBKp647Hzmqgin/vcHPGOfInZ9RvBNC86xV/kMej7ry3nwiPeZw8Hm
         rb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imvHeHfSB76NKxqNg7yS5d0bnfZ/68ukGArZSjXXLbU=;
        b=c6KdaA5SbVN3pZ/toxmPZDsTv/inBhc9riKMuR3xc1aigqUGMS05pAIPtTrziLc7Vw
         1bzvrzlGKNkZGQqk2GTX1HXg7YaAyQSNjwKYoDJBiclFyN+0HDDy7ETlGAySGDRGRqDr
         kCxBFM3VVYVsQW8Jv8PHiAgfLElBHhMPfQlmjkY17pXR5NXx9HVJNn+m/bonUGcNnGuf
         dW9P/yiCTTFeuScXJVDk5gnqLazceY1p+SVWKkdoH8Ckjk1IEvgu4rwG7p/t5UiRFy84
         UGFU40SA6ei2KUOazC4jO84UZjKlzanynzjhWLmsO36pig778SjH7J6JO2V1sltBYHpL
         jP9g==
X-Gm-Message-State: AFqh2konZfhpo7o/ez0wofyX9XqbrJhbqmhdwflY4BPdhEZowxDzipqy
        hae4X7MRJb4WNWqoe3gHupYPsA==
X-Google-Smtp-Source: AMrXdXt5UhWv4+gCCOg9vsmsrXhYZBecqcoz5x+/Oa5eI3PEct7oPHliTdSgvAqHMlV57ui5SVshog==
X-Received: by 2002:a17:902:b10e:b0:191:4367:7fde with SMTP id q14-20020a170902b10e00b0019143677fdemr994708plr.0.1673575518755;
        Thu, 12 Jan 2023 18:05:18 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902aa9600b001871461688esm12835625plr.175.2023.01.12.18.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 18:05:18 -0800 (PST)
Date:   Fri, 13 Jan 2023 02:05:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, pbonzini@redhat.com,
        jgg@nvidia.com, cohuck@redhat.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@redhat.com,
        akrowiak@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio: fix potential deadlock on vfio group lock
Message-ID: <Y8C8WpkjgFelldTQ@google.com>
References: <20230112203844.41179-1-mjrosato@linux.ibm.com>
 <20230112140517.6db5b346.alex.williamson@redhat.com>
 <bce7912a-f904-b5a3-d234-c3e2c42d9e54@linux.ibm.com>
 <Y8CX8YwT/T9v4U/D@google.com>
 <20230112175648.158dca5f.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112175648.158dca5f.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jan 12, 2023, Alex Williamson wrote:
> On Thu, 12 Jan 2023 23:29:53 +0000
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > On Thu, Jan 12, 2023, Matthew Rosato wrote:
> > > On 1/12/23 4:05 PM, Alex Williamson wrote:  
> > > > On Thu, 12 Jan 2023 15:38:44 -0500
> > > > Matthew Rosato <mjrosato@linux.ibm.com> wrote:  
> > > >> @@ -344,6 +345,35 @@ static bool vfio_assert_device_open(struct vfio_device *device)
> > > >>  	return !WARN_ON_ONCE(!READ_ONCE(device->open_count));
> > > >>  }
> > > >>  
> > > >> +static bool vfio_kvm_get_kvm_safe(struct kvm *kvm)
> > > >> +{
> > > >> +	bool (*fn)(struct kvm *kvm);
> > > >> +	bool ret;
> > > >> +
> > > >> +	fn = symbol_get(kvm_get_kvm_safe);
> > > >> +	if (WARN_ON(!fn))  
> > 
> > In a related vein to Alex's comments about error handling, this should not WARN.
> > WARNing during vfio_kvm_put_kvm() makes sense, but the "get" is somewhat blind.
> 
> It's not exactly blind though, we wouldn't have a kvm pointer if the
> kvm-vfio device hadn't stuffed one into the group.  We only call into
> here if we have a non-NULL pointer, so it wouldn't simply be that the
> kvm module isn't available for this to fire, but more that we have an
> API change to make the symbol no longer exist.  A WARN for that doesn't
> seem unreasonable.  Thanks,

Hmm, I was thinking that it might be possible for kvm.ko to be on its way out,
but barring use of force module unload, which breaks things left and right, kvm.ko
can only be going if all VMs have been destroyed.

Agreed, WARN is fine.
