Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED4C636CC
	for <linux-s390@archiver.kernel.org>; Fri,  3 Feb 2023 21:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBCVhG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjBCVhF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Feb 2023 16:37:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197DA87BF
        for <linux-s390@vger.kernel.org>; Fri,  3 Feb 2023 13:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675460155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k+UxZR8AqVwDwvK/Db4g0V588SY+VI2pB0owqXny0I=;
        b=Sy6gvVesgHw7JxfnxTUTJECI7a1/7v9QkOzDrmZ5HhXcqHmsPEI72aJiaUX2dciATLWJtD
        nF9cGZi65knzhsQyjRiddsecXmugw6Eu+IIm6/uOZ23foFdRtIkT/34/qRK3P4ZNkPCYQH
        0eeQf9bbrUBY6nqF04Ur91kUikd/Hys=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-cw-O6zMwOS-uPUZXrPZrig-1; Fri, 03 Feb 2023 16:35:54 -0500
X-MC-Unique: cw-O6zMwOS-uPUZXrPZrig-1
Received: by mail-io1-f69.google.com with SMTP id q12-20020a6b8e0c000000b0071d8eef7c67so3707797iod.5
        for <linux-s390@vger.kernel.org>; Fri, 03 Feb 2023 13:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k+UxZR8AqVwDwvK/Db4g0V588SY+VI2pB0owqXny0I=;
        b=N5iUG9sRz1hd+i9QLGo/FrNTVC2+uqFBWT4voQ0bnxfsTFVSIZ1yHPrIV3C6oV8p8Q
         1tJHdGMqcgsjirKUbh1SmFBFLHBkuxWx2PYv7xw0ZLkRu9eLk+Dt6rAH8PKPhsg825hT
         bSm41L9hQ5cak4wNGscIuWdHUfuF6cLg08BFDs+aY01oSMu2BDM4OOpYq2cvY8JAPqET
         Aw+94oK7xIWwjTO50WEdxsfsJjtxcw62pJQ1b4PDqQ9yQhbBOS/W68J5mQNPV+3mgx13
         vAZNDQOxAGqHq85LeVV6bh0DVjOhMCiW8IRWOGg/yxPCOeJ3kLhpQJ7Dy4sqAKT1j2Vy
         yV+g==
X-Gm-Message-State: AO0yUKW9tmLJ14Hnb5RwLtJ/1TCc/Soqs7dv32q4j3NZ1C7axwv35OuV
        KUF1zAhUNi5sQqqB59J2wd340PI2ElIKkctb4jN2+apkafhz/KJMWDF1cKnhi1/Ypa8lhriLvmr
        udAZZmGfrcR2LoRSnIvVWzA==
X-Received: by 2002:a05:6e02:148c:b0:312:7bbf:94f5 with SMTP id n12-20020a056e02148c00b003127bbf94f5mr9262272ilk.3.1675460153339;
        Fri, 03 Feb 2023 13:35:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8GiBZNAUhnppz+3LpmWjBO/5Dhk61WY57QRLNeBIn7RbRA8vBDcQoGmES9jBCpRxioDalZzw==
X-Received: by 2002:a05:6e02:148c:b0:312:7bbf:94f5 with SMTP id n12-20020a056e02148c00b003127bbf94f5mr9262252ilk.3.1675460153111;
        Fri, 03 Feb 2023 13:35:53 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a16-20020a924450000000b0031264571bd8sm1103072ilm.18.2023.02.03.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:35:52 -0800 (PST)
Date:   Fri, 3 Feb 2023 14:35:51 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "pmorel@linux.ibm.com" <pmorel@linux.ibm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "david@redhat.com" <david@redhat.com>,
        "akrowiak@linux.ibm.com" <akrowiak@linux.ibm.com>,
        "jjherne@linux.ibm.com" <jjherne@linux.ibm.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "Christopherson, , Sean" <seanjc@google.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] vfio: fix deadlock between group lock and kvm lock
Message-ID: <20230203143551.2f349702.alex.williamson@redhat.com>
In-Reply-To: <b5e64413-0374-edd8-9bfd-8bb613ab04f9@linux.ibm.com>
References: <20230202162442.78216-1-mjrosato@linux.ibm.com>
        <20230202124210.476adaf8.alex.williamson@redhat.com>
        <BN9PR11MB527618E281BEB8E479ABB0418CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230202161307.0c6aa23e.alex.williamson@redhat.com>
        <BN9PR11MB5276017F9CEBB4BAE58C40E88CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
        <DS0PR11MB7529050661FCE4A5AC4B17C3C3D79@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230203064940.435e4d65.alex.williamson@redhat.com>
        <DS0PR11MB75297154376388A3698C5CCAC3D79@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230203081942.64fbf9f1.alex.williamson@redhat.com>
        <ed030aa5-b3af-638e-6e26-4e3a20b98ef4@linux.ibm.com>
        <20230203133503.4d8fb3e8.alex.williamson@redhat.com>
        <b5e64413-0374-edd8-9bfd-8bb613ab04f9@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 3 Feb 2023 16:19:10 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> > @@ -350,32 +350,25 @@ void vfio_device_get_kvm_safe(struct vfio_device *device)
> >  
> >  	lockdep_assert_held(&device->dev_set->lock);
> >  
> > -	spin_lock(&device->group->kvm_ref_lock);
> > -	if (!device->group->kvm)
> > -		goto unlock;
> > -
> >  	pfn = symbol_get(kvm_put_kvm);
> >  	if (WARN_ON(!pfn))
> > -		goto unlock;
> > +		return;
> >  
> >  	fn = symbol_get(kvm_get_kvm_safe);
> >  	if (WARN_ON(!fn)) {
> >  		symbol_put(kvm_put_kvm);
> > -		goto unlock;
> > +		return;
> >  	}  
> >  >  	ret = fn(device->group->kvm);  
> 
> s/device->group->kvm/kvm/

Oops, yes.

> With that small change, this looks good to me too (and testing looks
> good too).  Do you want me to send a v4 for one last round of review?

Please do.  Thanks,

Alex

