Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107694;
	b=5cgIsmvoW0sTO3pe6Vis/WjalUMOk5dONB4xM8Xohs0TplqehuxjzSdqa0LXfnmQrwVb
	 2zZJSSjYZ2ghz2uemMfWecLLosMmWN/BRLsX+oLM7cLzL4+ZmFXiFUxQw2F/6fDUj1SBS
	 U+SXbAW80nXfRtWYRVfq8dwJG5Ia1yCAK74x6/hpWsVhv6DYplEKP79kfpWPx52hg/J/S
	 92XL0N6w9wERZhXZkXWptzRz1I3uHeJgN1u1hvSMWgmJO+vor0IBgoccSWTmXonQxCOyp
	 1f3/imJhLQime+t3W2hmEojy5RBGCZyotatF6bvkFGurR2KQ9J6UqiBg2ScxiPhYHdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107694;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
	b=f4jLuaqIoywYRxNr56gQ+3wYoEqDifviph0sphCHTN0Ij7SBgWrFQhNhunl+9cB6QORZ
	 o2xJRYQKJ6OHQjkLjgikgDY3Qbg0r3G1bmv42hHLotib6MUBjm8wM500gXHPm6KGKjS6E
	 QhdSoAQq7tGd9t0CmKIJEAq722wHi1FWd7e4A6n3zQKuGfSu1Hp1PnoNYvWv16Ynm/C2B
	 JQi2zDHfp/+4jqOa7v+v/LrzTAvHgk3WySbl/89Bb2P87wnuraSvELxBuNnkbunE1nEks
	 wQ1eeK0f7p66+/EtB/ej6uWzotoRQlonitwrUJYe4e/HD1KfKztAqnx0swQ6BDJmyng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EnwLxlcy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LnuptCKh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE6606A324
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 17:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBDE6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EnwLxlcy;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LnuptCKh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795107692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
	b=EnwLxlcyMafNx2JDTDVFOUg6DA/urKG3Ke1Uj09NZ/FvtUxnRm7I1388zNAEtpEgH0OlOi
	1fgSpha9pxStGIg+AQGC6V9ogwA2/Dwjv89ERV7OYA5220KRzuKRRIoLzlTn9eXMaboOMm
	6Tdn+uU6MZ3HM5dLFpSNXoq/+HH7ylg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-S7pR5xRaPEuPyRYCzv_b6A-1; Thu, 19 Nov 2026 12:01:30 -0500
X-MC-Unique: S7pR5xRaPEuPyRYCzv_b6A-1
X-Mimecast-MFC-AGG-ID: S7pR5xRaPEuPyRYCzv_b6A_1795107690
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3f3e256e8so24604a91.2
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 09:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795107689; cv=none;
        d=google.com; s=arc-20260327;
        b=iCQ3mfEzNRmbClZeqThayvISOXqaRvrUWPXCOGYqqsJ+1ekb9KuxbWLPQJWqqojY5s
         7tJVD/bDeh/3f6sL+SAuTtNt9v6F9mPZUvdU7hzkVZIuNYrMAuyu7HyAnMGhYTlXwB0c
         WuSP1g7plvUT8UGI0ioxLUNHrbx19uc5crzldvx1zT59xH7be+x8L5ASTEWT5GHtDCHL
         FI4zO5dLW5HCD8EMMFh+OX0urGCJdfQA+1AdHFULA81CDr56dXfZNAzn/beDjk4ZQfk3
         smPMo7gCxJ/I2Tw45NsFm/pLjek0ROMZMbfENzbVPny3Nv+Ew3A1XCJ4NEbhK4mLjVvj
         lJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
        fh=hOfNUtJ5k0Ysj+CPw2UioeMzVm9biC3s2KYGiLd4ANU=;
        b=bOzS5JhOy5ZP+b6dqP/aIPXhchBsvhqP6+GYyXTXvX+iN78yOzOqCgYqPrcDCTjX97
         tc2fHI45MA0V4ObVNidpbgWYP0MUqs4pUccJQWkZouuFvUHN0/4sxUKK0H34Regf/8JM
         mvUhGb32XXyclbUV1717sA/09lbfz37kdYx9M8NIXVr8jJSF9x2nKtF0miAFocxMvjK0
         fGJmQUeVA4MwrHWLbcehcoypdLACCOIDR37MBukt8zsP4L56uccMsdKCTlmgDKShderv
         pDmuBS6gSZwJtgbe69HFb/CfOOkUMlcCzByy8JTUuzAZ6eQRtCHdjNRAlhckGQXkTlqq
         zuvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795107689; x=1795712489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
        b=LnuptCKhiewPtlzNYcj22AgqS0jkiivyHH/2i/kHd/TYuVuivbPameYJuMsDooGOKK
         A/FbMsp01am+vPY52tweefpmoMMGNmVbc1S3AU8EQKglIk3/FGQXnRUWsX2Gcw5+NBxd
         REZMqPNyrMY8Jpg0LZT/b6vw5Ql86rk1qPpuTaqpHx/wRGqbTsmVQb4vEgQ2Ghag4jlS
         wElT49hTTPPFxsWgAgUi82iTuwoUwlYiz+dewdFtmLOtj13gquwGBEF3Kjovs4beXGfE
         PeW7OEVvl3uCUP+Z2eBqaAKYzPFXEL1sDRjx2oVV/IEhdpbb0EvrtUn4JoTkolekZArG
         CgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107689; x=1795712489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
        b=fcBSp234iN7O/SooIrSYQwkjN9O1UM9aNk/zxxI2MJuy6S53h5UblSLCDRos9qQ1Gn
         P6TNvwL/UuN0IXf74Kv1ElZtGud2AqVqdc706aSTnRjQqkCY0/BEhgKlyfrIFoQDkDoU
         GTRUt8jTC7owq1b+oe8Ssahp0FmGW87Fk8Qd2BKQUFX/to+eylLROtr15zpcgy/14A7Y
         k/NDpX96rz5QNB1YwTvK+1WVCcFjwHpISABWmCpPYJgVaq4CcmWQsnbC8K3e86nNO+wG
         a4kNMx0lbjT+k3r2j4EHmr5/Ok8UDJekc572AAOFw3tu6Clb2UGZIdVN+NyhImIhxxkR
         QFPg==
X-Forwarded-Encrypted: i=1; AL+hErH+W9AMJVhbRrjnal7Oun3rSiurpzkBF+hVvhbm7YTNLsIrUUzhJn3ro8JQBRnorkkhm14EYkmCE/b0@vger.kernel.org
X-Gm-Message-State: APuU4Z9vsrzBRp04AvjhoyxRIW++sThOJjR9paImwhcCYpvTbN51BBBq
	Xj76fCG45xls3PZ3as2o3RhuXQj6o4OEku473/2MubIOxQuTIyr8WcLbSQ699rJNWVfN0tY2AU0
	T3bXzlsrc5iylwpXriDVGvWZieVnM6Nh96Ld394f4un44iIekzX1laXYSDmD18H+nZ4+zBaAgcC
	8dWrSOzAsnD9CJcpWQrzMYkG26vuTiTyTmGuGNpw==
X-Gm-Gg: AZFdTZdOlAqsI1xth+hESzjHhd7vXi8X0xFFh7WQw2fOmvygqxYrUxSiNw5MY0zG5e0
	FdNrjdmU8SUXw7d7pNiQxU0ds5thngxz4BgiX/QO7WBK2UVs9t3O1BVzK2e4eSLrcjOgKi+agy3
	EhJ9p6rKF435e3YO7r24n3q+uQD+jOmFf2onZHbQ600BDP88O7ybBlogZkQPjrGL/WNSqpGwO7u
	4OYp0wv2GYpCM0pWhudmHbXJpM/eZ9ncKcVq2Zmu83IWA==
X-Received: by 2002:a17:90b:3b48:b0:3b3:b71e:b2f3 with SMTP id 98e67ed59e1d1-3b3d07d45e5mr6391818a91.45.1795107689337;
        Thu, 19 Nov 2026 09:01:29 -0800 (PST)
X-Received: by 2002:a17:90b:3b48:b0:3b3:b71e:b2f3 with SMTP id
 98e67ed59e1d1-3b3d07d45e5mr6391785a91.45.1795107688774; Thu, 19 Nov 2026
 09:01:28 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
In-Reply-To: <20261106164958.431978-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Nov 2026 18:01:17 +0100
X-Gm-Features: AclHuK9gbMLbzJlV5OY-0UEhrBFcgOdr2MuiGO3o20p9P6uVz6SxjkcfZmnaOTc
Message-ID: <CABgObfZYZxd2RMaWxyMwEoi860hAmtkjGCLh+YB9G7tpUVwStg@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] KVM: s390: Fixes for 7.4
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Christoph Schlameuss <schlameuss@linux.ibm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>, 
	Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:50=E2=80=AFPM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Paolo,
>
> first bunch of fixes. Some more are pending for the next round
> but I have not fully processed those. Those will come next week
> depending on how KVM forum works.

Pulled now, thanks.

Paolo

>
> The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7=
e4:
>
>   Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-master-7.4-1
>
> for you to fetch changes up to 62aef2c04e0e69a9b88affa74ff699ce5c4e8652:
>
>   selftests: drivers/s390x: Select uvdevice tests using the target archit=
ecture (2026-11-05 16:40:22 +0100)
>
> ----------------------------------------------------------------
> KVM: s390: Fixes
>
> - Fixes for the arm layer
>         - sashiko: https://sashiko.dev/#/patchset/20261103-s390_arm64_kvm=
_fixups-v1-0-21c36fedd878%40linux.ibm.com
> - Fix ESSA instruction handling in migration mode
>         - sashiko: https://sashiko.dev/#/patchset/20261015104822.77062-1-=
ggala%40linux.ibm.com
> - Fix crypto instruction no-hook handling
>         - https://sashiko.dev/#/patchset/20261020082534.481867-1-ggala%40=
linux.ibm.com
> - Fix selftest for uvdevice
>
> ----------------------------------------------------------------
> Andreas Grapentin (2):
>       KVM: s390: arm64: Declare enum vcpu_sysreg
>       KVM: s390: arm64: Fix kvm_arm64 module naming consistency
>
> Gautam Gala (2):
>       KVM: s390: fix ESSA addressing exception injection in migration mod=
e
>       KVM: s390: pqap: fix AP status written to wrong half of GR1
>
> Sasha Levin (1):
>       selftests: drivers/s390x: Select uvdevice tests using the target ar=
chitecture
>
> Steffen Eiden (1):
>       KVM: s390: arm64: Turn vcpu->arch.pause into a counter
>
>  arch/s390/include/asm/kvm_host_arm64.h                |  8 ++++----
>  arch/s390/kvm/arm64/Makefile                          | 12 ++++++------
>  arch/s390/kvm/gmap/dat.c                              |  5 ++++-
>  arch/s390/kvm/s390/priv.c                             |  8 +++++---
>  .../testing/selftests/drivers/s390x/uvdevice/Makefile | 19 ++++++-------=
------
>  5 files changed, 25 insertions(+), 27 deletions(-)
>

