Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E53C76196
	for <linux-s390@archiver.kernel.org>; Fri, 31 Mar 2023 15:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjCaPS0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjCaPSY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Mar 2023 11:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1841A4C39
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680275857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=RbEyqdcLizjZKl8WCc0rYnqqbfS6Vv2f4uc5dW3Z0h+NuaRzgE0WKiraeCUdh4Y8khhhV9
        gVcbCjgaYXIkkNKEqpHmdIkMxD1t5NRKQn2v7DYcnXZ1b4DGlTTsYzga+loyyC+uslqcLQ
        Y8eAO5++Qb4MqCqB0vIYM47gIIBhrbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-KYLKgkf3NweN5pB71c5vQw-1; Fri, 31 Mar 2023 11:17:31 -0400
X-MC-Unique: KYLKgkf3NweN5pB71c5vQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E11F285A588;
        Fri, 31 Mar 2023 15:17:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61FB01415126;
        Fri, 31 Mar 2023 15:17:29 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     kvm-ppc@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH kernel] KVM: PPC: Make KVM_CAP_IRQFD_RESAMPLE platform dependent
Date:   Fri, 31 Mar 2023 11:17:24 -0400
Message-Id: <20230331151724.359934-1-pbonzini@redhat.com>
In-Reply-To: <20220504074807.3616813-1-aik@ozlabs.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Queued, thanks.

Paolo


