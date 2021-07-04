Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F462C07E95
	for <linux-s390@archiver.kernel.org>; Sun,  4 Jul 2021 16:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C6611F1
	for <linux-s390@archiver.kernel.org>; Sun,  4 Jul 2021 16:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhGDQpM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 4 Jul 2021 12:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhGDQpL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 4 Jul 2021 12:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625416955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJP8lF3yVSno8hLF5E0+jAY8hs51Fdgeeejq30HaMN4=;
        b=LKr1AHfdvGJLnrH8+Rh5x83gm8ROJKoktQppkexiNcdPqb1P5mjacNFjAJb8qynZo2TiER
        wHZVADwH0PSarHMM+JJSEt44Yj7/iKHJwXkvCvHZnTyGenWjjfiXqqux1+jzZI3j2MGyn+
        E0iQHHvDIphOBpE+FNA2aiOtG5oplus=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-o1-GImnTMwS97ldDeJ1uOA-1; Sun, 04 Jul 2021 12:42:34 -0400
X-MC-Unique: o1-GImnTMwS97ldDeJ1uOA-1
Received: by mail-ed1-f72.google.com with SMTP id ee28-20020a056402291cb0290394a9a0bfaeso7827678edb.6
        for <linux-s390@vger.kernel.org>; Sun, 04 Jul 2021 09:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eJP8lF3yVSno8hLF5E0+jAY8hs51Fdgeeejq30HaMN4=;
        b=CjM/ZwGZ8WxzRoXRyCinkyxIB2HUT3SFS4U56lzk+WSsTCF2U8CAMG42l7TfddTJr5
         B8MCutmR8ZgvQqdiBHrtq5/1LDlYh27cRJeHQh/xhmiHE/i72Wy8+iLX8btKbdUupglu
         4RZldUNKvmYkAFw7ftOUDl/EqiQrUGyb2RxguUAQwtICHqn/zYJxbPgY00jEoO30rraU
         bUbG+69k2cO39tCmM0FL5RvL5LhJjldzCfWnOwkErnpkOB1MlCEF2XDq2l+CAUjNTrMS
         O+9mkOx9EfZnE+q05OvjTIviEVXBY3U1vHuK/oMIUPvXYkiPZ9qK1rDzTWAKXI2BU7kV
         Pzzw==
X-Gm-Message-State: AOAM532Gxp5PITtiJlUx4IhC5xxmnlmILm5uA2ttwblKTMKVVVaucmF1
        q7ffIyxG/Rvy/XT571dNrs4tmLtzfxDUpLvtzqc5O+xu8RTyZTq2z1hnNSCTHtX4w8IRWID61xa
        sD5uRz5XIR9NfWAQ3cU+MAQ==
X-Received: by 2002:a05:6402:1688:: with SMTP id a8mr9315076edv.4.1625416953226;
        Sun, 04 Jul 2021 09:42:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySRKh2auafYfCyQ94uiPtrikTLhYgWNMEJmuCDZ4NJkKDuuxyz6R8gZYYylRIkrYrWnvEL/w==
X-Received: by 2002:a05:6402:1688:: with SMTP id a8mr9315064edv.4.1625416953075;
        Sun, 04 Jul 2021 09:42:33 -0700 (PDT)
Received: from thuth.remote.csb (p5791d89b.dip0.t-ipconnect.de. [87.145.216.155])
        by smtp.gmail.com with ESMTPSA id d6sm4146271edp.59.2021.07.04.09.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 09:42:32 -0700 (PDT)
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210629131841.17319-1-frankja@linux.ibm.com>
 <20210629131841.17319-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 1/3] s390x: snippets: Add gitignore as
 well as linker script and start assembly
Message-ID: <a433cb96-88af-663d-50b9-44b96db23d25@redhat.com>
Date:   Sun, 4 Jul 2021 18:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629131841.17319-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29/06/2021 15.18, Janosch Frank wrote:
> Snippets are small guests That can be run under a unit test as the
> hypervisor.

s/That/that/. Maybe also rather something like:

Snippets are small guests which can be run under a unit test that implements 
a simple hypervisor.

?

> They can be written in C or assembly. The C code needs a
> linker script and a start assembly file that jumps to main to work
> properly. So let's add that as well as a gitignore entry for the new
> files.

Rest of the file looks fine to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>

