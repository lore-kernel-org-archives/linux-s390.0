Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC7C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 18 Jan 2022 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiARQUo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:20:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbiARQUn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jan 2022 11:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642522843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwrulS3gzA/74heRhQ+jQxvPAPi0xIckrPJaoqht2/c=;
        b=Wr3kPbeohBj64Y91OpkX1gCkWZF9LBbZoW5IGIU0guWMlDXfGJO2wwbxemoorFOdVsNtU7
        OUnahKQMYHfodhpKcB/VFnuopCqSIrBtA2wPYNaRuFQ896EPEr37G6GzZtRWCPU5PM7p+v
        0vcxMWOTewh3eSmIz/y7b+Neu0HDbp8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-zK5QuUmIMJeHixdEhZn-yA-1; Tue, 18 Jan 2022 11:20:41 -0500
X-MC-Unique: zK5QuUmIMJeHixdEhZn-yA-1
Received: by mail-wm1-f72.google.com with SMTP id n25-20020a05600c3b9900b00348b83fbd0dso2437642wms.0
        for <linux-s390@vger.kernel.org>; Tue, 18 Jan 2022 08:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EwrulS3gzA/74heRhQ+jQxvPAPi0xIckrPJaoqht2/c=;
        b=SkY8dBhJdWioCklifQI1g2j4dKyH+1ZNZML2CQ+A7IE6btTtAs1jE5EhQvGCFo28px
         WXypv383eXvKNawfL8xXsgx4MK6fZt7w3HxkWnhLotRT9qDJjeGkIPXe1S0LLzmoTmBU
         bjc9ra1dEBr0n/elupV3rjHj05fL/u4TaHubURTVCNLpn40G4UC/R2lOWOwstJT5iXdo
         JDwEDPVMO9OMzM0AhIR8x5+NeUV9vAgY457sz6HGoleiLrSgbyJhd+WaX92FidtgH8ZZ
         COGX04bkZa7u/5k+478tJJz4/hbbRQS56LgkMg7iXNLQDvtp22NAETI38T55JMtP25jv
         tXnw==
X-Gm-Message-State: AOAM530PAcaHRaEbXlnFR6Fro0Fm8bhofolacZlecQvFHDHBI4OA0Fuq
        MSWg0PsJSSS1Q0TUyyivd0ZGr7kL+hqzLrACW6yyMvzDAVGIyrwBFf0Sand2+i4Bh1/oxLdRw2D
        s/m8D5jyEIUrhUHPtiIsEqA==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13mr25057008wrt.641.1642522840126;
        Tue, 18 Jan 2022 08:20:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTz1c1QQcAMTiHafm/jmwdXgrf7wUWM5hGJvGgdN/CAmFDEzHQguURZEtsbIR0m3l3jikB/Q==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13mr25056991wrt.641.1642522839929;
        Tue, 18 Jan 2022 08:20:39 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id h2sm3124218wmq.2.2022.01.18.08.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:20:39 -0800 (PST)
Message-ID: <0c3b360a-8b95-0a18-a5df-59249247c291@redhat.com>
Date:   Tue, 18 Jan 2022 17:20:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [kvm-unit-tests] Permitted license for new library
Content-Language: en-US
To:     Alexandru Elisei <alexandru.elisei@arm.com>, thuth@redhat.com,
        lvivier@redhat.com, imbrenda@linux.ibm.com, david@redhat.com,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org
References: <YeboYFQQtuQH1+Rf@monolith.localdoman>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YeboYFQQtuQH1+Rf@monolith.localdoman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/18/22 17:18, Alexandru Elisei wrote:
> Hello,
> 
> I would like to know what licenses are permitted when adding a new library
> to kvm-unit-tests (similar to libfdt). Is it enough if the library is
> licensed under one of the GPLv2 compatible licenses [1] or are certain
> licenses from that list not accepted for kvm-unit-tests?
> 
> [1] https://www.gnu.org/licenses/license-list.html#GPLCompatibleLicenses

Any GPLv2-compatible license is acceptable.  GPLv2+ compatibility is 
nice but not required.

Paolo

