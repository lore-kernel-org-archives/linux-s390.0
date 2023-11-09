Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821FEC4332F
	for <linux-s390@archiver.kernel.org>; Thu,  9 Nov 2023 01:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjKIBvd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Nov 2023 20:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjKIBvc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Nov 2023 20:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E15269E
        for <linux-s390@vger.kernel.org>; Wed,  8 Nov 2023 17:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699494645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wO9s3m87KdAOj8dUM4yEg5modSpx8d1MOGCkijjqOoI=;
        b=IGy0oC8hd5ZG5/W8vbDSS6sBQHcSwL6QyHEirxKtJv5SvvIyNz7PzL49XTiUIFIjaGUb9R
        sJ1DVV2jAb/PnCshAXuhK/J5zjyWtPZumoPz3JiCfKRl2EiDYLsWxdMwwT+xEpssh7mgam
        H2EIZJRQy58sPzb+dEkU/oL2/ZEt8EM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-N4XZAqttM0SV2RwqpTjL0Q-1; Wed, 08 Nov 2023 20:50:44 -0500
X-MC-Unique: N4XZAqttM0SV2RwqpTjL0Q-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d32824db9eso318017a34.0
        for <linux-s390@vger.kernel.org>; Wed, 08 Nov 2023 17:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699494643; x=1700099443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wO9s3m87KdAOj8dUM4yEg5modSpx8d1MOGCkijjqOoI=;
        b=mafjpu85OsHcMjbsv5TlYoeZv80lSlhNYjExjvPupi7Ct0SNQAhItyXt7SSzbEXMif
         1UAvpHqdek45eu+TcDowWRD0dYJgGs/bcPguDaQZ3ztrm+NJ46/NORwXIi9T2lGM83Ld
         hXkpEbUa3a79f1CaLKJHdkpJBsBrpG/72YE++Pq1ODFx9U/mdutOhAnCDxpJ6fg5WwI4
         aTQIVo95AaJ+hfqhWzy9zzrTDsiec5f3nAIixfLB6CMKHmmRGd+9qY2PYlAQPcYuOnuM
         s5u+QApSdKmgBP4aDFpA6f2xHHdFvec5+vHGb+mMHE00PBjcu8mRdg1a3DCV1ZFibXBV
         gfSg==
X-Gm-Message-State: AOJu0Yz9VZschfLAEf3vDejqb0F+FAksjJR5fHTCyQjUD7VIX7qb+Hwz
        PAJrrcdpHzmb50mezBiH/sH/HGklNRB3i+2xS5Ea1G0j58LSFvOtKo6exHihUC2RzWvKcmAr8Pr
        24s5CVFiin6BLJ2mXVYJhp9rUwHsYrQAd
X-Received: by 2002:a05:6830:1bf4:b0:6c0:9e24:6eab with SMTP id k20-20020a0568301bf400b006c09e246eabmr3975592otb.33.1699494643287;
        Wed, 08 Nov 2023 17:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCEBDzcomi0jpbp8LbNnvxysJq0VKVbEHXKgZ9s3wB7Jgl4wxvistJT9ufWfgI0rmiF0Q3AA==
X-Received: by 2002:a05:6830:1bf4:b0:6c0:9e24:6eab with SMTP id k20-20020a0568301bf400b006c09e246eabmr3975583otb.33.1699494643074;
        Wed, 08 Nov 2023 17:50:43 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b0068fe5a5a566sm9827612pfm.142.2023.11.08.17.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 17:50:42 -0800 (PST)
Date:   Thu, 9 Nov 2023 09:50:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     edward6@linux.ibm.com
Cc:     fstests@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [Bug report] More xfs courruption issue found on s390x
Message-ID: <20231109015038.nyhlsmkzhq7eio7d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231029043333.v6wkqsorxdk2dbch@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20231108163812.1440930-1-edward6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108163812.1440930-1-edward6@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 08, 2023 at 05:38:12PM +0100, edward6@linux.ibm.com wrote:
> From: Eduard Shishkin <edward6@linux.ibm.com>
> 
> On Sun, Oct 29, 2023 at 12:33:33PM +0800, Zorro Lang wrote:
> 
> [...]
> 
> > All these falures are on s390x only... and more xfs corruption
> > failure by running fstests on s390x. I don't know if it's a s390x
> > issue or a xfs issue on big endian machine (s390x), so cc s390x
> > list.
> 
> Dear all,
> 
> It is a really great nuisance. We are looking into this from our
> (s390x) side in turn. Unfortunately, I don't see any ways except code
> review for now. If you have any ideas on how to optimize the process,
> please, let us know. Right now, I think, we can help with additional
> hardware resources.

Thanks the reply from s390x side, we had more discussion under another mail
thread:

https://lore.kernel.org/linux-xfs/20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m0888b2314d0dc866bdd7e1bd8927e599d57319bd

This's an issue about a xfs feature, but only reproducible on s390x. The
expert from xfs side is looking into it, I'll provide more information
for debuging. I'll cc s390 list later, if you'd like to watch it:)

Thanks,
Zorro

> 
> Thanks,
> Eduard.
> 

