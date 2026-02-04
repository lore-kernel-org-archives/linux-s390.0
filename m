Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305B2C3745
	for <linux-s390@vger.kernel.org>; Wed,  4 Feb 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205661; cv=pass; b=PtJkftXu210+OJEC6JdaCh7ZiaDSJLiDIfXPx7HeKZLvHjvIDyaLk3iF9vtHq/pxXgPvBG4vYqG6sMPxWZPx5W2Wp6fxEasZcVt5SUkDoNynMbMvnI5DCYR7ZxoFPmoL2M/VEn8XmzJX3dax+wXuwOe+MNevr6wwAePlCTaRSqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205661; c=relaxed/simple;
	bh=bEVPeML+wLtbEJlc7Ek2zFugLGebCrtuCYqQUr+0kT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC2M9MKpQs/uDCBWThvG5a14w/RCJAuLWZJM9byZgGNx+7eQvJ5Lftb0fE6QlZjp9DhR58VsEOvS/pyRIgJYQUX0j6PCXK7vTR9tySrygMFczYEckgW9Hte8XezGrjxJy1mEkLuwvFgtJ+fwXAowB08DX/Bzp+e1vJUElVQ/p20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfKOwu2B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2qPUC4I; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfKOwu2B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2qPUC4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770205660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41m/oc+dMSUkM8uHzNx611jXZiOBNudNWORLl8cHNfw=;
	b=bfKOwu2BaPEmE9qTmR7hB0XERStiimwl5upEdHnUUBknzVrUXBK8AlGsW/gVEUHVKT1TNp
	yn8iTOuGCf3Ald+5aFiUFC5hHc7IxlAcBSR6zUZiHujRyL10gizYmLhLsefLw2OiNRn/mz
	yNilhI06K7QuvEVbO/XT9Xyv0D98jbw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-LPzyZXCtNlierB93M6ReBA-1; Wed, 04 Feb 2026 06:47:39 -0500
X-MC-Unique: LPzyZXCtNlierB93M6ReBA-1
X-Mimecast-MFC-AGG-ID: LPzyZXCtNlierB93M6ReBA_1770205657
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-385c90cbca6so6749331fa.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Feb 2026 03:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770205657; cv=none;
        d=google.com; s=arc-20240605;
        b=XvUC8ituvEKwXTCYtC31DqtVhI97lr7TsZWAkGBBXkv3vcFJIeiFKwQ07tdexwuGdq
         BQDgvc9lvQTuZNaxSVyFmfPcpHDO6tUrIBDOicMX0KTtCns+N+evkSNMgJkSziOJEVnt
         zg7veBzeZlZyPlqAsmFJQA0f5FxiGf0/8NpkijRDeQX06fHI2mtw/4J6na83nheFs9PL
         zpCzaVpjYe88aVEgVu7YUS+fHr25TtOtVy/NfXy/lDDkjmXd3x2N5TV0CzbP5vPT+303
         yW/4NihMdfgmbS4pomQ+zOYHt8x8eoaTUyFWNOQbqY/9zZbXPq4drCOjrOdaMCAj2+wb
         M4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=41m/oc+dMSUkM8uHzNx611jXZiOBNudNWORLl8cHNfw=;
        fh=doQ/N3TlIkb3FI0FKXFuJM2F3g8r0Xc4Se1Zi/GxILk=;
        b=Cs7sSUlEfvogE8TuyqPQtSaSioWaoy5D2G+g1CrNGjZne6LQyFlORHgGj3eUMsxCKv
         Cu7XG6ofkRAEVKkYb7osscGRVgh/kzv9ywDH8za6SpMjTarhlcDbSpRUpNzLosBGuzUm
         8WlyB7ZaP0AId7+Hfc3sOXBM8sgLzYmq1n+KmjLegfJM6PqC8ePZgLrXyDR8LDmHuhQ3
         cNdVNtTuZouf0wzUQB0feVSb0nCbu7lXU1YEGmL4FpvUV9eNUAT9KBjZXyjZ3A0yfVxs
         1H7Kq5E7Dg3MNq5US8qTX04UwEiZLrBxDX53t9OM6Us39Kld2L8UinhWjRctkyI9wKRi
         YgHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770205657; x=1770810457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41m/oc+dMSUkM8uHzNx611jXZiOBNudNWORLl8cHNfw=;
        b=M2qPUC4Irz5aJrx/Tlfh5k6I8F8doU2zNZmBHrCE0a90fBcYq4idfXRKVyZsJDypup
         vnKpBfJI4OhTMN/l2tXzygyRIs1QQQNiF7LlvBh4KIjD9nJhf3rA/wWCvownRoXhEmaw
         mnW9hwzybzrrPNbDEsDGyHSpkvb0ujVdCMsTTNTMEyyUFU+zy4zfBPQlYnedP3Ojj5tP
         g1tdHIeF7ovViXJIJrxU+ceL+oouMqQ7dg+yhU8aLJmdssetMD3ceOegy+UYfCvTcL2N
         rd/xP0l09qTNJqHrFvBfvWYskMEui4F5bgC1w9ZUmaG83iqGZlEkH32Dyf1OZm1/4YeQ
         oRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770205657; x=1770810457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41m/oc+dMSUkM8uHzNx611jXZiOBNudNWORLl8cHNfw=;
        b=Q+nE9EOQ1++Arzp4dOou3eOOVjzKFQ1yidSeMxyfmYUOxHjzeoDfmIx4fYgf5zJhPR
         TTctvnD7hncBPWiSJJIL0lgJAhr4EUt5c+PxgVPFq7g3Gq2F40qw1T5Z9z93fZogf+6r
         RV6xwZY2ZONO2iG9+6/zt3OIswqXVDair0bd/6P8G7KsxSBqg3Od0mtXazfrZ46r5frQ
         T6+qhal3ZHQeV8QWXKj6kraPf7xh7jK3x6u5pQDIttn0OIb4hjfrfRUKJ2C57uz5GtPm
         AsOQqBwQns2KhQLR7h9vwuheKwkb5Ol54JuHl/Y8mFF9DDvD/fv7VuBWkuGgL5r9TXi+
         4OXA==
X-Gm-Message-State: AOJu0YzfIKg1y9woiRAsbmSzjzgYVwI1s0DhZ5bSOFCdZ4/LEQxwv2fI
	N2hh3Ky+OTpmb2lJyKZAr1JLtlDVlbkmjaRXw/+2NI4JD4OJIN0kRQHCfwXxGho+Vtb39kFSk01
	CDvMw5dcxHTTS26Qzwc6nP1aMxOgehkZ5CZnEIhTp0i9+34S+2NMOQv0DJMxzYHYqeHOxbz1oC8
	oYlbG/0ByNLGw3VUg16BjLLaFLhjN2rO6p9U0szg==
X-Gm-Gg: AZuq6aK+19WyHRv1rCrqkZm2gZuNkNfTX0p9zSA377q7/352FexnOG9KNemnYkvUid7
	c/WL1++vFzMRWqy8QorslzodRz6krT9cgclW8y24fjfhP7K9DjAd1ecylCp6oj38Mwzi8r9g7zX
	VAUaYjQkx6Te+vopTEySxi99DrfR5N5dCF4fi2PeA0+EK/Y7EME5zMSNX2t37l9WT7pRE=
X-Received: by 2002:a2e:be9e:0:b0:385:f50e:3f4c with SMTP id 38308e7fff4ca-38691cbb5b0mr10975331fa.16.1770205657315;
        Wed, 04 Feb 2026 03:47:37 -0800 (PST)
X-Received: by 2002:a2e:be9e:0:b0:385:f50e:3f4c with SMTP id
 38308e7fff4ca-38691cbb5b0mr10975201fa.16.1770205656841; Wed, 04 Feb 2026
 03:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs_GH0O7-nkh=8EhwscjzesawBJ+6b0MxuWZOOsp4B7HsA@mail.gmail.com>
 <f08b53ccdfc069f4e8c49511b04171bc@linux.ibm.com>
In-Reply-To: <f08b53ccdfc069f4e8c49511b04171bc@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 4 Feb 2026 19:47:22 +0800
X-Gm-Features: AZwV_QiCdBZ8WO6a6aTbcm_ycGmixNJulUN9wFg9vFAjVkU4MYhRp4tYPK-mu00
Message-ID: <CAHj4cs9H67Uz0iVaRQv447p7JFPRPy3TKAT4=Y6_e=wSHCZM5w@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed on zcrypt module after system
 boots up
To: freude@linux.ibm.com
Cc: linux-s390@vger.kernel.org, dengler@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:18=E2=80=AFPM Harald Freudenberger
<freude@linux.ibm.com> wrote:
>
> On 2026-01-30 09:23, Yi Zhang wrote:
> > Hi
> > I found this kmemleak issue after the system boots up with
> > linux-block/for-next, please help check it and let me know if you need
> > any test/info.
> >
> > # uname -r
> > 6.19.0-rc7+
> > # dmesg | grep kmemleak
> > [ 1648.765780] kmemleak: 1 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [ 6148.698090] kmemleak: 2 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [10419.366662] kmemleak: 3 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [14843.424498] kmemleak: 2 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [20987.442195] kmemleak: 2 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> >
> > # cat   /sys/kernel/debug/kmemleak
> > unreferenced object 0x990d0000 (size 12288):
> >   comm "dnf", pid 48539, jiffies 4296356469
> >   hex dump (first 32 bytes):
> >     00 00 00 00 99 0d 36 30 00 00 bb af 00 f7 1d 60  ......60.......`
> >     00 00 00 00 99 0d 00 10 00 00 00 00 99 0d 00 10  ................
> >   backtrace (crc 9893fb1d):
> >     kmemleak_alloc+0x6c/0xc0
> >     ___kmalloc_large_node+0x106/0x160
> >     __kmalloc_large_node_noprof+0x32/0x170
> >     __kmalloc_noprof+0x6d8/0xa00
> >     ap_init_apmsg+0xf6/0x190
> >     zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
> >     icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
> >     zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
> >     __s390x_sys_ioctl+0x178/0x1e0
> >     __do_syscall+0x166/0x460
> >     system_call+0x6e/0x90
> > unreferenced object 0xae148000 (size 12288):
> >   comm "dnf", pid 48539, jiffies 4296356470
> >   hex dump (first 32 bytes):
> >     00 00 00 00 ae 14 b6 30 00 00 bb af 00 f7 1d 60  .......0.......`
> >     00 00 00 00 ae 14 80 10 00 00 00 00 ae 14 80 10  ................
> >   backtrace (crc 41938ebb):
> >     kmemleak_alloc+0x6c/0xc0
> >     ___kmalloc_large_node+0x106/0x160
> >     __kmalloc_large_node_noprof+0x32/0x170
> >     __kmalloc_noprof+0x6d8/0xa00
> >     ap_init_apmsg+0xf6/0x190
> >     zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
> >     icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
> >     zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
> >     __s390x_sys_ioctl+0x178/0x1e0
> >     __do_syscall+0x166/0x460
> >     system_call+0x6e/0x90
> > unreferenced object 0x87dd4000 (size 12288):
> >   comm "dnf", pid 48633, jiffies 4296914470
> >   hex dump (first 32 bytes):
> >     00 00 00 00 94 c7 20 00 00 00 00 00 00 fe 90 80  ...... .........
> >     ff ff ff ff ff ff ff ff 00 10 63 c9 1e a5 48 b8  ..........c...H.
> >   backtrace (crc fb3113e3):
> >     kmemleak_alloc+0x6c/0xc0
> >     ___kmalloc_large_node+0x106/0x160
> >     __kmalloc_large_node_noprof+0x32/0x170
> >     __kmalloc_noprof+0x6d8/0xa00
> >     ap_init_apmsg+0xf6/0x190
> >     zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
> >     icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
> >     zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
> >     __s390x_sys_ioctl+0x178/0x1e0
> >     __do_syscall+0x166/0x460
> >     system_call+0x6e/0x90
> > unreferenced object 0x8e65c000 (size 12288):
> >   comm "dnf", pid 48633, jiffies 4296914470
> >   hex dump (first 32 bytes):
> >     00 00 00 00 aa 22 2e 00 00 00 00 00 00 fe 90 80  ....."..........
> >     ff ff ff ff ff ff ff ff 00 10 63 c9 1e a5 48 b8  ..........c...H.
> >   backtrace (crc 1b33772d):
> >     kmemleak_alloc+0x6c/0xc0
> >     ___kmalloc_large_node+0x106/0x160
> >     __kmalloc_large_node_noprof+0x32/0x170
> >     __kmalloc_noprof+0x6d8/0xa00
> >     ap_init_apmsg+0xf6/0x190
> >     zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
> >     icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
> >     zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
> >     __s390x_sys_ioctl+0x178/0x1e0
> >     __do_syscall+0x166/0x460
> >     system_call+0x6e/0x90--
> >
> >
> >
> > Best Regards,
> >   Yi Zhang
>
> I pulled exactly the repo you mentioned with the "for-linux" branch. But
> again
> there is no kmemleak reported regardless on how I play around with that.
> Can you please describe the environment you ran for this issue in more
> detail?

Hi
Sorry for the late response, the original environment was destroyed.
And the kernel I used was not linux-block/for-next, it's
6.19.0-0.rc7.47.eln154.s390x+debug and can be downloaded here[1].
I also tried to reinstall the server with
6.19.0-0.rc7.47.eln154.s390x+debug, but with no luck in reproducing it
now.

[1]
https://kojipkgs.fedoraproject.org//packages/kernel/6.19.0/0.rc7.47.eln154/=
s390x/
[root@ibm-z-516 ~]# uname -r
6.19.0-0.rc7.47.eln154.s390x+debug
[root@ibm-z-516 ~]# lszcrypt -V
CARD.DOM TYPE  MODE        STATUS     REQUESTS  PENDING HWTYPE QDEPTH
FUNCTIONS  DRIVER
---------------------------------------------------------------------------=
-----------------
01       CEX7C CCA-Coproc  online            0        0     13     09
---D--N--R cex4card
01.0001  CEX7C CCA-Coproc  online            0        0     13     09
---D--N--R cex4queue
[root@ibm-z-516 ~]# cat /proc/cpuinfo
vendor_id       : IBM/S390

> I assume you ran a "real" s390 LPAR or zVM and there must have been some
> kind of crypto card in your system. Could you please give me the output
> of
> "lszcrypt -V" for that system?
>
> Thanks
> Harald Freudenberger
> to send a request down to the kernel.
>


--=20
Best Regards,
  Yi Zhang

