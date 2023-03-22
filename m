Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1467CC6FD1F
	for <linux-s390@archiver.kernel.org>; Wed, 22 Mar 2023 17:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCVRVs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVRVs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Mar 2023 13:21:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70687664D5
        for <linux-s390@vger.kernel.org>; Wed, 22 Mar 2023 10:21:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j11so24323815lfg.13
        for <linux-s390@vger.kernel.org>; Wed, 22 Mar 2023 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1679505683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAMwytLDDPXOJZO7xVxuXg0wtjoShJg+clkvBywaXAo=;
        b=NhEzhajgiO0scbd61FI+YDLNe/DDnEOiVT7Dn5D2fjex5xhRtPRBlBY+JxrearBLuR
         yJ9WEWNww9OUPDpR/YugZQxUS1UBnqNP0yFExwUMGxUJfTrT5VYwaRDx/dh3CR7ZQNA2
         vx2lB9ZbwxHli0lFXOQMAyw0cjcA/Xd+hLVE3EEINvbWDbasZXcbqnsOBWETKPt3zh/w
         Hru80PEpNo5REJZ6HZnYvjhLcRbN8KcB13CqYlSzFrwKwd8vJ6KCyOZ6erFQiOPX9syh
         mxJbXKk7u7WFt6XLNTRW3nNNA1AXT4BIzQLCVemnqXLgNO0IDfFvHQCKHA8HXAFU44bQ
         X/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAMwytLDDPXOJZO7xVxuXg0wtjoShJg+clkvBywaXAo=;
        b=M74Phr/1KiLqAw/LNH0U/LJJDiqZ0LiDwQOF9iyynhW3dazzi79cKEETJc2N2h7IMj
         d90HA9neDx/ZID8wBpz0IBe/69mQ+LrMIoRVtXU82fbzAYeGyYrXoJR85IGDG4ZrXsWt
         Keig4JFCMsxQFNylfXJ5K71skCK8oHQtoV51fA89xvrDeIrCaPbtvtg4r1lASSI9TJiW
         vAJoFBIF/+6USvsfHvcplqKQZ5e4Xsyag95SdtuAfl5gvjs+XweDKq9hzbI/1m3EDLR+
         3CC2c4Lz4F7czac9f1HfibvA/JEUGQaoXCgQnQTcTEGyvFWEvGcT9yZipM75SIa2zQRg
         VUiQ==
X-Gm-Message-State: AO0yUKVBILC3gMrTncA0Z9TpJ/T4GGzAt6mro75VEHEWXVG4NpXvvETl
        GLbcfcOA2oqj5VtapXbGupBVAKqIHJKZ0BeuOtBbQA==
X-Google-Smtp-Source: AK7set9MuRTtqaHAxup5npSc4ZVmoBivLmO5CzIRbhpGcr+n85AcT1Z7IBjQDmgArMu1eeNf2AWjeNPVP6I/j8eTD4w=
X-Received: by 2002:ac2:5989:0:b0:4dd:a025:d8c with SMTP id
 w9-20020ac25989000000b004dda0250d8cmr2195562lfn.5.1679505682982; Wed, 22 Mar
 2023 10:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230322141031.2211141-1-viktor@daynix.com> <20230322123121-mutt-send-email-mst@kernel.org>
 <87mt44hh5f.fsf@redhat.com>
In-Reply-To: <87mt44hh5f.fsf@redhat.com>
From:   Viktor Prutyanov <viktor@daynix.com>
Date:   Wed, 22 Mar 2023 20:21:12 +0300
Message-ID: <CAPv0NP79iv=s-tdTWwb_3cWbucJSH7LTDYo0VxjdnWvpjguK3Q@mail.gmail.com>
Subject: Re: [PATCH v4] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        pasic@linux.ibm.com, farman@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 22, 2023 at 7:42=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> w=
rote:
>
> On Wed, Mar 22 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Wed, Mar 22, 2023 at 05:10:31PM +0300, Viktor Prutyanov wrote:
> >> According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> >> indicates that the driver passes extra data along with the queue
> >> notifications.
> >>
> >> In a split queue case, the extra data is 16-bit available index. In a
> >> packed queue case, the extra data is 1-bit wrap counter and 15-bit
> >> available index.
> >>
> >> Add support for this feature for MMIO, channel I/O and modern PCI
> >> transports.
> >>
> >> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> >> ---
> >>  v4: remove VP_NOTIFY macro and legacy PCI support, add
> >>     virtio_ccw_kvm_notify_with_data to virtio_ccw
> >>  v3: support feature in virtio_ccw, remove VM_NOTIFY, use avail_idx_sh=
adow,
> >>     remove byte swap, rename to vring_notification_data
> >>  v2: reject the feature in virtio_ccw, replace __le32 with u32
> >>
> >>  Tested with disabled VIRTIO_F_NOTIFICATION_DATA on qemu-system-s390x
> >>  (virtio-blk-ccw), qemu-system-riscv64 (virtio-blk-device,
> >>  virtio-rng-device), qemu-system-x86_64 (virtio-blk-pci, virtio-net-pc=
i)
> >>  to make sure nothing is broken.
> >>  Tested with enabled VIRTIO_F_NOTIFICATION_DATA on 64-bit RISC-V Linux
> >>  and my hardware implementation of virtio-rng.
> >
> > what did you test? virtio pci? mmio? guessing not ccw...
> >
> > Cornelia could you hack up something to quickly test ccw?
>
> Hm, I'm not entirely sure how notification data is supposed to be used
> in real life -- Viktor, what is your virtio-rng implementation doing;
> can this be hacked into all transports?

In hardware implementation of split VirtIO queue, the notification data fea=
ture
saves time on a memory request to avail_idx from the device side. I can
definitely say about MMIO, but most likely it is also useful for PCI.
It is also written here that this feature was added for efficiency:
https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg02728.html
Also DPDK has support for this feature in VirtIO PCI:
https://github.com/DPDK/dpdk/commit/7e72f3ec1a8abefd9321a61e484846e16177f5b=
1

>
> (Also, if the other ccw folks have something handy, please speak up :)
>
