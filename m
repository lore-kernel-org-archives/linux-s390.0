Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B0EB64DC
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jun 2023 13:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFUN47 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjFUN4x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Jun 2023 09:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100F91BC3
        for <linux-s390@vger.kernel.org>; Wed, 21 Jun 2023 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687355765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7y9KT9PySXHthutNF44xmw8PTiv1Tz4Z5j5n+ktDan8=;
        b=Pcaysak2oXYE3NzwHuODC5eA9CoPu4lgPIfEhbpbGAIJJa2PCcbmA4sNuTNGCuxdMH2g2U
        /E+IlYOcbXUPXYXOqFIV3/m7+2e+K7jJl1empK/kBvsu1mXu1mCzE6te5zCWbhGBUCmD0c
        biMAThqLuPJ67BUABlTDzKfKbYM0Al4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-U3catim0OvG360Z-jaGMYg-1; Wed, 21 Jun 2023 09:56:01 -0400
X-MC-Unique: U3catim0OvG360Z-jaGMYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E914D858290;
        Wed, 21 Jun 2023 13:55:59 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF9512166B32;
        Wed, 21 Jun 2023 13:55:58 +0000 (UTC)
Date:   Wed, 21 Jun 2023 21:55:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZJMBa76Yx3ITgMYH@MiWiFi-R3L-srv>
References: <20230620131356.25440-11-bhe@redhat.com>
 <202306211329.ticOJCSv-lkp@intel.com>
 <ZJLTxUOCEMh6l/El@MiWiFi-R3L-srv>
 <ZJLVB3CtS+3TodSp@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJLVB3CtS+3TodSp@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/21/23 at 12:46pm, Alexander Gordeev wrote:
> On Wed, Jun 21, 2023 at 06:41:09PM +0800, Baoquan He wrote:
> 
> Hi Baoquan,
> 
> > > [auto build test ERROR on akpm-mm/mm-everything]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > > patch link:    https://lore.kernel.org/r/20230620131356.25440-11-bhe%40redhat.com
> > > patch subject: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
> > > config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/config)
> > > compiler: s390-linux-gcc (GCC) 12.3.0
> > > reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/reproduce)
> > 
> > Thanks for reporting this.
> > 
> > I followed steps in above reproduce link, it failed as below. Please
> > help check if anything is missing.
> 
> Could it be because you locally have the fix you posted aganst v6?

I am not sure. I failed to setup the cross compiling environment
accoridng to steps of lkp. I borrowed a s390x machine, will build with
the config of lkp test robot to see if I can reproduce it.

