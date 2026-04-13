Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FB3BD64E
	for <linux-s390@vger.kernel.org>; Mon, 13 Apr 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079453; cv=pass; b=n2DU5uLmy0v0ujKtPeuE9LOUfYFNnjNnoysl//Eqc+32IIgU5So+nENQhcKQGATczgrczRv9f61LxDZMBESrzY6IRgOJOGo8ex51PYccvgLIm8hjVWLJr0wUXTcSqawvBiuYKau/hBUterH4RPeT/ShQ9/codT5oaSKLx/c6BvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079453; c=relaxed/simple;
	bh=xsKsPS+/LRix2wVTrwLV1Lanow3eWVIGZcL8m0QQv74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvBHoG2+NQAkWnyFUNXKKd8wC3NqHgikce1UI0eNcM7i+db3ufiK4eFkA4GfwZKsOdPca51MMuA8xCGj0geJl0w0X8OiZuiIhbj3IjvcKFixxlIVxzpj5CUQnFtCWus1C3fxLk4ZyKYgK/1RPOd+BWNx8ubWyhsQ6KmdXqC3E1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNBZRziL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgpT/99O; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNBZRziL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgpT/99O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776079450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUqUeA7oo4jBHFJWxogBW0d62Lmyv6k7nApGPlXPmhE=;
	b=FNBZRziL9AEmMbiVCezu8v5xiCV2oATTts3EO7abxsWit/sTtugXF6icoyHK5utntWLhoh
	0eQbg4Zgz+KFpdOKic9jGQ65DgwWSqEY3T94U3lwevyYZhEUm+GoVDA08BKzflcGOe+B64
	z7/P18isxQG+v1L/Fo6ArAQFQ5cnbDc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-JMogbS6ANjWGFwYsNDh3iA-1; Mon, 13 Apr 2026 07:24:09 -0400
X-MC-Unique: JMogbS6ANjWGFwYsNDh3iA-1
X-Mimecast-MFC-AGG-ID: JMogbS6ANjWGFwYsNDh3iA_1776079448
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d03bad787so4102206f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 13 Apr 2026 04:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776079448; cv=none;
        d=google.com; s=arc-20240605;
        b=ibbcucyfjTX9qMa3cdqXSviPq0bV9QGttoT7tEEU/iz9Kp2W3ktRQ2wkN3o1159M7j
         2oFmZkUydZmm/x5rGRSMZgEWUe+4lJW21Awqqw4UH8JmASZ5xs8Yww9CPzn1chMXWAKE
         TBl7BCz26IAJKY98m9pEsDA6NoVTeeEeDqpO4kYyvFHOT624zMZZ8gO1rbWoghkA3Y1e
         5zpUAzss7Ia4XuY9nI63dAbZhbZNWsFZLtN76+kn7NLY2g0AlmbjQ/7LTCMGUkY+0xP4
         +lfdMJevW7VHIb1Db6m+QH/heNMRXmEUZ/OXSxthXcwM3xH23VYonFLDuCa8BtmcuSno
         CNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUqUeA7oo4jBHFJWxogBW0d62Lmyv6k7nApGPlXPmhE=;
        fh=FK9Ntuc9g4RzZEk58PZFwUz/kKEUMY99gTco3c7Q1sI=;
        b=VF6yk9qkdI7ct0KDHdHvsUSVMLwGZ9quEvX7AzQnJJ0aRpNZQRdF6DqAXgtevpZm5z
         CqefXMws23xvHzGWNbjs3iwzJ0rMXZU4eYyPVClJ0YA7J1YNADhjjxoNC+6DPbNzC51t
         pjmDELP/AYikAzWYjsqyoeQtWPwtDgisgvFtpWEKMCoN/DjH169TG2c9EE3jbcoibA53
         zvumSrN+fZY17KEYxMVLKoHtiAJ8l21cpvdhGqenn+0MhgnSwTr1e5ZZGMdn0p+9GnuZ
         Yc41SoF0TUuVlJrlMY99S7VQShsm1H76fT1fflBnZVn30TQD0K1BP6P/3pi+aKbOUgOB
         +Ftw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776079448; x=1776684248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUqUeA7oo4jBHFJWxogBW0d62Lmyv6k7nApGPlXPmhE=;
        b=KgpT/99OYnHb9FKyFJaEWRG9ML99tCBN/FwIKDMe2Grmuo1EiN2nAFUiKnTw3wyPA3
         P1rcXrKryyFS4aqRRXZWHb8e6U8RXmJOTsm16I0k56pYT5SBno9LIi/JAP5wUf6H9gjB
         0DxWfipGaWc0ZWFPjJgGuc5Zzj1hCgcqEn1cyjsFuDm3rClVuevD2vGTN6mSW2N8nsS4
         A0sMkeZHeoXObqag8PfPT0Pch/9TdkZ8l5Q7GA0WdnP21ME/XYYfzdIZ5NKBT9IP/J24
         SJegUtQLcjmj7egZV//Gv6nD8nZHBu0HNgNrr6dF0lbbrxyjz3MPOVSan1mY203wizoq
         etMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079448; x=1776684248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUqUeA7oo4jBHFJWxogBW0d62Lmyv6k7nApGPlXPmhE=;
        b=qinoIAeHMSpARP7e0H+8DXgL9/waaIklUJu3MIEpEVIoG+E7iO3nBpyazuo/Rkk67t
         eWjGi4DdZSZqwPNq6LHDKddl4/7T2aBSdI5qIhLGuq2vYEWJ5IItvgHpe/mvbwNTExpL
         R8GMEH+548FFrGFM9SgXuduWValjgvHpQx7wdozDO3ZM1SKOOTuqKEoMn7YK8vs+xB2o
         0g405JDRV7Va9RmOdwiV+UAq6eZEPsDo6GSSW2h6otMrnV7RnVi4fl3o0dueVuPG3Qpr
         TocW9hk6nAV7g1bo+W0mXi1MiUskiQJWF/aN294L/16kd2eIrCVIeQ0W+6bxjCAFOsdi
         CNhg==
X-Forwarded-Encrypted: i=1; AFNElJ+YwxbdMprwhFCehAhLT/E3dtJIXNgj/VQiyMUMpVC81y+0vkwkyt7dw3VsSQty6m3Ej81YMj9Bp6Zv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wK7EH057vnP2I1yMzx/u+XLi43jMDY61N2E5wdVG9q3wlP0I
	nvt5WKBQLgqp7Y5lpwh+o8IlJsNwE0j2Xq/ep+YRn1OkBl6TyH8nfh5iVVH3WXr5oHik8HwGA6S
	gGPdSlQ4a+iDCpSHB7Abt3UDyNqoOcQUlWwJr5RXlwk8Y+U7fBOoJD2FT+/QoZOwk5fJ1SW+KXQ
	9u2vduMiXS/wLXqXpqCVAM4gND2/M57HlK6Hd0eg==
X-Gm-Gg: AeBDiev08rqH3EXCYWWaKKkBI9YVillr1xRaBeCuIKicdkzGti5yixGG4fPk43Dms29
	+6Jx3DskAvl6lFH5eXopEXUOGdVhlSZzsg/vo1uecJ6T7vAuwqUFpZox24KMsnytVtCyv2Pqu1B
	GIgD+AetfXkPh/4xHUuZW3lT24u/MatrxOAYzOK4W5mJI7ne64V6LF/9bO4tPwuVxYMIag7GOjp
	ZlRoFN+rI+HhLJUZNucVf6df1+twtwayXKsx2165zKIAiGJtoGh5noUKhwQ8evUPvtdm9nPWIBI
	DA9Q
X-Received: by 2002:a5d:5f47:0:b0:43d:7d24:b510 with SMTP id ffacd0b85a97d-43d7d24b9a4mr1542518f8f.22.1776079448132;
        Mon, 13 Apr 2026 04:24:08 -0700 (PDT)
X-Received: by 2002:a5d:5f47:0:b0:43d:7d24:b510 with SMTP id
 ffacd0b85a97d-43d7d24b9a4mr1542452f8f.22.1776079447584; Mon, 13 Apr 2026
 04:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413104721.203024-1-frankja@linux.ibm.com>
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 13:23:55 +0200
X-Gm-Features: AQROBzBTwHEVPVTAbdEJ4LqTkV7Mhh6IPc-Con_U5Sj-hzHox8sbwNXmybi8D80
Message-ID: <CABgObfaWO3J89sFmu3ZBPTztXcKgXPZu3FyiRcasejS=0tgJYQ@mail.gmail.com>
Subject: Re: [GIT PULL 00/12] KVM: s390: Changes for 7.1
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@kernel.org, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:47=E2=80=AFPM Janosch Frank <frankja@linux.ibm.c=
om> wrote:
>
> Hey Paolo,
>
> here are our changes for 7.1:
> - Claudio is finishing up gmap work by allowing 4k memslots
> - Eric and Hendrik added nesting ESA support
> - I've fixed up LPSW/E emulation, going through next as I don't expect
>   us to ever hit this
>
> There's been two conflicts because 7.0 received a number of gmap fixes.

This is just nearby lines being touched, I think? No real conflict.

Pulled, thanks.

Paolo

> Please pull
>
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-7.1-1
>
> for you to fetch changes up to 9b8e8aad5896d66005d29920cb1643076a20b172:
>
>   KVM: s390: ucontrol: Fix memslot handling (2026-04-07 17:20:42 +0200)
>
> ----------------------------------------------------------------
> - ESA nesting support
> - 4k memslots
> - LPSW/E fix
> ----------------------------------------------------------------
>
> Claudio Imbrenda (6):
>   KVM: s390: Add some useful mask macros
>   KVM: s390: Add alignment checks for hugepages
>   KVM: s390: Allow 4k granularity for memslots
>   KVM: selftests: Remove 1M alignment requirement for s390
>   KVM: s390: selftests: enable some common memory-related tests
>   KVM: s390: ucontrol: Fix memslot handling
>
> Eric Farman (4):
>   KVM: s390: only deliver service interrupt with payload
>   KVM: s390: vsie: Allow non-zarch guests
>   KVM: s390: vsie: Disable some bits when in ESA mode
>   KVM: s390: vsie: Accommodate ESA prefix pages
>
> Hendrik Brueckner (1):
>   KVM: s390: Add KVM capability for ESA mode guests
>
> Janosch Frank (1):
>   KVM: s390: Fix lpsw/e breaking event handling
>
>  Documentation/virt/kvm/api.rst                |  8 +++++
>  arch/s390/include/asm/kvm_host.h              |  1 +
>  arch/s390/include/asm/kvm_host_types.h        |  3 +-
>  arch/s390/kvm/dat.h                           |  5 +++
>  arch/s390/kvm/faultin.c                       |  2 +-
>  arch/s390/kvm/gaccess.c                       |  2 +-
>  arch/s390/kvm/gmap.c                          | 32 +++++++++++++++----
>  arch/s390/kvm/gmap.h                          |  3 +-
>  arch/s390/kvm/interrupt.c                     |  3 ++
>  arch/s390/kvm/kvm-s390.c                      | 28 ++++++++--------
>  arch/s390/kvm/kvm-s390.h                      |  5 ++-
>  arch/s390/kvm/priv.c                          |  8 +++--
>  arch/s390/kvm/vsie.c                          | 29 ++++++++++++++---
>  include/uapi/linux/kvm.h                      |  1 +
>  tools/testing/selftests/kvm/Makefile.kvm      |  9 ++----
>  tools/testing/selftests/kvm/dirty_log_test.c  |  3 --
>  .../testing/selftests/kvm/include/kvm_util.h  |  4 ---
>  .../selftests/kvm/kvm_page_table_test.c       |  3 --
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  9 +-----
>  tools/testing/selftests/kvm/lib/memstress.c   |  4 ---
>  .../selftests/kvm/pre_fault_memory_test.c     |  4 ---
>  .../selftests/kvm/set_memory_region_test.c    |  9 +-----
>  22 files changed, 102 insertions(+), 73 deletions(-)
>
> --
> 2.53.0
>

