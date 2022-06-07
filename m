Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793C5C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  7 Jun 2022 16:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiFGQ2J (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbiFGQ2I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jun 2022 12:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDEE7703F3
        for <linux-s390@vger.kernel.org>; Tue,  7 Jun 2022 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654619285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrAl4X9lQHa6ImUpXg4wJtJNI7HGCy4MpInWNhicFSE=;
        b=Ts4Ait/VaLC4bh2i8ytdpkHRJTas+qr9og9v/L2H/HZQ4INV3NaeSpFn/FZ7rXiROK7Rf7
        DQxQtEPpt+PlzQD5BMPStZl58DqOR/wq7A6m78Yc3Z+BBWZt08qKN9GEo+teNDkFHszCLM
        e9leKunnWymngLJzzZN5xCxv29jpfvQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-x9APmqhLM9OXDdMvNXVLcw-1; Tue, 07 Jun 2022 12:28:03 -0400
X-MC-Unique: x9APmqhLM9OXDdMvNXVLcw-1
Received: by mail-wr1-f71.google.com with SMTP id y2-20020adff142000000b0021581245fa1so2941949wro.7
        for <linux-s390@vger.kernel.org>; Tue, 07 Jun 2022 09:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QrAl4X9lQHa6ImUpXg4wJtJNI7HGCy4MpInWNhicFSE=;
        b=oClIWBH8BpX5WXWgZ1blsJuD063xadDWe2ZDiw2zKHKC9tizdb+9QikT+x1T5wt+AA
         XLHTDLEQAAcxDmrFXhiozQKGRnAgBDnGa/l0SRHsl3E6QifG9V+6dxzr4G+UXm+cEpBm
         n91Jo9+NMwL/0AhULylPDkkzEG7hTJS0ppGJDx1luHQTMgdmnNTW0VY+N05ahvFSBMyB
         6ZDfHpWaK4A8EAVOhLc1P96PJSeueAeQZ/J82+b4ciBkgffDdUj73f5Sb6ar8XGkpGYV
         k05nI/Kn8f/gGTONoaKeCvmMqIR/CIa5xv5Bwz2VmINyGAEgEgom7YJVxjkPESdI89ym
         yoNQ==
X-Gm-Message-State: AOAM533hcUo0kQe4VSaH2M2uSdfgZQLo5VF+wpN2UCO0001xGhYg6eAj
        96a9M5zcxxra2l9MINtfrWiPWJAbk3xdiLO+JRoBn34z6k31RbDm9Mb00poz8BIg466mOQskaig
        F1Y3dRB2YZsGlfSPvgczMAQ==
X-Received: by 2002:adf:fe90:0:b0:210:7e22:186e with SMTP id l16-20020adffe90000000b002107e22186emr29301438wrr.321.1654619282675;
        Tue, 07 Jun 2022 09:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRDGHUN1V8ilpafmjMJrCpHoJfcLfR+x/HPQ5S4rcMfI1wOnucWWWA4grpheVXro8sbOyqfA==
X-Received: by 2002:adf:fe90:0:b0:210:7e22:186e with SMTP id l16-20020adffe90000000b002107e22186emr29301405wrr.321.1654619282385;
        Tue, 07 Jun 2022 09:28:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id c186-20020a1c35c3000000b0039bc95cf4b2sm20949223wma.11.2022.06.07.09.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 09:28:01 -0700 (PDT)
Message-ID: <1999b2b7-13a8-8d91-89fb-6b624bc7dd15@redhat.com>
Date:   Tue, 7 Jun 2022 18:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GIT PULL 00/15] KVM: s390: pv dump and selftest changes
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
References: <20220601153646.6791-1-borntraeger@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220601153646.6791-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 6/1/22 17:36, Christian Borntraeger wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.19-2

Pulled now, thanks.

Paolo

