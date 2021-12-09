Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDCCC433FE
	for <linux-s390@archiver.kernel.org>; Thu,  9 Dec 2021 11:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhLILEU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Dec 2021 06:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235224AbhLILET (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Dec 2021 06:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639047644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00ij93hlZOT6u8A5z6dxMNboZcPXsP119VNHIIhnypY=;
        b=ba71KuPWUJXJH6YG8nbRAkcvkfdjc/bcEllDL9WoP5pFJAS/EkYvytc3gxXVyAkRuuMwtz
        SLmlmzjAQ7hN7L5DAo8jIvLqfHlhplH/Z4Ussq6xpfR3v7zotxoZjZXC2D4h3HWkegh9b2
        B81Xuu1BZtEb1CL6vgxOLRN9OjulHlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-ssb66sbKOASJOUYS4achUA-1; Thu, 09 Dec 2021 06:00:42 -0500
X-MC-Unique: ssb66sbKOASJOUYS4achUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269B4100F953;
        Thu,  9 Dec 2021 11:00:40 +0000 (UTC)
Received: from rhtmp (unknown [10.39.193.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B8A619729;
        Thu,  9 Dec 2021 11:00:39 +0000 (UTC)
Date:   Thu, 9 Dec 2021 12:00:37 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     ltao@redhat.com, hca@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/kexec: handle R_390_PLT32DBL reloc entries in
 arch_kexec_do_relocs()
Message-ID: <20211209120037.050e3db1@rhtmp>
In-Reply-To: <8735n32dua.fsf@oc8242746057.ibm.com>
References: <20211208105801.188140-1-egorenar@linux.ibm.com>
        <20211208145930.1ab4ce50@rhtmp>
        <8735n32dua.fsf@oc8242746057.ibm.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Alexander,

On Wed, 08 Dec 2021 18:42:05 +0100
Alexander Egorenkov <egorenar@linux.ibm.com> wrote:

> Hi Philipp,
>=20
> Philipp Rudo <prudo@redhat.com> writes:
>=20
> > Hi Alexander,
> >
> > thanks for taking care of this so fast!
> >
> > My personal approach was slightly different (see below). The idea
> > behind this was that arch_kexec_do_relocs is also used by others which
> > might have a PLT. For them your approach would mean an ABI breakage. On
> > the other hand in case the other users have the same problem they would
> > need to handle it for themselves. Not sure what's the better approach.
> > =20
>=20
> I'm also fine with your proposal for the fix.
>=20
> If i'm not mistaken, arch_kexec_do_relocs() is used in decompressor and
> for purgatory at the moment, and both should have all relocs resolved.
> Do we have more users of arch_kexec_do_relocs() ? That was the reason i
> added the fix to arch_kexec_do_relocs().

no, there are no other users of arch_kexec_do_relocs other than
kexec_file and kaslr at the moment.

=46rom a technical perspective your patch was totally fine for todays
use cases. My concern was more for a potential future user. But maybe I
was a little bit overcautious...=20

> Now i'm actually wondering why we don't have any issues with
> decompressor, probably because we do the final link where all
> PLT-relative addresses are fixed. Because i see plenty of R_390_PLT32DBL
> in startup.o e.g.

IIUC, the culprit is the '-r' option in the LDFLAGS. With this option
the output can be used again as input _for ld_. The way I interpret
this is that ld can (and apparently does) use any internal convention
without complying with the ABI when this option is given.

kaslr doesn't use '-r' but a combination of -fPIE (CFLAGS) and -pie
(LDFLAGS) so they are not affected by ld's internal behavior. Maybe
it's worth investigating in the long run if the purgatory could be build
with -fPIE/-pie as well.

Thanks
Philipp

