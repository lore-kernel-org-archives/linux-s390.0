Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8AFC433F5
	for <linux-s390@archiver.kernel.org>; Fri, 12 Nov 2021 09:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA21160EE2
	for <linux-s390@archiver.kernel.org>; Fri, 12 Nov 2021 09:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhKLJjD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234730AbhKLJjD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Nov 2021 04:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636709772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RS0GDdXEcb4iOfoVt7xdPZJYdb+hs05OLDjMHPHMII=;
        b=OECnLG35jp8c1qnIdCtAfTzgDpH5IrCAgrFlz78twauPnt6LmdN7/0oAbqUScBhctMAW2h
        3kdWn36i6d7S0BI55Po/H3oWRMESShzi5/OQWtfXCwxbAIxW2m6o/OsJSditjkLhnIAwGW
        RGpl0fo7eOA5jffSxx1Pq4O+s1URGCk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-47Ca0C1XO6uaRTkVpH1Ing-1; Fri, 12 Nov 2021 04:36:08 -0500
X-MC-Unique: 47Ca0C1XO6uaRTkVpH1Ing-1
Received: by mail-lj1-f199.google.com with SMTP id q64-20020a2e2a43000000b00218c94eab9bso2902055ljq.18
        for <linux-s390@vger.kernel.org>; Fri, 12 Nov 2021 01:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RS0GDdXEcb4iOfoVt7xdPZJYdb+hs05OLDjMHPHMII=;
        b=30wBylO+fa3SDDSH8+iHLSNaWB7Di1G2Ip1VltW7tup887IKzUoBcXPRfCGpxf6rZm
         YxCS309o/3uZcni+ASp2Sh/KaTJ5XTzTtE3xHCzr5B0EwNl37rJv4gC3f9VD264n+NNN
         wKQuu+pMF64LpnSrmxJA/AarOB73znyUNkSM6Mf5GEcBN8ZaJESYF+43dbrjQ6LMzFCn
         WqzpffYc2DeB4hyXRIZVNVLHiFDXU0XwJd9rPWqrRe7803J95J0bbTWxxnQNVKQMU8mk
         vUqA28FLXUzLzvc2W0FBN+s+PVV4S+Yk9pTQMf6P33jXZNA31B7XGs8hpZqZSTVDN6HT
         GHAg==
X-Gm-Message-State: AOAM53330YN5satX3O8yGOSFR2izyyXjEhzzxnoCQXmXq/JmJChPCWx2
        jdeOlSQ//8GSLoQbZ+CHTcxye9oyfXAsOhUQ/9GNIxD0W0XxJDSuGcFJTcbXPnPiSudQRkyQPDC
        ItvbfHlz46echBDEccLYLDpQoml70jWV2f9xlEg==
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr10592840ljp.294.1636709766791;
        Fri, 12 Nov 2021 01:36:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywvQLolUByNPBH2qOskivToNkP9OLC11Nnm+CW99rjkulOvlghOU/pbqG3fNXJml7WfM1mC6TAPlLWpCU4myk=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr10592820ljp.294.1636709766635;
 Fri, 12 Nov 2021 01:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20211110203322.1374925-1-farman@linux.ibm.com>
 <20211110203322.1374925-3-farman@linux.ibm.com> <dd8a8b49-da6d-0ab8-dc47-b24f5604767f@redhat.com>
 <ab82e68051674ea771e2cb5371ca2a204effab40.camel@linux.ibm.com>
 <32836eb5-532f-962d-161a-faa2213a0691@linux.ibm.com> <b116e738d8f9b185867ab28395012aaddd58af31.camel@linux.ibm.com>
 <85ba9fa3-ca25-b598-aecd-5e0c6a0308f2@redhat.com> <19a2543b24015873db736bddb14d0e4d97712086.camel@linux.ibm.com>
 <ff344676-0c37-610b-eafb-b1477db0f6a1@redhat.com> <006980fd7d0344b0258aa87128891fcd81c005b7.camel@linux.ibm.com>
 <CADFyXm7XM96yUEU_5Xf-nT8D5E0+sji2AwfKCvr_yvx6fZrf2g@mail.gmail.com>
In-Reply-To: <CADFyXm7XM96yUEU_5Xf-nT8D5E0+sji2AwfKCvr_yvx6fZrf2g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Date:   Fri, 12 Nov 2021 10:35:55 +0100
Message-ID: <CADFyXm5erJL4XBPDy2Xv94JNH1z88_etEer-UtJC_TTD1T-yEA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] KVM: s390: Extend the USER_SIGP capability
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, KVM <kvm@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>
> #1: SIGP INITIAL CPU RESET #2
> #1: SIGP SENSE #2
>
> As the SIGP INITIAL CPU RESET is processed fully asynchronous.

I meant to say "fully synchronous".

