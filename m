Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C7C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 19 May 2022 00:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiESAjV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 May 2022 20:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiESAjN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 May 2022 20:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AA0A1582B
        for <linux-s390@vger.kernel.org>; Wed, 18 May 2022 17:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652920751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhPoiNFlWhE/EG2LfPsngTKf/wXSwPmET9DKcPeU2e0=;
        b=eRZc/op9FmFNVYkP+CLWhQs1ica0gZG2G3FtPTqpLB4K5A69F+Szpuk9sCazIR4svDr6/Q
        gX6cRfvf3OyIXpmq3N2KABfR0Zp9V7w6EP2lXPhBpkHETUClcBY62UN08dhrdVI8xRlAEl
        lfvemDtsXZaWXRAzgYWApCGmEaQYCW0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-L87-ln_FMa6BzS8tUYo5IA-1; Wed, 18 May 2022 20:39:07 -0400
X-MC-Unique: L87-ln_FMa6BzS8tUYo5IA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 021A48015BA;
        Thu, 19 May 2022 00:39:07 +0000 (UTC)
Received: from localhost (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD749492C3B;
        Thu, 19 May 2022 00:39:05 +0000 (UTC)
Date:   Thu, 19 May 2022 08:39:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>, akpm@linux-foundation.org,
        zohar@linux.ibm.com
Cc:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
Message-ID: <20220519003902.GE156677@MiWiFi-R3L-srv>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-5-coxu@redhat.com>
 <YoTYm6Fo1vBUuJGu@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoTYm6Fo1vBUuJGu@osiris>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/18/22 at 01:29pm, Heiko Carstens wrote:
> On Thu, May 12, 2022 at 03:01:23PM +0800, Coiby Xu wrote:
> > From: Michal Suchanek <msuchanek@suse.de>
> > 
> > commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> > adds support for KEXEC_SIG verification with keys from platform keyring
> > but the built-in keys and secondary keyring are not used.
> > 
> > Add support for the built-in keys and secondary keyring as x86 does.
> > 
> > Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> > Cc: stable@vger.kernel.org
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: kexec@lists.infradead.org
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> > Acked-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > ---
> >  arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> As far as I can tell this doesn't have any dependency to the other
> patches in this series, so should I pick this up for the s390 tree, or
> how will this go upstream?

Thanks, Heiko.

I want to ask Mimi if this can be taken into KEYS-ENCRYPTED tree.
Otherwise I will ask Andrew to help pick this whole series.

Surely, this patch 4 can be taken into s390 seperately since it's
independent, both looks good.

Thanks
Baoquan

