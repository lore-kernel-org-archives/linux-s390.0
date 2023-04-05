Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2790BC76188
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 19:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjDETqw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjDETqv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 15:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF199EC
        for <linux-s390@vger.kernel.org>; Wed,  5 Apr 2023 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680723968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v0UG0byeuqLhQs+HkvCytAyNPcDi89bMLk15Ot/Yb9o=;
        b=ZOYLGuWVPhLfJ2DhhLo51PL1MEOLiNSxHqSztnljTDUGdYuqK9PfLah3kUDHIi+7/3/O7F
        /p5V19xXdxrTVfMueOLJltTALBywxXz9shzdDtdDAFuUUsO1DNFx93ouQtpDB3/fkw/CiB
        gl2ldDL+HggIclYLXv9kiWSsbvTpMyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-rTa71ey2MCCQay6tZWFKhw-1; Wed, 05 Apr 2023 15:45:59 -0400
X-MC-Unique: rTa71ey2MCCQay6tZWFKhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29B30101A550;
        Wed,  5 Apr 2023 19:45:57 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B72E940C6EC4;
        Wed,  5 Apr 2023 19:45:55 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 8DE6240134449; Wed,  5 Apr 2023 16:45:32 -0300 (-03)
Date:   Wed, 5 Apr 2023 16:45:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, arnd@arndb.de,
        keescook@chromium.org, paulmck@kernel.org, jpoimboe@kernel.org,
        samitolvanen@google.com, ardb@kernel.org,
        juerg.haefliger@canonical.com, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, tony@atomide.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        nick.hawkins@hpe.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, vschneid@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <ZC3P3Ds/BIcpRNGr@tpad>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC1XD/sEJY+zRujE@lothringen>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Apr 05, 2023 at 01:10:07PM +0200, Frederic Weisbecker wrote:
> On Wed, Apr 05, 2023 at 12:44:04PM +0200, Frederic Weisbecker wrote:
> > On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
> > > +	int state = atomic_read(&ct->state);
> > > +	/* will return true only for cpus in kernel space */
> > > +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> > > +}
> > 
> > Also note that this doesn't stricly prevent userspace from being interrupted.
> > You may well observe the CPU in kernel but it may receive the IPI later after
> > switching to userspace.
> > 
> > We could arrange for avoiding that with marking ct->state with a pending work bit
> > to flush upon user entry/exit but that's a bit more overhead so I first need to
> > know about your expectations here, ie: can you tolerate such an occasional
> > interruption or not?
> 
> Bah, actually what can we do to prevent from that racy IPI? Not much I fear...

Use a different mechanism other than an IPI to ensure in progress
__get_free_pages_fast() has finished execution.

Isnt this codepath slow path enough that it can use
synchronize_rcu_expedited?

