Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD38BC7EE23
	for <linux-s390@archiver.kernel.org>; Wed, 31 May 2023 13:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjEaNV1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 May 2023 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEaNV0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 31 May 2023 09:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4719FD9
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685539246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZVXm+IOCgmTsEqI3VXAOS0mHF1t0Jqm4WlZG/uBAgA=;
        b=jVtxelwL1lcBmhyLOFrhfHFZ7EZ8O7z617p1J0IGkkf0d9jfq5bwgBhabL1QU+no6TlzGG
        3sdX02iZJu7ceh28g/kKOi877gD7O0liYDxBqduT1qLcgZ9wplDK4rYXDw0ocsp0s0wWh9
        jFSWKGl9zNSeW4w9eye/rLDBqITO+LI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-FtDpDB1gOau_JsStcDUcFA-1; Wed, 31 May 2023 09:20:45 -0400
X-MC-Unique: FtDpDB1gOau_JsStcDUcFA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75b15543b49so401387285a.0
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 06:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539244; x=1688131244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZVXm+IOCgmTsEqI3VXAOS0mHF1t0Jqm4WlZG/uBAgA=;
        b=kdw0PpCwn/ms7YmavgoEPzkPb7lg/8Rjbm7PRVJYVJKlheid1cg+A43mFXX+zyzDvL
         WzgLgegKcMzEtXzDxF/rvE+fzbUXZnhfa2O0XrC+y3tiSuJC39Kle4TOlrUcJajSdRun
         7k0BIY6p8HB6z5HAbc2jNRFCTFn79nEpYZSBJdKps+HWezrDA3tTOdVw5BB+18tyKPEQ
         75Ft4kdZ9VaEhRG4oqgNVmu1cxLmXo0DYDBZzhZMhAOwEe+nPjGLfWubqFXWgwpLwKIG
         3xmaDFf9DDTt4HpnKCvdr8yIn8bqwHFVOxgds0kvqiwwMGq56R+z7By7s4j3Pp5HqjW5
         hkZg==
X-Gm-Message-State: AC+VfDxctgcwgdAAg6JSG5fOMeGYl2SSX13074Dar1/ogGFOqZXLBMyH
        FD9IbycdWTIKj+CqbwlcXPrkE+i7qPAKGZsTqkLcWTWTtwiA8RkN/rZ+4V/QweLae49oTGL/lqq
        asu2HzIKyG3D+B4h9hfF9Mg==
X-Received: by 2002:a05:6214:e4b:b0:5ea:d52:7042 with SMTP id o11-20020a0562140e4b00b005ea0d527042mr5919372qvc.31.1685539244764;
        Wed, 31 May 2023 06:20:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fkoMnFe/NS9uPFPjiSVB+gDPw+HMnw0nwLd0bciAqe6TJk7vFLomsCyZ6OqdJGwlkfWRidg==
X-Received: by 2002:a05:6214:e4b:b0:5ea:d52:7042 with SMTP id o11-20020a0562140e4b00b005ea0d527042mr5919359qvc.31.1685539244549;
        Wed, 31 May 2023 06:20:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0? ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
        by smtp.gmail.com with ESMTPSA id k18-20020a0cd692000000b006238ac6c3f3sm5787394qvi.33.2023.05.31.06.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:20:44 -0700 (PDT)
Message-ID: <d4ad9b34-60d3-3ffb-ee88-8bcb3d0ec647@redhat.com>
Date:   Wed, 31 May 2023 15:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] vfio: ap: realize the VFIO_DEVICE_GET_IRQ_INFO ioctl
Content-Language: en-US
To:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
        mjrosato@linux.ibm.com, alex.williamson@redhat.com,
        borntraeger@linux.ibm.com
References: <20230530223538.279198-1-akrowiak@linux.ibm.com>
 <20230530223538.279198-2-akrowiak@linux.ibm.com>
 <ee46966a-920a-37f6-9554-b2b10565cd58@redhat.com>
 <64d96082-8c05-0fb8-dfdd-96ad8efa6cd8@linux.ibm.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <64d96082-8c05-0fb8-dfdd-96ad8efa6cd8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/31/23 15:05, Anthony Krowiak wrote:
> 
> 
> On 5/31/23 8:54 AM, Cédric Le Goater wrote:
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thank you for the review.
> 

I also ran a few tests with the QEMU part on guests with passthrough
crypto devices. This is probably a v6.5 candidate.

C.

