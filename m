Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93350C43460
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 09:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E2261073
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 09:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhDOJCL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbhDOJCL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Apr 2021 05:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618477308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmprK/s2yXLK9tg/KIh5Kw+EZoIvomLpdnmrP8qdZsg=;
        b=OLak3G9iOfx3iMja89o/qFhPBYEv1zRh0c0AplCJyIqZC9Xt5k8IOMTfZUjg6DwNYU0Fva
        3PHL96rsiDue1z5rzlKg2+ans2dPhCNOvsInusnPaxxUOoexXEMMbfuHdGDVNs8jqt5Pok
        3Lhuj2J+BCmFxrP/EFmFrz46/efmUC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-yV-e3MiMNAyRdES6OBB4Zg-1; Thu, 15 Apr 2021 05:01:44 -0400
X-MC-Unique: yV-e3MiMNAyRdES6OBB4Zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49A5A1898284;
        Thu, 15 Apr 2021 09:01:43 +0000 (UTC)
Received: from gondolin (ovpn-113-158.ams2.redhat.com [10.36.113.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A4107086C;
        Thu, 15 Apr 2021 09:01:37 +0000 (UTC)
Date:   Thu, 15 Apr 2021 11:01:34 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] KVM: s390: fix guarded storage control register
 handling
Message-ID: <20210415110134.46136db2.cohuck@redhat.com>
In-Reply-To: <20210415080127.1061275-1-hca@linux.ibm.com>
References: <20210415080127.1061275-1-hca@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 15 Apr 2021 10:01:27 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> store_regs_fmt2() has an ordering problem: first the guarded storage
> facility is enabled on the local cpu, then preemption disabled, and
> then the STGSC (store guarded storage controls) instruction is
> executed.
> 
> If the process gets scheduled away between enabling the guarded
> storage facility and before preemption is disabled, this might lead to
> a special operation exception and therefore kernel crash as soon as
> the process is scheduled back and the STGSC instruction is executed.
> 
> Fixes: 4e0b1ab72b8a ("KVM: s390: gs support for kvm guests")
> Cc: <stable@vger.kernel.org> # 4.12
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

