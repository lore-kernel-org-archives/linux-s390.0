Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F072C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 23 May 2022 19:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiEWTch (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 May 2022 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiEWTbt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 May 2022 15:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3EB59157F
        for <linux-s390@vger.kernel.org>; Mon, 23 May 2022 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653333325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/0kz+ejxdczhCliiE6lC8QVlLMBxfRksui59KA65qM=;
        b=ghjL8dJL9ZbzcCvAUvsdbRACzFhnJffgkeMFEb+STnm97fZsziW/uniV90CIR7fyReI/r1
        72O1AtruJoyMUhnAOjF7qIxXnR3D+pMWnJExDfdkch+m4ZY3bjpiyXUE2tGV4PisSYgDH8
        XwV2sV0viaMZxypyMR5k3D3lxfuHCME=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-yuQtKMYMPF--uQgpBEvwnA-1; Mon, 23 May 2022 15:15:24 -0400
X-MC-Unique: yuQtKMYMPF--uQgpBEvwnA-1
Received: by mail-ej1-f72.google.com with SMTP id gh15-20020a170906e08f00b006fea2a22319so4036227ejb.20
        for <linux-s390@vger.kernel.org>; Mon, 23 May 2022 12:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k/0kz+ejxdczhCliiE6lC8QVlLMBxfRksui59KA65qM=;
        b=h0yxYQZqDv1ZrqF8iuwJaZOmt1bmbcxOTsoKUGj9aoSI7yxs7vuQvh1Fi+Clvjlxfw
         5A9u2J1b5QAvLx8X4CG9Ap6OFwqQ4a86+e7Nz4UtM/169TrZ2FXFJfb5uyKlRhYv57iQ
         K5bc19bKWDqkflfnpjUFzrbOmx/R9IVQhGw1Vg2SquKM+wYHygo4w0Lif9G0hBVTAMxk
         aIV6OA3r5pmQioxkN+gjPaahAmwNy5DiOb0E5eqVGodCSXIQnfJ1q1ERy6F/81nLEBFt
         MrchMU5iUKZrf2vzz2hF/iO7rL6VNMlDK/fPiXWJqxjdoFWI+qjXwWFWg28+uXiMipQI
         sePw==
X-Gm-Message-State: AOAM533MJd4MtoruqKL1fW40rW0BnNM+re798P2sbXxA/WHpMXQxYAYF
        pej2scEOh1twkqxYRdcYthu1pl+zjT0Vxdjsu0u+dWRAQqgNF00LMKd0aLbmi4ESof6X5xWydBN
        dSyl+XUpKFA7MZOwGTt29gw==
X-Received: by 2002:a17:907:6d15:b0:6fd:d985:889b with SMTP id sa21-20020a1709076d1500b006fdd985889bmr21549077ejc.753.1653333323221;
        Mon, 23 May 2022 12:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgkCPhcAB33EYPZ90yGnEhKwoYAq64BHcNEOKNWqNDyz59/iBOtrFdjzxw5hQFuZHG1dBu+g==
X-Received: by 2002:a17:907:6d15:b0:6fd:d985:889b with SMTP id sa21-20020a1709076d1500b006fdd985889bmr21549058ejc.753.1653333323039;
        Mon, 23 May 2022 12:15:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id c21-20020aa7c995000000b0042aaacd4edasm8624567edt.26.2022.05.23.12.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:15:22 -0700 (PDT)
Message-ID: <a1d7d9f9-bb9d-1b98-a073-85d835be0341@redhat.com>
Date:   Mon, 23 May 2022 21:15:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GIT PULL 0/4] KVM: s390: Fix and feature for 5.19
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
References: <20220523095625.13913-1-borntraeger@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220523095625.13913-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/23/22 11:56, Christian Borntraeger wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.19-1

Pulled, thanks.

Paolo

