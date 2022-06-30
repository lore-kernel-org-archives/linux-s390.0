Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DDDC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 30 Jun 2022 17:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiF3RLT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiF3RLR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jun 2022 13:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D0073EF30
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656609074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUOdzSO2oUbBwTqVsnQybwkshzKjPN1FQaK1nqX25to=;
        b=Iyqp/Hl9xBEgsitO36OnkNKNArrNvPinAEqNhgafXFZaI8FJJ6ujegGOuLhP1eZSh0d1uz
        a8XJOuAazL8Q62Tv3rG338V8K1v56H6JvMx5ACOQNTmxz8rZGb2DmMX/4KPL4VhfDdY3/o
        g+VHD/onmX9qAy141Duf7GVbXqq0KbQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-Ho44U6HkMr6XZIaXBLFZZw-1; Thu, 30 Jun 2022 13:11:12 -0400
X-MC-Unique: Ho44U6HkMr6XZIaXBLFZZw-1
Received: by mail-wm1-f72.google.com with SMTP id p22-20020a05600c359600b0039c7b23a1c7so1689238wmq.2
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 10:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JUOdzSO2oUbBwTqVsnQybwkshzKjPN1FQaK1nqX25to=;
        b=2EXi/ofPeVNpaQBxMn+aYjg52mEKrFgC3jqwWS9oVBJTUe1MQfIOz35WAsWM39adIs
         iW2sMWQVKxyAkTjcVBsg96fcYzEt5k/rduF2wuH9nPj4gGiRMY/2nMukw0R8CkWCNJ47
         2kBGbtm1haXyikzb70tjXgR1nVJ0+Z70ziUDNOCwfmyYzm3Mv+qXO8BGGj3hcQckxIQQ
         ymXfN3R7Eewt8oYiwXNJoywz//t9yumx+qsfuNQlHa5is18CegNqRt7P8G+HHchNaRfK
         8Gpfv3gDhhYv/j2RS1ZoRAE3tw1yFr1y93LHLSWqhG5xtf+4f27NRUWZbFkgR7OY7GBg
         FnPQ==
X-Gm-Message-State: AJIora9L0LT3NAtwwk+iMnBc/WQTYUrI5uiZoOvSpYmjdecQW8C1rGZb
        lDamhTf/rf1fGCYUTUeJMj3+O2hMU9ndZ9apK23Cr2kz8A5E9a4CjvLc3aiuBIfTO/s4STzCD7G
        dWMfew7dAbvVhX4DWVJqNeQ==
X-Received: by 2002:a05:600c:1d96:b0:3a0:30b6:bb1a with SMTP id p22-20020a05600c1d9600b003a030b6bb1amr12787108wms.93.1656609070902;
        Thu, 30 Jun 2022 10:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s10GRhnhicYja7eIwUqagyOtGj985hy18rMk27XChhm0UIb5PrlgWH3C/QnwSYivs8HJgcbQ==
X-Received: by 2002:a05:600c:1d96:b0:3a0:30b6:bb1a with SMTP id p22-20020a05600c1d9600b003a030b6bb1amr12787092wms.93.1656609070585;
        Thu, 30 Jun 2022 10:11:10 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-66.web.vodafone.de. [109.43.179.66])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b0020c5253d907sm3704470wrz.83.2022.06.30.10.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 10:11:09 -0700 (PDT)
Message-ID: <c58d2ce5-66c0-2072-5788-9463a6003888@redhat.com>
Date:   Thu, 30 Jun 2022 19:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [kvm-unit-tests PATCH v1 3/3] s390x: add pgm spec interrupt loop
 test
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220630113059.229221-1-nrb@linux.ibm.com>
 <20220630113059.229221-4-nrb@linux.ibm.com>
 <dd270d92-a5dc-8a75-0edc-e9fdbb254cc9@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <dd270d92-a5dc-8a75-0edc-e9fdbb254cc9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/06/2022 16.38, Janis Schoetterl-Glausch wrote:
> On 6/30/22 13:30, Nico Boehr wrote:
>> An invalid PSW causes a program interrupt. When an invalid PSW is
>> introduced in the pgm_new_psw, an interrupt loop occurs as soon as a
>> program interrupt is caused.
>>
>> QEMU should detect that and panick the guest, hence add a test for it.
> 
> Why is that, after all in LPAR it would just spin, right?

Not sure what the LPAR is doing, but the guest is certainly completely 
unusable, so a panic event is the right thing to do here for QEMU.

> Also, panicK.
> How do you assert that the guest doesn't spin forever, is there a timeout?

I agree, it would be good to have a "timeout" set in the unittests.cfg for 
this test here (some few seconds should be enough).

  Thomas

