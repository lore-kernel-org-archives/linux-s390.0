Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C4EC433E0
	for <linux-s390@archiver.kernel.org>; Thu,  4 Mar 2021 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520F064F1E
	for <linux-s390@archiver.kernel.org>; Thu,  4 Mar 2021 12:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbhCDM0Z (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 4 Mar 2021 07:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240448AbhCDMZ7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Mar 2021 07:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614860673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxObeU9oRNIEYPUzsFdsCeXo8HenXTZFo5mB0PbnSaY=;
        b=bmvA91+yci2L6g4cmnrGYc0hKq0KMXquT1nYB/I918eKhOc6R+NPD8gxkcgeIZPe7xdEnz
        lpl/noYU5lYlSjGrY8aceNMJ1hP826rXrjxvh8GlwVV8OXt0rzS3k2TBNNhfgjbQEaYXme
        0puT7ijwQg7dzC9JTbaZgkn1GubWJ1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-vS-F6leBOJuWhHZ7eJyWTg-1; Thu, 04 Mar 2021 07:24:31 -0500
X-MC-Unique: vS-F6leBOJuWhHZ7eJyWTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56BFF87A82A;
        Thu,  4 Mar 2021 12:24:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E37F55D71B;
        Thu,  4 Mar 2021 12:24:25 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v3 5/7] s390x: Print more information on
 program exceptions
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        pmorel@linux.ibm.com, david@redhat.com
References: <20210222085756.14396-1-frankja@linux.ibm.com>
 <20210222085756.14396-6-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <7869c8a0-bd7b-ab58-fbf9-6106680e2065@redhat.com>
Date:   Thu, 4 Mar 2021 13:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222085756.14396-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/02/2021 09.57, Janosch Frank wrote:
> Currently we only get a single line of output if a test runs in a
> unexpected program exception. Let's also print the general registers
> to give soem more context.

s/soem/some/

With the typo fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>

