Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF8C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 15:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41FC611AE
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 15:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhJEP1k (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235411AbhJEP1g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 11:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633447545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFyOXULNG37B2RXyMjh+ETk1npKEA5EyN+8as2bm268=;
        b=acB+WXiBYUf5GYJveAfTVB//aHu41VpyC4dqluN/NoGQ+wx+HZzc4l3PpedBTeGWOfpl5L
        A6K5Y3Ad+9IE5VEIPtECj91cKKZvZJ+r0o/N7vPmfKtMIusPJ0RQWRKj+QtM8scgLKbvPk
        NPfdDd8TT0gDpMJi0jdovE/Z/8GAPiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-APCPKKKXMWSVumbKwVQo8w-1; Tue, 05 Oct 2021 11:25:44 -0400
X-MC-Unique: APCPKKKXMWSVumbKwVQo8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8E029F939;
        Tue,  5 Oct 2021 15:25:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E82885F4F6;
        Tue,  5 Oct 2021 15:25:33 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, linux-s390@vger.kernel.org,
        markver@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211005135909.2b8ab021.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com> <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
 <20211004040937-mutt-send-email-mst@kernel.org>
 <20211005124303.3abf848b.pasic@linux.ibm.com> <87lf372084.fsf@redhat.com>
 <20211005135909.2b8ab021.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 05 Oct 2021 17:25:32 +0200
Message-ID: <87czoj1ok3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 05 Oct 2021 13:13:31 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>> Or am I misunderstanding what you're getting at?
>> 
>
> Probably. I'm talking about pre- "do transport specific legacy detection
> in the device instead of looking at VERSION_1" you are probably talking
> about the post-state. If we had this new behavior for all relevant
> hypervisors then we wouldn't need to do a thing in the guest. The current
> code would work like charm.

Yeah, I was thinking more about the desired state. We need to both fix
QEMU (and other VMMs or devices should check whether they are doing the
right thing) and add a workaround on the driver side to make it work
with existing QEMUs.

