Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450CAC433F5
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F3661360
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 15:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhJDPwt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235983AbhJDPws (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 11:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633362659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wnNQLEGYyuqtuWKutOrdKZyTyV/siDKuhdgiO+cXLTs=;
        b=dgsIVRBjNOSoNZsUEy7Vf1rOGD5gUB2B3386ryxhI514LkdsUza/TN2HgtsgK9xzxzk60Q
        ce1gGkYq87kVC4tDc3AcqzM6CIEl48Spjtgg75POlYT/gPm5Rw8TJTH/1EUZyY/XeLsPc8
        nBEt2hcTGYCayRlcDNUy95GuBFXGeUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-c0t_ZGP3Pt2ItEdpb_iEag-1; Mon, 04 Oct 2021 11:50:58 -0400
X-MC-Unique: c0t_ZGP3Pt2ItEdpb_iEag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F25A3824FA6;
        Mon,  4 Oct 2021 15:50:56 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C9BB10016FB;
        Mon,  4 Oct 2021 15:50:45 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211004110537-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <875yuc3ln2.fsf@redhat.com>
 <20211004110537-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Mon, 04 Oct 2021 17:50:44 +0200
Message-ID: <87wnms23hn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 04:33:21PM +0200, Cornelia Huck wrote:
>> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
>> >> 
>> >> [cc:qemu-devel]
>> >> 
>> >> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> 
>> >> > On Fri, Oct 01, 2021 at 09:21:25AM +0200, Halil Pasic wrote:
>> >> >> On Thu, 30 Sep 2021 07:12:21 -0400
>> >> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> >> 
>> >> >> > On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
>> >> >> > > This patch fixes a regression introduced by commit 82e89ea077b9
>> >> >> > > ("virtio-blk: Add validation for block size in config space") and
>> >> >> > > enables similar checks in verify() on big endian platforms.
>> >> >> > > 
>> >> >> > > The problem with checking multi-byte config fields in the verify
>> >> >> > > callback, on big endian platforms, and with a possibly transitional
>> >> >> > > device is the following. The verify() callback is called between
>> >> >> > > config->get_features() and virtio_finalize_features(). That we have a
>> >> >> > > device that offered F_VERSION_1 then we have the following options
>> >> >> > > either the device is transitional, and then it has to present the legacy
>> >> >> > > interface, i.e. a big endian config space until F_VERSION_1 is
>> >> >> > > negotiated, or we have a non-transitional device, which makes
>> >> >> > > F_VERSION_1 mandatory, and only implements the non-legacy interface and
>> >> >> > > thus presents a little endian config space. Because at this point we
>> >> >> > > can't know if the device is transitional or non-transitional, we can't
>> >> >> > > know do we need to byte swap or not.  
>> >> >> > 
>> >> >> > Hmm which transport does this refer to?
>> >> >> 
>> >> >> It is the same with virtio-ccw and virtio-pci. I see the same problem
>> >> >> with both on s390x. I didn't try with virtio-blk-pci-non-transitional
>> >> >> yet (have to figure out how to do that with libvirt) for pci I used
>> >> >> virtio-blk-pci.
>> >> >> 
>> >> >> > Distinguishing between legacy and modern drivers is transport
>> >> >> > specific.  PCI presents
>> >> >> > legacy and modern at separate addresses so distinguishing
>> >> >> > between these two should be no trouble.
>> >> >> 
>> >> >> You mean the device id? Yes that is bolted down in the spec, but
>> >> >> currently we don't exploit that information. Furthermore there
>> >> >> is a fat chance that with QEMU even the allegedly non-transitional
>> >> >> devices only present a little endian config space after VERSION_1
>> >> >> was negotiated. Namely get_config for virtio-blk is implemented in
>> >> >> virtio_blk_update_config() which does virtio_stl_p(vdev,
>> >> >> &blkcfg.blk_size, blk_size) and in there we don't care
>> >> >> about transitional or not:
>> >> >> 
>> >> >> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>> >> >> {
>> >> >> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>> >> >>     return virtio_is_big_endian(vdev);
>> >> >> #elif defined(TARGET_WORDS_BIGENDIAN)
>> >> >>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>> >> >>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>> >> >>         return false;
>> >> >>     }
>> >> >>     return true;
>> >> >> #else
>> >> >>     return false;
>> >> >> #endif
>> >> >> }
>> >> >> 
>> >> >
>> >> > ok so that's a QEMU bug. Any virtio 1.0 and up
>> >> > compatible device must use LE.
>> >> > It can also present a legacy config space where the
>> >> > endian depends on the guest.
>> >> 
>> >> So, how is the virtio core supposed to determine this? A
>> >> transport-specific callback?
>> >
>> > I'd say a field in VirtIODevice is easiest.
>> 
>> The transport needs to set this as soon as it has figured out whether
>> we're using legacy or not.
>
> Basically on each device config access?

Prior to the first one, I think. It should not change again, should it?

>
>> I guess we also need to fence off any
>> accesses respectively error out the device if the driver tries any
>> read/write operations that would depend on that knowledge?
>> 
>> And using a field in VirtIODevice would probably need some care when
>> migrating. Hm...
>
> It's just a shorthand to minimize changes. No need to migrate I think.

If we migrate in from an older QEMU, we don't know whether we are
dealing with legacy or not, until feature negotiation is already
done... don't we have to ask the transport?

