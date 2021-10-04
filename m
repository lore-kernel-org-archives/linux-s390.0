Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2649C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 07:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D160610E6
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 07:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhJDHDq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232375AbhJDHDn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 03:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633330914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/XfU4rWvDAgggUknehKIH8tN+C4S9auUfbUS+SGc1Y=;
        b=Nx8a1I0q8zI++hdRCwsDmlLz+25pjLsE13NM33Y7xIYEqi47Rp/GCXjIeUU331iXYYkQNO
        upacob8FpM3LDn2u9tynDC6M0lmKa2x28gVwBzXZ25XD4s1o421O39PgZRlSikj6hih91Y
        2M2uNRNmZGXIf42b3wBhcjGiL78QwWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-HVuoH5hPNc2doNzFCNwWqQ-1; Mon, 04 Oct 2021 03:01:51 -0400
X-MC-Unique: HVuoH5hPNc2doNzFCNwWqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB74B91274;
        Mon,  4 Oct 2021 07:01:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D20AF51DFA;
        Mon,  4 Oct 2021 07:01:44 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211002082128-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com> <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Mon, 04 Oct 2021 09:01:42 +0200
Message-ID: <87pmsl2rzd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Oct 01, 2021 at 05:18:46PM +0200, Cornelia Huck wrote:
>> I'd say we need a hack here so that we assume little-endian config space
>> if VERSION_1 has been offered; if your patch here works, I assume QEMU
>> does what we expect (assmuming little-endian as well.) I'm mostly
>> wondering what happens if you use a different VMM; can we expect it to
>> work similar to QEMU?
>
> Hard to say of course ... hopefully other VMMs are actually
> implementing the spec. E.g. IIUC rust vmm is modern only.

Yes, I kind of hope they are simply doing LE config space accesses.

Are there any other VMMs that are actually supported on s390x (or other
BE architectures)?

